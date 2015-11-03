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
public class CardReaderCommandExec {

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
		String sn = StringUtil.getHexStrFromBytes(0, 15, b).toUpperCase();
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
			cardSN = StringUtil.getHexStrFromBytes(39, 42, b);
		}

		Map map = new HashMap();
		// 获取机器号序列号
		if (frameByte[0] == 0x03 && frameByte[1] == 0x08) {
			byte frame = CardReaderResultCommandCode.HeartStatus;
			TerminalManager.UuidToSNList.put(selectionKey.attachment().toString(), sn);
			TerminalManager.SNToSocketChannelList.put(sn, (SocketChannel) selectionKey.channel());
			map.put("'f1'", frame);
			map.put("'r'", 1);
			// 下载读卡机参数
		} else if (frameByte[1] == 0x04) {
			// 单位名称
			if (frameByte[2] == 0x08) {
				map.put("'f1'", CardReaderResultCommandCode.CompanyName);
			//密码
			} else if (frameByte[2] == 0x03) {
				map.put("'f1'", CardReaderResultCommandCode.CardReaderPwd);
			}
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////写卡回复
			// //////////////////////////////////////////////////////////////////////////////
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x01, 0x01 })) {
			// 单个发卡完成
			if (commandCode == CardReaderCommandCode.SingleCard) {
				map.put("'f1'", CardReaderResultCommandCode.SingleCardDone);
				map.put("'r'", cardStatus);
			}
			// 信息发卡完成
			else if (commandCode == CardReaderCommandCode.InfoCard) {
				map.put("'f1'", CardReaderResultCommandCode.InfoCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂完成
			else if (commandCode == CardReaderCommandCode.Unloss) {
				map.put("'f1'", CardReaderResultCommandCode.UnlossDone);
				map.put("'r'", cardStatus);
			}
			// 有卡注销完成
			else if (commandCode == CardReaderCommandCode.OffWithCard) {
				map.put("'f1'", CardReaderResultCommandCode.OffWithCardDone);
				map.put("'r'", cardStatus);
			}
			// 补卡完成
			else if (commandCode == CardReaderCommandCode.RemakeCard) {
				map.put("'f1'", CardReaderResultCommandCode.RemakeCardDone);
				map.put("'r'", cardStatus);
			}
			// 换新卡完成
			else if (commandCode == CardReaderCommandCode.ChangeNewCard) {
				map.put("'f1'", CardReaderResultCommandCode.ChangeNewCardDone);
				map.put("'r'", cardStatus);
			}
			// 读卡修正完成
			else if (commandCode == CardReaderCommandCode.ReadCard) {
				map.put("'f1'", CardReaderResultCommandCode.ReadCardDone);
				map.put("'r'", cardStatus);
			}
			// 制出纳卡完成
			else if (commandCode == CardReaderCommandCode.MakeCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.MakeCashierCardDone);
				map.put("'r'", cardStatus);
				map.put("'newCardSN'", cardSN);
			}
			// 挂失出纳卡完成
			else if (commandCode == CardReaderCommandCode.LossCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.LossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂出纳卡完成
			else if (commandCode == CardReaderCommandCode.UnLossCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.UnLossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 解挂出纳卡完成
			else if (commandCode == CardReaderCommandCode.UnLossCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.UnLossCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 补办出纳卡完成
			else if (commandCode == CardReaderCommandCode.RemakeCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.RemakeCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 修改出纳卡有效期完成
			else if (commandCode == CardReaderCommandCode.InvalidDateCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.InvalidDateCashierCardDone);
				map.put("'r'", cardStatus);
			}
			// 存取款完成
			else if (commandCode == CardReaderCommandCode.Charge) {
				map.put("'f1'", CardReaderResultCommandCode.ChargeDone);
				map.put("'r'", cardStatus);
			}
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////读卡回复
			// //////////////////////////////////////////////////////////////////////////////
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x00, 0x01 })) {
			int baseLen = 43;
			// 获取出纳卡基本信息命令
			if (commandCode == CardReaderCommandCode.CashierCardBaseInfo) {
				map.put("'f1'", CardReaderResultCommandCode.CashierCardBaseInfoCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				map.put("'cardNO'", cardSN);
			}
			// 发送单个发卡命令
			else if (commandCode == CardReaderCommandCode.SingleCard) {
				map.put("'f1'", CardReaderResultCommandCode.SingleCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 发送信息发卡命令
			else if (commandCode == CardReaderCommandCode.InfoCard) {
				map.put("'f1'", CardReaderResultCommandCode.InfoCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 发解挂命令
			else if (commandCode == CardReaderCommandCode.Unloss) {
				map.put("'f1'", CardReaderResultCommandCode.UnlossCmd);
				map.put("'r'", cardStatus);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(StringUtil.getHexStrFromBytes(baseLen + 3, baseLen + 3 + 3, b), 16));
			}
			// 发有卡注销命令
			else if (commandCode == CardReaderCommandCode.OffWithCard) {
				map.put("'f1'", CardReaderResultCommandCode.OffWithCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(StringUtil.getHexStrFromBytes(baseLen + 3, baseLen + 3 + 3, b), 16));
			}
			// 发补卡命令
			else if (commandCode == CardReaderCommandCode.RemakeCard) {
				map.put("'f1'", CardReaderResultCommandCode.RemakeCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 换卡读原卡命令
			else if (commandCode == CardReaderCommandCode.ReadOldCard) {
				map.put("'f1'", CardReaderResultCommandCode.ReadOldCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(StringUtil.getHexStrFromBytes(baseLen + 3, baseLen + 3 + 3, b), 16));
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
			}
			// 换卡换新卡命令
			else if (commandCode == CardReaderCommandCode.ChangeNewCard) {
				map.put("'f1'", CardReaderResultCommandCode.ChangeNewCardCmd);
				map.put("'r'", cardStatus);
				map.put("'newCardSN'", cardSN);
			}
			// 读卡修正命令
			else if (commandCode == CardReaderCommandCode.ReadCard) {
				map.put("'f1'", CardReaderResultCommandCode.ReadCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				int base0 = baseLen + 3;
				try {
					map.put("'userId'", Integer.parseInt(StringUtil.getHexStrFromBytes(base0, base0 + 3, b), 16));
				} catch (Exception e) {
					map.put("userId", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'cardNO'", Integer.parseInt(StringUtil.getHexStrFromBytes(base0 + 4, base0 + 7, b), 16));
				} catch (Exception e) {
					map.put("cardNO", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'invalidDate'", StringUtil.dateFromHexStr(StringUtil.getHexStrFromBytes(base0 + 10, base0 + 11, b)));
				} catch (Exception e) {
					map.put("invalidDate", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					int status = Integer.parseInt(StringUtil.getHexStrFromBytes(base0 + 12, base0 + 12, b), 16);
					String statusDesc = "正常";
					if (status == 241) {
						statusDesc = "正常";
					} else if (status == 243) {
						statusDesc = "挂失";
					} else if (status == 244) {
						statusDesc = "注销";
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
					map.put("'cardSeq'", Integer.parseInt(StringUtil.getHexStrFromBytes(base2 + 4, base2 + 4, b), 16));
				} catch (Exception e) {
					map.put("cardSeq", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'cardTypeId'", Integer.parseInt(StringUtil.getHexStrFromBytes(base2 + 5, base2 + 5, b), 16));
				} catch (Exception e) {
					map.put("cardTypeId", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'totalFare'", (float) Integer.parseInt(StringUtil.getHexStrFromBytes(base2 + 10, base2 + 13, b), 16) / 100);
				} catch (Exception e) {
					map.put("totalFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}

				int consume0 = baseLen + 19 * 2 + 3;
				try {
					map.put("'opCount'", Integer.parseInt(StringUtil.getHexStrFromBytes(consume0, consume0 + 1, b), 16));
				} catch (Exception e) {
					map.put("opCount", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'oddFare'", (float) Integer.parseInt(StringUtil.getHexStrFromBytes(consume0 + 3, consume0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("oddFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}

				int subsidy0 = baseLen + 19 * 3 + 3;
				try {
					map.put("'subsidyOpCount'", Integer.parseInt(StringUtil.getHexStrFromBytes(subsidy0, subsidy0 + 1, b), 16));
				} catch (Exception e) {
					map.put("subsidyOpCount", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'subsidyOddFare'", (float) Integer.parseInt(StringUtil.getHexStrFromBytes(subsidy0 + 2, subsidy0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("subsidyOddFare", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
				try {
					map.put("'subsidyVersion'", Integer.parseInt(StringUtil.getHexStrFromBytes(subsidy0 + 8, subsidy0 + 9, b), 16));
				} catch (Exception e) {
					map.put("subsidyVersion", DesUtil.decrypt(DeviceCommunicateStr.Unknow));
				}
			}
			// 制出纳卡命令
			else if (commandCode == CardReaderCommandCode.MakeCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.MakeCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 挂失出纳卡命令
			else if (commandCode == CardReaderCommandCode.LossCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.LossCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
			}
			// 解挂出纳卡命令
			else if (commandCode == CardReaderCommandCode.UnLossCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.UnLossCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
			}
			// 补办出纳卡命令
			else if (commandCode == CardReaderCommandCode.RemakeCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.RemakeCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
			}
			// 读取出纳卡命令
			else if (commandCode == CardReaderCommandCode.ReadCashierCard) {
				map.put("'f1'", CardReaderResultCommandCode.ReadCashierCardCmd);
				map.put("'r'", cardStatus);

				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				String date = StringUtil.dateFromHexStr(StringUtil.getHexStrFromBytes(baseLen + 3 + 19 + 10, baseLen + 3 + 19 + 11, b));
				map.put("'date'", date);
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen, b.length - 1, b));
			}
			// 读取卡余额命令
			else if (commandCode == CardReaderCommandCode.ReadCardOddFare) {
				map.put("'f1'", CardReaderResultCommandCode.ReadCardOddFareCmd);
				map.put("'r'", cardStatus);

				int base0 = baseLen + 3;
				map.put("'userId'", Integer.parseInt(StringUtil.getHexStrFromBytes(base0, base0 + 3, b), 16));
				map.put("'cardNO'", Integer.parseInt(StringUtil.getHexStrFromBytes(base0 + 4, base0 + 7, b), 16));
				map.put("'cardSN'", cardSN);

				int status = Integer.parseInt(StringUtil.getHexStrFromBytes(base0 + 12, base0 + 12, b), 16);
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
				map.put("'oddFare'", (float) Integer.parseInt(StringUtil.getHexStrFromBytes(consume0 + 3, consume0 + 5, b), 16) / 100);
				map.put("'cardInfoStr'", StringUtil.getHexStrFromBytes(baseLen + 19, b.length - 1, b));
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
