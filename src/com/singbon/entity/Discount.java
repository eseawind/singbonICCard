package com.singbon.entity;

import java.io.Serializable;

/**
 * 优惠方案
 * 
 * @author 郝威
 * 
 */
public class Discount implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private Integer companyId;

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getDiscountType() {
		return discountType;
	}

	public void setDiscountType(Integer discountType) {
		this.discountType = discountType;
	}

	private Integer discountType;
	private Integer rate;
	private Integer subsidy;
	private Integer giveCash;

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public Integer getSubsidy() {
		return subsidy;
	}

	public void setSubsidy(Integer subsidy) {
		this.subsidy = subsidy;
	}

	public Integer getGiveCash() {
		return giveCash;
	}

	public void setGiveCash(Integer giveCash) {
		this.giveCash = giveCash;
	}
}
