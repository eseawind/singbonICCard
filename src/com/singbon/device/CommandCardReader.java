package com.singbon.device;

import com.singbon.util.StringUtil;

/**
 * 读卡机命令
 * 
 * @author 郝威
 * 
 */
public class CommandCardReader {

	/**
	 * 读卡 cd00
	 */
	public static String ReadCard = "cd00";
	/**
	 * 写卡 cd01
	 */
	public static String WriteCard = "cd01";
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
