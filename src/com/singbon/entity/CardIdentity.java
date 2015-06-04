package com.singbon.entity;

import java.io.Serializable;

/**
 * 卡身份
 * 
 * @author 郝威
 * 
 */
public class CardIdentity implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String identityName;

	public String getIdentityName() {
		return identityName;
	}

	public void setIdentityName(String identityName) {
		this.identityName = identityName;
	}

}
