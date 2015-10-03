package com.singbon.device;

import java.nio.channels.SelectionKey;
import java.nio.channels.SocketChannel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import com.singbon.util.DesUtil;
import com.singbon.util.StringUtil;

/**
 * 处理读卡机回复命令
 * 
 * @author 郝威
 * 
 */
public class ExecCardReaderCommand {

	/**
	 * 分发命令
	 * 
	 * @param selectionKey
	 * @param b
	 *            26 27指令 00 获取机器号序列号，01读卡，
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void execCommand(SelectionKey selectionKey, byte[] b) {
		if (b == null)
			return;
		String sn = StringUtil.byteToHexStr(0, 15, b);
		// 帧
		byte[] frameByte = Arrays.copyOfRange(b, 30, 34);
		// 命令码
		int commandCode = StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
		// 状态码 1读写成功、2寻卡失败、3卡校验失败、4物理卡号不匹配、5读写卡失败
		byte cardStatus = 0;
		// 物理卡号
		String cardSN = null;
		if (frameByte[0] == 0x03 && frameByte[1] == (byte) 0xcd) {
			cardStatus = b[45];
			cardSN = StringUtil.byteToHexStr(39, 42, b);
		}

		Map map = new HashMap();
		// 获取机器号序列号
		if (frameByte[0] == 0x03 && frameByte[1] == 0x08) {
			byte frame = FrameCardReader.HeartStatus;
			TerminalManager.UuidToSNList.put(selectionKey.attachment().toString(), sn);
			TerminalManager.SNToSocketChannelList.put(sn, (SocketChannel) selectionKey.channel());
			map.put("'f1'", frame);
			map.put("'r'", 1);
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////写卡回复
			// //////////////////////////////////////////////////////////////////////////////
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x01, 0x01 })) {
			// 单个发卡完成
			if (commandCode == CommandCodeCardReader.SingleCard) {
				map.put("'f1'", FrameCardReader.SingleCardDone);
				map.put("'r'", cardStatus);
			}
			// 信息发卡完成
			else if (commandCode == CommandCodeCardReader.InfoCard) {
				map.put("'f1'", FrameCardReader.InfoCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂完成
			else if (commandCode == CommandCodeCardReader.Unloss) {
				map.put("'f1'", FrameCardReader.UnlossDone);
				map.put("'r'", cardStatus);
			}
			// 补卡完成
			else if (commandCode == CommandCodeCardReader.RemakeCard) {
				map.put("'f1'", FrameCardReader.RemakeCardDone);
				map.put("'r'", cardStatus);
			}
			// 换新卡完成
			else if (commandCode == CommandCodeCardReader.ChangeNewCard) {
				map.put("'f1'", FrameCardReader.ChangeNewCardDone);
				map.put("'r'", cardStatus);
			}
			// 读卡修正完成
			else if (commandCode == CommandCodeCardReader.ReadCard) {
				map.put("'f1'", FrameCardReader.ReadCardDone);
				map.put("'r'", cardStatus);
			}
			// 制出纳卡完成
			else if (commandCode == CommandCodeCardReader.MakeCashierCard) {
				map.put("'f1'", FrameCardReader.MakeCashierCardDone);
				map.put("'r'", cardStatus);
				map.put("'newCardSN'", cardSN);
			}
			// 挂失出纳卡完成
			else if (commandCode == CommandCodeCardReader.LossCashierCard) {
				map.put("'f1'", FrameCardReader.LossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂出纳卡完成
			else if (commandCode == CommandCodeCardReader.UnLossCashierCard) {
				map.put("'f1'", FrameCardReader.UnLossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂出纳卡完成
			else if (commandCode == CommandCodeCardReader.UnLossCashierCard) {
				map.put("'f1'", FrameCardReader.UnLossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 补办出纳卡完成
			else if (commandCode == CommandCodeCardReader.RemakeCashierCard) {
				map.put("'f1'", FrameCardReader.RemakeCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 修改出纳卡有效期完成
			else if (commandCode == CommandCodeCardReader.InvalidDateCashierCard) {
				map.put("'f1'", FrameCardReader.InvalidDateCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 存取款完成
			else if (commandCode == CommandCodeCardReader.Charge) {
				map.put("'f1'", FrameCardReader.ChargeDone);
				map.put("'r'", cardStatus);
			}
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////读卡回复
			// //////////////////////////////////////////////////////////////////////////////
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x00, 0x01 })) {
			int baseLen = 43;
			// 获取出纳卡基本信息命令
			if (commandCode == CommandCodeCardReader.CashierCardBaseInfo) {
				map.put("'f1'", FrameCardReader.CashierCardBaseInfoCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				map.put("'cardNO'", cardSN);
			}
			// 发送单个发卡命令
			else if (commandCode == CommandCodeCardReader.SingleCard) {
				map.put("'f1'", FrameCardReader.SingleCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 发送信息发卡命令
			else if (commandCode == CommandCodeCardReader.InfoCard) {
				map.put("'f1'", FrameCardReader.InfoCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 发解挂命令
			else if (commandCode == CommandCodeCardReader.Unloss) {
				map.put("'f1'", FrameCardReader.UnlossCmd);
				map.put("'r'", cardStatus);
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen, b.length - 1, b));
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(StringUtil.byteToHexStr(baseLen + 3, baseLen + 3 + 3, b), 16));
			}
			// 发补卡命令
			else if (commandCode == CommandCodeCardReader.RemakeCard) {
				map.put("'f1'", FrameCardReader.RemakeCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 换卡读原卡命令
			else if (commandCode == CommandCodeCardReader.ReadOldCard) {
				map.put("'f1'", FrameCardReader.ReadOldCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(StringUtil.byteToHexStr(baseLen + 3, baseLen + 3 + 3, b), 16));
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen, b.length - 1, b));
			}
			// 换卡换新卡命令
			else if (commandCode == CommandCodeCardReader.ChangeNewCard) {
				map.put("'f1'", FrameCardReader.ChangeNewCardCmd);
				map.put("'r'", cardStatus);
				map.put("'newCardSN'", cardSN);
			}
			// 读卡修正命令
			else if (commandCode == CommandCodeCardReader.ReadCard) {
				map.put("'f1'", FrameCardReader.ReadCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				int base0 = baseLen + 3;
				try {
					map.put("'userId'", Integer.parseInt(StringUtil.byteToHexStr(base0, base0 + 3, b), 16));
				} catch (Exception e) {
					map.put("userId", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'cardNO'", Integer.parseInt(StringUtil.byteToHexStr(base0 + 4, base0 + 7, b), 16));
				} catch (Exception e) {
					map.put("cardNO", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'invalidDate'", StringUtil.dateFromHexStr(StringUtil.byteToHexStr(base0 + 10, base0 + 11, b)));
				} catch (Exception e) {
					map.put("invalidDate", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					int status = Integer.parseInt(StringUtil.byteToHexStr(base0 + 12, base0 + 12, b), 16);
					String statusDesc = "正常";
					if (status == 241) {
						statusDesc = "正常";
					} else if (status == 242) {
						statusDesc = "未开户或注销";
					} else if (status == 243) {
						statusDesc = "挂失";
					} else {
						statusDesc = "异常";
					}

					map.put("'status'", status);
					map.put("'statusDesc'", statusDesc);
				} catch (Exception e) {
					map.put("status", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
					map.put("statusDesc", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}

				int base2 = baseLen + 19 + 3;
				try {
					map.put("'cardSeq'", Integer.parseInt(StringUtil.byteToHexStr(base2 + 4, base2 + 4, b), 16));
				} catch (Exception e) {
					map.put("cardSeq", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'cardTypeId'", Integer.parseInt(StringUtil.byteToHexStr(base2 + 5, base2 + 5, b), 16));
				} catch (Exception e) {
					map.put("cardTypeId", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'totalFare'", (float) Integer.parseInt(StringUtil.byteToHexStr(base2 + 10, base2 + 13, b), 16) / 100);
				} catch (Exception e) {
					map.put("totalFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}

				int consume0 = baseLen + 19 * 2 + 3;
				try {
					map.put("'opCount'", Integer.parseInt(StringUtil.byteToHexStr(consume0, consume0 + 1, b), 16));
				} catch (Exception e) {
					map.put("opCount", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'oddFare'", (float) Integer.parseInt(StringUtil.byteToHexStr(consume0 + 3, consume0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("oddFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}

				int subsidy0 = baseLen + 19 * 3 + 3;
				try {
					map.put("'subsidyOpCount'", Integer.parseInt(StringUtil.byteToHexStr(subsidy0, subsidy0 + 1, b), 16));
				} catch (Exception e) {
					map.put("subsidyOpCount", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'subsidyOddFare'", (float) Integer.parseInt(StringUtil.byteToHexStr(subsidy0 + 2, subsidy0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("subsidyOddFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'subsidyVersion'", Integer.parseInt(StringUtil.byteToHexStr(subsidy0 + 8, subsidy0 + 9, b), 16));
				} catch (Exception e) {
					map.put("subsidyVersion", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
			}
			// 制出纳卡命令
			else if (commandCode == CommandCodeCardReader.MakeCashierCard) {
				map.put("'f1'", FrameCardReader.MakeCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 挂失出纳卡命令
			else if (commandCode == CommandCodeCardReader.LossCashierCard) {
				map.put("'f1'", FrameCardReader.LossCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen, b.length - 1, b));
			}
			// 解挂出纳卡命令
			else if (commandCode == CommandCodeCardReader.UnLossCashierCard) {
				map.put("'f1'", FrameCardReader.UnLossCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen, b.length - 1, b));
			}
			// 补办出纳卡命令
			else if (commandCode == CommandCodeCardReader.RemakeCashierCard) {
				map.put("'f1'", FrameCardReader.RemakeCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 读取出纳卡命令
			else if (commandCode == CommandCodeCardReader.ReadCashierCard) {
				map.put("'f1'", FrameCardReader.ReadCashierCardCmd);
				map.put("'r'", cardStatus);

				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				String date = StringUtil.dateFromHexStr(StringUtil.byteToHexStr(baseLen + 3 + 19 + 10, baseLen + 3 + 19 + 11, b));
				map.put("'date'", date);
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen, b.length - 1, b));
			}
			// 读取卡余额命令
			else if (commandCode == CommandCodeCardReader.ReadCardOddFare) {
				map.put("'f1'", FrameCardReader.ReadCardOddFareCmd);
				map.put("'r'", cardStatus);

				int base0 = baseLen + 3;
				map.put("'userId'", Integer.parseInt(StringUtil.byteToHexStr(base0, base0 + 3, b), 16));
				map.put("'cardNO'", Integer.parseInt(StringUtil.byteToHexStr(base0 + 4, base0 + 7, b), 16));
				map.put("'cardSN'", cardSN);

				int status = Integer.parseInt(StringUtil.byteToHexStr(base0 + 12, base0 + 12, b), 16);
				String statusDesc = "正常";
				if (status == 241) {
					statusDesc = "正常";
				} else if (status == 242) {
					statusDesc = "未开户或注销";
				} else if (status == 243) {
					statusDesc = "挂失";
				} else {
					statusDesc = "异常";
				}

				map.put("'status'", status);
				map.put("'statusDesc'", statusDesc);

				int consume0 = baseLen + 19 * 2 + 3;
				map.put("'oddFare'", (float) Integer.parseInt(StringUtil.byteToHexStr(consume0 + 3, consume0 + 5, b), 16) / 100);
				map.put("'cardInfoStr'", StringUtil.byteToHexStr(baseLen + 19, b.length - 1, b));
			}
		}
		if (map.size() > 0) {
			TerminalManager.sendToCardManager(map, sn);
		}
	}

	private static String getCashierOperId(byte[] b) {
		String operId = "";
		String hex = Integer.toHexString(b[40] & 0x0F);
		operId += hex;
		hex = Integer.toHexString(b[43] & 0xFF);
		if (hex.length() == 1) {
			hex = '0' + hex;
		}
		operId += hex;
		hex = Integer.toHexString(b[44] & 0xFF);
		if (hex.length() == 1) {
			hex = '0' + hex;
		}
		operId += hex;
		return operId;
	}
}
