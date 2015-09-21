package com.singbon.device;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.comet4j.core.util.JSONUtil;

import com.singbon.entity.ConsumeRecord;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 处理消费机回复命令
 * 
 * @author 郝威
 * 
 */
public class ExecPosCommand {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void execCommand(InetSocketAddress inetSocketAddress, byte[] b) {
		if (b == null)
			return;
		String sn = StringUtil.byteToHexString(0, 15, b);
		TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);
		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		int recNO = 0;
		Map map = new HashMap();
		// 终端设备状态，设置sn与inetSocketAddress对照关系
		if (b[30] == FramePos.Status && b[31] == SubStatusFramePos.SysStatus) {
			map.put("'type'", "status");
			map.put("'sn'", sn);
			map.put("recordNum", StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]));
			map.put("batchNum", StringUtil.byteToInt(b[38]) * 256 + StringUtil.byteToInt(b[39]));
			map.put("blackNum", StringUtil.byteToInt(b[40]) * 256 + StringUtil.byteToInt(b[41]));
			map.put("subsidyVersion", StringUtil.byteToInt(b[56]) * 256 + StringUtil.byteToInt(b[57]));
			map.put("subsidyAuth", (b[58] >> 1) & 0x1);
			// 普通记录
		} else if (b[30] == 1 && b[31] == 1) {
			map.put("'type'", "record");
			map.put("'sn'", sn);
			// 帐号 4,卡号 4,卡序号1,卡总额 4, 卡余额
			// 4,管理费额4,补助余额4,操作金额4,卡操作次数2,补助操作计数2,补助操作额4,RecNo
			recNO = consumeRecord(sn, map, b);
			// 订餐记录
		} else if (b[30] == 8 && b[31] == 1) {
			map.put("'type'", "cookbookRecord");
			map.put("'sn'", sn);
			// 菜单消费 202 0xca,菜单订餐 203 0xcb
			int recType = b[92] & 0xff;
			if (recType == 0xca) {
				recNO = consumeRecord(sn, map, b);
			} else if (recType == 0xcb) {
				recNO = cookbookRecord(map, b);
			}
			// 命令回复
		} else {
			execReplyCommand(sn, commandCode, b, map);
			return;
		}

		// 回复记录号
		if (recNO > 0) {
			System.out.println("recNO:" + recNO);
			try {
				String buf = StringUtil.byteToHexString(0, 27, b) + "000d010100000000" + StringUtil.hexLeftPad(recNO, 4) + "000000";
				b = StringUtil.strTobytes(buf);
				TerminalManager.sendToPos(inetSocketAddress, b);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		// 向监控平台发送命令
		if (map.size() > 0) {
			String msg = JSONUtil.convertToJson(map);
			Integer companyId = TerminalManager.SNToCompanyList.get(sn);
			TerminalManager.EngineInstance.sendToAll("Co" + companyId, msg);
		}
	}

	// 分解消费记录
	@SuppressWarnings("rawtypes")
	private static int consumeRecord(String sn, Map map, byte[] b) {
		// 大帧：1为普通8为菜单
		int frame = b[30];
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setAccType((int) b[31]);
		record.setDeviceNum(TerminalManager.SNToDevicelList.get(sn).getDeviceNum());

		record.setCardSumFare(StringUtil.hexToInt(baseIndex + 15, baseIndex + 18, b));
		record.setCardOddFare(StringUtil.hexToInt(baseIndex + 19, baseIndex + 22, b));
		record.setDiscountFare(StringUtil.hexToInt(baseIndex + 23, baseIndex + 26, b));
		record.setSubsidyOddFare(StringUtil.hexToInt(baseIndex + 27, baseIndex + 30, b));
		record.setCardOpFare(StringUtil.hexToInt(baseIndex + 31, baseIndex + 34, b));
		record.setCardOpCount(StringUtil.hexToInt(baseIndex + 35, baseIndex + 36, b));
		record.setSubsidyOpCount(StringUtil.hexToInt(baseIndex + 37, baseIndex + 38, b));
		record.setSubsidyOpFare(StringUtil.hexToInt(baseIndex + 39, baseIndex + 42, b));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, 2000 + b[43]);
		c.set(Calendar.MONTH, b[44]);
		c.set(Calendar.DAY_OF_MONTH, b[45]);
		c.set(Calendar.HOUR_OF_DAY, b[46]);
		c.set(Calendar.MINUTE, b[47]);
		c.set(Calendar.SECOND, b[48]);
		record.setOpTime(c.getTime());
		int recNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecNO(recNO);
		record.setMealId(0);

		// 订餐消费记录
		if (frame == 8) {
			record.setCookbookCode(StringUtil.hexToInt(baseIndex + 52, baseIndex + 53, b));
			record.setCookbookNum(StringUtil.hexToInt(baseIndex + 60, baseIndex + 60, b));
		}
		return recNO;
	}

	// 分解订餐消费记录
	@SuppressWarnings("rawtypes")
	private static int cookbookRecord(Map map, byte[] b) {
		ConsumeRecord record = new ConsumeRecord();
		int baseIndex = 30;
		record.setUserId(StringUtil.hexToInt(baseIndex + 6, baseIndex + 9, b));
		record.setCardNO(StringUtil.hexToInt(baseIndex + 10, baseIndex + 13, b));
		record.setCardSeq(StringUtil.hexToInt(baseIndex + 14, baseIndex + 14, b));
		record.setAccType((int) b[31]);
		// record.setDeviceNum(TerminalManager.SNToDevicelList.get(sn).getDeviceNum());

		record.setCardSumFare(StringUtil.hexToInt(baseIndex + 15, baseIndex + 18, b));
		record.setCardOddFare(StringUtil.hexToInt(baseIndex + 19, baseIndex + 22, b));
		record.setDiscountFare(StringUtil.hexToInt(baseIndex + 23, baseIndex + 26, b));
		record.setSubsidyOddFare(StringUtil.hexToInt(baseIndex + 27, baseIndex + 30, b));
		record.setCardOpFare(StringUtil.hexToInt(baseIndex + 31, baseIndex + 34, b));
		record.setCardOpCount(StringUtil.hexToInt(baseIndex + 35, baseIndex + 36, b));
		record.setSubsidyOpCount(StringUtil.hexToInt(baseIndex + 37, baseIndex + 38, b));
		record.setSubsidyOpFare(StringUtil.hexToInt(baseIndex + 39, baseIndex + 42, b));
		Calendar c = Calendar.getInstance();
		c.set(Calendar.YEAR, 2000 + b[43]);
		c.set(Calendar.MONTH, b[44]);
		c.set(Calendar.DAY_OF_MONTH, b[45]);
		c.set(Calendar.HOUR_OF_DAY, b[46]);
		c.set(Calendar.MINUTE, b[47]);
		c.set(Calendar.SECOND, b[48]);
		record.setOpTime(c.getTime());
		int recNO = StringUtil.hexToInt(baseIndex + 49, baseIndex + 50, b);
		record.setRecNO(recNO);
		record.setMealId(0);
		return recNO;
	}

	// 分解命令回复
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static void execReplyCommand(String sn, int commandCode, byte[] b, Map map) {
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
		Device device = TerminalManager.SNToDevicelList.get(sn);
		map.put("type", "log");
		map.put("time", StringUtil.dateFormat(new Date(), "yyyyMMdd HH:mm:ss"));
		map.put("from", device.getDeviceName());
		byte subFrame = b[32];
		switch (b[31]) {
		// 校时
		case FramePos.SysTime:
			if (subFrame == SubOtherFramePos.SysTime) {
				map.put("des", "执行终端校时命令成功");
			}
			break;
		// 系统参数
		case FramePos.SysPara:
			if (subFrame == SubSysParaFramePos.SysPara) {
				map.put("des", "执行系统参数命令成功");
			} else if (subFrame == SubSysParaFramePos.Meal) {
				map.put("des", "执行餐别限次命令成功");
			} else if (subFrame == SubSysParaFramePos.Discount) {
				map.put("des", "执行折扣费率及管理费成功");
			}
			break;
		// 菜单
		case FramePos.Cookbook:
			if (subFrame == SubCookbookFramePos.OrderTime1) {
				map.put("des", "执行订餐时间段1-6成功");
			} else if (subFrame == SubCookbookFramePos.OrderTime2) {
				map.put("des", "执行订餐时间段7-12成功");
			} else if (subFrame == SubCookbookFramePos.Update) {
				map.put("des", "执行菜肴清单更新成功");
			} else if (subFrame == SubCookbookFramePos.Append) {
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format("发送菜肴清单追加命令：第%s/%s个，编号：%s，单价：%s，菜名：%s", sendCommand.getCookbookIndex(), sendCommand.getCookbookTotal(), cookbook.getCookbookCode(), cookbook.getPrice(),
						cookbook.getCookbookName());
				map.put("des", log);
			}
			break;
		// 初始化
		case FramePos.SysInit:
			if (subFrame == SubOtherFramePos.SysInit) {
				map.put("des", "执行初始化命令成功");
			}
			break;

		default:
			break;
		}
		if (map.size() > 3) {
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.EngineInstance.sendToAll("Co" + device.getCompanyId(), msg);
		}
	}
}
