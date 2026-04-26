package com.ruoyi.book.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 借阅记录对象 borrow_record
 *
 * @author Alanine
 * @date 2026-04-19
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class BorrowRecord extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 借阅记录ID
     */
    private Long recordId;

    /**
     * 借阅人ID
     */
    @Excel(name = "借阅人ID")
    private Long userId;

    /**
     * 借阅人姓名
     */
    @Excel(name = "借阅人姓名")
    private String userName;

    /**
     * 借阅时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "借阅时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date borrowTime;

    /**
     * 预计归还时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预计归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date planReturnTime;

    /**
     * 实际归还时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date returnTime;

    /**
     * 借阅状态 0=待借阅 1=已借出 2=已归还 3=逾期
     */
    @Excel(name = "借阅状态 0=待借阅 1=已借出 2=已归还 3=逾期")
    private String status;

    /**
     * 书籍ID
     */
    @Excel(name = "书籍ID")
    private Long bookId;

    /**
     * 书籍名称
     */
    @Excel(name = "书籍名称")
    private String bookName;

    /**
     * 作者
     */
    @Excel(name = "作者")
    private String author;

    /**
     * ISBN
     */
    @Excel(name = "ISBN")
    private String isbn;

    /**
     * 分类
     */
    @Excel(name = "分类")
    private String category;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("recordId", getRecordId())
                .append("userId", getUserId())
                .append("userName", getUserName())
                .append("borrowTime", getBorrowTime())
                .append("planReturnTime", getPlanReturnTime())
                .append("returnTime", getReturnTime())
                .append("status", getStatus())
                .append("bookId", getBookId())
                .append("bookName", getBookName())
                .append("author", getAuthor())
                .append("isbn", getIsbn())
                .append("category", getCategory())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
