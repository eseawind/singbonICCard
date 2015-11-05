package com.singbon.entity;

import java.io.Serializable;

/**
 * 终端设备
 * 
 * @author 郝威
 * 
 */
public class Device implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Integer groupId;
	private Integer posParamGroupId;
	private String deviceName;
	private Integer deviceNum;
	private Integer deviceType;
	private Integer enable;
	private Integer lastRecordNO = 0;
	/**
	 * 监控用
	 */
	private Integer isOnline;
	private String sn;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public Integer getDeviceNum() {
		return deviceNum;
	}

	public void setDeviceNum(Integer deviceNum) {
		this.deviceNum = deviceNum;
	}

	public Integer getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(Integer deviceType) {
		this.deviceType = deviceType;
	}

	public Integer getEnable() {
		return enable;
	}

	public void setEnable(Integer enable) {
		this.enable = enable;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public Integer getIsOnline() {
		return isOnline;
	}

	public void setIsOnline(Integer isOnline) {
		this.isOnline = isOnline;
	}

	public Integer getPosParamGroupId() {
		return posParamGroupId;
	}

	public void setPosParamGroupId(Integer posParamGroupId) {
		this.posParamGroupId = posParamGroupId;
	}

	public Integer getLastRecordNO() {
		return lastRecordNO;
	}

	public void setLastRecordNO(Integer lastRecordNO) {
		this.lastRecordNO = lastRecordNO;
	}

}
