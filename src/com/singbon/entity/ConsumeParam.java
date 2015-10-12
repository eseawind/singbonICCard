package com.singbon.entity;

import java.io.Serializable;

/**
 * 消费参数
 * 
 * @author 郝威
 * 
 */
public class ConsumeParam implements Serializable {

	private static final long serialVersionUID = -4349415810057681133L;

	// 卡底金（单位元、默认0） 选择卡类型
	// 日限额（单位元、默认0）
	// 次限额（单位元、默认0）
	// 用户密码 8888
	private Integer id;
	private Integer companyId;
	private Integer cardMinFare;
	private String cardMinFareCardTypes;
	private Integer dayLimitFare;
	private String dayLimitFareCardTypes;
	private Integer timeLimitFare;
	private String timeLimitFareCardTypes;
	private String userPwd;

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

	public Integer getCardMinFare() {
		return cardMinFare;
	}

	public void setCardMinFare(Integer cardMinFare) {
		this.cardMinFare = cardMinFare;
	}

	public String getCardMinFareCardTypes() {
		return cardMinFareCardTypes;
	}

	public void setCardMinFareCardTypes(String cardMinFareCardTypes) {
		this.cardMinFareCardTypes = cardMinFareCardTypes;
	}

	public Integer getDayLimitFare() {
		return dayLimitFare;
	}

	public void setDayLimitFare(Integer dayLimitFare) {
		this.dayLimitFare = dayLimitFare;
	}

	public String getDayLimitFareCardTypes() {
		return dayLimitFareCardTypes;
	}

	public void setDayLimitFareCardTypes(String dayLimitFareCardTypes) {
		this.dayLimitFareCardTypes = dayLimitFareCardTypes;
	}

	public Integer getTimeLimitFare() {
		return timeLimitFare;
	}

	public void setTimeLimitFare(Integer timeLimitFare) {
		this.timeLimitFare = timeLimitFare;
	}

	public String getTimeLimitFareCardTypes() {
		return timeLimitFareCardTypes;
	}

	public void setTimeLimitFareCardTypes(String timeLimitFareCardTypes) {
		this.timeLimitFareCardTypes = timeLimitFareCardTypes;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

}
