package com.ruoyi.book.mapper;

import java.util.List;

import com.ruoyi.book.domain.Book;
import org.apache.ibatis.annotations.Mapper;

/**
 * 书籍信息Mapper接口
 *
 * @author Alanien
 * @date 2026-04-19
 */
@Mapper
public interface BookMapper {
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
     * 删除书籍信息信息
     *
     * @param bookId 书籍信息主键
     * @return 结果
     */
    int deleteBookByBookId(Long bookId);

    /**
     * 根据ISBN查询书籍
     *
     * @param isbn ISBN编号
     * @return 书籍信息
     */
    Book selectBookByIsbn(String isbn);
}
