package com.singbon.entity;

import java.io.Serializable;

/**
 * 组授权
 * 
 * @author 郝威
 * 
 */
public class AuthGroupRoles implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private String role;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
