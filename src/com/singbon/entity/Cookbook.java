package com.singbon.entity;

import java.io.Serializable;

/**
 * 菜肴清单
 * 
 * @author 郝威
 * 
 */
public class Cookbook implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private Integer cookbookCode;
	private String cookbookName;
	private Float price;
	private String remark;
	private boolean enable;

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

	public Integer getCookbookCode() {
		return cookbookCode;
	}

	public void setCookbookCode(Integer cookbookCode) {
		this.cookbookCode = cookbookCode;
	}

	public String getCookbookName() {
		return cookbookName;
	}

	public void setCookbookName(String cookbookName) {
		this.cookbookName = cookbookName;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

}
