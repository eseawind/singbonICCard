package com.singbon.entity;

import java.io.Serializable;

/**
 * 组用户
 * 
 * @author 郝威
 * 
 */
public class AuthGroupUser implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer operId;
	private Integer groupId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOperId() {
		return operId;
	}

	public void setOperId(Integer operId) {
		this.operId = operId;
	}

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

}
