package com.singbon.entity;

import java.io.Serializable;

//用户卡信息
//
//@author 郝威
//

@SuppressWarnings("serial")
public class CardAllInfo implements Serializable {

	// 卡批次号
	private Integer cardBatch;
	// 限次时间段定义
	private Integer[] LimitPeriods;
	// 补助限次时间段定义
	private Integer[] SubsidyLimitPeriods;

	public Integer getCardBatch() {
		return cardBatch;
	}

	public void setCardBatch(Integer cardBatch) {
		this.cardBatch = cardBatch;
	}

	public Integer[] getLimitPeriods() {
		return LimitPeriods;
	}

	public void setLimitPeriods(Integer[] limitPeriods) {
		LimitPeriods = limitPeriods;
	}

	public Integer[] getSubsidyLimitPeriods() {
		return SubsidyLimitPeriods;
	}

	public void setSubsidyLimitPeriods(Integer[] subsidyLimitPeriods) {
		SubsidyLimitPeriods = subsidyLimitPeriods;
	}

}
