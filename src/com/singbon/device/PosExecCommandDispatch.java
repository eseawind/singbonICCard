package com.singbon.device;

import java.net.InetSocketAddress;
import java.util.Calendar;
import java.util.Date;
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
		Device device = TerminalManager.SNToDeviceList.get(sn);
		if (device == null || device.getEnable() == 0)
			return;

		Integer transferId = device.getTransferId();
		if (transferId == null) {
			transferId = 0;
		}
		// 设置sn与inetSocketAddress对照关系
		if (transferId == 0) {
			TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);
		}

		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		Map map = new HashMap();
		map.put("'sn'", sn);
		// 监控非中转更新访问时间
		map.put("'transferId'", transferId);

		// 心跳包
		if (b[30] == PosFrame.Status && b[31] == PosSubFrameStatus.SysStatus) {
			// 监控打开执行操作
			if (TerminalManager.CompanyIdToMonitorRunningList.containsKey(device.getCompanyId())
					&& TerminalManager.CompanyIdToMonitorRunningList.get(device.getCompanyId())) {
				map.put("'type'", "s");
				// 非中转设备
				if (device.getDeviceType() != 1) {
					map.put("a", Integer.parseInt(StringUtil.getHexStrFromBytes(36, 37, b), 16));
					map.put("b", (b[44] >> 1) & 0x1);
					map.put("c", Integer.parseInt(StringUtil.getHexStrFromBytes(55, 56, b), 16));

					autoExecCommand(inetSocketAddress, b, device, commandCode);
				}
				// 向监控平台发送心跳
				if (map.size() > 1) {
					TerminalManager.sendToMonitor(map, device.getCompanyId());
				}
			}

			// 记录帧 1普通消费、2补助消费、9领取补助记录
		} else if (b[30] == 1 && (b[31] == 1 || b[31] == 2 || b[31] == 3 || b[31] == 9 || b[31] == 39)) {
			PosExecConsumeRecord record = new PosExecConsumeRecord(device, b, map, inetSocketAddress);
			record.run();
			// 订餐取餐记录
		} else if (b[30] == 8 && (b[31] == 1 || b[31] == 2 || b[31] == 3)) {
			// 菜单消费 202 0xca,菜单订餐 203 0xcb
			int recType = b[92] & 0xff;
			if (recType == 202) {
				PosExecConsumeRecord record = new PosExecConsumeRecord(device, b, map, inetSocketAddress);
				record.run();
			} else if (recType == 203) {
				PosExecCookbookRecord record = new PosExecCookbookRecord(device, b, map, inetSocketAddress);
				record.run();
			}
			// 补助请求
		} else if (b[30] == 4 && b[31] == 1) {
			PosExecSubsidyRequest request = new PosExecSubsidyRequest(device, b);
			request.run();
			// 命令回复
		} else {
			PosExecReplyCommand.execReplyCommand(device, commandCode, b, map);
			return;
		}
	}

	private static void autoExecCommand(InetSocketAddress inetSocketAddress, byte[] b, Device device, int commandCode) {
		// 相差半分钟校时
		Calendar c1 = Calendar.getInstance();
		c1.set(StringUtil.objToInt("20" + StringUtil.getHexStrFromBytes(45, 45, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(46, 46, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(47, 47, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(48, 48, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(49, 49, b)),
				StringUtil.objToInt(StringUtil.getHexStrFromBytes(50, 50, b)));
		c1.add(Calendar.MONTH, -1);
		Calendar c2 = Calendar.getInstance();
		c2.setTime(new Date());

		if (Math.abs(c1.getTimeInMillis() - c2.getTimeInMillis()) > 30000) {
			String sendBufStr = StringUtil.hexLeftPad(PosFrame.Sys07, 2)
					+ StringUtil.hexLeftPad(PosSubFrameSys07.SysTime, 2) + "0000"
					+ StringUtil.hexLeftPad(commandCode, 4) + StringUtil.timeToHexStr() + "0000";
			String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
			sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum
					+ DeviceType.Main + DeviceType.getDeviceTypeFrame(device) + bufLen + sendBufStr;
			byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
			try {
				TerminalManager.sendToPos(inetSocketAddress, sendBuf);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 自动下载批次黑名单
		int lastBatchId = Integer.parseInt(StringUtil.getHexStrFromBytes(38, 39, b), 16);
		long sysLastBatchId = 0;
		if (TerminalManager.CompanyIdToLastBatchIdList.containsKey(device.getCompanyId())) {
			sysLastBatchId = TerminalManager.CompanyIdToLastBatchIdList.get(device.getCompanyId());
		}
		if (lastBatchId != sysLastBatchId && sysLastBatchId != 0) {
			PosExecBatchBlack black = new PosExecBatchBlack(lastBatchId, device);
			black.run();
		}

		// 自动下载黑名单
		long lastBlackNum = Long.parseLong(StringUtil.getHexStrFromBytes(40, 43, b), 16);
		long sysLastBlackNum = 0;
		if (TerminalManager.CompanyIdToLastBlackNumList.containsKey(device.getCompanyId())) {
			sysLastBlackNum = TerminalManager.CompanyIdToLastBlackNumList.get(device.getCompanyId());
		}

		if (lastBlackNum != sysLastBlackNum && sysLastBlackNum != 0) {
			PosExecCardBlack black = new PosExecCardBlack(lastBlackNum, device);
			black.run();
		}
	}
}
