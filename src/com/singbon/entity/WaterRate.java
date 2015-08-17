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
	private String waterRateName;
	private String beginTime;
	private String endTime;
	private Integer rate1;
	private Integer rate2;
	private String authCard;

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

	public String getWaterRateName() {
		return waterRateName;
	}

	public void setWaterRateName(String waterRateName) {
		this.waterRateName = waterRateName;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getRate1() {
		return rate1;
	}

	public void setRate1(Integer rate1) {
		this.rate1 = rate1;
	}

	public Integer getRate2() {
		return rate2;
	}

	public void setRate2(Integer rate2) {
		this.rate2 = rate2;
	}

	public String getAuthCard() {
		return authCard;
	}

	public void setAuthCard(String authCard) {
		this.authCard = authCard;
	}

}
