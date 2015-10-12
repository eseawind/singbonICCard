package com.singbon.device;

/**
 * 菜单子帧定义
 * 
 * @author 郝威
 * 
 */
public class PosSubFrameCookbook {
	/**
	 * 菜单更新
	 */
	public final static byte Update = 0x01;
	/**
	 * 菜单追加
	 */
	public final static byte Append = 0x02;
	/**
	 * 点餐时间段1到6
	 */
	public final static byte OrderTime1 = 0x03;
	/**
	 * 点餐时间段7到12
	 */
	public final static byte OrderTime2 = 0x04;
	/**
	 * 查询最后菜单编号
	 */
	public final static byte GetLastNum = 0x05;
	/**
	 * 单独下载菜单
	 */
	public final static byte DownloadSigel = 0x06;

}
