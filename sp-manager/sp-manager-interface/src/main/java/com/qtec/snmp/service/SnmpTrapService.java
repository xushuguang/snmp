package com.qtec.snmp.service;

import com.qtec.snmp.pojo.po.Keybuffer;
import com.qtec.snmp.pojo.po.Keyrate;

import java.util.List;

/**
 * User: james.xu
 * Date: 2018/1/30
 * Time: 16:27
 * Version:V1.0
 */
public interface SnmpTrapService {
    /**
     * 初始化snmpTrap
     */
    void init();

    /**
     * 启动snmpTrap
     */
    void run();

    /**
     * 停止snmpTrap
     */
    void stop();

}
