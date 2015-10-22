package com.singbon.device;

/**
 * 消费机大帧定义
 * 
 * @author 郝威
 * 
 */
public class PosFrame {

	/**
	 * 系统状态 0x03
	 */
	public final static byte Status = 0x03;
	/**
	 * 系统 0x04
	 */
	public final static byte Sys = 0x04;
	/**
	 * 黑名单 0x05
	 */
	public final static byte Black = 0x05;
	/**
	 * 校时 0x07
	 */
	public final static byte SysTime = 0x07;
	/**
	 * 菜单 0x09
	 */
	public final static byte Cookbook = 0x09;
	/**
	 * 初始化 0x19
	 */
	public final static byte SysInit = 0x19;
	/**
	 * 在线升级 0x1a
	 */
	public final static byte OnlineUpdate = 0x1A;
}
