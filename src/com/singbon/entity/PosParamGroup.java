package com.singbon.entity;

import java.io.Serializable;

/**
 * 消费参数
 * 
 * @author 郝威
 * 
 */
public class PosParamGroup implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Integer cardMinFare;
	private String groupName;
	private Integer subsidyReset;
	private Integer subsidyFirst;
	private Integer enableCardMinFare;
	private Integer enableTimeLimitFare;
	private Integer enableDayLimitFare;
	private Integer enableDiscount;
	private Integer enableMeal;
	private Integer bound;

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

	public Integer getCardMinFare() {
		return cardMinFare;
	}

	public void setCardMinFare(Integer cardMinFare) {
		this.cardMinFare = cardMinFare;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getSubsidyReset() {
		return subsidyReset;
	}

	public void setSubsidyReset(Integer subsidyReset) {
		this.subsidyReset = subsidyReset;
	}

	public Integer getSubsidyFirst() {
		return subsidyFirst;
	}

	public void setSubsidyFirst(Integer subsidyFirst) {
		this.subsidyFirst = subsidyFirst;
	}

	public Integer getEnableCardMinFare() {
		return enableCardMinFare;
	}

	public void setEnableCardMinFare(Integer enableCardMinFare) {
		this.enableCardMinFare = enableCardMinFare;
	}

	public Integer getEnableTimeLimitFare() {
		return enableTimeLimitFare;
	}

	public void setEnableTimeLimitFare(Integer enableTimeLimitFare) {
		this.enableTimeLimitFare = enableTimeLimitFare;
	}

	public Integer getEnableDayLimitFare() {
		return enableDayLimitFare;
	}

	public void setEnableDayLimitFare(Integer enableDayLimitFare) {
		this.enableDayLimitFare = enableDayLimitFare;
	}

	public Integer getEnableDiscount() {
		return enableDiscount;
	}

	public void setEnableDiscount(Integer enableDiscount) {
		this.enableDiscount = enableDiscount;
	}

	public Integer getEnableMeal() {
		return enableMeal;
	}

	public void setEnableMeal(Integer enableMeal) {
		this.enableMeal = enableMeal;
	}

	public Integer getBound() {
		return bound;
	}

	public void setBound(Integer bound) {
		this.bound = bound;
	}

}
