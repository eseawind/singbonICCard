package com.singbon.device;

import com.singbon.util.StringUtil;

/**
 * 读卡机帧定义
 * 
 * @author 郝威
 * 
 */
public class CardReaderFrame {

	/**
	 * 读卡 cd00
	 */
	public static String ReadCard = "cd00";
	/**
	 * 写卡 cd01
	 */
	public static String WriteCard = "cd01";
	/**
	 * 下载单位名称 0408
	 */
	public static String CompanyName = "0408";
	/**
	 * 下载读卡机密码 0403
	 */
	public static String CardReaderPwd = "0403";
	/**
	 * 不验证物理卡号00
	 */
	public static String NoValidateCardSN = "00";
	/**
	 * 验证物理卡号01
	 */
	public static String ValidateCardSN = "01";
	/**
	 * 没有物理卡号
	 */
	public static String NoCardSN = StringUtil.strLeftPadWithChar("", 8, "4");

}
