package com.ruoyi.book.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.ruoyi.common.core.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.book.domain.BorrowItem;
import com.ruoyi.book.mapper.BorrowRecordMapper;
import com.ruoyi.book.domain.BorrowRecord;
import com.ruoyi.book.service.IBorrowRecordService;

/**
 * 借阅记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
@Service
public class BorrowRecordServiceImpl implements IBorrowRecordService 
{
    @Autowired
    private BorrowRecordMapper borrowRecordMapper;

    /**
     * 查询借阅记录
     * 
     * @param recordId 借阅记录主键
     * @return 借阅记录
     */
    @Override
    public BorrowRecord selectBorrowRecordByRecordId(Long recordId)
    {
        return borrowRecordMapper.selectBorrowRecordByRecordId(recordId);
    }

    /**
     * 查询借阅记录列表
     * 
     * @param borrowRecord 借阅记录
     * @return 借阅记录
     */
    @Override
    public List<BorrowRecord> selectBorrowRecordList(BorrowRecord borrowRecord)
    {
        return borrowRecordMapper.selectBorrowRecordList(borrowRecord);
    }

    /**
     * 新增借阅记录
     * 
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    @Transactional
    @Override
    public int insertBorrowRecord(BorrowRecord borrowRecord)
    {
        borrowRecord.setCreateTime(DateUtils.getNowDate());
        int rows = borrowRecordMapper.insertBorrowRecord(borrowRecord);
        insertBorrowItem(borrowRecord);
        return rows;
    }

    /**
     * 修改借阅记录
     * 
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    @Transactional
    @Override
    public int updateBorrowRecord(BorrowRecord borrowRecord)
    {
        borrowRecord.setUpdateTime(DateUtils.getNowDate());
        borrowRecordMapper.deleteBorrowItemByRecordId(borrowRecord.getRecordId());
        insertBorrowItem(borrowRecord);
        return borrowRecordMapper.updateBorrowRecord(borrowRecord);
    }

    /**
     * 批量删除借阅记录
     * 
     * @param recordIds 需要删除的借阅记录主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteBorrowRecordByRecordIds(Long[] recordIds)
    {
        borrowRecordMapper.deleteBorrowItemByRecordIds(recordIds);
        return borrowRecordMapper.deleteBorrowRecordByRecordIds(recordIds);
    }

    /**
     * 删除借阅记录信息
     * 
     * @param recordId 借阅记录主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteBorrowRecordByRecordId(Long recordId)
    {
        borrowRecordMapper.deleteBorrowItemByRecordId(recordId);
        return borrowRecordMapper.deleteBorrowRecordByRecordId(recordId);
    }

    /**
     * 新增借阅明细子信息
     * 
     * @param borrowRecord 借阅记录对象
     */
    public void insertBorrowItem(BorrowRecord borrowRecord)
    {
        List<BorrowItem> borrowItemList = borrowRecord.getBorrowItemList();
        Long recordId = borrowRecord.getRecordId();
        if (StringUtils.isNotNull(borrowItemList))
        {
            List<BorrowItem> list = new ArrayList<BorrowItem>();
            for (BorrowItem borrowItem : borrowItemList)
            {
                borrowItem.setRecordId(recordId);
                list.add(borrowItem);
            }
            if (list.size() > 0)
            {
                borrowRecordMapper.batchBorrowItem(list);
            }
        }
    }
}
