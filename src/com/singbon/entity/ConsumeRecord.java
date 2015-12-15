package com.singbon.entity;

import java.io.Serializable;

/**
 * 消费数据
 * 
 * @author 郝威
 * 
 */
public class ConsumeRecord implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Long userId;
	private String userNO;
	private String username;
	private Long cardNO;
	private Integer cardSeq;
	private Integer deviceId;
	private String deviceName;
	private Long sumFare;
	private Long oddFare;
	private Long subsidyOddFare;
	private Long discountFare;
	private Long opFare;
	private Long subsidyOpFare;
	private Integer mealId;
	private String mealName;
	private String opTime;
	private String collectTime;
	private Integer opCount;
	private Integer subsidyOpCount;
	private Integer recordNO;
	private Integer consumeType;
	private String consumeTypeDes;
	private Integer cookbookCode;
	private String cookbookName;
	private Integer cookbookNum;
	private Integer result;
	private Integer recordCount;
	private Integer subsidyAuth;
	private String cardSN;

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

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUserNO() {
		return userNO;
	}

	public void setUserNO(String userNO) {
		this.userNO = userNO;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Long getCardNO() {
		return cardNO;
	}

	public void setCardNO(Long cardNO) {
		this.cardNO = cardNO;
	}

	public Integer getCardSeq() {
		return cardSeq;
	}

	public void setCardSeq(Integer cardSeq) {
		this.cardSeq = cardSeq;
	}

	public Integer getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Integer deviceId) {
		this.deviceId = deviceId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public Long getSumFare() {
		return sumFare;
	}

	public void setSumFare(Long sumFare) {
		this.sumFare = sumFare;
	}

	public Long getOddFare() {
		return oddFare;
	}

	public void setOddFare(Long oddFare) {
		this.oddFare = oddFare;
	}

	public Long getSubsidyOddFare() {
		return subsidyOddFare;
	}

	public void setSubsidyOddFare(Long subsidyOddFare) {
		this.subsidyOddFare = subsidyOddFare;
	}

	public Long getDiscountFare() {
		return discountFare;
	}

	public void setDiscountFare(Long discountFare) {
		this.discountFare = discountFare;
	}

	public Long getOpFare() {
		return opFare;
	}

	public void setOpFare(Long opFare) {
		this.opFare = opFare;
	}

	public Long getSubsidyOpFare() {
		return subsidyOpFare;
	}

	public void setSubsidyOpFare(Long subsidyOpFare) {
		this.subsidyOpFare = subsidyOpFare;
	}

	public Integer getMealId() {
		return mealId;
	}

	public void setMealId(Integer mealId) {
		this.mealId = mealId;
	}

	public String getMealName() {
		return mealName;
	}

	public void setMealName(String mealName) {
		this.mealName = mealName;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getCollectTime() {
		return collectTime;
	}

	public void setCollectTime(String collectTime) {
		this.collectTime = collectTime;
	}

	public Integer getOpCount() {
		return opCount;
	}

	public void setOpCount(Integer opCount) {
		this.opCount = opCount;
	}

	public Integer getSubsidyOpCount() {
		return subsidyOpCount;
	}

	public void setSubsidyOpCount(Integer subsidyOpCount) {
		this.subsidyOpCount = subsidyOpCount;
	}

	public Integer getRecordNO() {
		return recordNO;
	}

	public void setRecordNO(Integer recordNO) {
		this.recordNO = recordNO;
	}

	public Integer getConsumeType() {
		return consumeType;
	}

	public void setConsumeType(Integer consumeType) {
		this.consumeType = consumeType;
	}

	public String getConsumeTypeDes() {
		return consumeTypeDes;
	}

	public void setConsumeTypeDes(String consumeTypeDes) {
		this.consumeTypeDes = consumeTypeDes;
	}

	public Integer getCookbookCode() {
		return cookbookCode;
	}

	public void setCookbookCode(Integer cookbookCode) {
		this.cookbookCode = cookbookCode;
	}

	public String getCookbookName() {
		return cookbookName;
	}

	public void setCookbookName(String cookbookName) {
		this.cookbookName = cookbookName;
	}

	public Integer getCookbookNum() {
		return cookbookNum;
	}

	public void setCookbookNum(Integer cookbookNum) {
		this.cookbookNum = cookbookNum;
	}

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public Integer getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(Integer recordCount) {
		this.recordCount = recordCount;
	}

	public Integer getSubsidyAuth() {
		return subsidyAuth;
	}

	public void setSubsidyAuth(Integer subsidyAuth) {
		this.subsidyAuth = subsidyAuth;
	}

	public String getCardSN() {
		return cardSN;
	}

	public void setCardSN(String cardSN) {
		this.cardSN = cardSN;
	}

}
