package com.singbon.entity;

import java.io.Serializable;

/**
 * 公司
 * 
 * @author 郝威
 * 
 */
public class Company implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String compayName;

	public String getCompayName() {
		return compayName;
	}

	public void setCompayName(String compayName) {
		this.compayName = compayName;
	}
}
