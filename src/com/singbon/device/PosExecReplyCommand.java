package com.singbon.device;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.util.DesUtil;
import com.singbon.util.StringUtil;

/**
 * 处理命令回复
 * 
 * @author 郝威
 * 
 */
public class PosExecReplyCommand {

	// 分解命令回复
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void execReplyCommand(Device device, Integer commandCode, byte[] b, Map map) {
		SendCommand sendCommand = null;
		synchronized (TerminalManager.sendCommandObject) {
			ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(device.getSn());
			if (sendCommandList != null && sendCommandList.size() > 0) {
				sendCommand = sendCommandList.get(0);
//				System.out.println(sendCommand.getCommandCode() + " " + commandCode);
				if (sendCommand.getCommandCode() == commandCode) {
					sendCommandList.remove(sendCommand);
				}
			}
		}

		map.put("type", "log");
		map.put("time", StringUtil.dateFormat(new Date(), "yyyy-MM-dd HH:mm:ss"));
		map.put("from", device.getDeviceName());
		byte subFrame = b[32];
		switch (b[31]) {
		// 系统07
		case PosFrame.Sys07:
			if (subFrame == PosSubFrameSys07.SysTime) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecSysTime));
			} else if (subFrame == PosSubFrameSys07.GrantSubsidy) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecGrantSubsidy));
			} else if (subFrame == PosSubFrameSys07.DisableSubsidy) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecDisableSubsidy));
			}
			break;
		// 系统04
		case PosFrame.Sys04:
			if (subFrame == PosSubFrameSys04.ConsumeParam) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecConsumeParams));
			} else if (subFrame == PosSubFrameSys04.Meal) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecMeal));
			} else if (subFrame == PosSubFrameSys04.Discount) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecDiscount));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.SysPwd) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecSysPwd));
			} else if (sendCommand.getSubFrame() == PosSubFrameSys04.SetCompanyName) {
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
						cookbook.getPrice() / 100, cookbook.getCookbookName());
				map.put("des", log);
			} else if (subFrame == PosSubFrameCookbook.Modify) {
				Cookbook cookbook = sendCommand.getCookbook();
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.ExecModifyCookbook), cookbook.getCookbookCode(), cookbook.getPrice(), cookbook.getCookbookName());
				map.put("des", log);
			} else if (subFrame == PosSubFrameCookbook.GetLastNum) {
				int code = StringUtil.byteToInt(b[38]) * 256 + StringUtil.byteToInt(b[39]);
				ArrayList<SendCommand> tempList = new ArrayList<SendCommand>();
				synchronized (TerminalManager.sendCommandObject) {
					ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(device.getSn());
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
						TerminalManager.SNToSendCommandList.put(device.getSn(), tempList);
					}
//					System.out.println("new size:" + tempList.size());
				}
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecGetLastNumCookbook));
			}
			break;
		// 黑名单
		case PosFrame.Black:
			if (subFrame == PosSubFrameBlack.BatchUpdate) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecBatchUpdate));
			} else if (subFrame == PosSubFrameBlack.BatchAppend) {
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.ExecBatchAppend), sendCommand.getBatchNames());
				map.put("des", log);

				int lastBatchId = Integer.parseInt(StringUtil.getHexStrFromBytes(b.length - 4, b.length - 3, b), 16);
				TerminalManager.CompanyIdToLastBatchIdList.put(device.getCompanyId(), lastBatchId);
			} else if (subFrame == PosSubFrameBlack.AllUpdate) {
				map.put("des", DesUtil.decrypt(DeviceCommunicateStr.ExecBlackUpdate));
			} else if (subFrame == PosSubFrameBlack.IncAppend) {
				String log = String.format(DesUtil.decrypt(DeviceCommunicateStr.ExecBlackAppend), sendCommand.getBlackNumsDes());
				map.put("des", log);

			//	long lastBlackNum = Long.parseLong(StringUtil.getHexStrFromBytes(b.length - 6, b.length - 3, b), 16);
			//	TerminalManager.CompanyIdToLastBlackNumList.put(device.getCompanyId(), lastBlackNum);
			}
			break;
		// 初始化
		case PosFrame.SysInit:
			if (subFrame == PosSubFrameSys07.SysInit) {
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
