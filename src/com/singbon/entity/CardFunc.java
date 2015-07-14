package com.singbon.entity;

import java.io.Serializable;

/**
 * 卡功能
 * 
 * @author 郝威
 * 
 */
public class CardFunc implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String funcName;

	public String getFuncName() {
		return funcName;
	}

	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}


}
