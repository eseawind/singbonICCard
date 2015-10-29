package com.singbon.device;

/**
 * 系统04子帧定义
 * 
 * @author 郝威
 * 
 */
public class PosSubFrameSys04 {

	/**
	 * 消费参数 0x01
	 */
	public final static byte ConsumeParam = 0x01;
	/**
	 * 餐别限次 0x02
	 */
	public final static byte Meal = 0x02;
	/**
	 * 系统密码 0x03
	 */
	public final static byte SysPwd = 0x03;
	/**
	 * 折扣费率及管理费 0x04
	 */
	public final static byte Discount = 0x04;
	/**
	 * 查询设备所属公司名称 0x07
	 */
	public final static byte GetCompanyName = 0x07;
	/**
	 * 下载设备所属公司名称 0x08
	 */
	public final static byte SetCompanyName = 0x08;
	/**
	 * 查询设备所属公司的静态ID 0x09
	 */
	public final static byte SetSN = 0x09;

}
