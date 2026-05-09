package com.ruoyi.book.mapper;

import java.util.List;
import com.ruoyi.book.domain.Book;

/**
 * 书籍信息Mapper接口
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
public interface BookMapper 
{
    /**
     * 查询书籍信息
     * 
     * @param bookId 书籍信息主键
     * @return 书籍信息
     */
    public Book selectBookByBookId(Long bookId);

    /**
     * 查询书籍信息列表
     * 
     * @param book 书籍信息
     * @return 书籍信息集合
     */
    public List<Book> selectBookList(Book book);

    /**
     * 新增书籍信息
     * 
     * @param book 书籍信息
     * @return 结果
     */
    public int insertBook(Book book);

    /**
     * 修改书籍信息
     * 
     * @param book 书籍信息
     * @return 结果
     */
    public int updateBook(Book book);

    /**
     * 删除书籍信息
     * 
     * @param bookId 书籍信息主键
     * @return 结果
     */
    public int deleteBookByBookId(Long bookId);

    /**
     * 批量删除书籍信息
     * 
     * @param bookIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteBookByBookIds(Long[] bookIds);
}
