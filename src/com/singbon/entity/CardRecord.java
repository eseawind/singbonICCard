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

	// 发卡
	public static Integer MakeCard = 0;
	// 收取卡押金
	public static Integer GetCardDeposit = 1;
	// 发卡赠送金额
	public static Integer MakeCardGiveFare = 2;
	// 补卡
	public static Integer RemakeCard = 3;
	// 挂失
	public static Integer Loss = 4;
	// 解挂
	public static Integer Unloss = 5;
	// PC存款
	public static Integer PCSaving = 6;
	// 充值赠送金额
	public static Integer PCSavingGiveFare = 7;
	// PC取款
	public static Integer PCTake = 8;
	// 退还卡押金
	public static Integer BackCardDeposit = 9;
	// 消费机补助存款
	public static Integer PosSubsidySaving = 10;
	// 消费机补助清零
	public static Integer PosSubsidyClear = 11;
	// 水控补助存款
	public static Integer WaterSubsidySaving = 12;
	// 水控补助清零
	public static Integer WaterSubsidyClear = 13;
	// 卡注销
	public static Integer CardOff = 14;

	public static String[] recordTypes = { "发卡", // 0
			"收取卡押金", // 1
			"发卡赠送金额", // 2
			"补卡", // 3
			"挂失", // 4
			"解挂", // 5
			"PC存款", // 6
			"存款赠送金额", // 7
			"PC取款", // 8
			"退还卡押金", // 9
			"消费机补助存款", // 10
			"消费机补助清零", // 11
			"水控补助存款", // 12
			"水控补助清零", // 13
			"卡注销"// 14
	};
	private Integer id;
	private Integer companyId;
	private Integer operId;
	private Long userId;
	private Long cardNO;
	private String cardSN;
	private Integer recordType;
	private Integer opFare;
	private Integer oddFare;
	private Integer subsidyOddFare;
	private Integer cardOddFare;
	private Integer cardSubsidyOddFare;
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

	public Integer getOperId() {
		return operId;
	}

	public void setOperId(Integer operId) {
		this.operId = operId;
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

	public Integer getOddFare() {
		return oddFare;
	}

	public void setOddFare(Integer oddFare) {
		this.oddFare = oddFare;
	}

	public Integer getSubsidyOddFare() {
		return subsidyOddFare;
	}

	public void setSubsidyOddFare(Integer subsidyOddFare) {
		this.subsidyOddFare = subsidyOddFare;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public Integer getCardOddFare() {
		return cardOddFare;
	}

	public void setCardOddFare(Integer cardOddFare) {
		this.cardOddFare = cardOddFare;
	}

	public Integer getCardSubsidyOddFare() {
		return cardSubsidyOddFare;
	}

	public void setCardSubsidyOddFare(Integer cardSubsidyOddFare) {
		this.cardSubsidyOddFare = cardSubsidyOddFare;
	}

}
