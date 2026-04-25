package com.ruoyi.modules.monitor.domain.server;

/**
 * JVM相关信息
 * 
 * @author ruoyi
 */
public class Jvm
{
    /**
     * JVM内存总量
     */
    private String total;

    /**
     * JVM最大内存
     */
    private String max;

    /**
     * JVM空闲内存
     */
    private String free;

    /**
     * JVM使用内存
     */
    private String used;

    /**
     * JVM使用率
     */
    private double usage;

    /**
     * JDK版本
     */
    private String version;

    /**
     * JDK路径
     */
    private String home;

    /**
     * JVM名称
     */
    private String name;

    /**
     * 启动时间
     */
    private String startTime;

    /**
     * 运行时长
     */
    private String runTime;

    /**
     * 运行参数
     */
    private String inputArgs;

    public String getTotal()
    {
        return total;
    }

    public void setTotal(String total)
    {
        this.total = total;
    }

    public String getMax()
    {
        return max;
    }

    public void setMax(String max)
    {
        this.max = max;
    }

    public String getFree()
    {
        return free;
    }

    public void setFree(String free)
    {
        this.free = free;
    }

    public String getUsed()
    {
        return used;
    }

    public void setUsed(String used)
    {
        this.used = used;
    }

    public double getUsage()
    {
        return usage;
    }

    public void setUsage(double usage)
    {
        this.usage = usage;
    }

    public String getVersion()
    {
        return version;
    }

    public void setVersion(String version)
    {
        this.version = version;
    }

    public String getHome()
    {
        return home;
    }

    public void setHome(String home)
    {
        this.home = home;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getStartTime()
    {
        return startTime;
    }

    public void setStartTime(String startTime)
    {
        this.startTime = startTime;
    }

    public String getRunTime()
    {
        return runTime;
    }

    public void setRunTime(String runTime)
    {
        this.runTime = runTime;
    }

    public String getInputArgs()
    {
        return inputArgs;
    }

    public void setInputArgs(String inputArgs)
    {
        this.inputArgs = inputArgs;
    }
}