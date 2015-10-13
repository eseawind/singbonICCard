package com.singbon.entity;

import java.io.Serializable;

/**
 * 公司
 * 
 * @author 郝威
 * 
 */
public class Company implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private String companyName;
	private Integer serialNumber;
	private String authNumber;
	private Integer baseSection;
	private Integer heartInterval;
	private Integer uploadInterval;
	private Integer uploadErrTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Integer getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(Integer serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getAuthNumber() {
		return authNumber;
	}

	public void setAuthNumber(String authNumber) {
		this.authNumber = authNumber;
	}

	public Integer getBaseSection() {
		return baseSection;
	}

	public void setBaseSection(Integer baseSection) {
		this.baseSection = baseSection;
	}

	public Integer getHeartInterval() {
		return heartInterval;
	}

	public void setHeartInterval(Integer heartInterval) {
		this.heartInterval = heartInterval;
	}

	public Integer getUploadInterval() {
		return uploadInterval;
	}

	public void setUploadInterval(Integer uploadInterval) {
		this.uploadInterval = uploadInterval;
	}

	public Integer getUploadErrTime() {
		return uploadErrTime;
	}

	public void setUploadErrTime(Integer uploadErrTime) {
		this.uploadErrTime = uploadErrTime;
	}

}
