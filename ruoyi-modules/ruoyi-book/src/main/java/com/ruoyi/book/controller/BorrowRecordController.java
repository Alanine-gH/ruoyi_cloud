package com.ruoyi.book.controller;

import java.util.List;

import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.book.domain.BorrowRecord;
import com.ruoyi.book.domain.dto.BorrowRequestDTO;
import com.ruoyi.book.service.IBorrowRecordService;

/**
 * 借阅记录Controller
 *
 * @author Alanine
 * @date 2026-04-19
 */
@RestController
@RequestMapping("/book/record")
public class BorrowRecordController extends BaseController {
    @Autowired
    private IBorrowRecordService borrowRecordService;

    /**
     * 查询借阅记录列表
     */
    @PreAuthorize("@ss.hasPermi('book:record:list')")
    @GetMapping("/list")
    public TableDataInfo list(BorrowRecord borrowRecord) {
        startPage();
        List<BorrowRecord> list = borrowRecordService.selectBorrowRecordList(borrowRecord);
        return getDataTable(list);
    }

    /**
     * 导出借阅记录列表
     */
    @PreAuthorize("@ss.hasPermi('book:record:export')")
    @Log(title = "借阅记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, BorrowRecord borrowRecord) {
        List<BorrowRecord> list = borrowRecordService.selectBorrowRecordList(borrowRecord);
        ExcelUtil<BorrowRecord> util = new ExcelUtil<BorrowRecord>(BorrowRecord.class);
        util.exportExcel(response, list, "借阅记录数据");
    }

    /**
     * 获取借阅记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('book:record:query')")
    @GetMapping("/{recordId}")
    public AjaxResult getInfo(@PathVariable("recordId") Long recordId) {
        return success(borrowRecordService.selectBorrowRecordByRecordId(recordId));
    }

    /**
     * 新增借阅记录
     */
    @PreAuthorize("@ss.hasPermi('book:record:add')")
    @Log(title = "借阅记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BorrowRecord borrowRecord) {
        return toAjax(borrowRecordService.insertBorrowRecord(borrowRecord));
    }

    /**
     * 修改借阅记录
     */
    @PreAuthorize("@ss.hasPermi('book:record:edit')")
    @Log(title = "借阅记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BorrowRecord borrowRecord) {
        return toAjax(borrowRecordService.updateBorrowRecord(borrowRecord));
    }

    /**
     * 删除借阅记录
     */
    @PreAuthorize("@ss.hasPermi('book:record:remove')")
    @Log(title = "借阅记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds) {
        return toAjax(borrowRecordService.deleteBorrowRecordByRecordIds(recordIds));
    }

    /**
     * 借书操作
     */
    @PreAuthorize("@ss.hasPermi('book:record:add')")
    @Log(title = "借阅记录", businessType = BusinessType.INSERT)
    @PostMapping("/borrow")
    public AjaxResult borrow(@RequestBody BorrowRequestDTO borrowRequest) {
        return toAjax(borrowRecordService.borrowBooks(borrowRequest.getBorrowRecord(), borrowRequest.getBookIds()));
    }

    /**
     * 还书操作
     */
    @PreAuthorize("@ss.hasPermi('book:record:edit')")
    @Log(title = "借阅记录", businessType = BusinessType.UPDATE)
    @PutMapping("/return/{recordId}")
    public AjaxResult returnBooks(@PathVariable Long recordId) {
        return success(borrowRecordService.returnBooks(recordId));
    }

    /**
     * 下载借阅记录导入模板
     */
    @PreAuthorize("@ss.hasPermi('book:record:import')")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<BorrowRecord> util = new ExcelUtil<BorrowRecord>(BorrowRecord.class);
        util.importTemplateExcel(response, "借阅记录模板");
    }

    /**
     * 导入借阅记录数据
     */
    @PreAuthorize("@ss.hasPermi('book:record:import')")
    @Log(title = "借阅记录", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) {
        ExcelUtil<BorrowRecord> util = new ExcelUtil<BorrowRecord>(BorrowRecord.class);
        try {
            List<BorrowRecord> recordList = util.importExcel(file.getInputStream());
            String message = borrowRecordService.importRecord(recordList, updateSupport);
            return success(message);
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }
}
