package com.singbon.entity;

import java.io.Serializable;

// 黑名单
//
//@author 郝威
//

public class CardBlack implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer companyId;
	private Long cardNO;
	private Integer blackType;

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

	public Long getCardNO() {
		return cardNO;
	}

	public void setCardNO(Long cardNO) {
		this.cardNO = cardNO;
	}

	public Integer getBlackType() {
		return blackType;
	}

	public void setBlackType(Integer blackType) {
		this.blackType = blackType;
	}

}
