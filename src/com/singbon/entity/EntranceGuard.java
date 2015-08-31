package com.singbon.entity;

import java.io.Serializable;

/**
 * 门禁参数设置
 * 
 * @author 郝威
 * 
 */
public class EntranceGuard implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private Integer openDelay;
	private Integer cardPwdType;
	private Integer recordType;
	private Integer authType;
	private Integer openStatus;
	private String operPwd;

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

	public Integer getOpenDelay() {
		return openDelay;
	}

	public void setOpenDelay(Integer openDelay) {
		this.openDelay = openDelay;
	}

	public Integer getCardPwdType() {
		return cardPwdType;
	}

	public void setCardPwdType(Integer cardPwdType) {
		this.cardPwdType = cardPwdType;
	}

	public Integer getRecordType() {
		return recordType;
	}

	public void setRecordType(Integer recordType) {
		this.recordType = recordType;
	}

	public Integer getAuthType() {
		return authType;
	}

	public void setAuthType(Integer authType) {
		this.authType = authType;
	}

	public Integer getOpenStatus() {
		return openStatus;
	}

	public void setOpenStatus(Integer openStatus) {
		this.openStatus = openStatus;
	}

	public String getOperPwd() {
		return operPwd;
	}

	public void setOperPwd(String operPwd) {
		this.operPwd = operPwd;
	}

}
