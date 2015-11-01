package com.singbon.entity;

import java.io.Serializable;

/**
 * 管理人员(公司管理员，公司出纳员)
 * 
 * @author 郝威
 * 
 */
public class SysUser implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer operId;
	private Integer companyId;
	private String loginName;
	private String loginPwd;
	private Integer loginType;
	private Integer deviceId;
	private Integer status;

	public Integer getOperId() {
		return operId;
	}

	public void setOperId(Integer operId) {
		this.operId = operId;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLoginPwd() {
		return loginPwd;
	}

	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}

	public Integer getLoginType() {
		return loginType;
	}

	public void setLoginType(Integer loginType) {
		this.loginType = loginType;
	}

	public Integer getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Integer deviceId) {
		this.deviceId = deviceId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}
