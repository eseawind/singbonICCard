package com.singbon.service.monitor;

import java.net.SocketAddress;
import java.nio.channels.DatagramChannel;

import org.springframework.stereotype.Service;

import com.singbon.device.CommandCodePos;
import com.singbon.device.CommandPos;
import com.singbon.device.DeviceType;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 采集监控业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MonitorService implements Runnable{

	/**
	 * 校时
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws Exception
	 */
	public void time(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, Integer commandCode) throws Exception {
		// String commandCodeStr = StringUtil.hexLeftPad(CommandCodePos.Time,
		// 4);
		String sendBufStr = CommandPos.Time + StringUtil.timeToHexString() + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	@Override
	public void run() {
		while(true){
			
		}
	}
}
