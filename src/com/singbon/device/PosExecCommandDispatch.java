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
		String sn = StringUtil.getHexStrFromBytes(0, 15, b).toUpperCase();
		if (!TerminalManager.SNToDeviceList.containsKey(sn))
			return;
		Device device = TerminalManager.SNToDeviceList.get(sn);

		// 设置sn与inetSocketAddress对照关系
		TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);
		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		Map map = new HashMap();
		map.put("'sn'", sn);

		// 心跳包
		if (b[30] == PosFrame.Status && b[31] == PosSubFrameStatus.SysStatus) {
			map.put("'type'", "status");
			map.put("recordCount", Integer.parseInt(StringUtil.getHexStrFromBytes(36, 37, b), 16));
			map.put("lastBatchNum", Integer.parseInt(StringUtil.getHexStrFromBytes(38, 39, b), 16));
			int lastBlackNum = Integer.parseInt(StringUtil.getHexStrFromBytes(40, 43, b), 16);
			map.put("lastBlackNum", lastBlackNum);
			map.put("subsidyAuth", (b[44] >> 1) & 0x1);
			map.put("batchCount", Integer.parseInt(StringUtil.getHexStrFromBytes(51, 52, b), 16));
			map.put("blackCount", Integer.parseInt(StringUtil.getHexStrFromBytes(53, 54, b), 16));
			map.put("subsidyVersion", Integer.parseInt(StringUtil.getHexStrFromBytes(55, 56, b), 16));

			// 命令码为1是主动询问返回的状态
			commandCode = StringUtil.byteToInt(b[34]) * 256 + StringUtil.byteToInt(b[35]);
			if (commandCode == 1) {
				PosExecReplyCommand.execReplyCommand(device, commandCode, b, map, true);
			}
//			int sysLastBlackNum = TerminalManager.CompanyIdToLastBlackCardNOList.get(device.getCompanyId());
			
			// 记录帧 1普通消费、2补助消费、9领取补助记录
		} else if (b[30] == 1 && (b[31] == 1 || b[31] == 2 || b[31] == 9 || b[31] == 39)) {
			// 帐号 4,卡号 4,卡序号1,卡总额 4, 卡余额
			// 4,管理费额4,补助余额4,操作金额4,卡操作次数2,补助操作计数2,补助操作额4,RecNo
			PosExecConsumeRecord record = new PosExecConsumeRecord(device, b, inetSocketAddress);
			record.run();
			// 订餐取餐记录
		} else if (b[30] == 8 && b[31] == 1) {
			map.put("'type'", "cookbookRecord");
			// 菜单消费 202 0xca,菜单订餐 203 0xcb
			int recType = b[92] & 0xff;
			if (recType == 0xca) {
				// PosExecConsumeRecord.consumeRecord(device, map, b);
			} else if (recType == 0xcb) {
				PosExecCookbookRecord.cookbookRecord(device, map, b);
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

		// 向监控平台发送命令
		if (map.size() > 1) {
			TerminalManager.sendToMonitor(map, device.getCompanyId());
		}
	}
}
