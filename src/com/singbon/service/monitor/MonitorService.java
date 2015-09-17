package com.singbon.service.monitor;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketAddress;
import java.nio.channels.DatagramChannel;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.comet4j.core.util.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.device.DeviceType;
import com.singbon.device.FramePos;
import com.singbon.device.SendCommand;
import com.singbon.device.SubCookbookFramePos;
import com.singbon.device.SubOtherFramePos;
import com.singbon.device.SubSysParaFramePos;
import com.singbon.device.TerminalManager;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.OrderTime;
import com.singbon.util.StringUtil;

/**
 * 采集监控业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MonitorService implements Runnable {

	@Autowired
	public DeviceDAO deviceDAO;

	private List<Device> deviceList;

	public void setDeviceList(List<Device> deviceList) {
		this.deviceList = deviceList;
	}

	/**
	 * 校时
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void time(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(FramePos.SysTime, 2) + StringUtil.hexLeftPad(SubOtherFramePos.SysTime, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4)
				+ StringUtil.timeToHexString() + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 系统参数
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void sysPara(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		ConsumeParam consumeParam = TerminalManager.CompanyToConsumeParalList.get(device.getCompanyId());
		// 卡底金（1 字节）
		// +日限额（2 字节，高字节在前）
		// +次限额（2 字节，高字节在前）
		// +参数判断标准（1 字节，未用）--
		// +补助宏冲标志位（1 字节，该字节为 0 启用宏冲）

		// +优先消费补助，餐别限次标志位（1 字节，低四位 0 优先消费补助；
		// 高四位为 0 指不启用餐别限次）

		// +连级注册标志位（1 字节，该字节为 0 启用联机注册；否则不起用
		// 联机注册）--
		// +提前注册天数（1 字节，未用）--
		// +补助截止日期（1 字节，未用）--
		// +补助发放到大钱包还是小钱包标志位（1 字节，未用）--
		// +485 通信通信波特率标志位（1 字节，1 为 9600，3 为 115200，其
		// 它值为 115200）

		// +卡底金卡类型标志位（2 字节，高字节在前） +
		// 日限额卡类型标志位（2 字节，高字节在前；使用方法同上）
		// +次限额卡类型标志位（2 字节，高字节在前；使用方法同上）
		String sendBufStr = StringUtil.hexLeftPad(FramePos.SysPara, 2) + StringUtil.hexLeftPad(SubSysParaFramePos.SysPara, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "00000000000000"
				+ StringUtil.hexLeftPad(consumeParam.getCardMinFare(), 2) + StringUtil.hexLeftPad(consumeParam.getDayLimitFare(), 4) + StringUtil.hexLeftPad(consumeParam.getTimeLimitFare(), 4)
				+ StringUtil.hexLeftPad(consumeParam.getConsumeType(), 2) + "0000000003" + getHexString(consumeParam.getCardMinFareCardTypes()) + getHexString(consumeParam.getDayLimitFareCardTypes())
				+ getHexString(consumeParam.getTimeLimitFareCardTypes()) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 参别限次
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void meal(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		List<Meal> mealList = TerminalManager.CompanyToMealList.get(device.getCompanyId());
		// 时间段 1 的开始时间（2 字节，时，分）
		// +时间段 1 的结束时间（2 字节，时，分）
		// +时间段 1 的次数（1 字节）
		String sendBufStr = StringUtil.hexLeftPad(FramePos.SysPara, 2) + StringUtil.hexLeftPad(SubSysParaFramePos.Meal, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4);
		for (Meal meal : mealList) {
			String beginTimeHour = StringUtil.hexLeftPad(Integer.parseInt(meal.getBeginTime().substring(0, 2)), 2);
			String beginTimeMin = StringUtil.hexLeftPad(Integer.parseInt(meal.getBeginTime().substring(3, 5)), 2);
			String endTimeHour = StringUtil.hexLeftPad(Integer.parseInt(meal.getEndTime().substring(0, 2)), 2);
			String endTimeMin = StringUtil.hexLeftPad(Integer.parseInt(meal.getEndTime().substring(3, 5)), 2);
			String timeLimit = StringUtil.hexLeftPad(meal.getTimeLimit(), 2);
			sendBufStr += (beginTimeHour + beginTimeMin + endTimeHour + endTimeMin + timeLimit);
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 折扣费率及管理费
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void discount(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		List<Discount> discountList = TerminalManager.CompanyToDiscountList.get(device.getCompanyId());
		// 卡类型 0 的折扣和管理费（2 字节，第 1 字节的高位为 0，
		// 则收取管理费，有效数据为第 1 字节的低 7 位（高字节），
		// 第 2 字节）
		String sendBufStr = StringUtil.hexLeftPad(FramePos.SysPara, 2) + StringUtil.hexLeftPad(SubSysParaFramePos.Discount, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4);
		for (Discount discount : discountList) {
			String rate = StringUtil.hexLeftPad(discount.getRate(), 2);
			sendBufStr += ("00" + rate);
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 订餐时间段
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void orderTime(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, byte subFrame, int commandCode, int beginIndex, int endIndex) throws IOException {
		List<OrderTime> orderTimeList = TerminalManager.CompanyToOrderTimeList.get(device.getCompanyId());
		// 时间段 1 的开始时间（2 字节，时，分）
		// +时间段 1 的结束时间（2 字节，时，分）
		// +时间段 1 的次数（1 字节）
		String sendBufStr = StringUtil.hexLeftPad(FramePos.Cookbook, 2) + StringUtil.hexLeftPad(subFrame, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4);
		for (int i = beginIndex; i < endIndex; i++) {
			OrderTime orderTime = orderTimeList.get(i);
			String time = StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(3, 5)), 2)
					+ StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(3, 5)), 2);
			sendBufStr += time;
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 菜肴清单更新
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void updateCookbook(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(FramePos.Cookbook, 2) + StringUtil.hexLeftPad(SubCookbookFramePos.Update, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/**
	 * 菜肴清单追加
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void appendCookbook(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, SendCommand sendCommand) throws IOException {
		Cookbook cookbook = sendCommand.getCookbook();
		String sendBufStr = StringUtil.hexLeftPad(FramePos.Cookbook, 2) + StringUtil.hexLeftPad(SubCookbookFramePos.Append, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ StringUtil.hexLeftPad(cookbook.getCookbookCode(), 4) + StringUtil.hexLeftPad(cookbook.getPrice() * 100, 8) + getCookbookNameHexString(cookbook.getCookbookName()) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	private String getCookbookNameHexString(String name) throws UnsupportedEncodingException {
		String result = "";
		byte[] nameByte = name.getBytes("GB2312");
		for (byte b : nameByte) {
			result += StringUtil.hexLeftPad(b, 2);
		}
		return StringUtil.stringLeftPad(result, 34);
	}

	private String getHexString(String str) {
		String result = "";
		for (int i = 0; i < 16; i++) {
			if (str.indexOf("," + i + ",") == -1) {
				result += "0";
			} else {
				result += "1";
			}
		}
		return StringUtil.binaryHexString(result);
	}

	/**
	 * 初始化
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void sysInit(Device device, DatagramChannel datagramChannel, SocketAddress socketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(FramePos.SysInit, 2) + StringUtil.hexLeftPad(SubOtherFramePos.SysInit, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToPos(datagramChannel, socketAddress, sendBuf);
	}

	/*
	 * 监控线程
	 */
	public void run() {
		boolean stop = false;
		while (!stop) {
			for (Device d : this.deviceList) {
				String sn = d.getSn();
				DatagramChannel datagramChannel = TerminalManager.SNToDatagramChannelList.get(sn);
				SocketAddress socketAddress = TerminalManager.SNToSocketAddresslList.get(sn);

				SendCommand sendCommand = null;
				synchronized (TerminalManager.sendCommandObject) {
					List<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);

					if (datagramChannel != null && socketAddress != null && sendCommandList != null && sendCommandList.size() > 0) {
						StringUtil.println("命令个数：" + sendCommandList.size());

						sendCommand = sendCommandList.get(0);
						// 访问次数
						int sendTime = sendCommand.getSendTime();
						if (sendTime >= 5) {
							sendCommandList.clear();
							continue;
						}
						try {
							excuteCommand(d, datagramChannel, socketAddress, sendCommand);
							sendCommand.setSendTime(++sendTime);
						} catch (IOException e) {
							e.printStackTrace();
						}
					} else {
						// try {
						// Thread.sleep(1000);
						// } catch (InterruptedException e) {
						// stop = true;
						// e.printStackTrace();
						// break;
						// }
						continue;
					}
				}

				// 检测命令是否执行
				try {
					for (int i = 0; i < 5; i++) {
						synchronized (TerminalManager.sendCommandObject) {
							List<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
							if (sendCommandList != null && sendCommandList.size() > 0) {
								SendCommand tempSendCommand = sendCommandList.get(0);
								if (sendCommand != tempSendCommand) {
									break;
								}
							}
						}
						Thread.sleep(200);
					}
				} catch (InterruptedException e) {
					stop = true;
					break;
				}
			}
		}
	}

	/**
	 * 执行处理命令
	 * 
	 * @param d
	 * @param datagramChannel
	 * @param socketAddress
	 * @param sendCommand
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	private void excuteCommand(Device d, DatagramChannel datagramChannel, SocketAddress socketAddress, SendCommand sendCommand) throws IOException {
		byte frame = sendCommand.getFrame();
		Map map = new HashMap();
		map.put("type", "log");
		map.put("time", new Date().toLocaleString());
		map.put("from", d.getDeviceName());
		switch (frame) {
		// 校时
		case FramePos.SysTime:
			if (sendCommand.getSubFrame() == SubOtherFramePos.SysTime) {
				time(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送终端校时命令");
			}
			break;
		// 系统参数
		case FramePos.SysPara:
			if (sendCommand.getSubFrame() == SubSysParaFramePos.SysPara) {
				sysPara(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送系统参数命令");
			} else if (sendCommand.getSubFrame() == SubSysParaFramePos.Meal) {
				meal(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送餐别限次命令");
			} else if (sendCommand.getSubFrame() == SubSysParaFramePos.Discount) {
				discount(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送折扣费率及管理费命令");
			}
			break;
		// 菜单
		case FramePos.Cookbook:
			if (sendCommand.getSubFrame() == SubCookbookFramePos.OrderTime1) {
				orderTime(d, datagramChannel, socketAddress, SubCookbookFramePos.OrderTime1, sendCommand.getCommandCode(), 0, 6);
				map.put("des", "发送订餐时间段1-6命令");
			} else if (sendCommand.getSubFrame() == SubCookbookFramePos.OrderTime2) {
				orderTime(d, datagramChannel, socketAddress, SubCookbookFramePos.OrderTime2, sendCommand.getCommandCode(), 6, 12);
				map.put("des", "发送订餐时间段7-12命令");
			} else if (sendCommand.getSubFrame() == SubCookbookFramePos.Update) {
				updateCookbook(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送菜肴清单更新命令");
			} else if (sendCommand.getSubFrame() == SubCookbookFramePos.Append) {
				appendCookbook(d, datagramChannel, socketAddress, sendCommand);
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format("发送菜肴清单追加命令：第{0}/{1}个，编号：{2}，单价：{3}，菜名：{4}", sendCommand.getCookbookIndex(), sendCommand.getCookbookTotal(), cookbook.getCookbookCode(),
						cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			}
			break;
		// 初始化
		case FramePos.SysInit:
			if (sendCommand.getSubFrame() == SubOtherFramePos.SysInit) {
				sysInit(d, datagramChannel, socketAddress, sendCommand.getCommandCode());
				map.put("des", "发送初始化命令");
			}
			break;

		default:
			break;
		}
		if (map.size() > 3) {
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.EngineInstance.sendToAll("Co" + d.getCompanyId(), msg);
		}
	}
}
