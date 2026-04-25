package com.ruoyi.modules.monitor.service;

import java.util.List;
import java.util.Properties;
import java.util.Set;
import com.ruoyi.modules.monitor.domain.SysCache;

/**
 * 缓存监控 服务层
 * 
 * @author ruoyi
 */
public interface ISysCacheService
{
    /**
     * 查询缓存信息
     * 
     * @return 缓存信息
     * @throws Exception 
     */
    public Properties getCacheInfo() throws Exception;

    /**
     * 查询缓存名称列表
     * 
     * @return 缓存名称列表
     */
    public List<SysCache> getCacheNames();

    /**
     * 查询缓存键名列表
     * 
     * @param cacheName 缓存名称
     * @return 缓存键名列表
     */
    public Set<String> getCacheKeys(String cacheName);

    /**
     * 查询缓存内容
     * 
     * @param cacheName 缓存名称
     * @param cacheKey 缓存键名
     * @return 缓存内容
     */
    public SysCache getCacheValue(String cacheName, String cacheKey);

    /**
     * 清理指定名称缓存
     * 
     * @param cacheName 缓存名称
     */
    public void clearCacheName(String cacheName);

    /**
     * 清理指定键名缓存
     * 
     * @param cacheKey 缓存键名
     */
    public void clearCacheKey(String cacheKey);

    /**
     * 清理全部缓存
     */
    public void clearCacheAll();
}