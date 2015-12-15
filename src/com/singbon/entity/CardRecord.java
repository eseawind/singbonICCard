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
	// 按卡修正
	public static Integer UpdateByCard = 15;
	// 按库修正
	public static Integer UpdateByUserInfo = 16;

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
			"卡注销", // 14
			"按卡修正", // 15
			"按库修正"// 16
	};
	private Integer id;
	private Integer companyId;
	private Integer operId;
	private Long userId;
	private Long cardNO;
	private String cardSN;
	private Integer recordType;
	private Integer opFare;
	private Long oddFare;
	private Long subsidyOddFare;
	private Long cardOddFare;
	private Long cardSubsidyOddFare;
	private Integer opCount;
	private Integer subsidyOpCount;
	private Integer cardOpCount;
	private Integer cardSubsidyOpCount;
	private String opTime;

	public static Integer getMakeCard() {
		return MakeCard;
	}

	public static void setMakeCard(Integer makeCard) {
		MakeCard = makeCard;
	}

	public static Integer getGetCardDeposit() {
		return GetCardDeposit;
	}

	public static void setGetCardDeposit(Integer getCardDeposit) {
		GetCardDeposit = getCardDeposit;
	}

	public static Integer getMakeCardGiveFare() {
		return MakeCardGiveFare;
	}

	public static void setMakeCardGiveFare(Integer makeCardGiveFare) {
		MakeCardGiveFare = makeCardGiveFare;
	}

	public static Integer getRemakeCard() {
		return RemakeCard;
	}

	public static void setRemakeCard(Integer remakeCard) {
		RemakeCard = remakeCard;
	}

	public static Integer getLoss() {
		return Loss;
	}

	public static void setLoss(Integer loss) {
		Loss = loss;
	}

	public static Integer getUnloss() {
		return Unloss;
	}

	public static void setUnloss(Integer unloss) {
		Unloss = unloss;
	}

	public static Integer getPCSaving() {
		return PCSaving;
	}

	public static void setPCSaving(Integer pCSaving) {
		PCSaving = pCSaving;
	}

	public static Integer getPCSavingGiveFare() {
		return PCSavingGiveFare;
	}

	public static void setPCSavingGiveFare(Integer pCSavingGiveFare) {
		PCSavingGiveFare = pCSavingGiveFare;
	}

	public static Integer getPCTake() {
		return PCTake;
	}

	public static void setPCTake(Integer pCTake) {
		PCTake = pCTake;
	}

	public static Integer getPosSubsidySaving() {
		return PosSubsidySaving;
	}

	public static void setPosSubsidySaving(Integer posSubsidySaving) {
		PosSubsidySaving = posSubsidySaving;
	}

	public static Integer getPosSubsidyClear() {
		return PosSubsidyClear;
	}

	public static void setPosSubsidyClear(Integer posSubsidyClear) {
		PosSubsidyClear = posSubsidyClear;
	}

	public static Integer getWaterSubsidySaving() {
		return WaterSubsidySaving;
	}

	public static void setWaterSubsidySaving(Integer waterSubsidySaving) {
		WaterSubsidySaving = waterSubsidySaving;
	}

	public static Integer getWaterSubsidyClear() {
		return WaterSubsidyClear;
	}

	public static void setWaterSubsidyClear(Integer waterSubsidyClear) {
		WaterSubsidyClear = waterSubsidyClear;
	}

	public static Integer getCardOff() {
		return CardOff;
	}

	public static void setCardOff(Integer cardOff) {
		CardOff = cardOff;
	}

	public static Integer getUpdateByCard() {
		return UpdateByCard;
	}

	public static void setUpdateByCard(Integer updateByCard) {
		UpdateByCard = updateByCard;
	}

	public static Integer getUpdateByUserInfo() {
		return UpdateByUserInfo;
	}

	public static void setUpdateByUserInfo(Integer updateByUserInfo) {
		UpdateByUserInfo = updateByUserInfo;
	}

	public static String[] getRecordTypes() {
		return recordTypes;
	}

	public static void setRecordTypes(String[] recordTypes) {
		CardRecord.recordTypes = recordTypes;
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

	public Long getCardOddFare() {
		return cardOddFare;
	}

	public void setCardOddFare(Long cardOddFare) {
		this.cardOddFare = cardOddFare;
	}

	public Long getCardSubsidyOddFare() {
		return cardSubsidyOddFare;
	}

	public void setCardSubsidyOddFare(Long cardSubsidyOddFare) {
		this.cardSubsidyOddFare = cardSubsidyOddFare;
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

	public Integer getCardOpCount() {
		return cardOpCount;
	}

	public void setCardOpCount(Integer cardOpCount) {
		this.cardOpCount = cardOpCount;
	}

	public Integer getCardSubsidyOpCount() {
		return cardSubsidyOpCount;
	}

	public void setCardSubsidyOpCount(Integer cardSubsidyOpCount) {
		this.cardSubsidyOpCount = cardSubsidyOpCount;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
