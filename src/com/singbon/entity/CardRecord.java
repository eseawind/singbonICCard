package com.singbon.entity;

import java.io.Serializable;

/**
 * 卡操作记录
 * 
 * @author 郝威
 * 
 */
public class CardRecord implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Long userId;
	private Long cardNO;
	private String cardSN;
	private Integer recordType;
	private Integer opFare;
	private String opTime;

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

	public Long getCardNO() {
		return cardNO;
	}

	public void setCardNO(Long cardNO) {
		this.cardNO = cardNO;
	}

	public String getCardSN() {
		return cardSN;
	}

	public void setCardSN(String cardSN) {
		this.cardSN = cardSN;
	}

	public Integer getRecordType() {
		return recordType;
	}

	public void setRecordType(Integer recordType) {
		this.recordType = recordType;
	}

	public Integer getOpFare() {
		return opFare;
	}

	public void setOpFare(Integer opFare) {
		this.opFare = opFare;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

}
