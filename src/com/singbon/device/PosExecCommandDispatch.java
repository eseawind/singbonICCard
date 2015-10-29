package com.singbon.device;

import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.Map;

import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 处理分发消费机回复命令
 * 
 * @author 郝威
 * 
 */
public class PosExecCommandDispatch {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void execCommand(InetSocketAddress inetSocketAddress, byte[] b) {
		if (b == null)
			return;
		String sn = StringUtil.getHexStrFromBytes(0, 15, b);
		// 设置sn与inetSocketAddress对照关系
		TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);
		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		int recNO = 0;
		Map map = new HashMap();
		map.put("'sn'", sn);
		Device device = TerminalManager.SNToDevicelList.get(sn);
		// 终端设备状态
		if (b[30] == PosFrame.Status && b[31] == PosSubFrameStatus.SysStatus) {
			map.put("'type'", "status");
			map.put("recordNum", StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]));
			map.put("batchNum", StringUtil.byteToInt(b[38]) * 256 + StringUtil.byteToInt(b[39]));
			map.put("blackNum", StringUtil.byteToInt(b[40]) * 256 + StringUtil.byteToInt(b[41]));
			map.put("subsidyVersion", StringUtil.byteToInt(b[56]) * 256 + StringUtil.byteToInt(b[57]));
			map.put("subsidyAuth", (b[58] >> 1) & 0x1);

			// 命令码为1是主动询问返回的状态
			commandCode = StringUtil.byteToInt(b[34]) * 256 + StringUtil.byteToInt(b[35]);
			if (commandCode == 1) {
				PosExecReplyCommand.execReplyCommand(device, commandCode, b, map, true);
			}
			// 普通记录
		} else if (b[30] == 1 && b[31] == 1) {
			map.put("'type'", "consumeRecord");
			// 帐号 4,卡号 4,卡序号1,卡总额 4, 卡余额
			// 4,管理费额4,补助余额4,操作金额4,卡操作次数2,补助操作计数2,补助操作额4,RecNo
			recNO = PosExecConsumeRecord.consumeRecord(device, map, b);
			// 补助记录
		} else if (b[30] == 1 && b[31] == 9) {
			map.put("'type'", "consumeRecord");
			// 订餐取餐记录
		} else if (b[30] == 8 && b[31] == 1) {
			map.put("'type'", "cookbookRecord");
			// 菜单消费 202 0xca,菜单订餐 203 0xcb
			int recType = b[92] & 0xff;
			if (recType == 0xca) {
				recNO = PosExecConsumeRecord.consumeRecord(device, map, b);
			} else if (recType == 0xcb) {
				recNO = PosExecCookbookRecord.cookbookRecord(device, map, b);
			}
			// 补助请求
		} else if (b[30] == 4 && b[31] == 1) {
			PosExecSubsidyRequest request = new PosExecSubsidyRequest(device, b);
			request.run();
			// 命令回复
		} else {
			PosExecReplyCommand.execReplyCommand(device, commandCode, b, map, false);
			return;
		}

		// 回复记录号
		if (recNO > 0) {
			try {
				String buf = StringUtil.getHexStrFromBytes(0, 27, b) + "000d0101" + StringUtil.strLeftPad("", 8) + StringUtil.hexLeftPad(recNO, 4) + "000000";
				b = StringUtil.strTobytes(buf);
				TerminalManager.sendToPos(inetSocketAddress, b);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 向监控平台发送命令
		if (map.size() > 0) {
			TerminalManager.sendToMonitor(map, device.getCompanyId());
		}
	}
}
