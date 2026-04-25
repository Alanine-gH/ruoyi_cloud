package com.ruoyi.modules.monitor.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.constant.CacheConstants;
import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.modules.monitor.domain.SysCache;
import com.ruoyi.modules.monitor.service.ISysCacheService;

/**
 * 缓存监控 服务层处理
 * 
 * @author ruoyi
 */
@Service
public class SysCacheServiceImpl implements ISysCacheService
{
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    private final static List<SysCache> caches = new ArrayList<SysCache>();
    
    static
    {
        caches.add(new SysCache(CacheConstants.LOGIN_TOKEN_KEY, "用户信息"));
        caches.add(new SysCache(CacheConstants.SYS_CONFIG_KEY, "配置信息"));
        caches.add(new SysCache(CacheConstants.SYS_DICT_KEY, "数据字典"));
        caches.add(new SysCache(CacheConstants.CAPTCHA_CODE_KEY, "验证码"));
        caches.add(new SysCache(CacheConstants.REPEAT_SUBMIT_KEY, "防重提交"));
        caches.add(new SysCache(CacheConstants.RATE_LIMIT_KEY, "限流处理"));
        caches.add(new SysCache(CacheConstants.PWD_ERR_CNT_KEY, "密码错误次数"));
    }

    @Override
    @SuppressWarnings("deprecation")
    public Properties getCacheInfo() throws Exception
    {
        return (Properties) redisTemplate.execute((RedisCallback<Object>) connection -> connection.info());
    }

    @Override
    public List<SysCache> getCacheNames()
    {
        return caches;
    }

    @Override
    public Set<String> getCacheKeys(String cacheName)
    {
        Set<String> cacheKeys = redisTemplate.keys(cacheName + "*");
        return new TreeSet<>(cacheKeys);
    }

    @Override
    public SysCache getCacheValue(String cacheName, String cacheKey)
    {
        String cacheValue = redisTemplate.opsForValue().get(cacheKey);
        return new SysCache(cacheName, cacheKey, cacheValue);
    }

    @Override
    public void clearCacheName(String cacheName)
    {
        Collection<String> cacheKeys = redisTemplate.keys(cacheName + "*");
        redisTemplate.delete(cacheKeys);
    }

    @Override
    public void clearCacheKey(String cacheKey)
    {
        redisTemplate.delete(cacheKey);
    }

    @Override
    public void clearCacheAll()
    {
        Collection<String> cacheKeys = redisTemplate.keys("*");
        redisTemplate.delete(cacheKeys);
    }
}