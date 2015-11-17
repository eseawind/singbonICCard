package com.singbon.device;

/**
 * 黑名单子帧定义
 * 
 * @author 郝威
 * 
 */
public class PosSubFrameBlack {

	/**
	 * 批次更新 0x01
	 */
	public final static byte BatchUpdate = 0x01;
	/**
	 * 批次追加 0x02
	 */
	public final static byte BatchAppend = 0x02;
	/**
	 * 全量更新(已改为黑名单更新) 0x03
	 */
	public final static byte AllUpdate = 0x03;
	/**
	 * 增量追加(已改为黑名单追加) 0x05
	 */
	public final static byte IncAppend = 0x05;

}
