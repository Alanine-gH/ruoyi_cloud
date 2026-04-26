package com.ruoyi.book.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 书籍信息对象 book
 *
 * @author Alanien
 * @date 2026-04-19
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class Book extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 书籍ID
     */
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
     * ISBN编号
     */
    @Excel(name = "ISBN编号")
    private String isbn;

    /**
     * 书籍分类
     */
    @Excel(name = "书籍分类")
    private String category;

    /**
     * 库存数量
     */
    @Excel(name = "库存数量")
    private Long stock;

    /**
     * 书籍封面图片地址
     */
    @Excel(name = "书籍封面图片地址")
    private String coverImg;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("bookId", getBookId())
                .append("bookName", getBookName())
                .append("author", getAuthor())
                .append("isbn", getIsbn())
                .append("category", getCategory())
                .append("stock", getStock())
                .append("coverImg", getCoverImg())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .toString();
    }
}
