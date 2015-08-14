package com.singbon.device;

/**
 * 读卡机帧定义
 * 
 * @author 郝威
 * 
 */
public class FrameCardReader {

	/**
	 * 存在物理卡号 0x70
	 */
	public static byte ExsitCardSN = 0x70;
	/**
	 * 获取出纳员基本信息命令 0x71
	 */
	public static byte CashierCardBaseInfoCmd = 0x71;
	
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
	/**
	 * 挂失出纳卡命令 0x12
	 */
	public static byte LossCashierCardCmd = 0x12;
	/**
	 * 挂失出纳卡完成 0x13
	 */
	public static byte LossCashierCardDone = 0x13;
	/**
	 * 解挂出纳卡命令 0x14
	 */
	public static byte UnLossCashierCardCmd = 0x14;
	/**
	 * 解挂出纳卡完成 0x15
	 */
	public static byte UnLossCashierCardDone = 0x15;
	/**
	 * 补办出纳卡命令 0x16
	 */
	public static byte RemakeCashierCardCmd = 0x16;
	/**
	 * 补办出纳卡完成 0x17
	 */
	public static byte RemakeCashierCardDone = 0x17;
	/**
	 * 读取出纳卡命令 0x18
	 */
	public static byte ReadCashierCardCmd = 0x18;
	/**
	 * 修改出纳卡有效期完成 0x19
	 */
	public static byte InvalidDateCashierCardDone = 0x19;
	/**
	 * 读取卡余额命令 0x1a
	 */
	public static byte ReadCardOddFareCmd = 0x1a;
	/**
	 * 存取款完成 0x1b
	 */
	public static byte ChargeDone = 0x1b;

}
