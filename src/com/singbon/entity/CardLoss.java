package com.singbon.entity;

import java.io.Serializable;

//用户卡挂失
//
//@author 郝威
//

public class CardLoss implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	// 所属公司
	private Integer companyId;
	// 逻辑卡号
	private Integer cardNO;

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

	public Integer getCardNO() {
		return cardNO;
	}

	public void setCardNO(Integer cardNO) {
		this.cardNO = cardNO;
	}
}
