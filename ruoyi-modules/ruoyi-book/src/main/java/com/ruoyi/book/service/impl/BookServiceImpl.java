package com.ruoyi.book.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.book.mapper.BookMapper;
import com.ruoyi.book.domain.Book;
import com.ruoyi.book.service.IBookService;

/**
 * 书籍信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
@Service
public class BookServiceImpl implements IBookService 
{
    @Autowired
    private BookMapper bookMapper;

    /**
     * 查询书籍信息
     * 
     * @param bookId 书籍信息主键
     * @return 书籍信息
     */
    @Override
    public Book selectBookByBookId(Long bookId)
    {
        return bookMapper.selectBookByBookId(bookId);
    }

    /**
     * 查询书籍信息列表
     * 
     * @param book 书籍信息
     * @return 书籍信息
     */
    @Override
    public List<Book> selectBookList(Book book)
    {
        return bookMapper.selectBookList(book);
    }

    /**
     * 新增书籍信息
     * 
     * @param book 书籍信息
     * @return 结果
     */
    @Override
    public int insertBook(Book book)
    {
        book.setCreateTime(DateUtils.getNowDate());
        return bookMapper.insertBook(book);
    }

    /**
     * 修改书籍信息
     * 
     * @param book 书籍信息
     * @return 结果
     */
    @Override
    public int updateBook(Book book)
    {
        book.setUpdateTime(DateUtils.getNowDate());
        return bookMapper.updateBook(book);
    }

    /**
     * 批量删除书籍信息
     * 
     * @param bookIds 需要删除的书籍信息主键
     * @return 结果
     */
    @Override
    public int deleteBookByBookIds(Long[] bookIds)
    {
        return bookMapper.deleteBookByBookIds(bookIds);
    }

    /**
     * 删除书籍信息信息
     * 
     * @param bookId 书籍信息主键
     * @return 结果
     */
    @Override
    public int deleteBookByBookId(Long bookId)
    {
        return bookMapper.deleteBookByBookId(bookId);
    }
}
