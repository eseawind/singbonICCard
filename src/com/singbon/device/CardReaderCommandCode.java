package com.singbon.device;

/**
 * 读卡机命令码
 * 
 * @author 郝威
 * 
 */
public class CardReaderCommandCode {

	/**
	 * 制功能卡 0x70
	 */
	public static byte MakeFuncCard = 0x70;
	/**
	 * 单个发卡 0x01
	 */
	public static byte SingleCard = 0x01;
	/**
	 * 信息发卡 0x02
	 */
	public static byte InfoCard = 0x02;
	/**
	 * 解挂 0x03
	 */
	public static byte Unloss = 0x03;
	/**
	 * 补卡 0x04
	 */
	public static byte RemakeCard = 0x04;

	/**
	 * 读卡 0x07
	 */
	public static byte ReadCard = 0x07;
	/**
	 * 按库修正 0x08
	 */
	public static byte UpdateByInfo = 0x08;
	/**
	 * 读取卡余额 0x0e
	 */
	public static byte ReadCardOddFare = 0x0e;
	/**
	 * 存取款 0x0f
	 */
	public static byte Charge = 0x0f;
	/**
	 * 卡注销 0x10
	 */
	public static byte CardOff = 0x10;
}
