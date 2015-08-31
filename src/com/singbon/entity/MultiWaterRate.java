package com.singbon.entity;

import java.io.Serializable;

/**
 * 一控多水控费率
 * 
 * @author 郝威
 * 
 */
public class MultiWaterRate implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private Integer consumeType;
	private Integer chargeType;
	private Integer rate1Status;
	private Integer rate1DeductFare;
	private Integer rate1DeductCycle;
	private Integer rate2Status;
	private Integer rate2DeductFare;
	private Integer rate2DeductCycle;
	private Integer rate3Status;
	private Integer rate3DeductFare;
	private Integer rate3DeductCycle;
	private Integer rate4Status;
	private Integer rate4DeductFare;
	private Integer rate4DeductCycle;

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

	public Integer getChargeType() {
		return chargeType;
	}

	public void setChargeType(Integer chargeType) {
		this.chargeType = chargeType;
	}

	public Integer getRate1Status() {
		return rate1Status;
	}

	public void setRate1Status(Integer rate1Status) {
		this.rate1Status = rate1Status;
	}

	public Integer getRate1DeductFare() {
		return rate1DeductFare;
	}

	public void setRate1DeductFare(Integer rate1DeductFare) {
		this.rate1DeductFare = rate1DeductFare;
	}

	public Integer getRate1DeductCycle() {
		return rate1DeductCycle;
	}

	public void setRate1DeductCycle(Integer rate1DeductCycle) {
		this.rate1DeductCycle = rate1DeductCycle;
	}

	public Integer getRate2Status() {
		return rate2Status;
	}

	public void setRate2Status(Integer rate2Status) {
		this.rate2Status = rate2Status;
	}

	public Integer getRate2DeductFare() {
		return rate2DeductFare;
	}

	public void setRate2DeductFare(Integer rate2DeductFare) {
		this.rate2DeductFare = rate2DeductFare;
	}

	public Integer getRate2DeductCycle() {
		return rate2DeductCycle;
	}

	public void setRate2DeductCycle(Integer rate2DeductCycle) {
		this.rate2DeductCycle = rate2DeductCycle;
	}

	public Integer getRate3Status() {
		return rate3Status;
	}

	public void setRate3Status(Integer rate3Status) {
		this.rate3Status = rate3Status;
	}

	public Integer getRate3DeductFare() {
		return rate3DeductFare;
	}

	public void setRate3DeductFare(Integer rate3DeductFare) {
		this.rate3DeductFare = rate3DeductFare;
	}

	public Integer getRate3DeductCycle() {
		return rate3DeductCycle;
	}

	public void setRate3DeductCycle(Integer rate3DeductCycle) {
		this.rate3DeductCycle = rate3DeductCycle;
	}

	public Integer getRate4Status() {
		return rate4Status;
	}

	public void setRate4Status(Integer rate4Status) {
		this.rate4Status = rate4Status;
	}

	public Integer getRate4DeductFare() {
		return rate4DeductFare;
	}

	public void setRate4DeductFare(Integer rate4DeductFare) {
		this.rate4DeductFare = rate4DeductFare;
	}

	public Integer getRate4DeductCycle() {
		return rate4DeductCycle;
	}

	public void setRate4DeductCycle(Integer rate4DeductCycle) {
		this.rate4DeductCycle = rate4DeductCycle;
	}

}
