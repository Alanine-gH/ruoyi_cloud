package com.ruoyi.book.service;

import java.util.List;

import com.ruoyi.book.domain.Book;

/**
 * 书籍信息Service接口
 *
 * @author Alanien
 * @date 2026-04-19
 */
public interface IBookService {
    /**
     * 查询书籍信息
     *
     * @param bookId 书籍信息主键
     * @return 书籍信息
     */
    Book selectBookByBookId(Long bookId);

    /**
     * 查询书籍信息列表
     *
     * @param book 书籍信息
     * @return 书籍信息集合
     */
    List<Book> selectBookList(Book book);

    /**
     * 新增书籍信息
     *
     * @param book 书籍信息
     * @return 结果
     */
    int insertBook(Book book);

    /**
     * 修改书籍信息
     *
     * @param book 书籍信息
     * @return 结果
     */
    int updateBook(Book book);

    /**
     * 批量删除书籍信息
     *
     * @param bookIds 需要删除的书籍信息主键
     * @return 结果
     */
    int deleteBookByBookIds(Long[] bookIds);

    /**
     * 导入书籍数据
     *
     * @param bookList      书籍数据列表
     * @param updateSupport 是否更新支持，如果已存在，则进行更新
     * @return 结果
     */
    String importBook(List<Book> bookList, boolean updateSupport);

    /**
     * 删除书籍信息信息
     *
     * @param bookId 书籍信息主键
     * @return 结果
     */
    int deleteBookByBookId(Long bookId);
}
