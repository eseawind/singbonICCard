package com.singbon.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * 卡类别
 * 
 * @author 郝威
 * 
 */
public class CardType implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;
	private Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	private String typeName;

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

}
