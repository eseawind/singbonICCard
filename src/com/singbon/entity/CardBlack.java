package com.singbon.entity;

import java.io.Serializable;

//用户卡挂失
//
//@author 郝威
//

public class CardBlack implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	// 所属公司
	private Integer companyId;
	// 逻辑卡号
	private Long cardNO;

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
}
