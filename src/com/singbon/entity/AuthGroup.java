package com.singbon.entity;

import java.io.Serializable;

/**
 * 授权分组
 * 
 * @author 郝威
 * 
 */
public class AuthGroup implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	private Integer id;
	private String groupName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

}
