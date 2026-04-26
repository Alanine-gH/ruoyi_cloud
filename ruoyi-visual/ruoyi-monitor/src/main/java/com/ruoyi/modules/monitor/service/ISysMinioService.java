package com.ruoyi.modules.monitor.service;




import io.minio.messages.Bucket;
import io.minio.messages.Item;

import java.util.List;

/**
 * minio业务层
 */
public interface ISysMinioService {
    /**
     * 获取所有桶列表
     * @return 桶列表
     */
    List<Bucket> listBuckets();

    /**
     * 获取桶内对象列表
     * @param bucketName 桶名称
     * @return 对象列表
     */
    List<Item> listObjects(String bucketName);

    /**
     * 创建桶
     * @param bucketName 桶名称
     */
    void createBucket(String bucketName);

    /**
     * 删除桶
     * @param bucketName 桶名称
     */
    void deleteBucket(String bucketName);

    /**
     * 删除对象
     * @param bucketName 桶名称
     * @param objectName 对象名称
     */
    void deleteObject(String bucketName, String objectName);
}
