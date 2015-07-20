package com.singbon.device;

/**
 * 读卡机帧定义
 * 
 * @author 郝威
 * 
 */
public class FrameCardReader {

	/**
	 * 存在物理卡号 0x7f
	 */
	public static byte ExsitCardSN = 0x7f;
	/**
	 * 状态 0x01
	 */
	public static byte Status = 0x01;
	/**
	 * 心跳状态 0x02
	 */
	public static byte HeartStatus = 0x02;
	/**
	 * 单个发卡命令 0x03
	 */
	public static byte SingleCardCmd = 0x03;
	/**
	 * 单个发卡完成 0x04
	 */
	public static byte SingleCardDone = 0x04;
	/**
	 * 信息发卡命令 0x05
	 */
	public static byte InfoCardCmd = 0x05;
	/**
	 * 信息发卡完成 0x06
	 */
	public static byte InfoCardDone = 0x06;
	/**
	 * 解挂命令 0x07
	 */
	public static byte UnlossCmd = 0x07;
	/**
	 * 解挂完成 0x08
	 */
	public static byte UnlossDone = 0x08;
	/**
	 * 补卡命令 0x09
	 */
	public static byte RemakeCardCmd = 0x09;
	/**
	 * 补卡完成 0x0a
	 */
	public static byte RemakeCardDone = 0x0a;
	/**
	 * 换卡读原卡命令 0x0b
	 */
	public static byte ReadOldCardCmd = 0x0b;
	/**
	 * 换卡换新卡命令 0x0c
	 */
	public static byte ChangeNewCardCmd = 0x0c;
	/**
	 * 换卡换新卡完成 0x0d
	 */
	public static byte ChangeNewCardDone = 0x0d;
	/**
	 * 读卡修正命令 0x0e
	 */
	public static byte ReadCardCmd = 0x0e;
	/**
	 * 读卡修正完成 0x0f
	 */
	public static byte ReadCardDone = 0x0f;
	/**
	 * 制出纳卡命令 0x10
	 */
	public static byte MakeCashierCardCmd = 0x10;
	/**
	 * 制出纳卡完成 0x11
	 */
	public static byte MakeCashierCardDone = 0x11;

}
