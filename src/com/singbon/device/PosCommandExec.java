package com.singbon.device;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.singbon.entity.ConsumeRecord;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.entity.Meal;
import com.singbon.util.DesUtil;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 处理消费机回复命令
 * 
 * @author 郝威
 * 
 */
public class PosCommandExec {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void execCommand(InetSocketAddress inetSocketAddress, byte[] b) {
		if (b == null)
			return;
		String sn = StringUtil.byteToHexStr(0, 15, b);
		// 设置sn与inetSocketAddress对照关系
		TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);
		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		int recNO = 0;
		Map map = new HashMap();
		// 终端设备状态
		if (b[30] == PosFrame.Status && b[31] == PosSubFrameStatus.SysStatus) {
			map.put("'type'", "status");
			map.put("'sn'", sn);
			map.put("recordNum", StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]));
			map.put("batchNum", StringUtil.byteToInt(b[38]) * 256 + StringUtil.byteToInt(b[39]));
			map.put("blackNum", StringUtil.byteToInt(b[40]) * 256 + StringUtil.byteToInt(b[41]));
			map.put("subsidyVersion", StringUtil.byteToInt(b[56]) * 256 + StringUtil.byteToInt(b[57]));
			map.put("subsidyAuth", (b[58] >> 1) & 0x1);

			// 命令码为1是主动询问返回的状态
			commandCode = StringUtil.byteToInt(b[34]) * 256 + StringUtil.byteToInt(b[35]);
			if (commandCode == 1) {
				execReplyCommand(sn, commandCode, b, map, true);
			}
			// 普通记录
		} else if (b[30] == 1 && b[31] == 1) {
			map.put("'type'", "consumeRecord");
			map.put("'sn'", sn);
			// 帐号 4,卡号 4,卡序号1,卡总额 4, 卡余额
			// 4,管理费额4,补助余额4,操作金额4,卡操作次数2,补助操作计数2,补助操作额4,RecNo
			recNO = consumeRecord(sn, map, b);
			// 订餐取餐记录
		} else if (b[30] == 8 && b[31] == 1) {
			map.put("'type'", "cookbookRecord");
			map.put("'sn'", sn);
			// 菜单消费 202 0xca,菜单订餐 203 0xcb
			int recType = b[92] & 0xff;
			if (recType == 0xca) {
				recNO = consumeRecord(sn, map, b);
			} else if (recType == 0xcb) {
				recNO = cookbookRecord(map, b, sn);
			}
			// 命令回复
		} else {
			execReplyCommand(sn, commandCode, b, map, false);
			return;
		}

		// 回复记录号
		if (recNO > 0) {
			try {
				String buf = StringUtil.byteToHexStr(0, 27, b) + "000d0101" + StringUtil.strLeftPad("", 8) + StringUtil.hexLeftPad(recNO, 4) + "000000";
				b = StringUtil.strTobytes(buf);
				TerminalManager.sendToPos(inetSocketAddress, b);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 向监控平台发送命令
		if (map.size() > 0) {
			Integer companyId = TerminalManager.SNToCompanyList.get(sn);
			TerminalManager.sendToMonitor(map, companyId);
		}
	}

	// 分解消费记录
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static int consumeRecord(String sn, Map map, byte[] b) {
		Device device = TerminalManager.SNToDevicelList.get(sn);
		// 大帧：1为普通8为菜单
		int frame = b[30];
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		Integer userId = StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b);
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setDeviceNum(device.getDeviceNum());

		record.setCardSumFare(StringUtil.hexToInt(baseIndex + 15, baseIndex + 18, b));
		record.setCardOddFare(StringUtil.hexToInt(baseIndex + 19, baseIndex + 22, b));
		record.setDiscountFare(StringUtil.hexToInt(baseIndex + 23, baseIndex + 26, b));
		record.setSubsidyOddFare(StringUtil.hexToInt(baseIndex + 27, baseIndex + 30, b));
		record.setCardOpFare(StringUtil.hexToInt(baseIndex + 31, baseIndex + 34, b));
		record.setCardOpCount(StringUtil.hexToInt(baseIndex + 35, baseIndex + 36, b));
		record.setSubsidyOpCount(StringUtil.hexToInt(baseIndex + 37, baseIndex + 38, b));
		record.setSubsidyOpFare(StringUtil.hexToInt(baseIndex + 39, baseIndex + 42, b));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, 2000 + StringUtil.byteToBCDInt(b[baseIndex + 43]));
		c.set(Calendar.MONTH, StringUtil.byteToBCDInt(b[baseIndex + 44]));
		c.set(Calendar.DAY_OF_MONTH, StringUtil.byteToBCDInt(b[baseIndex + 45]));
		c.set(Calendar.HOUR_OF_DAY, StringUtil.byteToBCDInt(b[baseIndex + 46]));
		c.set(Calendar.MINUTE, StringUtil.byteToBCDInt(b[baseIndex + 47]));
		c.set(Calendar.SECOND, StringUtil.byteToBCDInt(b[baseIndex + 48]));
		record.setOpTimeDes(StringUtil.dateFormat(c.getTime(), "yyyy-MM-dd HH:mm:ss"));
		int recordNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecordNO(recordNO);
		record.setConsumeType((int) b[31]);
		record.setConsumeTypeDes(ConsumeType.NormalConsume);

		List<Map> list = JdbcUtil.baseDAO.selectBySql("select userNO,username from user where userId=" + userId);
		if (list.size() > 0) {
			String userNO = String.valueOf(list.get(0).get("userNO"));
			String username = String.valueOf(list.get(0).get("username"));
			record.setUserNO(userNO);
			record.setUsername(username);
		}

		List<Meal> mealList = TerminalManager.CompanyToMealList.get(device.getCompanyId());
		int mealId = 0;
		String opTime = StringUtil.dateFormat(c.getTime(), "HH:mm:ss");
		for (Meal m : mealList) {
			if (m.getBeginTime().compareTo(opTime) <= 0 && m.getEndTime().compareTo(opTime) >= 0) {
				mealId = m.getId();
				record.setMealName(m.getMealName());
			}
		}
		record.setMealId(mealId);

		// 订餐消费记录
		if (frame == 8) {
			record.setCookbookCode(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
			record.setCookbookNum(StringUtil.hexToInt(baseIndex + 60, baseIndex + 60, b));
		}

		map.put("consumeRecord", record);
		return recordNO;
	}

	// 分解订餐取餐记录
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static int cookbookRecord(Map map, byte[] b, String sn) {
		Device device = TerminalManager.SNToDevicelList.get(sn);
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setDeviceNum(device.getDeviceNum());

		record.setCardSumFare(StringUtil.hexToInt(baseIndex + 15, baseIndex + 18, b));
		record.setCardOddFare(StringUtil.hexToInt(baseIndex + 19, baseIndex + 22, b));
		record.setDiscountFare(StringUtil.hexToInt(baseIndex + 23, baseIndex + 26, b));
		record.setSubsidyOddFare(StringUtil.hexToInt(baseIndex + 27, baseIndex + 30, b));
		record.setCardOpFare(StringUtil.hexToInt(baseIndex + 31, baseIndex + 34, b));
		record.setCardOpCount(StringUtil.hexToInt(baseIndex + 35, baseIndex + 36, b));
		record.setSubsidyOpCount(StringUtil.hexToInt(baseIndex + 37, baseIndex + 38, b));
		record.setSubsidyOpFare(StringUtil.hexToInt(baseIndex + 39, baseIndex + 42, b));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, 2000 + StringUtil.byteToInt(b[43]));
		c.set(Calendar.MONTH, StringUtil.byteToInt(b[44]));
		c.set(Calendar.DAY_OF_MONTH, StringUtil.byteToInt(b[45]));
		c.set(Calendar.HOUR_OF_DAY, StringUtil.byteToInt(b[46]));
		c.set(Calendar.MINUTE, StringUtil.byteToInt(b[47]));
		c.set(Calendar.SECOND, StringUtil.byteToInt(b[48]));
		record.setOpTime(c.getTime());
		int recordNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecordNO(recordNO);
		record.setMealId(0);

		// 发送订餐记录到监控平台
		map.put("record", record);
		TerminalManager.sendToMonitor(map, device.getCompanyId());
		return recordNO;
	}

	// 分解命令回复
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static void execReplyCommand(String sn, int commandCode, byte[] b, Map map, boolean statusReply) {
		SendCommand sendCommand = null;
		synchronized (TerminalManager.sendCommandObject) {
			ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
			if (sendCommandList != null && sendCommandList.size() > 0) {
				sendCommand = sendCommandList.get(0);
				System.out.println(sendCommand.getCommandCode() + " " + commandCode);
				if (sendCommand.getCommandCode() == commandCode) {
					sendCommandList.remove(sendCommand);
				}
			}
		}
		// 如果是获取状态回复就返回
		if (statusReply) {
			return;
		}

		Device device = TerminalManager.SNToDevicelList.get(sn);
		map.put("type", "log");
		map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
		map.put("from", device.getDeviceName());
		byte subFrame = b[32];
		switch (b[31]) {
		// 校时
		case PosFrame.SysTime:
			if (subFrame == PosSubFrameOther.SysTime) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecSysTime));
			}
			break;
		// 系统参数
		case PosFrame.Sys:
			if (subFrame == PosSubFrameSysParam.ConsumeParam) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecConsumeParams));
			} else if (subFrame == PosSubFrameSysParam.Meal) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecMeal));
			} else if (subFrame == PosSubFrameSysParam.Discount) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecDiscount));
			} else if (sendCommand.getSubFrame() == PosSubFrameSysParam.SysPwd) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecSysPwd));
			} else if (sendCommand.getSubFrame() == PosSubFrameSysParam.SetCompanyName) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecCompanyName));
			}
			break;
		// 菜单
		case PosFrame.Cookbook:
			if (subFrame == PosSubFrameCookbook.OrderTime1) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecOrderTime1));
			} else if (subFrame == PosSubFrameCookbook.OrderTime2) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecOrderTime2));
			} else if (subFrame == PosSubFrameCookbook.Update) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecUpdate));
			} else if (subFrame == PosSubFrameCookbook.Append) {
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.ExecAppend), sendCommand.getCookbookIndex(), sendCommand.getCookbookTotal(), cookbook.getCookbookCode(),
						cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (subFrame == PosSubFrameCookbook.Modify) {
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.ExecModifyCookbook), cookbook.getCookbookCode(), cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (subFrame == PosSubFrameCookbook.GetLastNum) {
				int code = StringUtil.byteToInt(b[38]) * 256 + StringUtil.byteToInt(b[39]);
				ArrayList<SendCommand> tempList = new ArrayList<SendCommand>();
				synchronized (TerminalManager.sendCommandObject) {
					ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn);
					if (sendCommandList != null && sendCommandList.size() > 0) {
						for (SendCommand command : sendCommandList) {
							if (command.getFrame() == PosFrame.Cookbook) {
								int code2 = command.getCookbook().getCookbookCode();
								if (code2 > code) {
									tempList.add(command);
								}
							} else {
								tempList.add(command);
							}
						}
						TerminalManager.SNToSendCommandList.put(sn, tempList);
					}
					System.out.println("new size:" + tempList.size());
				}
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecGetLastNumCookbook));
			}
			break;
		// 初始化
		case PosFrame.SysInit:
			if (subFrame == PosSubFrameOther.SysInit) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecSysInit));
			}
			break;

		default:
			break;
		}
		if (map.size() > 3) {
			TerminalManager.sendToMonitor(map, device.getCompanyId());
		}
	}
}
