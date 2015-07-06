package com.singbon.entity;

import java.io.Serializable;

//用户卡信息
//
//@author 郝威
//

public class CardAllInfo implements Serializable {

	// 卡批次号
	private Integer cardBatch;
	// 开户卡成本
	private Integer cardCost;
	// 卡底金 单位是元
	private Integer cardDeposit;
	// 日消费限额 单位是元
	private Integer limitDayFare;
	// 次消费限额
	private Integer limitTimesFare;
	// 操作额
	private Integer opCash;
	// 赠送金额
	private Integer giveCash;
	// 限次时间段定义
	private Integer[] LimitPeriods;

	public Integer getCardBatch() {
		return cardBatch;
	}

	public void setCardBatch(Integer cardBatch) {
		this.cardBatch = cardBatch;
	}

	public Integer getCardCost() {
		return cardCost;
	}

	public void setCardCost(Integer cardCost) {
		this.cardCost = cardCost;
	}

	public Integer getCardDeposit() {
		return cardDeposit;
	}

	public void setCardDeposit(Integer cardDeposit) {
		this.cardDeposit = cardDeposit;
	}

	public Integer getLimitDayFare() {
		return limitDayFare;
	}

	public void setLimitDayFare(Integer limitDayFare) {
		this.limitDayFare = limitDayFare;
	}

	public Integer getLimitTimesFare() {
		return limitTimesFare;
	}

	public void setLimitTimesFare(Integer limitTimesFare) {
		this.limitTimesFare = limitTimesFare;
	}

	public Integer getOpCash() {
		return opCash;
	}

	public void setOpCash(Integer opCash) {
		this.opCash = opCash;
	}

	public Integer[] getLimitPeriods() {
		return LimitPeriods;
	}

	public void setLimitPeriods(Integer[] limitPeriods) {
		LimitPeriods = limitPeriods;
	}

	public Integer getGiveCash() {
		return giveCash;
	}

	public void setGiveCash(Integer giveCash) {
		this.giveCash = giveCash;
	}

}
