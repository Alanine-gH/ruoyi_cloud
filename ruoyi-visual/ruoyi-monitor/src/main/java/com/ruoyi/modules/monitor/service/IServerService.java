package com.ruoyi.modules.monitor.service;

import com.ruoyi.modules.monitor.domain.Server;

/**
 * 服务器监控 服务层
 * 
 * @author ruoyi
 */
public interface IServerService
{
    /**
     * 获取服务器信息
     * 
     * @return 服务器信息
     * @throws Exception
     */
    public Server getServerInfo() throws Exception;
}