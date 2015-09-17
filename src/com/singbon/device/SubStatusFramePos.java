package com.singbon.device;

/**
 * 终端设备状态子帧定义
 * 
 * @author 郝威
 * 
 */
public class SubStatusFramePos {

	/**
	 * 上位机主动询问
	 */
	public final static byte Ask = 0x01;
	/**
	 * 下位机主动发送
	 */
	public final static byte SysStatus = 0x08;

}
