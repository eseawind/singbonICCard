package com.singbon.service.monitor;

import java.net.InetSocketAddress;
import java.util.List;

import org.springframework.stereotype.Service;

import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceType;
import com.singbon.device.SendCommand;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 串口主动采集业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CollectService implements Runnable {

	private Integer transferInterval;
	private List<Device> deviceList;

	public Integer getTransferInterval() {
		return transferInterval;
	}

	public void setTransferInterval(Integer transferInterval) {
		this.transferInterval = transferInterval;
	}

	public List<Device> getDeviceList() {
		return deviceList;
	}

	public void setDeviceList(List<Device> deviceList) {
		this.deviceList = deviceList;
	}

	/*
	 * 采集线程
	 */
	public void run() {
		boolean stop = false;
		while (!stop) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				stop = true;
			}
			for (Device d : this.deviceList) {
				InetSocketAddress inetSocketAddress = TerminalManager.SNToInetSocketAddressList.get(d.getTransferSn());
				if (inetSocketAddress == null) {
					continue;
				}

				// 当前设备命令列表
				List<SendCommand> sendCommandList = null;
				// 同步执行
				synchronized (TerminalManager.sendCommandObject) {
					sendCommandList = TerminalManager.SNToSendCommandList.get(d.getSn());
					if (sendCommandList == null || sendCommandList.size() == 0) {
						String sendBufStr = "0101" + "0000" + "00000000";
						String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
						sendBufStr = d.getSn() + StringUtil.hexLeftPad(d.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(d) + bufLen + sendBufStr;
						byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
						try {
							TerminalManager.sendToPos(inetSocketAddress, sendBuf);
							System.out.println();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}

				if (sendCommandList == null || sendCommandList.size() == 0) {
					try {
						// 采集间隔
						Thread.sleep(transferInterval);
					} catch (InterruptedException e) {
						e.printStackTrace();
						stop = true;
						break;
					}
				}
			}
		}
	}
}
