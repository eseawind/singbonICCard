package com.singbon.device;

/**
 * 读卡机帧定义
 * 
 * @author 郝威
 * 
 */
public class FrameCardReader {

	/**
	 * 存在物理卡号
	 */
	public static byte ExsitCardSN = 0x7f;
	/**
	 * 状态
	 */
	public static byte Status = 0x01;
	/**
	 * 心跳状态
	 */
	public static byte HeartStatus = 0x02;
	/**
	 * 单个发卡命令
	 */
	public static byte SingleCardCmd = 0x03;
	/**
	 * 单个发卡完成
	 */
	public static byte SingleCardDone = 0x04;
	/**
	 * 信息发卡命令
	 */
	public static byte InfoCardCmd = 0x05;
	/**
	 * 信息发卡完成
	 */
	public static byte InfoCardDone = 0x06;
	/**
	 * 解挂命令
	 */
	public static byte UnlossCmd = 0x07;
	/**
	 * 解挂完成
	 */
	public static byte UnlossDone = 0x08;

}
