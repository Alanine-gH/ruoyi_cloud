package com.ruoyi.book.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.book.domain.BorrowRecord;
import com.ruoyi.book.service.IBorrowRecordService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 借阅记录Controller
 * 
 * @author ruoyi
 * @date 2026-05-06
 */
@RestController
@RequestMapping("/record")
public class BorrowRecordController extends BaseController
{
    @Autowired
    private IBorrowRecordService borrowRecordService;

    /**
     * 查询借阅记录列表
     */
    @RequiresPermissions("book:record:list")
    @GetMapping("/list")
    public TableDataInfo list(BorrowRecord borrowRecord)
    {
        startPage();
        List<BorrowRecord> list = borrowRecordService.selectBorrowRecordList(borrowRecord);
        return getDataTable(list);
    }

    /**
     * 导出借阅记录列表
     */
    @RequiresPermissions("book:record:export")
    @Log(title = "借阅记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, BorrowRecord borrowRecord)
    {
        List<BorrowRecord> list = borrowRecordService.selectBorrowRecordList(borrowRecord);
        ExcelUtil<BorrowRecord> util = new ExcelUtil<BorrowRecord>(BorrowRecord.class);
        util.exportExcel(response, list, "借阅记录数据");
    }

    /**
     * 获取借阅记录详细信息
     */
    @RequiresPermissions("book:record:query")
    @GetMapping(value = "/{recordId}")
    public AjaxResult getInfo(@PathVariable("recordId") Long recordId)
    {
        return success(borrowRecordService.selectBorrowRecordByRecordId(recordId));
    }

    /**
     * 新增借阅记录
     */
    @RequiresPermissions("book:record:add")
    @Log(title = "借阅记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BorrowRecord borrowRecord)
    {
        return toAjax(borrowRecordService.insertBorrowRecord(borrowRecord));
    }

    /**
     * 修改借阅记录
     */
    @RequiresPermissions("book:record:edit")
    @Log(title = "借阅记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BorrowRecord borrowRecord)
    {
        return toAjax(borrowRecordService.updateBorrowRecord(borrowRecord));
    }

    /**
     * 删除借阅记录
     */
    @RequiresPermissions("book:record:remove")
    @Log(title = "借阅记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds)
    {
        return toAjax(borrowRecordService.deleteBorrowRecordByRecordIds(recordIds));
    }
}
