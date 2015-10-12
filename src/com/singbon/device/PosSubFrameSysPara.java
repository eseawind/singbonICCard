package com.singbon.device;

/**
 * 系统参数子帧定义
 * 
 * @author 郝威
 * 
 */
public class PosSubFrameSysPara {

	/**
	 * 系统参数
	 */
	public final static byte SysPara = 0x01;
	/**
	 * 餐别限次
	 */
	public final static byte Meal = 0x02;
	/**
	 * 系统密码
	 */
	public final static byte SysPwd = 0x03;
	/**
	 * 折扣费率及管理费
	 */
	public final static byte Discount = 0x04;
	/**
	 * 查询设备所属公司名称
	 */
	public final static byte GetCompanyName = 0x07;
	/**
	 * 下载设备所属公司名称
	 */
	public final static byte SetCompanyName = 0x08;
	/**
	 * 查询设备所属公司的静态ID
	 */
	public final static byte SetSN = 0x09;

}
