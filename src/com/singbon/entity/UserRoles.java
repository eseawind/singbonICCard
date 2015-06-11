package com.singbon.entity;

import java.io.Serializable;

/**
 * 用户权限
 * 
 * @author 郝威
 * 
 */
public class UserRoles implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private Integer userId;
	private String role;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
