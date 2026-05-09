package com.ruoyi.book.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 借阅明细子对象 borrow_item
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
public class BorrowItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 明细ID */
    private Long itemId;

    /** 借阅记录ID */
    @Excel(name = "借阅记录ID")
    private Long recordId;

    /** 书籍ID */
    @Excel(name = "书籍ID")
    private Long bookId;

    /** 书籍名称 */
    @Excel(name = "书籍名称")
    private String bookName;

    public void setItemId(Long itemId) 
    {
        this.itemId = itemId;
    }

    public Long getItemId() 
    {
        return itemId;
    }
    public void setRecordId(Long recordId) 
    {
        this.recordId = recordId;
    }

    public Long getRecordId() 
    {
        return recordId;
    }
    public void setBookId(Long bookId) 
    {
        this.bookId = bookId;
    }

    public Long getBookId() 
    {
        return bookId;
    }
    public void setBookName(String bookName) 
    {
        this.bookName = bookName;
    }

    public String getBookName() 
    {
        return bookName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("itemId", getItemId())
            .append("recordId", getRecordId())
            .append("bookId", getBookId())
            .append("bookName", getBookName())
            .toString();
    }
}
