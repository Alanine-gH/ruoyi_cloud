package com.ruoyi.book.service.impl;

import java.util.List;

import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.book.mapper.BorrowRecordMapper;
import com.ruoyi.book.mapper.BorrowItemMapper;
import com.ruoyi.book.mapper.BookMapper;
import com.ruoyi.book.domain.BorrowRecord;
import com.ruoyi.book.domain.BorrowItem;
import com.ruoyi.book.domain.Book;
import com.ruoyi.book.service.IBorrowRecordService;

/**
 * 借阅记录Service业务层处理
 *
 * @author Alanine
 * @date 2026-04-19
 */
@Service
@Slf4j
public class BorrowRecordServiceImpl implements IBorrowRecordService {
    @Autowired
    private BorrowRecordMapper borrowRecordMapper;

    @Autowired
    private BorrowItemMapper borrowItemMapper;

    @Autowired
    private BookMapper bookMapper;

    /**
     * 查询借阅记录
     *
     * @param recordId 借阅记录主键
     * @return 借阅记录
     */
    @Override
    public BorrowRecord selectBorrowRecordByRecordId(Long recordId) {
        return borrowRecordMapper.selectBorrowRecordByRecordId(recordId);
    }

    /**
     * 查询借阅记录列表
     *
     * @param borrowRecord 借阅记录
     * @return 借阅记录
     */
    @Override
    public List<BorrowRecord> selectBorrowRecordList(BorrowRecord borrowRecord) {
        return borrowRecordMapper.selectBorrowRecordList(borrowRecord);
    }

    /**
     * 新增借阅记录
     *
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    @Override
    public int insertBorrowRecord(BorrowRecord borrowRecord) {
        borrowRecord.setCreateTime(DateUtils.getNowDate());
        return borrowRecordMapper.insertBorrowRecord(borrowRecord);
    }

    /**
     * 修改借阅记录
     *
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    @Override
    public int updateBorrowRecord(BorrowRecord borrowRecord) {
        borrowRecord.setUpdateTime(DateUtils.getNowDate());
        return borrowRecordMapper.updateBorrowRecord(borrowRecord);
    }

    /**
     * 批量删除借阅记录
     *
     * @param recordIds 需要删除的借阅记录主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteBorrowRecordByRecordIds(Long[] recordIds)
    {
        for (Long recordId : recordIds)
        {
            BorrowItem item = new BorrowItem();
            item.setRecordId(recordId);
            List<BorrowItem> items = borrowItemMapper.selectBorrowItemList(item);
            if (items != null && !items.isEmpty())
            {
                Long[] itemIds = items.stream().map(BorrowItem::getItemId).toArray(Long[]::new);
                borrowItemMapper.deleteBorrowItemByItemIds(itemIds);
            }
        }
        return borrowRecordMapper.deleteBorrowRecordByRecordIds(recordIds);
    }

    /**
     * 删除借阅记录信息
     *
     * @param recordId 借阅记录主键
     * @return 结果
     */
    @Override
    @Transactional
    public int deleteBorrowRecordByRecordId(Long recordId)
    {
        BorrowItem item = new BorrowItem();
        item.setRecordId(recordId);
        List<BorrowItem> items = borrowItemMapper.selectBorrowItemList(item);
        if (items != null && !items.isEmpty())
        {
            Long[] itemIds = items.stream().map(BorrowItem::getItemId).toArray(Long[]::new);
            borrowItemMapper.deleteBorrowItemByItemIds(itemIds);
        }
        return borrowRecordMapper.deleteBorrowRecordByRecordId(recordId);
    }

    /**
     * 借书操作
     */
    @Override
    @Transactional
    public int borrowBooks(BorrowRecord borrowRecord, Long[] bookIds)
    {
        // 设置借阅时间和状态
        borrowRecord.setBorrowTime(DateUtils.getNowDate());
        borrowRecord.setStatus("1"); // 已借出
        borrowRecord.setCreateTime(DateUtils.getNowDate());

        // 保存借阅记录
        int result = borrowRecordMapper.insertBorrowRecord(borrowRecord);
        if (result <= 0)
        {
            throw new ServiceException("创建借阅记录失败");
        }

        // 处理每本书的借阅
        for (Long bookId : bookIds)
        {
            // 检查书籍库存
            Book book = bookMapper.selectBookByBookId(bookId);
            if (book == null)
            {
                throw new ServiceException("书籍不存在");
            }
            if (book.getStock() <= 0)
            {
                throw new ServiceException("书籍库存不足");
            }

            // 减少库存
            book.setStock(book.getStock() - 1);
            int updateResult = bookMapper.updateBook(book);
            if (updateResult <= 0)
            {
                throw new ServiceException("更新书籍库存失败");
            }

            // 创建借阅明细
            BorrowItem borrowItem = new BorrowItem();
            borrowItem.setRecordId(borrowRecord.getRecordId());
            borrowItem.setBookId(bookId);
            borrowItem.setBookName(book.getBookName());
            borrowItem.setCreateTime(DateUtils.getNowDate());
            int itemResult = borrowItemMapper.insertBorrowItem(borrowItem);
            if (itemResult <= 0)
            {
                throw new ServiceException("创建借阅明细失败");
            }
        }

        return result;
    }

    /**
     * 还书操作
     */
    @Override
    @Transactional
    public Object returnBooks(Long recordId) {
        // 查询借阅记录
        BorrowRecord borrowRecord = borrowRecordMapper.selectBorrowRecordByRecordId(recordId);
        if (borrowRecord == null) {
            throw new ServiceException("借阅记录不存在");
        }
        // 如果已经是已归还状态，直接返回成功
        if ("2".equals(borrowRecord.getStatus())) {
            return 1;
        }
        // 如果不是已借出状态，抛出异常
        boolean style_one = "1".equals(borrowRecord.getStatus());
        boolean style_three = "3".equals(borrowRecord.getStatus());//逾期
        if (!style_one && !style_three) {
            throw new ServiceException("该记录不是已借出状态，当前状态为：" + borrowRecord.getStatus());
        }

        // 查询借阅明细
        BorrowItem borrowItem = new BorrowItem();
        borrowItem.setRecordId(recordId);
        List<BorrowItem> borrowItems = borrowItemMapper.selectBorrowItemList(borrowItem);

        // 处理每本书的归还
        if (borrowItems != null && !borrowItems.isEmpty()) {
            for (BorrowItem item : borrowItems) {
                // 更新书籍库存
                Book book = bookMapper.selectBookByBookId(item.getBookId());
                if (book == null) {
                    throw new ServiceException("书籍不存在");
                }
                book.setStock(book.getStock() + 1);
                int updateResult = bookMapper.updateBook(book);
                if (updateResult <= 0) {
                    throw new ServiceException("更新书籍库存失败");
                }
            }
        }

        // 更新借阅记录状态
        borrowRecord.setReturnTime(DateUtils.getNowDate());
        borrowRecord.setStatus("2"); // 已归还
        borrowRecord.setUpdateTime(DateUtils.getNowDate());
        //判断
        if (borrowRecordMapper.updateBorrowRecord(borrowRecord) <= 0) {
            throw new ServiceException("更新借阅记录失败");
        }
        if (style_three) {
            log.warn("逾期已还书");
            //逾期向前端发一个alert
            return 2;
        }
        return 1;
    }

    /**
     * 导入借阅记录数据
     *
     * @param recordList 借阅记录数据列表
     * @param updateSupport 是否更新支持，如果已存在，则进行更新
     * @return 结果
     */
    @Override
    @Transactional
    public String importRecord(List<BorrowRecord> recordList, boolean updateSupport)
    {
        if (recordList == null || recordList.isEmpty())
        {
            throw new ServiceException("导入借阅记录数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (BorrowRecord record : recordList)
        {
            try
            {
                // 验证书籍是否存在
                if (record.getBookId() != null)
                {
                    Book book = bookMapper.selectBookByBookId(record.getBookId());
                    if (book == null)
                    {
                        failureNum++;
                        failureMsg.append("、").append(record.getBookName()).append("（书籍不存在）");
                        continue;
                    }
                }

                // 检查是否已存在
                BorrowRecord existingRecord = borrowRecordMapper.selectBorrowRecordByRecordId(record.getRecordId());
                if (existingRecord == null)
                {
                    // 新增
                    record.setCreateTime(DateUtils.getNowDate());
                    record.setUpdateTime(DateUtils.getNowDate());
                    borrowRecordMapper.insertBorrowRecord(record);
                    successNum++;
                }
                else if (updateSupport)
                {
                    // 更新
                    record.setUpdateTime(DateUtils.getNowDate());
                    borrowRecordMapper.updateBorrowRecord(record);
                    successNum++;
                }
                else
                {
                    failureNum++;
                    failureMsg.append("、").append(record.getRecordId());
                }
            }
            catch (Exception e)
            {
                failureNum++;
                String msg = "" + record.getRecordId() + " 导入失败：" + e.getMessage();
                failureMsg.append("、").append(msg);
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "导入失败的借阅记录有：");
            throw new ServiceException(failureMsg.toString());
        }
        else
        {
            successMsg.append("导入成功 ").append(successNum).append(" 条借阅记录数据");
        }
        return successMsg.toString();
    }
}
