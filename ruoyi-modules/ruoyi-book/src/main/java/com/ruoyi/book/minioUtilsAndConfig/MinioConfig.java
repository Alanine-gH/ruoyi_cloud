package com.ruoyi.book.minioUtilsAndConfig;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import jakarta.annotation.PostConstruct;

/**
 * Minio配置类
 *
 * @author Alanine
 */
@Slf4j
@Data
@Configuration
public class MinioConfig {
    /**
     * 访问地址
     */
    @Value("${minio.endpoint}")
    private String endpoint;

    @Value("${minio.port}")
    private int port;

    /**
     * accessKey类似于用户ID，用于唯一标识你的账户
     */
    @Value("${minio.accessKey}")
    private String accessKey;

    /**
     * secretKey是你账户的密码
     */
    @Value("${minio.secretKey}")
    private String secretKey;
    /**
     * 默认存储桶
     */
    @Value("${minio.bucketName}")
    private String bucketName;
    /**
     * 下载目录
     */
    @Value("${minio.downloadDir}")
    private String downloadDir;

    private MinioClient minioClient;

    @Bean
    public MinioClient minioClient() {
        MinioClient client = MinioClient.builder()
                .endpoint(endpoint, port, false)
                .credentials(accessKey, secretKey).build();
        this.minioClient = client;
        return client;
    }

    @PostConstruct
    public void init() {
        try {
            if (!minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build())) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
                log.info("创建MinIO存储桶: {} 成功", bucketName);
            } else {
                log.info("MinIO存储桶: {} 已存在", bucketName);
            }
        } catch (Exception e) {
            log.error("初始化MinIO存储桶失败: {}", e.getMessage());
        }
    }
}
