package com.ruoyi.book.mapper;

import java.util.List;

import com.ruoyi.book.domain.BorrowItem;
import org.apache.ibatis.annotations.Mapper;

/**
 * 借阅明细Mapper接口
 *
 * @author Alanine
 * @date 2026-04-19
 */
@Mapper
public interface BorrowItemMapper {
    /**
     * 查询借阅明细
     *
     * @param itemId 借阅明细主键
     * @return 借阅明细
     */
    BorrowItem selectBorrowItemByItemId(Long itemId);

    /**
     * 查询借阅明细列表
     *
     * @param borrowItem 借阅明细
     * @return 借阅明细集合
     */
    List<BorrowItem> selectBorrowItemList(BorrowItem borrowItem);

    /**
     * 新增借阅明细
     *
     * @param borrowItem 借阅明细
     * @return 结果
     */
    int insertBorrowItem(BorrowItem borrowItem);

    /**
     * 修改借阅明细
     *
     * @param borrowItem 借阅明细
     * @return 结果
     */
    int updateBorrowItem(BorrowItem borrowItem);

    /**
     * 批量删除借阅明细
     *
     * @param itemIds 需要删除的借阅明细主键
     * @return 结果
     */
    int deleteBorrowItemByItemIds(Long[] itemIds);

    /**
     * 删除借阅明细信息
     *
     * @param itemId 借阅明细主键
     * @return 结果
     */
    int deleteBorrowItemByItemId(Long itemId);
}