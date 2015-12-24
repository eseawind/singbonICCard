package com.singbon.service.monitor;

import java.net.InetSocketAddress;
import java.util.List;

import org.springframework.stereotype.Service;

import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceType;
import com.singbon.device.PosFrame;
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
public class PosTransferService implements Runnable {

	private Integer accessTimeout;
	private Integer transferInterval;
	private Integer blackInterval;
	private List<Device> deviceList;

	public void setAccessTimeout(Integer accessTimeout) {
		this.accessTimeout = accessTimeout;
	}

	public void setTransferInterval(Integer transferInterval) {
		this.transferInterval = transferInterval;
	}

	public void setBlackInterval(Integer blackInterval) {
		this.blackInterval = blackInterval;
	}

	public List<Device> getDeviceList() {
		return deviceList;
	}

	public void setDeviceList(List<Device> deviceList) {
		this.deviceList = deviceList;
	}

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
				// 当前命令
				SendCommand sendCommand = null;
				// 访问次数
				int sendTime = 0;
				// 同步执行当前命令
				synchronized (TerminalManager.sendCommandObject) {
					sendCommandList = TerminalManager.SNToSendCommandList.get(d.getSn());
					if (sendCommandList != null && sendCommandList.size() > 0) {
//						StringUtil.println("命令个数：" + sendCommandList.size());
						sendCommand = sendCommandList.get(0);
						sendTime = sendCommand.getSendTime();
						if (sendTime >= 5) {
							sendCommandList.clear();
							continue;
						}
						try {
							MonitorService.excuteCommand(d, inetSocketAddress, sendCommand);
							sendCommand.setSendTime(++sendTime);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}

				// 如果没有命令，发送采集，间隔1s+终端访问次数*200ms
				if (sendCommandList == null || sendCommandList.size() == 0) {
					String sendBufStr = "0101" + "0000" + "00000000";
					String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
					sendBufStr = d.getSn() + StringUtil.hexLeftPad(d.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.getDeviceTypeFrame(d) + bufLen + sendBufStr;
					byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
					try {
						TerminalManager.sendToPos(inetSocketAddress, sendBuf);
					} catch (Exception e) {
						e.printStackTrace();
					}
					try {
						Thread.sleep(1000);
						for (int i = 0; i < accessTimeout; i++) {
							Thread.sleep(200);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
						stop = true;
						break;
					}
					continue;
				}

				// 如果下载黑名单不检测是否命令回复，继续询问下个设备
				if (sendCommand != null && sendCommand.getFrame() == PosFrame.Black) {
					try {
						if (sendTime <= 1) {
							Thread.sleep(100);
						} else {
							Thread.sleep(blackInterval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
						stop = true;
						break;
					}
					continue;
				}

				// 检测命令是否执行，比较命令列表里的第0命令和当前执行的命令是否一致
				try {
					// 等待消除网络延时
					Thread.sleep(1000);

					for (int i = 0; i < accessTimeout; i++) {
						synchronized (TerminalManager.sendCommandObject) {
							List<SendCommand> sendCommandList2 = TerminalManager.SNToSendCommandList.get(d.getSn());
							if (sendCommandList2.size() > 0) {
								SendCommand tempSendCommand = sendCommandList2.get(0);
								if (sendCommand != tempSendCommand) {
//									System.out.println("tf" + sendCommand.getSendTime());
									break;
								}
							} else {
								// 列表为空说明执行完毕
								break;
							}
						}
//						System.out.println("tnf" + sendCommand.getSendTime());
						Thread.sleep(200);
					}
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
