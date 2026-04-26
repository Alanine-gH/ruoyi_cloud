package com.ruoyi.modules.monitor.controller;
//
//import com.ruoyi.common.annotation.Anonymous;
//import com.ruoyi.system.service.ISysMinioService;
import com.ruoyi.common.core.annotation.Anonymous;
import io.minio.messages.Bucket;
import io.minio.messages.Item;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.modules.monitor.service.ISysMinioService;
import org.apache.xmlbeans.impl.xb.xsdschema.BlockSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * minio列表
 *
 * @author ruoyi
 */
@Anonymous
@RestController
@RequestMapping("/monitor/minio")
public class MinioController {

    @Autowired
    private ISysMinioService sysMinioService;

    /**
     * 获取所有桶列表
     */
    @GetMapping("/buckets")
    public AjaxResult listBuckets() {
        try {
            List<Bucket> buckets = sysMinioService.listBuckets();
            System.out.println("获取到的桶列表: " + buckets);
            // 转换为可序列化的对象
            List<Map<String, Object>> bucketList = new ArrayList<>();
            for (Bucket bucket : buckets) {
                Map<String, Object> bucketMap = new HashMap<>();
                bucketMap.put("name", bucket.name());
                bucketMap.put("creationDate", bucket.creationDate());
                bucketList.add(bucketMap);
            }
            System.out.println("转换后的桶列表: " + bucketList);
            return AjaxResult.success(bucketList);
        } catch (Exception e) {
            System.err.println("获取桶列表失败: " + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("获取桶列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取桶内对象列表
     */
    @GetMapping("/objects/{bucketName}")
    public AjaxResult listObjects(@PathVariable String bucketName) {
        try {
            List<Item> objects = sysMinioService.listObjects(bucketName);
            System.out.println("获取到的对象列表: " + objects);
            // 转换为可序列化的对象
            List<Map<String, Object>> objectList = new ArrayList<>();
            for (Item item : objects) {
                Map<String, Object> itemMap = new HashMap<>();
                itemMap.put("name", item.objectName());
                itemMap.put("size", item.size());
                itemMap.put("lastModified", item.lastModified());
                objectList.add(itemMap);
            }
            System.out.println("转换后的对象列表: " + objectList);
            return AjaxResult.success(objectList);
        } catch (Exception e) {
            System.err.println("获取对象列表失败: " + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("获取对象列表失败: " + e.getMessage());
        }
    }

    /**
     * 创建桶
     */
    @PostMapping("/buckets/{bucketName}")
    public AjaxResult createBucket(@PathVariable String bucketName) {
        try {
            sysMinioService.createBucket(bucketName);
            System.out.println("创建桶成功: " + bucketName);
            return AjaxResult.success();
        } catch (Exception e) {
            System.err.println("创建桶失败: " + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("创建桶失败: " + e.getMessage());
        }
    }

    /**
     * 删除桶
     */
    @DeleteMapping("/buckets/{bucketName}")
    public AjaxResult deleteBucket(@PathVariable String bucketName) {
        try {
            sysMinioService.deleteBucket(bucketName);
            System.out.println("删除桶成功: " + bucketName);
            return AjaxResult.success();
        } catch (Exception e) {
            System.err.println("删除桶失败: " + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("删除桶失败: " + e.getMessage());
        }
    }

    /**
     * 删除对象
     */
    @DeleteMapping("/objects/{bucketName}/{objectName}")
    public AjaxResult deleteObject(@PathVariable String bucketName, @PathVariable String objectName) {
        try {
            sysMinioService.deleteObject(bucketName, objectName);
            System.out.println("删除对象成功: " + objectName);
            return AjaxResult.success();
        } catch (Exception e) {
            System.err.println("删除对象失败: " + e.getMessage());
            e.printStackTrace();
            return AjaxResult.error("删除对象失败: " + e.getMessage());
        }
    }
}
