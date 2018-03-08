package com.qtec.snmp.pojo.dto;

import java.util.List;

/**
 * User: james.xu
 * Date: 2018/3/2
 * Time: 15:18
 * Version:V1.0
 */
public class NodeDto {
    private String name;
    private String nodeIp;
    private List<Long> ids;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNodeIp() {
        return nodeIp;
    }

    public void setNodeIp(String nodeIp) {
        this.nodeIp = nodeIp;
    }

    public List<Long> getIds() {
        return ids;
    }

    public void setIds(List<Long> ids) {
        this.ids = ids;
    }
}