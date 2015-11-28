package com.singbon.entity;

import java.io.Serializable;

/**
 * 批次
 * 
 * @author 郝威
 * 
 */
public class Batch implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;
	private Integer companyId;
	private String batchName;
	private String beginDate;
	private String endDate;
	private Integer status;
	private String statusDesc;

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

	public String getBatchName() {
		return batchName;
	}

	public void setBatchName(String batchName) {
		this.batchName = batchName;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getStatusDesc() {
		if (this.status == 0) {
			statusDesc = "正常";
		} else {
			statusDesc = "挂失";
		}
		return statusDesc;
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}
}
