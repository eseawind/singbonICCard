package com.singbon.device;

import com.singbon.entity.Device;

/**
 * 终端设备类型
 * 
 * @author 郝威
 * 
 */
public class DeviceType {

	/**
	 * 主设备 0000
	 */
	public static String Main = "0000";
	/**
	 * 读卡机 0808
	 */
	public static String CardReader = "0808";
	/**
	 * 消费机 0202
	 */
	public static String POS = "0202";
	/**
	 * 水控 0303
	 */
	public static String WaterControl = "0303";
	
	/**
	 * 获取设备类型帧
	 * @param device
	 * @return
	 */
	public static String getDeviceTypeFrame(Device device) {
		String frame = "0202";
		if (device.getDeviceType() == 3) {
			frame = "0303";
		}
		return frame;
	}
}
