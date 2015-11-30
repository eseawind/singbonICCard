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

	public static String[] recordTypes = { "发卡", // 0
			"收取卡押金", // 1
			"赠送金额", // 2
			"补卡", // 3
			"挂失", // 4
			"解挂", // 5
			"PC存款", // 6
			"PC取款", // 7
			"退还卡押金", // 8
			"补助存款", // 9
			"补助清零", // 10
			"卡注销"// 11
	};
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
