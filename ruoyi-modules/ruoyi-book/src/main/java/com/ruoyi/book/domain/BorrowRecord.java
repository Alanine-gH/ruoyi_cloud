package com.ruoyi.book.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 借阅记录对象 borrow_record
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
public class BorrowRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 借阅记录ID */
    private Long recordId;

    /** 借阅人ID */
    @Excel(name = "借阅人ID")
    private Long userId;

    /** 借阅人姓名 */
    @Excel(name = "借阅人姓名")
    private String userName;

    /** 借阅时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "借阅时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date borrowTime;

    /** 预计归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "预计归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date planReturnTime;

    /** 实际归还时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "实际归还时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date returnTime;

    /** 借阅状态 */
    @Excel(name = "借阅状态")
    private String status;

    /** 借阅明细子信息 */
    private List<BorrowItem> borrowItemList;

    public void setRecordId(Long recordId) 
    {
        this.recordId = recordId;
    }

    public Long getRecordId() 
    {
        return recordId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }

    public void setBorrowTime(Date borrowTime) 
    {
        this.borrowTime = borrowTime;
    }

    public Date getBorrowTime() 
    {
        return borrowTime;
    }

    public void setPlanReturnTime(Date planReturnTime) 
    {
        this.planReturnTime = planReturnTime;
    }

    public Date getPlanReturnTime() 
    {
        return planReturnTime;
    }

    public void setReturnTime(Date returnTime) 
    {
        this.returnTime = returnTime;
    }

    public Date getReturnTime() 
    {
        return returnTime;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public List<BorrowItem> getBorrowItemList()
    {
        return borrowItemList;
    }

    public void setBorrowItemList(List<BorrowItem> borrowItemList)
    {
        this.borrowItemList = borrowItemList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("recordId", getRecordId())
            .append("userId", getUserId())
            .append("userName", getUserName())
            .append("borrowTime", getBorrowTime())
            .append("planReturnTime", getPlanReturnTime())
            .append("returnTime", getReturnTime())
            .append("status", getStatus())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("borrowItemList", getBorrowItemList())
            .toString();
    }
}
