package com.ruoyi.book.controller;

import java.util.List;

import com.ruoyi.book.domain.BorrowItem;
import com.ruoyi.book.service.IBorrowItemService;
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

/**
 * 借阅明细Controller
 * 
 * @author Alanine
 * @date 2026-04-19
 */
@RestController
@RequestMapping("/book/item")
public class BorrowItemController extends BaseController
{
    @Autowired
    private IBorrowItemService borrowItemService;

    /**
     * 查询借阅明细列表
     */
    @PreAuthorize("@ss.hasPermi('book:item:list')")
    @GetMapping("/list")
    public TableDataInfo list(BorrowItem borrowItem)
    {
        startPage();
        List<BorrowItem> list = borrowItemService.selectBorrowItemList(borrowItem);
        return getDataTable(list);
    }

    /**
     * 导出借阅明细列表
     */
    @PreAuthorize("@ss.hasPermi('book:item:export')")
    @Log(title = "借阅明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, BorrowItem borrowItem)
    {
        List<BorrowItem> list = borrowItemService.selectBorrowItemList(borrowItem);
        ExcelUtil<BorrowItem> util = new ExcelUtil<BorrowItem>(BorrowItem.class);
        util.exportExcel(response, list, "借阅明细数据");
    }

    /**
     * 获取借阅明细详细信息
     */
    @PreAuthorize("@ss.hasPermi('book:item:query')")
    @GetMapping("/{itemId}")
    public AjaxResult getInfo(@PathVariable("itemId") Long itemId)
    {
        return success(borrowItemService.selectBorrowItemByItemId(itemId));
    }

    /**
     * 新增借阅明细
     */
    @PreAuthorize("@ss.hasPermi('book:item:add')")
    @Log(title = "借阅明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BorrowItem borrowItem)
    {
        return toAjax(borrowItemService.insertBorrowItem(borrowItem));
    }

    /**
     * 修改借阅明细
     */
    @PreAuthorize("@ss.hasPermi('book:item:edit')")
    @Log(title = "借阅明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BorrowItem borrowItem)
    {
        return toAjax(borrowItemService.updateBorrowItem(borrowItem));
    }

    /**
     * 删除借阅明细
     */
    @PreAuthorize("@ss.hasPermi('book:item:remove')")
    @Log(title = "借阅明细", businessType = BusinessType.DELETE)
    @DeleteMapping("/{itemIds}")
    public AjaxResult remove(@PathVariable Long[] itemIds)
    {
        return toAjax(borrowItemService.deleteBorrowItemByItemIds(itemIds));
    }
}
