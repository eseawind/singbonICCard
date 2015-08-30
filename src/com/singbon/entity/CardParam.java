package com.singbon.entity;

import java.io.Serializable;

/**
 * 制卡参数
 * 
 * @author 郝威
 * 
 */
public class CardParam implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	// 卡成本（单位元、0元）
	// 卡押金（单位元、0元）
	// 预付金额（单位元、0元）

	private Integer id;
	private Integer companyId;
	private Integer cardCost;
	private Integer cardDeposit;
	private Integer prepayFare;

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

	public Integer getPrepayFare() {
		return prepayFare;
	}

	public void setPrepayFare(Integer prepayFare) {
		this.prepayFare = prepayFare;
	}

}
