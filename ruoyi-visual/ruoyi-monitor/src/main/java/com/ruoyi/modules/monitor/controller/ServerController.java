package com.ruoyi.modules.monitor.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.modules.monitor.service.IServerService;

/**
 * 服务器监控
 * 
 * @author ruoyi
 */
@RestController
@RequestMapping("/monitor/server")
public class ServerController
{
    @Autowired
    private IServerService serverService;

    @GetMapping()
    public AjaxResult getInfo() throws Exception
    {
        return AjaxResult.success(serverService.getServerInfo());
    }
}