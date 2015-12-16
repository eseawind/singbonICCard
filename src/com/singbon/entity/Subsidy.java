package com.singbon.entity;

import java.io.Serializable;

//用户授权信息
//
//@author 郝威
//

public class Subsidy implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Long userId;
	private Integer companyId;
	private float subsidyFare;
	private Integer subsidyVersion;
	private String invalidDate;
	private Integer subsidyStatus;

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public float getSubsidyFare() {
		return subsidyFare;
	}

	public void setSubsidyFare(float subsidyFare) {
		this.subsidyFare = subsidyFare;
	}

	public Integer getSubsidyVersion() {
		return subsidyVersion;
	}

	public void setSubsidyVersion(Integer subsidyVersion) {
		this.subsidyVersion = subsidyVersion;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(String invalidDate) {
		this.invalidDate = invalidDate;
	}

	public Integer getSubsidyStatus() {
		return subsidyStatus;
	}

	public void setSubsidyStatus(Integer subsidyStatus) {
		this.subsidyStatus = subsidyStatus;
	}

}
