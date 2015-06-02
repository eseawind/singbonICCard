package com.singbon.entity;

import java.io.Serializable;

/**
 * 用户
 * 
 * @author 郝威
 * 
 */
public class User implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	private Integer companyId;

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	private Integer id;
	private UserDept userDept;
	public UserDept getUserDept() {
		return userDept;
	}

	public void setUserDept(UserDept userDept) {
		this.userDept = userDept;
	}

	private String userNO;
	private String username;
	private Integer sex;
	private String cardID;
	private Integer cardType;
	private Integer cardStatus;

	private String sexDesc;
	private String cardTypeDesc;
	private String cardStatusDesc;

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

	public Integer getCardStatus() {
		return cardStatus;
	}

	public void setCardStatus(Integer cardStatus) {
		this.cardStatus = cardStatus;
	}

	public String getSexDesc() {
		return sexDesc;
	}

	public void setSexDesc(String sexDesc) {
		this.sexDesc = sexDesc;
	}

	public String getCardTypeDesc() {
		return cardTypeDesc;
	}

	public void setCardTypeDesc(String cardTypeDesc) {
		this.cardTypeDesc = cardTypeDesc;
	}

	public String getCardStatusDesc() {
		return cardStatusDesc;
	}

	public void setCardStatusDesc(String cardStatusDesc) {
		this.cardStatusDesc = cardStatusDesc;
	}
}
