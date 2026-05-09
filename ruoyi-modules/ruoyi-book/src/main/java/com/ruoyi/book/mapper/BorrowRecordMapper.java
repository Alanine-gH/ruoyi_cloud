package com.ruoyi.book.mapper;

import java.util.List;
import com.ruoyi.book.domain.BorrowRecord;
import com.ruoyi.book.domain.BorrowItem;
import org.apache.ibatis.annotations.Mapper;

/**
 * 借阅记录Mapper接口
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
@Mapper
public interface BorrowRecordMapper 
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
     * 删除借阅记录
     * 
     * @param recordId 借阅记录主键
     * @return 结果
     */
    public int deleteBorrowRecordByRecordId(Long recordId);

    /**
     * 批量删除借阅记录
     * 
     * @param recordIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBorrowRecordByRecordIds(Long[] recordIds);

    /**
     * 批量删除借阅明细子
     * 
     * @param recordIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBorrowItemByRecordIds(Long[] recordIds);
    
    /**
     * 批量新增借阅明细子
     * 
     * @param borrowItemList 借阅明细子列表
     * @return 结果
     */
    public int batchBorrowItem(List<BorrowItem> borrowItemList);
    

    /**
     * 通过借阅记录主键删除借阅明细子信息
     * 
     * @param recordId 借阅记录ID
     * @return 结果
     */
    public int deleteBorrowItemByRecordId(Long recordId);
}
