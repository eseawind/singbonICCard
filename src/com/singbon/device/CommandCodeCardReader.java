package com.singbon.device;

/**
 * 读卡机命令码
 * 
 * @author 郝威
 * 
 */
public class CommandCodeCardReader {

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
	 * 换卡读原卡 0x05
	 */
	public static byte ReadOldCard = 0x05;
	/**
	 * 换卡换新卡 0x05
	 */
	public static byte ChangeNewCard = 0x06;

}
