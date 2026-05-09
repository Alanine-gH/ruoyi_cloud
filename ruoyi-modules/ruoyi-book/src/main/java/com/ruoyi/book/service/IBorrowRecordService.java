package com.ruoyi.book.service;

import java.util.List;
import com.ruoyi.book.domain.BorrowRecord;

/**
 * 借阅记录Service接口
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
public interface IBorrowRecordService 
{
    /**
     * 查询借阅记录
     * 
     * @param recordId 借阅记录主键
     * @return 借阅记录
     */
    public BorrowRecord selectBorrowRecordByRecordId(Long recordId);

    /**
     * 查询借阅记录列表
     * 
     * @param borrowRecord 借阅记录
     * @return 借阅记录集合
     */
    public List<BorrowRecord> selectBorrowRecordList(BorrowRecord borrowRecord);

    /**
     * 新增借阅记录
     * 
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    public int insertBorrowRecord(BorrowRecord borrowRecord);

    /**
     * 修改借阅记录
     * 
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    public int updateBorrowRecord(BorrowRecord borrowRecord);

    /**
     * 批量删除借阅记录
     * 
     * @param recordIds 需要删除的借阅记录主键集合
     * @return 结果
     */
    public int deleteBorrowRecordByRecordIds(Long[] recordIds);

    /**
     * 删除借阅记录信息
     * 
     * @param recordId 借阅记录主键
     * @return 结果
     */
    public int deleteBorrowRecordByRecordId(Long recordId);
}
