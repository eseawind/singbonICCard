package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 管理人员(公司管理员，公司出纳员)
 * 
 * @author 郝威
 * 
 */
public class SysUser implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	String[] statusDescList = { "未发卡", "正常", "挂失" };
	private Integer id;
	private Integer companyId;
	private String name;
	private Integer cardNO;
	private String cardSN;
	private String superAdmin;
	private String loginName;
	private String loginPwd;
	private Integer userType;
	private Integer enabled;
	private Integer deptId;
	private String deptDesc;
	private Integer status;
	@SuppressWarnings("unused")
	private String statusDesc;
	private Date invalidDate;

	public String getSuperAdmin() {
		return superAdmin;
	}

	public void setSuperAdmin(String superAdmin) {
		this.superAdmin = superAdmin;
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

	public Integer getUserType() {
		return userType;
	}

	public void setUserType(Integer userType) {
		this.userType = userType;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getStatusDesc() {
		return this.statusDescList[status];
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	public Date getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(Date invalidDate) {
		this.invalidDate = invalidDate;
	}

	public String[] getStatusDescList() {
		return statusDescList;
	}

	public void setStatusDescList(String[] statusDescList) {
		this.statusDescList = statusDescList;
	}

	public String getDeptDesc() {
		return deptDesc;
	}

	public void setDeptDesc(String deptDesc) {
		this.deptDesc = deptDesc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

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

	public Integer getCardNO() {
		return cardNO;
	}

	public void setCardNO(Integer cardNO) {
		this.cardNO = cardNO;
	}

	public String getCardSN() {
		return cardSN;
	}

	public void setCardSN(String cardSN) {
		this.cardSN = cardSN;
	}

}
