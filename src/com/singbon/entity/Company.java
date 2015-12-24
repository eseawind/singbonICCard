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
	private String serialNumber;
	private String authNumber;
	private Integer baseSection;
	private Integer heartInterval;
	private Integer uploadInterval;
	private Integer uploadErrTime;
	private Integer accessTimeout;
	private Integer transferInterval;
	private Integer blackInterval;
	private String invalidDate;
	private boolean enable;
	// 不入库
	private Integer subsidyVersion;
	private String subsidyInvalidDate;
	// 自动下载黑名单用
	private Integer lastBatchNum;
	private Long lastBlackNum;

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

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
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

	public Integer getSubsidyVersion() {
		return subsidyVersion;
	}

	public void setSubsidyVersion(Integer subsidyVersion) {
		this.subsidyVersion = subsidyVersion;
	}

	public String getSubsidyInvalidDate() {
		return subsidyInvalidDate;
	}

	public void setSubsidyInvalidDate(String subsidyInvalidDate) {
		this.subsidyInvalidDate = subsidyInvalidDate;
	}

	public String getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(String invalidDate) {
		this.invalidDate = invalidDate;
	}

	public Integer getLastBatchNum() {
		return lastBatchNum;
	}

	public void setLastBatchNum(Integer lastBatchNum) {
		this.lastBatchNum = lastBatchNum;
	}

	public Long getLastBlackNum() {
		return lastBlackNum;
	}

	public void setLastBlackNum(Long lastBlackNum) {
		this.lastBlackNum = lastBlackNum;
	}

	public boolean getEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	public Integer getAccessTimeout() {
		return accessTimeout;
	}

	public void setAccessTimeout(Integer accessTimeout) {
		this.accessTimeout = accessTimeout;
	}

	public Integer getTransferInterval() {
		return transferInterval;
	}

	public void setTransferInterval(Integer transferInterval) {
		this.transferInterval = transferInterval;
	}

	public Integer getBlackInterval() {
		return blackInterval;
	}

	public void setBlackInterval(Integer blackInterval) {
		this.blackInterval = blackInterval;
	}

}
