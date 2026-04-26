package com.ruoyi.book.service;

import java.util.List;

import com.ruoyi.book.domain.BorrowRecord;

/**
 * 借阅记录Service接口
 *
 * @author Alanine
 * @date 2026-04-19
 */
public interface IBorrowRecordService {
    /**
     * 查询借阅记录
     *
     * @param recordId 借阅记录主键
     * @return 借阅记录
     */
    BorrowRecord selectBorrowRecordByRecordId(Long recordId);

    /**
     * 查询借阅记录列表
     *
     * @param borrowRecord 借阅记录
     * @return 借阅记录集合
     */
    List<BorrowRecord> selectBorrowRecordList(BorrowRecord borrowRecord);

    /**
     * 新增借阅记录
     *
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    int insertBorrowRecord(BorrowRecord borrowRecord);

    /**
     * 修改借阅记录
     *
     * @param borrowRecord 借阅记录
     * @return 结果
     */
    int updateBorrowRecord(BorrowRecord borrowRecord);

    /**
     * 批量删除借阅记录
     *
     * @param recordIds 需要删除的借阅记录主键集合
     * @return 结果
     */
    int deleteBorrowRecordByRecordIds(Long[] recordIds);

    /**
     * 删除借阅记录信息
     *
     * @param recordId 借阅记录主键
     * @return 结果
     */
    int deleteBorrowRecordByRecordId(Long recordId);

    /**
     * 借书操作
     *
     * @param borrowRecord 借阅记录
     * @param bookIds      书籍ID列表
     * @return 结果
     */
    int borrowBooks(BorrowRecord borrowRecord, Long[] bookIds);

    /**
     * 还书操作
     *
     * @param recordId 借阅记录ID
     * @return 结果，1表示正常归还，2表示逾期归还
     */
    Object returnBooks(Long recordId);

    /**
     * 导入借阅记录数据
     *
     * @param recordList    借阅记录数据列表
     * @param updateSupport 是否更新支持，如果已存在，则进行更新
     * @return 结果
     */
    String importRecord(List<BorrowRecord> recordList, boolean updateSupport);
}
