package com.ruoyi.book.service.impl;

import java.util.List;

import com.ruoyi.common.core.exception.ServiceException;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.book.mapper.BookMapper;
import com.ruoyi.book.domain.Book;
import com.ruoyi.book.service.IBookService;

/**
 * 书籍信息Service业务层处理
 *
 * @author Alanien
 * @date 2026-04-19
 */
@Service
public class BookServiceImpl implements IBookService {
    @Autowired
    private BookMapper bookMapper;

    /**
     * 查询书籍信息
     *
     * @param bookId 书籍信息主键
     * @return 书籍信息
     */
    @Override
    public Book selectBookByBookId(Long bookId) {
        return bookMapper.selectBookByBookId(bookId);
    }

    /**
     * 查询书籍信息列表
     *
     * @param book 书籍信息
     * @return 书籍信息
     */
    @Override
    public List<Book> selectBookList(Book book) {
        return bookMapper.selectBookList(book);
    }

    /**
     * 新增书籍信息
     *
     * @param book 书籍信息
     * @return 结果
     */
    @Override
    public int insertBook(Book book) {
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
    public int updateBook(Book book) {
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
    public int deleteBookByBookIds(Long[] bookIds) {
        return bookMapper.deleteBookByBookIds(bookIds);
    }

    /**
     * 删除书籍信息信息
     *
     * @param bookId 书籍信息主键
     * @return 结果
     */
    @Override
    public int deleteBookByBookId(Long bookId) {
        return bookMapper.deleteBookByBookId(bookId);
    }

    /**
     * 导入书籍数据
     *
     * @param bookList      书籍数据列表
     * @param updateSupport 是否更新支持，如果已存在，则进行更新
     * @return 结果
     */
    @Override
    public String importBook(List<Book> bookList, boolean updateSupport) {
        if (bookList == null || bookList.isEmpty()) {
            throw new ServiceException("导入书籍数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (Book book : bookList) {
            try {
                // 验证ISBN是否唯一
                Book existingBook = bookMapper.selectBookByIsbn(book.getIsbn());
                if (existingBook == null) {
                    // 新增
                    book.setCreateTime(DateUtils.getNowDate());
                    book.setUpdateTime(DateUtils.getNowDate());
                    bookMapper.insertBook(book);
                    successNum++;
                } else if (updateSupport) {
                    // 更新
                    book.setBookId(existingBook.getBookId());
                    book.setUpdateTime(DateUtils.getNowDate());
                    bookMapper.updateBook(book);
                    successNum++;
                } else {
                    failureNum++;
                    failureMsg.append("、").append(book.getBookName());
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "" + book.getBookName() + " 导入失败：" + e.getMessage();
                failureMsg.append("、").append(msg);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "导入失败的书籍有：");
            throw new ServiceException(failureMsg.toString());
        } else {
            successMsg.append("导入成功 ").append(successNum).append(" 条书籍数据");
        }
        return successMsg.toString();
    }
}
