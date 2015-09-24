package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 消费数据
 * 
 * @author 郝威
 * 
 */
public class ConsumeRecord implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer userId;
	private String userNO;
	private String username;
	private Integer cardNO;
	private Integer cardSeq;
	private Integer consumeType;
	private String consumeTypeDes;
	private Integer deviceNum;
	private Integer cardSumFare;
	private Integer cardOddFare;
	private Integer discountFare;
	private Integer subsidyOddFare;
	private Integer cardOpFare;
	private Integer cardOpCount;
	private Integer subsidyOpCount;
	private Integer subsidyOpFare;
	private Date opTime;
	private String opTimeDes;
	private Integer recordNO;
	private Integer mealId;
	private String mealName;
	private Date uploadTime;

	private Integer cookbookCode;
	private Integer cookbookNum;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
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

	public Integer getCardNO() {
		return cardNO;
	}

	public void setCardNO(Integer cardNO) {
		this.cardNO = cardNO;
	}

	public Integer getCardSeq() {
		return cardSeq;
	}

	public void setCardSeq(Integer cardSeq) {
		this.cardSeq = cardSeq;
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

	public Integer getDeviceNum() {
		return deviceNum;
	}

	public void setDeviceNum(Integer deviceNum) {
		this.deviceNum = deviceNum;
	}

	public Integer getCardSumFare() {
		return cardSumFare;
	}

	public void setCardSumFare(Integer cardSumFare) {
		this.cardSumFare = cardSumFare;
	}

	public Integer getCardOddFare() {
		return cardOddFare;
	}

	public void setCardOddFare(Integer cardOddFare) {
		this.cardOddFare = cardOddFare;
	}

	public Integer getDiscountFare() {
		return discountFare;
	}

	public void setDiscountFare(Integer discountFare) {
		this.discountFare = discountFare;
	}

	public Integer getSubsidyOddFare() {
		return subsidyOddFare;
	}

	public void setSubsidyOddFare(Integer subsidyOddFare) {
		this.subsidyOddFare = subsidyOddFare;
	}

	public Integer getCardOpFare() {
		return cardOpFare;
	}

	public void setCardOpFare(Integer cardOpFare) {
		this.cardOpFare = cardOpFare;
	}

	public Integer getCardOpCount() {
		return cardOpCount;
	}

	public void setCardOpCount(Integer cardOpCount) {
		this.cardOpCount = cardOpCount;
	}

	public Integer getSubsidyOpCount() {
		return subsidyOpCount;
	}

	public void setSubsidyOpCount(Integer subsidyOpCount) {
		this.subsidyOpCount = subsidyOpCount;
	}

	public Integer getSubsidyOpFare() {
		return subsidyOpFare;
	}

	public void setSubsidyOpFare(Integer subsidyOpFare) {
		this.subsidyOpFare = subsidyOpFare;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public String getOpTimeDes() {
		return opTimeDes;
	}

	public void setOpTimeDes(String opTimeDes) {
		this.opTimeDes = opTimeDes;
	}

	public Integer getRecordNO() {
		return recordNO;
	}

	public void setRecordNO(Integer recordNO) {
		this.recordNO = recordNO;
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

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public Integer getCookbookCode() {
		return cookbookCode;
	}

	public void setCookbookCode(Integer cookbookCode) {
		this.cookbookCode = cookbookCode;
	}

	public Integer getCookbookNum() {
		return cookbookNum;
	}

	public void setCookbookNum(Integer cookbookNum) {
		this.cookbookNum = cookbookNum;
	}

}
