package com.singbon.service.monitor;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.dao.systemManager.systemSetting.CookbookDAO;
import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.dao.systemManager.systemSetting.MealDAO;
import com.singbon.dao.systemManager.systemSetting.OrderTimeDAO;
import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceCommunicateStr;
import com.singbon.device.DeviceType;
import com.singbon.device.PosFrame;
import com.singbon.device.SendCommand;
import com.singbon.device.PosSubFrameCookbook;
import com.singbon.device.PosSubFrameOther;
import com.singbon.device.PosSubFrameSysPara;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.OrderTime;
import com.singbon.util.DesUtil;
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
	@Autowired
	public ConsumeParamDAO consumeParamDAO;
	@Autowired
	public MealDAO mealDAO;
	@Autowired
	public OrderTimeDAO orderTimeDAO;
	@Autowired
	public DiscountDAO discountDAO;
	@Autowired
	public CookbookDAO cookbookDAO;

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
	public void time(Device device, InetSocketAddress inetSocketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysTime, 2) + StringUtil.hexLeftPad(PosSubFrameOther.SysTime, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + StringUtil.timeToHexStr()
				+ "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void sysPara(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws IOException {
		ConsumeParam consumeParam = command.getConsumeParam();
		if (consumeParam == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysPara, 2) + StringUtil.hexLeftPad(PosSubFrameSysPara.SysPara, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4)
				+ "00000000000000" + StringUtil.hexLeftPad(consumeParam.getCardMinFare(), 2) + StringUtil.hexLeftPad(consumeParam.getDayLimitFare(), 4)
				+ StringUtil.hexLeftPad(consumeParam.getTimeLimitFare(), 4) + StringUtil.hexLeftPad(consumeParam.getConsumeType(), 2) + "0000000003"
				+ getHexString(consumeParam.getCardMinFareCardTypes()) + getHexString(consumeParam.getDayLimitFareCardTypes()) + getHexString(consumeParam.getTimeLimitFareCardTypes()) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void meal(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws IOException {
		List<Meal> mealList = command.getMealList();
		if (mealList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysPara, 2) + StringUtil.hexLeftPad(PosSubFrameSysPara.Meal, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
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
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void discount(Device device, InetSocketAddress inetSocketAddress, SendCommand command) throws IOException {
		List<Discount> discountList = command.getDiscountList();
		if (discountList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysPara, 2) + StringUtil.hexLeftPad(PosSubFrameSysPara.Discount, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		for (Discount discount : discountList) {
			String rate = StringUtil.hexLeftPad(discount.getRate(), 2);
			sendBufStr += ("00" + rate);
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void orderTime(Device device, InetSocketAddress inetSocketAddress, byte subFrame, SendCommand command, int beginIndex, int endIndex) throws IOException {
		List<OrderTime> orderTimeList = command.getOrderTimeList();
		if (orderTimeList == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(subFrame, 2) + "0000" + StringUtil.hexLeftPad(command.getCommandCode(), 4);
		for (int i = beginIndex; i < endIndex; i++) {
			OrderTime orderTime = orderTimeList.get(i);
			String time = StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getBeginTime().substring(3, 5)), 2)
					+ StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(0, 2)), 2) + StringUtil.hexLeftPad(Integer.parseInt(orderTime.getEndTime().substring(3, 5)), 2);
			sendBufStr += time;
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void updateCookbook(Device device, InetSocketAddress inetSocketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.Update, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
	public void appendCookbook(Device device, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws IOException {
		Cookbook cookbook = sendCommand.getCookbook();
		if (cookbook == null)
			return;
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.Append, 2) + "0000" + StringUtil.hexLeftPad(sendCommand.getCommandCode(), 4)
				+ StringUtil.hexLeftPad(cookbook.getCookbookCode(), 4) + StringUtil.hexLeftPad(cookbook.getPrice() * 100, 8)
				+ StringUtil.strRightPad(StringUtil.strToGB2312(cookbook.getCookbookName()), 32) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/**
	 * 获取最后菜单编号
	 * 
	 * @param device
	 * @param datagramChannel
	 * @param commandCode
	 * @throws IOException
	 * @throws Exception
	 */
	public void getLastNumCookbook(Device device, InetSocketAddress inetSocketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.Cookbook, 2) + StringUtil.hexLeftPad(PosSubFrameCookbook.GetLastNum, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
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
		return StringUtil.binaryHexStr(result);
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
	public void sysInit(Device device, InetSocketAddress inetSocketAddress, int commandCode) throws IOException {
		String sendBufStr = StringUtil.hexLeftPad(PosFrame.SysInit, 2) + StringUtil.hexLeftPad(PosSubFrameOther.SysInit, 2) + "0000" + StringUtil.hexLeftPad(commandCode, 4) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.POS + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);

		TerminalManager.sendToPos(inetSocketAddress, sendBuf);
	}

	/*
	 * 监控线程
	 */
	public void run() {
		boolean stop = false;
		while (!stop) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				stop = true;
				e1.printStackTrace();
			}
			for (Device d : this.deviceList) {
				String sn = d.getSn();
				InetSocketAddress inetSocketAddress = TerminalManager.SNToInetSocketAddressList.get(sn);
				if (inetSocketAddress == null) {
					continue;
				}

				// 当前设备命令列表
				List<SendCommand> sendCommandList = null;
				// 当前命令
				SendCommand sendCommand = null;
				// 同步执行当前命令
				synchronized (TerminalManager.sendCommandObject) {
					sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
					if (sendCommandList != null && sendCommandList.size() > 0) {
						StringUtil.println("命令个数：" + sendCommandList.size());
						sendCommand = sendCommandList.get(0);
						// 访问次数
						int sendTime = sendCommand.getSendTime();
						if (sendTime >= 5) {
							sendCommandList.clear();
							continue;
						}
						try {
							excuteCommand(d, inetSocketAddress, sendCommand);
							sendCommand.setSendTime(++sendTime);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}

				// 如果没有命令，继续询问下个设备
				if (sendCommandList == null || sendCommandList.size() == 0) {
					continue;
				}

				// 检测命令是否执行，比较命令列表里的第0命令和当前执行的命令是否一致
				try {
					// 等待消除网络延时
					Thread.sleep(1000);

					for (int i = 0; i < 5; i++) {
						synchronized (TerminalManager.sendCommandObject) {
							List<SendCommand> sendCommandList2 = TerminalManager.SNToSendCommandList.get(sn);
							if (sendCommandList2.size() > 0) {
								SendCommand tempSendCommand = sendCommandList2.get(0);
								if (sendCommand != tempSendCommand) {
									System.out.println("f" + sendCommand.getSendTime());
									break;
								}
							} else {
								// 列表为空说明执行完毕
								break;
							}
						}
						System.out.println("nf" + sendCommand.getSendTime());
						Thread.sleep(200);
					}
				} catch (InterruptedException e) {
					e.printStackTrace();
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void excuteCommand(Device d, InetSocketAddress inetSocketAddress, SendCommand sendCommand) throws IOException {
		byte frame = sendCommand.getFrame();
		Map map = new HashMap();
		map.put("type", "log");
		map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
		map.put("from", d.getDeviceName());
		switch (frame) {
		// 校时
		case PosFrame.SysTime:
			if (sendCommand.getSubFrame() == PosSubFrameOther.SysTime) {
				time(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysTime));
			}
			break;
		// 系统参数
		case PosFrame.SysPara:
			if (sendCommand.getSubFrame() == PosSubFrameSysPara.SysPara) {
				sysPara(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysPara));
			} else if (sendCommand.getSubFrame() == PosSubFrameSysPara.Meal) {
				meal(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendMeal));
			} else if (sendCommand.getSubFrame() == PosSubFrameSysPara.Discount) {
				discount(d, inetSocketAddress, sendCommand);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendDiscount));
			}
			break;
		// 菜单
		case PosFrame.Cookbook:
			if (sendCommand.getSubFrame() == PosSubFrameCookbook.OrderTime1) {
				orderTime(d, inetSocketAddress, PosSubFrameCookbook.OrderTime1, sendCommand, 0, 6);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendOrderTime1));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.OrderTime2) {
				orderTime(d, inetSocketAddress, PosSubFrameCookbook.OrderTime2, sendCommand, 6, 12);
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendOrderTime2));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.Update) {
				updateCookbook(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendUpdate));
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.Append) {
				appendCookbook(d, inetSocketAddress, sendCommand);
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.SendAppend), sendCommand.getCookbookIndex(), sendCommand.getCookbookTotal(), cookbook.getCookbookCode(),
						cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (sendCommand.getSubFrame() == PosSubFrameCookbook.GetLastNum) {
				getLastNumCookbook(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendGetLastNumCookbook));
			}
			break;
		// 初始化
		case PosFrame.SysInit:
			if (sendCommand.getSubFrame() == PosSubFrameOther.SysInit) {
				sysInit(d, inetSocketAddress, sendCommand.getCommandCode());
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.SendSysInit));
			}
			break;

		default:
			break;
		}
		if (map.size() > 3) {
			TerminalManager.sendToMonitor(map, d.getCompanyId());
		}
	}

	/**
	 * 添加命令
	 * 
	 * @param device
	 * @param cmd
	 * @param commandIndex
	 * @param sendCommandList
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void addCommand(Company company, Device device, String cmd, Integer cookbookCode, int commandIndex, ArrayList<SendCommand> sendCommandList) {
		// 清空命令
		if ("clear".equals(cmd)) {
			sendCommandList.clear();
			// 校时
		} else if ("sysTime".equals(cmd)) {
			if (sendCommandList.size() > 0) {
				SendCommand firstSendCommand = sendCommandList.get(0);
				if (firstSendCommand.getCommandCode() == 0) {
					return;
				}
			}
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.SysTime);
			sendCommand.setSubFrame(PosSubFrameOther.SysTime);
			sendCommand.setCommandCode(0);
			sendCommandList.add(0, sendCommand);
			// 系统参数
		} else if ("sysPara".equals(cmd)) {
			// 设置消费参数
			ConsumeParam consumeParam = consumeParamDAO.selectByCompanyId(company.getId());
			// 设置订参别限次
			List<Meal> mealList = mealDAO.selectList(company.getId());
			// 设置订餐时间段
			List<OrderTime> orderTimeList = orderTimeDAO.selectByCompanyId(company.getId());

			// 系统参数
			SendCommand sendCommand1 = new SendCommand();
			sendCommand1.setFrame(PosFrame.SysPara);
			sendCommand1.setSubFrame(PosSubFrameSysPara.SysPara);
			sendCommand1.setCommandCode(commandIndex++);
			sendCommand1.setConsumeParam(consumeParam);

			// 参别限次
			SendCommand sendCommand2 = new SendCommand();
			sendCommand2.setFrame(PosFrame.SysPara);
			sendCommand2.setSubFrame(PosSubFrameSysPara.Meal);
			sendCommand2.setCommandCode(commandIndex++);
			sendCommand2.setMealList(mealList);

			// 订餐时间段
			SendCommand sendCommand3 = new SendCommand();
			sendCommand3.setFrame(PosFrame.Cookbook);
			sendCommand3.setSubFrame(PosSubFrameCookbook.OrderTime1);
			sendCommand3.setCommandCode(commandIndex++);
			sendCommand3.setOrderTimeList(orderTimeList);

			SendCommand sendCommand4 = new SendCommand();
			sendCommand4.setFrame(PosFrame.Cookbook);
			sendCommand4.setSubFrame(PosSubFrameCookbook.OrderTime2);
			sendCommand4.setCommandCode(commandIndex++);
			sendCommand4.setOrderTimeList(orderTimeList);

			sendCommandList.add(sendCommand1);
			sendCommandList.add(sendCommand2);
			sendCommandList.add(sendCommand3);
			sendCommandList.add(sendCommand4);
			// 折扣费率及管理费
		} else if ("discount".equals(cmd)) {
			List<Discount> discountList = discountDAO.selectList(company.getId());

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.SysPara);
			sendCommand.setSubFrame(PosSubFrameSysPara.Discount);
			sendCommand.setCommandCode(commandIndex);
			sendCommand.setDiscountList(discountList);
			sendCommandList.add(sendCommand);
			// 全部菜肴清单
		} else if ("allCookbook".equals(cmd)) {
			for (SendCommand sc : sendCommandList) {
				if (sc.getSubFrame() == PosSubFrameCookbook.Update || sc.getSubFrame() == PosSubFrameCookbook.Append || sc.getSubFrame() == PosSubFrameCookbook.GetLastNum) {
					Map map = new HashMap();
					map.put("type", "log");
					map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
					map.put("from", device.getDeviceName());
					map.put("des", DesUtil.decrypt(DeviceCommunicateStr.CookbookAdded));
					TerminalManager.sendToMonitor(map, company.getId());
					return;
				}
			}
			List<Cookbook> cookbookList = cookbookDAO.selectList(company.getId());

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.Update);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);

			int index = 0;
			for (Cookbook cookbook : cookbookList) {
				SendCommand sendCommand2 = new SendCommand();
				sendCommand2.setFrame(PosFrame.Cookbook);
				sendCommand2.setSubFrame(PosSubFrameCookbook.Append);
				sendCommand2.setCookbook(cookbook);
				sendCommand2.setCommandCode(commandIndex++);
				sendCommand2.setCookbookIndex(++index);
				sendCommand2.setCookbookTotal(cookbookList.size());
				sendCommandList.add(sendCommand2);
			}
			// 追加菜肴清单
		} else if ("appendCookbook".equals(cmd)) {
			for (SendCommand sc : sendCommandList) {
				if (sc.getSubFrame() == PosSubFrameCookbook.Update || sc.getSubFrame() == PosSubFrameCookbook.Append || sc.getSubFrame() == PosSubFrameCookbook.GetLastNum) {
					Map map = new HashMap();
					map.put("type", "log");
					map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
					map.put("from", device.getDeviceName());
					map.put("des", DesUtil.decrypt(DeviceCommunicateStr.CookbookAdded));
					TerminalManager.sendToMonitor(map, company.getId());
					return;
				}
			}

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.GetLastNum);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);

			List<Cookbook> cookbookList = cookbookDAO.selectList(company.getId());

			int index = 0;
			for (Cookbook cookbook : cookbookList) {
				SendCommand sendCommand2 = new SendCommand();
				sendCommand2.setFrame(PosFrame.Cookbook);
				sendCommand2.setSubFrame(PosSubFrameCookbook.Append);
				sendCommand2.setCookbook(cookbook);
				sendCommand2.setCommandCode(commandIndex++);
				sendCommand2.setCookbookIndex(++index);
				sendCommand2.setCookbookTotal(cookbookList.size());
				sendCommandList.add(sendCommand2);
			}
			// 单个菜肴清单
		} else if ("singleCookbook".equals(cmd)) {
			Cookbook cookbook = (Cookbook) this.cookbookDAO.selectById(cookbookCode);
			if (cookbook == null) {
				Map map = new HashMap();
				map.put("type", "log");
				map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
				map.put("from", device.getDeviceName());
				String des = String.format(DesUtil.decrypt(DeviceCommunicateStr.NotExsitCookbook), cookbookCode);
				map.put("des", des);
				TerminalManager.sendToMonitor(map, company.getId());
				return;
			}
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.Cookbook);
			sendCommand.setSubFrame(PosSubFrameCookbook.DownloadSigel);
			sendCommand.setCookbook(cookbook);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);
			// 初始化
		} else if ("sysInit".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(PosFrame.SysInit);
			sendCommand.setSubFrame(PosSubFrameOther.SysInit);
			sendCommand.setCommandCode(0);
			sendCommandList.clear();
			sendCommandList.add(sendCommand);
		}
	}
}
