package com.ruoyi.book.service.impl;

import java.util.List;

import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.book.mapper.BorrowItemMapper;
import com.ruoyi.book.domain.BorrowItem;
import com.ruoyi.book.service.IBorrowItemService;

/**
 * 借阅明细Service业务层处理
 * 
 * @author Alanine
 * @date 2026-04-19
 */
@Service
public class BorrowItemServiceImpl implements IBorrowItemService 
{
    @Autowired
    private BorrowItemMapper borrowItemMapper;

    /**
     * 查询借阅明细
     * 
     * @param itemId 借阅明细主键
     * @return 借阅明细
     */
    @Override
    public BorrowItem selectBorrowItemByItemId(Long itemId)
    {
        return borrowItemMapper.selectBorrowItemByItemId(itemId);
    }

    /**
     * 查询借阅明细列表
     * 
     * @param borrowItem 借阅明细
     * @return 借阅明细
     */
    @Override
    public List<BorrowItem> selectBorrowItemList(BorrowItem borrowItem)
    {
        return borrowItemMapper.selectBorrowItemList(borrowItem);
    }

    /**
     * 新增借阅明细
     * 
     * @param borrowItem 借阅明细
     * @return 结果
     */
    @Override
    public int insertBorrowItem(BorrowItem borrowItem)
    {
        borrowItem.setCreateTime(DateUtils.getNowDate());
        return borrowItemMapper.insertBorrowItem(borrowItem);
    }

    /**
     * 修改借阅明细
     * 
     * @param borrowItem 借阅明细
     * @return 结果
     */
    @Override
    public int updateBorrowItem(BorrowItem borrowItem)
    {
        borrowItem.setUpdateTime(DateUtils.getNowDate());
        return borrowItemMapper.updateBorrowItem(borrowItem);
    }

    /**
     * 批量删除借阅明细
     * 
     * @param itemIds 需要删除的借阅明细主键
     * @return 结果
     */
    @Override
    public int deleteBorrowItemByItemIds(Long[] itemIds)
    {
        return borrowItemMapper.deleteBorrowItemByItemIds(itemIds);
    }

    /**
     * 删除借阅明细信息
     * 
     * @param itemId 借阅明细主键
     * @return 结果
     */
    @Override
    public int deleteBorrowItemByItemId(Long itemId)
    {
        return borrowItemMapper.deleteBorrowItemByItemId(itemId);
    }
}