package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户
 * 
 * @author 郝威
 * 
 */
public class User implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Integer deptId;
	private String username;
	private String shortName;
	private String userNO;
	private Integer sex;
	private String sexDesc;
	private String cardID;
	private Integer cardType;
	private String cardTypeDesc;
	private Integer cardFunc;
	private String cardFuncDesc;
	private Integer cardIdentity;
	private String cardIdentityDesc;
	private Integer status;
	private String statusDesc;
	private float cardCost;
	private float cardDeposit;
	private Date beginDate;
	private Date endDate;
	private String consumePwd;
	private String identityPwd;
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getDeptId() {
		return deptId;
	}
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
	public String getUserNO() {
		return userNO;
	}
	public void setUserNO(String userNO) {
		this.userNO = userNO;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getSexDesc() {
		return sexDesc;
	}
	public void setSexDesc(String sexDesc) {
		this.sexDesc = sexDesc;
	}
	public String getCardID() {
		return cardID;
	}
	public void setCardID(String cardID) {
		this.cardID = cardID;
	}
	public Integer getCardType() {
		return cardType;
	}
	public void setCardType(Integer cardType) {
		this.cardType = cardType;
	}
	public String getCardTypeDesc() {
		return cardTypeDesc;
	}
	public void setCardTypeDesc(String cardTypeDesc) {
		this.cardTypeDesc = cardTypeDesc;
	}
	public Integer getCardFunc() {
		return cardFunc;
	}
	public void setCardFunc(Integer cardFunc) {
		this.cardFunc = cardFunc;
	}
	public String getCardFuncDesc() {
		return cardFuncDesc;
	}
	public void setCardFuncDesc(String cardFuncDesc) {
		this.cardFuncDesc = cardFuncDesc;
	}
	public Integer getCardIdentity() {
		return cardIdentity;
	}
	public void setCardIdentity(Integer cardIdentity) {
		this.cardIdentity = cardIdentity;
	}
	public String getCardIdentityDesc() {
		return cardIdentityDesc;
	}
	public void setCardIdentityDesc(String cardIdentityDesc) {
		this.cardIdentityDesc = cardIdentityDesc;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getStatusDesc() {
		return statusDesc;
	}
	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}
	public float getCardCost() {
		return cardCost;
	}
	public void setCardCost(float cardCost) {
		this.cardCost = cardCost;
	}
	public float getCardDeposit() {
		return cardDeposit;
	}
	public void setCardDeposit(float cardDeposit) {
		this.cardDeposit = cardDeposit;
	}
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getConsumePwd() {
		return consumePwd;
	}
	public void setConsumePwd(String consumePwd) {
		this.consumePwd = consumePwd;
	}
	public String getIdentityPwd() {
		return identityPwd;
	}
	public void setIdentityPwd(String identityPwd) {
		this.identityPwd = identityPwd;
	}

}
