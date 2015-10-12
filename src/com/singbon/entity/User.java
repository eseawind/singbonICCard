package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

//用户卡信息
//
//@author 郝威
//

public class User implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

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
	private Integer cardNO;
	// 物理卡号
	private String cardSN;
	// 卡序号(第几张卡)
	private Integer cardSeq;
	// 性别
	private Integer sex;
	// 性别描述
	@SuppressWarnings("unused")
	private String sexDesc;
	// 卡型号(0~15类卡)
	private Integer cardTypeId;
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
	private Date invalidDate;
	// 制卡日期
	private Date cardMakeDate;
	// 卡总额
	private Integer totalFare;
	// 卡状态
	private Integer status;
	// 卡状态描述
	@SuppressWarnings("unused")
	private String statusDesc;

	// 大钱包内容
	// 卡余额
	private Integer oddFare;
	// 上次消费时间
	private Date lastConsumeTime;
	// 当日操作金额
	private Integer daySumFare;
	// 卡操作计数器(大钱包)
	private Integer opCount;

	// 小钱包内容
	// 卡补助余额
	private Integer subsidyOddFare;
	// 上次补助消费时间
	private Date lastSubsidyConsumeTime;
	// 当日补助操作金额
	private Integer subsidyDaySum;
	// 卡操作计数器(小钱包)
	private Integer subsidyOpCount;
	// 补助版本
	private Integer subsidyVersion;
	// 补助失效日期
	private Date subsidyInvalidDate;
	// 总数量
	private Integer totalCount;

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
		if (this.sex == 0) {
			return "男";
		} else {
			return "女";
		}
	}

	public void setSexDesc(String sexDesc) {
		this.sexDesc = sexDesc;
	}

	public Integer getCardTypeId() {
		return cardTypeId;
	}

	public void setCardTypeId(Integer cardTypeId) {
		this.cardTypeId = cardTypeId;
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

	public Date getInvalidDate() {
		return invalidDate;
	}

	public void setInvalidDate(Date invalidDate) {
		this.invalidDate = invalidDate;
	}

	/**
	 * 0未发卡、241正常、243挂失、244注销卡，其他都是异常卡
	 * 
	 * @return
	 */
	public Integer getStatus() {
		return status;
	}

	/**
	 * 0未发卡、241正常、243挂失、244注销卡，其他都是异常卡
	 */
	public void setStatus(Integer status) {
		this.status = status;
	}

	/**
	 * 0未发卡、241正常、243挂失、244注销卡，其他都是异常卡
	 */
	public String getStatusDesc() {
		String des = null;
		if (status == 0) {
			des = "未发卡";
		} else if (status == 241) {
			des = "正常";
		} else if (status == 243) {
			des = "挂失";
		} else if (status == 244) {
			des = "注销";
		} else  {
			des = "异常卡";
		}
		return des;
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	public Date getLastConsumeTime() {
		return lastConsumeTime;
	}

	public void setLastConsumeTime(Date lastConsumeTime) {
		this.lastConsumeTime = lastConsumeTime;
	}

	public Integer getDaySumFare() {
		return daySumFare;
	}

	public void setDaySumFare(Integer daySumFare) {
		this.daySumFare = daySumFare;
	}

	public Date getLastSubsidyConsumeTime() {
		return lastSubsidyConsumeTime;
	}

	public void setLastSubsidyConsumeTime(Date lastSubsidyConsumeTime) {
		this.lastSubsidyConsumeTime = lastSubsidyConsumeTime;
	}

	public Integer getSubsidyVersion() {
		return subsidyVersion;
	}

	public void setSubsidyVersion(Integer subsidyVersion) {
		this.subsidyVersion = subsidyVersion;
	}

	public Date getSubsidyInvalidDate() {
		return subsidyInvalidDate;
	}

	public void setSubsidyInvalidDate(Date subsidyInvalidDate) {
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

	public Date getCardMakeDate() {
		return cardMakeDate;
	}

	public void setCardMakeDate(Date cardMakeDate) {
		this.cardMakeDate = cardMakeDate;
	}

	public Integer getTotalFare() {
		return totalFare;
	}

	public void setTotalFare(Integer totalFare) {
		this.totalFare = totalFare;
	}

	public Integer getOddFare() {
		return oddFare;
	}

	public void setOddFare(Integer oddFare) {
		this.oddFare = oddFare;
	}

	public Integer getOpCount() {
		return opCount;
	}

	public void setOpCount(Integer opCount) {
		this.opCount = opCount;
	}

	public Integer getSubsidyOddFare() {
		return subsidyOddFare;
	}

	public void setSubsidyOddFare(Integer subsidyOddFare) {
		this.subsidyOddFare = subsidyOddFare;
	}

	public Integer getSubsidyDaySum() {
		return subsidyDaySum;
	}

	public void setSubsidyDaySum(Integer subsidyDaySum) {
		this.subsidyDaySum = subsidyDaySum;
	}

	public Integer getSubsidyOpCount() {
		return subsidyOpCount;
	}

	public void setSubsidyOpCount(Integer subsidyOpCount) {
		this.subsidyOpCount = subsidyOpCount;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

}
