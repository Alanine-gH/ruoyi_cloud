package com.ruoyi.modules.monitor.service.impl;

import org.springframework.stereotype.Service;
import com.ruoyi.modules.monitor.domain.Server;
import com.ruoyi.modules.monitor.service.IServerService;

/**
 * 服务器监控 服务层处理
 * 
 * @author ruoyi
 */
@Service
public class ServerServiceImpl implements IServerService
{
    @Override
    public Server getServerInfo() throws Exception
    {
        Server server = new Server();
        server.copyTo();
        return server;
    }
}