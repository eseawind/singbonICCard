package com.singbon.device;

/**
 * 读卡机返回结果命令码给客户端
 * 
 * @author 郝威
 * 
 */
public class CardReaderResultCommandCode {

	/**
	 * 存在物理卡号 0x70
	 */
	public static byte ExsitCardSN = 0x70;
	/**
	 * 下载单位名称 0x72
	 */
	public static byte CompanyName = 0x72;
	/**
	 * 下载读卡机密码 0x73
	 */
	public static byte CardReaderPwd = 0x73;
	/**
	 * 系统校时 0x74
	 */
	public static byte SysTime = 0x74;

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
	 * 按库修正命令 0x0e
	 */
	public static byte ReadCardCmd = 0x0e;
	/**
	 * 按库修正完成 0x0f
	 */
	public static byte UpdateByInfoDone = 0x0f;
	/**
	 * 制功能卡 0x10
	 */
	public static byte MakeFuncCardDone = 0x10;
	/**
	 * 读取卡余额命令 0x1a
	 */
	public static byte ReadCardOddFareCmd = 0x1a;
	/**
	 * 存取款完成 0x1b
	 */
	public static byte ChargeDone = 0x1b;
	/**
	 * 有卡注销命令 0x1c
	 */
	public static byte OffWithCardCmd = 0x1c;
	/**
	 * 有卡注销完成 0x1d
	 */
	public static byte OffWithCardDone = 0x1d;

}
