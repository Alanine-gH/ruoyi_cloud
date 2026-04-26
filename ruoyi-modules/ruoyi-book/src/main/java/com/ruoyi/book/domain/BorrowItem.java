package com.ruoyi.book.domain;

import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 借阅明细对象 borrow_item
 *
 * @author Alanine
 * @date 2026-04-19
 */
@Data
public class BorrowItem extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 明细ID
     */
    
    private Long itemId;

    /**
     * 借阅记录ID
     */
    @Excel(name = "借阅记录ID")
    
    private Long recordId;

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

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("itemId", getItemId())
                .append("recordId", getRecordId())
                .append("bookId", getBookId())
                .append("bookName", getBookName())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
