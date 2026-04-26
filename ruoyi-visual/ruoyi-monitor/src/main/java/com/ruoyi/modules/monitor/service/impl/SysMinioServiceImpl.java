package com.ruoyi.modules.monitor.service.impl;
//
//import com.ruoyi.common.utils.MinioUtils;
//import com.ruoyi.system.service.ISysMinioService;
import io.minio.messages.Bucket;
import io.minio.messages.Item;
import com.ruoyi.modules.monitor.service.ISysMinioService;
import com.ruoyi.modules.monitor.untils.MinioUtils;
import org.apache.xmlbeans.impl.xb.xsdschema.BlockSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * minio业务层处理
 */
@Service
public class SysMinioServiceImpl implements ISysMinioService {

    @Autowired
    private MinioUtils minioUtils;

    @Override
    public List<Bucket> listBuckets() {
        return minioUtils.getAllBuckets();
    }

    @Override
    public List<Item> listObjects(String bucketName) {
        return minioUtils.getAllObjectsByPrefix(bucketName, "", true);
    }

    @Override
    public void createBucket(String bucketName) {
        minioUtils.createBucket(bucketName);
    }

    @Override
    public void deleteBucket(String bucketName) {
        minioUtils.removeBucket(bucketName);
    }

    @Override
    public void deleteObject(String bucketName, String objectName) {
        minioUtils.removeFile(bucketName, objectName);
    }
}
