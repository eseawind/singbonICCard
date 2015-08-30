package com.singbon.entity;

import java.io.Serializable;

/**
 * 水控费率2、3、4
 * 
 * @author 郝威
 * 
 */
public class WaterRate implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private Integer consumeType;
	private Integer goWaterType;
	private Integer stopWaterType;
	private Integer rate1Status;
	private Integer rate1ConsumeFare;
	private Integer rate1ConsumeCycle;
	private Integer rate1NextDayReset;
	private Integer rate2Status;
	private String rate2BeginTime;
	private String rate2EndTime;
	private Integer rate2Value1;
	private Integer rate2Value2;
	private String rate2CardTypes;
	private Integer rate3Status;
	private String rate3BeginTime;
	private String rate3EndTime;
	private Integer rate3Value1;
	private Integer rate3Value2;
	private String rate3CardTypes;
	private Integer rate4Status;
	private String rate4BeginTime;
	private String rate4EndTime;
	private Integer rate4Value1;
	private Integer rate4Value2;
	private String rate4CardTypes;
	private Integer rate5DeductFare;
	private Integer rate5DeductCycle;

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

	public Integer getRate1Status() {
		return rate1Status;
	}

	public void setRate1Status(Integer rate1Status) {
		this.rate1Status = rate1Status;
	}

	public Integer getRate1ConsumeFare() {
		return rate1ConsumeFare;
	}

	public void setRate1ConsumeFare(Integer rate1ConsumeFare) {
		this.rate1ConsumeFare = rate1ConsumeFare;
	}

	public Integer getRate1ConsumeCycle() {
		return rate1ConsumeCycle;
	}

	public void setRate1ConsumeCycle(Integer rate1ConsumeCycle) {
		this.rate1ConsumeCycle = rate1ConsumeCycle;
	}

	public Integer getRate1NextDayReset() {
		return rate1NextDayReset;
	}

	public void setRate1NextDayReset(Integer rate1NextDayReset) {
		this.rate1NextDayReset = rate1NextDayReset;
	}

	public Integer getRate2Status() {
		return rate2Status;
	}

	public void setRate2Status(Integer rate2Status) {
		this.rate2Status = rate2Status;
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

	public Integer getRate2Value1() {
		return rate2Value1;
	}

	public void setRate2Value1(Integer rate2Value1) {
		this.rate2Value1 = rate2Value1;
	}

	public Integer getRate2Value2() {
		return rate2Value2;
	}

	public void setRate2Value2(Integer rate2Value2) {
		this.rate2Value2 = rate2Value2;
	}

	public String getRate2CardTypes() {
		return rate2CardTypes;
	}

	public void setRate2CardTypes(String rate2CardTypes) {
		this.rate2CardTypes = rate2CardTypes;
	}

	public Integer getRate3Status() {
		return rate3Status;
	}

	public void setRate3Status(Integer rate3Status) {
		this.rate3Status = rate3Status;
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

	public Integer getRate3Value1() {
		return rate3Value1;
	}

	public void setRate3Value1(Integer rate3Value1) {
		this.rate3Value1 = rate3Value1;
	}

	public Integer getRate3Value2() {
		return rate3Value2;
	}

	public void setRate3Value2(Integer rate3Value2) {
		this.rate3Value2 = rate3Value2;
	}

	public String getRate3CardTypes() {
		return rate3CardTypes;
	}

	public void setRate3CardTypes(String rate3CardTypes) {
		this.rate3CardTypes = rate3CardTypes;
	}

	public Integer getRate4Status() {
		return rate4Status;
	}

	public void setRate4Status(Integer rate4Status) {
		this.rate4Status = rate4Status;
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

	public Integer getRate4Value1() {
		return rate4Value1;
	}

	public void setRate4Value1(Integer rate4Value1) {
		this.rate4Value1 = rate4Value1;
	}

	public Integer getRate4Value2() {
		return rate4Value2;
	}

	public void setRate4Value2(Integer rate4Value2) {
		this.rate4Value2 = rate4Value2;
	}

	public String getRate4CardTypes() {
		return rate4CardTypes;
	}

	public void setRate4CardTypes(String rate4CardTypes) {
		this.rate4CardTypes = rate4CardTypes;
	}

	public Integer getRate5DeductFare() {
		return rate5DeductFare;
	}

	public void setRate5DeductFare(Integer rate5DeductFare) {
		this.rate5DeductFare = rate5DeductFare;
	}

	public Integer getRate5DeductCycle() {
		return rate5DeductCycle;
	}

	public void setRate5DeductCycle(Integer rate5DeductCycle) {
		this.rate5DeductCycle = rate5DeductCycle;
	}

}
