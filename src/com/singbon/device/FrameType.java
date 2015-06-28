package com.singbon.device;

/**
 * 帧定义
 * 
 * @author 郝威
 * 
 */
public class FrameType {

	/**
	 * 读卡机写卡回复
	 */
	public static byte CardReaderWriteResponse = 0x03;
	/**
	 * 读卡机读卡回复
	 */
	public static byte CardReaderReadResponse = 0x04;
	/**
	 * 读卡机状态
	 */
	public static byte CardReaderStatus = 0x01;
	/**
	 * 读卡机心跳状态
	 */
	public static byte CardReaderHeartStatus = 0x02;

}
