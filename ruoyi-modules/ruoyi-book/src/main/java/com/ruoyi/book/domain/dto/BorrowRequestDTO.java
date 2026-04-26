package com.ruoyi.book.domain.dto;

import com.ruoyi.book.domain.BorrowRecord;
import lombok.Data;

/**
 * 借书请求DTO
 */
@Data
public class BorrowRequestDTO {
    private BorrowRecord borrowRecord;
    private Long[] bookIds;
}
