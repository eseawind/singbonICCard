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
	private String companyName;
	private Integer serialNumber;
	private Integer authNumber;
	private Integer baseSection;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Integer getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(Integer serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Integer getAuthNumber() {
		return authNumber;
	}

	public void setAuthNumber(Integer authNumber) {
		this.authNumber = authNumber;
	}

	public Integer getBaseSection() {
		return baseSection;
	}

	public void setBaseSection(Integer baseSection) {
		this.baseSection = baseSection;
	}

}
