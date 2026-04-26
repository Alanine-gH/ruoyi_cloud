package com.ruoyi.book.controller;

import java.util.List;

import com.ruoyi.book.domain.Book;
import com.ruoyi.book.service.IBookService;
import com.ruoyi.book.minioUtilsAndConfig.MinioConfig;
import com.ruoyi.common.core.utils.file.FileUtils;
import com.ruoyi.book.minioUtilsAndConfig.MinioUtils;
import com.ruoyi.common.core.utils.StringUtils;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * 书籍信息Controller
 *
 * @author Alanien
 * @date 2026-04-19
 */
@RestController
@RequestMapping("/book/detail")
public class BookController extends BaseController {
    @Autowired
    private IBookService bookService;

    @Autowired
    private MinioUtils minioUtils;

    @Autowired
    private MinioConfig minioConfig;

    /**
     * 查询书籍信息列表
     */
    @PreAuthorize("@ss.hasPermi('book:detail:list')")
    @GetMapping("/list")
    public TableDataInfo list(Book book) {
        startPage();
        List<Book> list = bookService.selectBookList(book);
        // 处理书籍封面URL
        for (Book bookItem : list) {
            if (StringUtils.isNotEmpty(bookItem.getCoverImg())) {
                // 检查是否已经是完整URL
                if (!bookItem.getCoverImg().startsWith("http")) {
                    String coverUrl = minioConfig.getEndpoint() + ":" + minioConfig.getPort() + "/" + minioConfig.getBucketName() + "/" + bookItem.getCoverImg();
                    bookItem.setCoverImg(coverUrl);
                }
            }
        }
        return getDataTable(list);
    }

    /**
     * 默认查询书籍信息列表（根路径）
     */
    @PreAuthorize("@ss.hasPermi('book:detail:list')")
    @GetMapping
    public TableDataInfo index(Book book) {
        return list(book);
    }

    /**
     * 导出书籍信息列表
     */
    @PreAuthorize("@ss.hasPermi('book:detail:export')")
    @Log(title = "书籍信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Book book) {
        List<Book> list = bookService.selectBookList(book);
        ExcelUtil<Book> util = new ExcelUtil<Book>(Book.class);
        util.exportExcel(response, list, "书籍信息数据");
    }

    /**
     * 获取书籍信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('book:detail:query')")
    @GetMapping("/{bookId}")
    public AjaxResult getInfo(@PathVariable("bookId") Long bookId) {
        Book book = bookService.selectBookByBookId(bookId);
        // 处理书籍封面URL
        if (StringUtils.isNotEmpty(book.getCoverImg())) {
            // 检查是否已经是完整URL
            if (!book.getCoverImg().startsWith("http")) {
                String coverUrl = minioConfig.getEndpoint() + ":" + minioConfig.getPort() + "/" + minioConfig.getBucketName() + "/" + book.getCoverImg();
                book.setCoverImg(coverUrl);
            }
        }
        return success(book);
    }

    /**
     * 新增书籍信息
     */
    @PreAuthorize("@ss.hasPermi('book:detail:add')")
    @Log(title = "书籍信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Book book) {
        // 处理封面图片URL，提取对象路径
        if (StringUtils.isNotEmpty(book.getCoverImg())) {
            // 如果是完整URL，提取对象路径部分
            if (book.getCoverImg().startsWith("http")) {
                String bucketPath = "/" + minioConfig.getBucketName() + "/";
                int bucketIndex = book.getCoverImg().indexOf(bucketPath);
                if (bucketIndex != -1) {
                    String objectPath = book.getCoverImg().substring(bucketIndex + bucketPath.length());
                    book.setCoverImg(objectPath);
                }
            }
        }
        return toAjax(bookService.insertBook(book));
    }

    /**
     * 修改书籍信息
     */
    @PreAuthorize("@ss.hasPermi('book:detail:edit')")
    @Log(title = "书籍信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Book book) {
        System.out.println("修改书籍信息，coverImg: " + book.getCoverImg());
        // 处理封面图片URL，提取对象路径
        if (StringUtils.isNotEmpty(book.getCoverImg())) {
            // 如果是完整URL，提取对象路径部分
            if (book.getCoverImg().startsWith("http")) {
                String bucketPath = "/" + minioConfig.getBucketName() + "/";
                int bucketIndex = book.getCoverImg().indexOf(bucketPath);
                if (bucketIndex != -1) {
                    String objectPath = book.getCoverImg().substring(bucketIndex + bucketPath.length());
                    System.out.println("提取对象路径: " + objectPath);
                    book.setCoverImg(objectPath);
                }
            }
        }
        System.out.println("更新前的coverImg: " + book.getCoverImg());
        int result = bookService.updateBook(book);
        System.out.println("更新结果: " + result);
        return toAjax(result);
    }

    /**
     * 删除书籍信息
     */
    @PreAuthorize("@ss.hasPermi('book:detail:remove')")
    @Log(title = "书籍信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{bookIds}")
    public AjaxResult remove(@PathVariable Long[] bookIds) {
        return toAjax(bookService.deleteBookByBookIds(bookIds));
    }

    /**
     * 下载书籍导入模板
     */
    @PreAuthorize("@ss.hasPermi('book:detail:import')")
    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response) {
        ExcelUtil<Book> util = new ExcelUtil<Book>(Book.class);
        util.importTemplateExcel(response, "书籍信息模板");
    }

    /**
     * 导入书籍数据
     */
    @PreAuthorize("@ss.hasPermi('book:detail:import')")
    @Log(title = "书籍信息", businessType = BusinessType.IMPORT)
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) {
        ExcelUtil<Book> util = new ExcelUtil<Book>(Book.class);
        try {
            List<Book> bookList = util.importExcel(file.getInputStream());
            String message = bookService.importBook(bookList, updateSupport);
            return success(message);
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    /**
     * 上传书籍封面
     */
    @PreAuthorize("@ss.hasPermi('book:detail:edit')")
    @Log(title = "书籍封面", businessType = BusinessType.UPDATE)
    @PostMapping("/uploadCover")
    public AjaxResult uploadCover(@RequestParam("file") MultipartFile file) throws Exception {
        try {
            String objectName = "book/cover/" + FileUtils.extractFilename(file);
            minioUtils.uploadFile(minioConfig.getBucketName(), file, objectName, file.getContentType());
            String coverUrl = minioConfig.getEndpoint() + ":" + minioConfig.getPort() + "/" + minioConfig.getBucketName() + "/" + objectName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", coverUrl);
            ajax.put("fileName", objectName);
            ajax.put("newFileName", FileUtils.getName(objectName));
            ajax.put("originalFilename", file.getOriginalFilename());
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
}
