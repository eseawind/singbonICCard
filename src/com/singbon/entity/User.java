package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

//用户卡信息
//
//@author 郝威
//

public class User implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	String[] statusDescList = { "未发卡", "正常卡", "挂失", "异常卡" };

	// 卡基本信息
	// 用户帐号
	private Integer userId;
	// 所属公司
	private Integer companyId;
	// 部门编码
	private Integer deptId;
	// 用户姓名
	private String username;
	// 姓名简拼
	private String shortName;
	// 用户编号
	private String userNO;
	// 身份证号
	private String cardID;
	// 逻辑卡号
	private String cardNO;
	// 物理卡号
	private String cardSN;
	// 卡序号(第几张卡)
	private Integer cardSeq;
	// 性别
	private Integer sex;
	// 性别描述
	private String sexDesc;
	// 卡型号(0~15类卡)
	private Integer cardType;
	// 卡功能
	private Integer cardFunc;
	// 卡功能描述
	private String cardFuncDesc;
	// 客户身份
	private Integer cardIdentity;
	// 客户身份描述
	private String cardIdentityDesc;
	private Date beginDate;
	private Date endDate;
	// 消费密码
	private String consumePwd;
	// 身份密码
	private String identityPwd;
	// 失效期(YYYY-MM-DD)
	private String invalidDate;
	// 卡总额
	private Integer cardTotalFare;
	// 卡状态
	private Integer status;
	// 卡状态描述
	private String statusDesc;

	// 大钱包内容
	// 卡余额
	private Integer cardOddFare;
	// 上次消费时间
	private String lastConsumeTime;
	// 当日操作金额
	private Integer daySumFare;
	// 卡操作计数器(大钱包)
	private Integer cardOPCounter;

	// 小钱包内容
	// 卡补助余额
	private Integer cardOddSubsidy;
	// 上次补助消费时间
	private String lastSubsidyConsumeTime;
	// 当日补助操作金额
	private Integer daySumSubsidy;
	// 卡操作计数器(小钱包)
	private Integer subsidyCardOPCounter;
	// 补助计数器
	private Integer subsidyTimesCounter;
	// 补助失效日期
	private String subsidyInvalidDate;

	public String[] getStatusDescList() {
		return statusDescList;
	}

	public void setStatusDescList(String[] statusDescList) {
		this.statusDescList = statusDescList;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
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

	public String getCardNO() {
		return cardNO;
	}

	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}

	public String getCardSN() {
		return cardSN;
	}

	public void setCardSN(String cardSN) {
		this.cardSN = cardSN;
	}

	public Integer getCardSeq() {
		return cardSeq;
	}

	public void setCardSeq(Integer cardSeq) {
		this.cardSeq = cardSeq;
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

	public Integer getCardType() {
		return cardType;
	}

	public void setCardType(Integer cardType) {
		this.cardType = cardType;
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

	public String getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(String invalidDate) {
		this.invalidDate = invalidDate;
	}

	public Integer getCardTotalFare() {
		return cardTotalFare;
	}

	public void setCardTotalFare(Integer cardTotalFare) {
		this.cardTotalFare = cardTotalFare;
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

	public Integer getCardOddFare() {
		return cardOddFare;
	}

	public void setCardOddFare(Integer cardOddFare) {
		this.cardOddFare = cardOddFare;
	}

	public String getLastConsumeTime() {
		return lastConsumeTime;
	}

	public void setLastConsumeTime(String lastConsumeTime) {
		this.lastConsumeTime = lastConsumeTime;
	}

	public Integer getDaySumFare() {
		return daySumFare;
	}

	public void setDaySumFare(Integer daySumFare) {
		this.daySumFare = daySumFare;
	}

	public Integer getCardOPCounter() {
		return cardOPCounter;
	}

	public void setCardOPCounter(Integer cardOPCounter) {
		this.cardOPCounter = cardOPCounter;
	}

	public Integer getCardOddSubsidy() {
		return cardOddSubsidy;
	}

	public void setCardOddSubsidy(Integer cardOddSubsidy) {
		this.cardOddSubsidy = cardOddSubsidy;
	}

	public String getLastSubsidyConsumeTime() {
		return lastSubsidyConsumeTime;
	}

	public void setLastSubsidyConsumeTime(String lastSubsidyConsumeTime) {
		this.lastSubsidyConsumeTime = lastSubsidyConsumeTime;
	}

	public Integer getDaySumSubsidy() {
		return daySumSubsidy;
	}

	public void setDaySumSubsidy(Integer daySumSubsidy) {
		this.daySumSubsidy = daySumSubsidy;
	}

	public Integer getSubsidyCardOPCounter() {
		return subsidyCardOPCounter;
	}

	public void setSubsidyCardOPCounter(Integer subsidyCardOPCounter) {
		this.subsidyCardOPCounter = subsidyCardOPCounter;
	}

	public Integer getSubsidyTimesCounter() {
		return subsidyTimesCounter;
	}

	public void setSubsidyTimesCounter(Integer subsidyTimesCounter) {
		this.subsidyTimesCounter = subsidyTimesCounter;
	}

	public String getSubsidyInvalidDate() {
		return subsidyInvalidDate;
	}

	public void setSubsidyInvalidDate(String subsidyInvalidDate) {
		this.subsidyInvalidDate = subsidyInvalidDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCardID() {
		return cardID;
	}

	public void setCardID(String cardID) {
		this.cardID = cardID;
	}

}
