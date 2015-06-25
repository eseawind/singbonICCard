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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private Integer companyId;

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	private String sn;

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
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

	private Integer deviceNum;
	private Integer deviceType;
	private Integer enable;

	private String deviceName;
	private Integer userId;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

}
