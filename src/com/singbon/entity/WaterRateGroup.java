package com.singbon.entity;

import java.io.Serializable;

/**
 * 一控一水控费率
 * 
 * @author 郝威
 * 
 */
public class WaterRateGroup implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private String groupName;
	private Integer consumeType;
	private Integer goWaterType;
	private Integer stopWaterType;
	private Integer waterPrecision;
	private Integer rate1Fare;
	private Integer rate1Cycle;
	private Integer rate1Water;
	private Integer rate1NextDayReset;
	private Integer rate1Status;
	private String rate1CardTypes;
	private Integer rate2Fare;
	private Integer rate2Cycle;
	private Integer rate2Water;
	private String rate2BeginTime;
	private String rate2EndTime;
	private String rate2CardTypes;
	private Integer rate3Fare;
	private Integer rate3Cycle;
	private Integer rate3Water;
	private String rate3BeginTime;
	private String rate3EndTime;
	private String rate3CardTypes;
	private Integer rate4Fare;
	private Integer rate4Cycle;
	private Integer rate4Water;
	private String rate4BeginTime;
	private String rate4EndTime;
	private String rate4CardTypes;
	private Integer rate5Fare;
	private Integer rate5Cycle;
	private Integer rate5Water;
	private Integer pwd;
	private Integer bound;
	private Integer subsidyReset;
	private Integer subsidyFirst;
	private Integer enableCheckTime;
	private Integer enableCardMinFare;
	private Integer enableTimeLimitFare;
	private Integer enableDayLimitFare;
	private Integer enableDiscount;
	private Integer enableMeal;
	private Integer updateNum;
	private Integer deviceNum;

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

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getConsumeType() {
		return consumeType;
	}

	public void setConsumeType(Integer consumeType) {
		this.consumeType = consumeType;
	}

	public Integer getGoWaterType() {
		return goWaterType;
	}

	public void setGoWaterType(Integer goWaterType) {
		this.goWaterType = goWaterType;
	}

	public Integer getStopWaterType() {
		return stopWaterType;
	}

	public void setStopWaterType(Integer stopWaterType) {
		this.stopWaterType = stopWaterType;
	}

	public Integer getWaterPrecision() {
		return waterPrecision;
	}

	public void setWaterPrecision(Integer waterPrecision) {
		this.waterPrecision = waterPrecision;
	}

	public Integer getRate1Fare() {
		return rate1Fare;
	}

	public void setRate1Fare(Integer rate1Fare) {
		this.rate1Fare = rate1Fare;
	}

	public Integer getRate1Cycle() {
		return rate1Cycle;
	}

	public void setRate1Cycle(Integer rate1Cycle) {
		this.rate1Cycle = rate1Cycle;
	}

	public Integer getRate1Water() {
		return rate1Water;
	}

	public void setRate1Water(Integer rate1Water) {
		this.rate1Water = rate1Water;
	}

	public Integer getRate1NextDayReset() {
		return rate1NextDayReset;
	}

	public void setRate1NextDayReset(Integer rate1NextDayReset) {
		this.rate1NextDayReset = rate1NextDayReset;
	}

	public Integer getRate1Status() {
		return rate1Status;
	}

	public void setRate1Status(Integer rate1Status) {
		this.rate1Status = rate1Status;
	}

	public String getRate1CardTypes() {
		return rate1CardTypes;
	}

	public void setRate1CardTypes(String rate1CardTypes) {
		this.rate1CardTypes = rate1CardTypes;
	}

	public Integer getRate2Fare() {
		return rate2Fare;
	}

	public void setRate2Fare(Integer rate2Fare) {
		this.rate2Fare = rate2Fare;
	}

	public Integer getRate2Cycle() {
		return rate2Cycle;
	}

	public void setRate2Cycle(Integer rate2Cycle) {
		this.rate2Cycle = rate2Cycle;
	}

	public Integer getRate2Water() {
		return rate2Water;
	}

	public void setRate2Water(Integer rate2Water) {
		this.rate2Water = rate2Water;
	}

	public String getRate2BeginTime() {
		return rate2BeginTime;
	}

	public void setRate2BeginTime(String rate2BeginTime) {
		this.rate2BeginTime = rate2BeginTime;
	}

	public String getRate2EndTime() {
		return rate2EndTime;
	}

	public void setRate2EndTime(String rate2EndTime) {
		this.rate2EndTime = rate2EndTime;
	}

	public String getRate2CardTypes() {
		return rate2CardTypes;
	}

	public void setRate2CardTypes(String rate2CardTypes) {
		this.rate2CardTypes = rate2CardTypes;
	}

	public Integer getRate3Fare() {
		return rate3Fare;
	}

	public void setRate3Fare(Integer rate3Fare) {
		this.rate3Fare = rate3Fare;
	}

	public Integer getRate3Cycle() {
		return rate3Cycle;
	}

	public void setRate3Cycle(Integer rate3Cycle) {
		this.rate3Cycle = rate3Cycle;
	}

	public Integer getRate3Water() {
		return rate3Water;
	}

	public void setRate3Water(Integer rate3Water) {
		this.rate3Water = rate3Water;
	}

	public String getRate3BeginTime() {
		return rate3BeginTime;
	}

	public void setRate3BeginTime(String rate3BeginTime) {
		this.rate3BeginTime = rate3BeginTime;
	}

	public String getRate3EndTime() {
		return rate3EndTime;
	}

	public void setRate3EndTime(String rate3EndTime) {
		this.rate3EndTime = rate3EndTime;
	}

	public String getRate3CardTypes() {
		return rate3CardTypes;
	}

	public void setRate3CardTypes(String rate3CardTypes) {
		this.rate3CardTypes = rate3CardTypes;
	}

	public Integer getRate4Fare() {
		return rate4Fare;
	}

	public void setRate4Fare(Integer rate4Fare) {
		this.rate4Fare = rate4Fare;
	}

	public Integer getRate4Cycle() {
		return rate4Cycle;
	}

	public void setRate4Cycle(Integer rate4Cycle) {
		this.rate4Cycle = rate4Cycle;
	}

	public Integer getRate4Water() {
		return rate4Water;
	}

	public void setRate4Water(Integer rate4Water) {
		this.rate4Water = rate4Water;
	}

	public String getRate4BeginTime() {
		return rate4BeginTime;
	}

	public void setRate4BeginTime(String rate4BeginTime) {
		this.rate4BeginTime = rate4BeginTime;
	}

	public String getRate4EndTime() {
		return rate4EndTime;
	}

	public void setRate4EndTime(String rate4EndTime) {
		this.rate4EndTime = rate4EndTime;
	}

	public String getRate4CardTypes() {
		return rate4CardTypes;
	}

	public void setRate4CardTypes(String rate4CardTypes) {
		this.rate4CardTypes = rate4CardTypes;
	}

	public Integer getRate5Fare() {
		return rate5Fare;
	}

	public void setRate5Fare(Integer rate5Fare) {
		this.rate5Fare = rate5Fare;
	}

	public Integer getRate5Cycle() {
		return rate5Cycle;
	}

	public void setRate5Cycle(Integer rate5Cycle) {
		this.rate5Cycle = rate5Cycle;
	}

	public Integer getRate5Water() {
		return rate5Water;
	}

	public void setRate5Water(Integer rate5Water) {
		this.rate5Water = rate5Water;
	}

	public Integer getPwd() {
		return pwd;
	}

	public void setPwd(Integer pwd) {
		this.pwd = pwd;
	}

	public Integer getBound() {
		return bound;
	}

	public void setBound(Integer bound) {
		this.bound = bound;
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

	public Integer getEnableCheckTime() {
		return enableCheckTime;
	}

	public void setEnableCheckTime(Integer enableCheckTime) {
		this.enableCheckTime = enableCheckTime;
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

	public Integer getUpdateNum() {
		return updateNum;
	}

	public void setUpdateNum(Integer updateNum) {
		this.updateNum = updateNum;
	}

	public Integer getDeviceNum() {
		return deviceNum;
	}

	public void setDeviceNum(Integer deviceNum) {
		this.deviceNum = deviceNum;
	}

}
