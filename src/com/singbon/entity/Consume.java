package com.singbon.entity;

import java.io.Serializable;
import java.sql.Date;

/**
 * 消费数据
 * 
 * @author 郝威
 * 
 */
public class Consume implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private Integer companyId;

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	
	private Integer id;
	private float money;
	private Date uploadTime;

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

}
