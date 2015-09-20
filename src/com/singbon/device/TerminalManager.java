package com.singbon.device;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.socket.DatagramPacket;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.comet4j.core.CometContext;
import org.comet4j.core.CometEngine;
import org.comet4j.core.util.JSONUtil;

import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 终端设备通信监控管理
 * 
 * @author 郝威
 * 
 */
public class TerminalManager {

	/**
	 * 服务器推送连接引擎
	 */
	public static CometEngine EngineInstance = null;

	/**
	 * netty
	 */
	public static ChannelHandlerContext ctx = null;

	/**
	 * SN到公司映射，
	 */
	public static Map<String, Integer> SNToCompanyList = new HashMap<String, Integer>();

	/**
	 * UUID到SN序列号映射列表
	 */
	public static Map<String, String> UuidToSNList = new HashMap<String, String>();

	/**
	 * SN序列号到设备映射列表
	 */
	public static Map<String, Device> SNToDevicelList = new HashMap<String, Device>();

	/**
	 * SN序列号到套接字通道映射列表
	 */
	public static Map<String, SocketChannel> SNToSocketChannelList = new HashMap<String, SocketChannel>();

	/**
	 * SN序列号到InetSocketAddress映射列表
	 */
	public static Map<String, InetSocketAddress> SNToInetSocketAddressList = new HashMap<String, InetSocketAddress>();

	/**
	 * 公司ID到采集监控多线程映射列表
	 */
	public static Map<Integer, Thread> CompanyToMonitorThreadlList = new HashMap<Integer, Thread>();

	/**
	 * SN序列号到发送命令映射列表
	 */
	public static Map<String, ArrayList<SendCommand>> SNToSendCommandList = new HashMap<String, ArrayList<SendCommand>>();

	// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// //////////////////////////////监控用
	// ///////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 锁
	public static Object sendCommandObject = new Object();

	/**
	 * 注册通道
	 * 
	 * @param sn
	 */
	public static void registChannel(String channelId) {
		if (!CometContext.getInstance().getAppModules().contains(channelId)) {
			CometContext.getInstance().registChannel(channelId);
		}
	}

	/**
	 * 获取通道
	 * 
	 * @param sn
	 * @return
	 */
	public static SocketChannel getSocketChannel(String sn) {
		return SNToSocketChannelList.get(sn);
	}

	/**
	 * 获取扇区
	 * 
	 * @return
	 */
	public static int getSection(int companyId) {
		return 1;
	}

	// 获取回复帧
	private byte[] getFrame(byte[] b) {
		return Arrays.copyOfRange(b, 30, 34);
	}

	// 获取回复命令号
	private int getCommandCode(byte[] b) {
		return StringUtil.byteToInt(b[36]) * 256 + StringUtil.byteToInt(b[37]);
	}

	// 获取序列号
	private String getSN(byte[] b) {
		String sn = "";
		for (int i = 0; i < 16; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sn += hex;
		}
		return sn;
	}

	// 获取物理卡号
	private String getCardSN(byte[] b) {
		String sn = "";
		for (int i = 39; i < 43; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sn += hex;
		}
		return sn;
	}

	/**
	 * 获取卡字节数据
	 * 
	 * @param begin
	 * @param end
	 * @param b
	 * @return
	 */
	private String cardInfo(int begin, int end, byte[] b) {
		String baseInfoStr = "";
		for (int i = begin; i <= end; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			baseInfoStr += hex;
		}
		return baseInfoStr;
	}

	/**
	 * 分发命令
	 * 
	 * @param selectionKey
	 * @param b
	 *            26 27指令 00 获取机器号序列号，01读卡，
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void dispatchCardReaderCommand(SelectionKey selectionKey, byte[] b) {
		if (b == null)
			return;
		String sn = getSN(b);
		// 帧
		byte[] frameByte = getFrame(b);
		// 命令码
		int commandCode = getCommandCode(b);
		// 状态码 1读写成功、2寻卡失败、3卡校验失败、4物理卡号不匹配、5读写卡失败
		byte cardStatus = 0;
		// 物理卡号
		String cardSN = null;
		if (frameByte[0] == 0x03 && frameByte[1] == (byte) 0xcd) {
			cardStatus = b[45];
			cardSN = getCardSN(b);
		}

		Map map = new HashMap();
		// 获取机器号序列号
		if (frameByte[0] == 0x03 && frameByte[1] == 0x08) {
			byte frame = FrameCardReader.Status;
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
				map.put("'cardInfoStr'", cardInfo(baseLen, b.length - 1, b));
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(cardInfo(baseLen + 3, baseLen + 3 + 3, b), 16));
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
				map.put("'userId'", Integer.parseInt(cardInfo(baseLen + 3, baseLen + 3 + 3, b), 16));
				map.put("'cardInfoStr'", cardInfo(baseLen, b.length - 1, b));
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
					map.put("'userId'", Integer.parseInt(cardInfo(base0, base0 + 3, b), 16));
				} catch (Exception e) {
					map.put("userId", "未知");
				}
				try {
					map.put("'cardNO'", Integer.parseInt(cardInfo(base0 + 4, base0 + 7, b), 16));
				} catch (Exception e) {
					map.put("cardNO", "未知");
				}
				try {
					map.put("'invalidDate'", StringUtil.dateFromHexString(cardInfo(base0 + 10, base0 + 11, b)));
				} catch (Exception e) {
					map.put("invalidDate", "未知");
				}
				try {
					int status = Integer.parseInt(cardInfo(base0 + 12, base0 + 12, b), 16);
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
					map.put("status", "未知");
					map.put("statusDesc", "未知");
				}

				int base2 = baseLen + 19 + 3;
				try {
					map.put("'cardSeq'", Integer.parseInt(cardInfo(base2 + 4, base2 + 4, b), 16));
				} catch (Exception e) {
					map.put("cardSeq", "未知");
				}
				try {
					map.put("'cardTypeId'", Integer.parseInt(cardInfo(base2 + 5, base2 + 5, b), 16));
				} catch (Exception e) {
					map.put("cardTypeId", "未知");
				}
				try {
					map.put("'totalFare'", (float) Integer.parseInt(cardInfo(base2 + 10, base2 + 13, b), 16) / 100);
				} catch (Exception e) {
					map.put("totalFare", "未知");
				}

				int consume0 = baseLen + 19 * 2 + 3;
				try {
					map.put("'opCount'", Integer.parseInt(cardInfo(consume0, consume0 + 1, b), 16));
				} catch (Exception e) {
					map.put("opCount", "未知");
				}
				try {
					map.put("'oddFare'", (float) Integer.parseInt(cardInfo(consume0 + 3, consume0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("oddFare", "未知");
				}

				int subsidy0 = baseLen + 19 * 3 + 3;
				try {
					map.put("'subsidyOpCount'", Integer.parseInt(cardInfo(subsidy0, subsidy0 + 1, b), 16));
				} catch (Exception e) {
					map.put("subsidyOpCount", "未知");
				}
				try {
					map.put("'subsidyOddFare'", (float) Integer.parseInt(cardInfo(subsidy0 + 2, subsidy0 + 5, b), 16) / 100);
				} catch (Exception e) {
					map.put("subsidyOddFare", "未知");
				}
				try {
					map.put("'subsidyVersion'", Integer.parseInt(cardInfo(subsidy0 + 8, subsidy0 + 9, b), 16));
				} catch (Exception e) {
					map.put("subsidyVersion", "未知");
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
				map.put("'cardInfoStr'", cardInfo(baseLen, b.length - 1, b));
			}
			// 解挂出纳卡命令
			else if (commandCode == CommandCodeCardReader.UnLossCashierCard) {
				map.put("'f1'", FrameCardReader.UnLossCashierCardCmd);
				map.put("'r'", cardStatus);
				map.put("'operId'", Integer.parseInt(getCashierOperId(b), 16));
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", cardInfo(baseLen, b.length - 1, b));
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
				String date = StringUtil.dateFromHexString(cardInfo(baseLen + 3 + 19 + 10, baseLen + 3 + 19 + 11, b));
				map.put("'date'", date);
				map.put("'cardSN'", cardSN);
				map.put("'cardInfoStr'", cardInfo(baseLen, b.length - 1, b));
			}
			// 读取卡余额命令
			else if (commandCode == CommandCodeCardReader.ReadCardOddFare) {
				map.put("'f1'", FrameCardReader.ReadCardOddFareCmd);
				map.put("'r'", cardStatus);

				int base0 = baseLen + 3;
				map.put("'userId'", Integer.parseInt(cardInfo(base0, base0 + 3, b), 16));
				map.put("'cardNO'", Integer.parseInt(cardInfo(base0 + 4, base0 + 7, b), 16));
				map.put("'cardSN'", cardSN);

				int status = Integer.parseInt(cardInfo(base0 + 12, base0 + 12, b), 16);
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
				map.put("'oddFare'", (float) Integer.parseInt(cardInfo(consume0 + 3, consume0 + 5, b), 16) / 100);
				map.put("'cardInfoStr'", cardInfo(baseLen + 19, b.length - 1, b));
			}
		}
		if (map.size() > 0) {
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.EngineInstance.sendToAll("c" + sn, msg);
		}
	}

	private String getCashierOperId(byte[] b) {
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

	/**
	 * 获取卡号序列号
	 * 
	 * @param socketChannel
	 * @throws IOException
	 */
	public static void getCardNOSN(SocketChannel socketChannel) throws IOException {
		ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55,
				(byte) 0xaa, 0x55, (byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xff, 0x00, 0x06, (byte) 0xff, (byte) 0xaa, 0x00, 0x00, 0x00, 0x00 });
		socketChannel.write(byteBuffer);
	}

	/**
	 * 获取读卡机心跳状态
	 * 
	 * @param socketChannel
	 * @throws IOException
	 */
	public static void getCardReaderHeartStatus(SocketChannel socketChannel) throws IOException {
		ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55, (byte) 0xaa, 0x55,
				(byte) 0xaa, 0x55, (byte) 0xff, (byte) 0xff, (byte) 0xff, (byte) 0xff, 0x00, 0x06, (byte) 0xff, (byte) 0xaa, 0x00, 0x01, 0x00, 0x00 });
		socketChannel.write(byteBuffer);
	}

	/**
	 * 关闭连接通道
	 * 
	 * @param socketChannel
	 * @throws IOException
	 */
	public static void closeSocketChannel(String sn) throws IOException {
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
		socketChannel.close();
		TerminalManager.SNToSocketChannelList.remove(sn);
	}

	/**
	 * 先获取卡信息后操作
	 * 
	 * @param socketChannel
	 * @param device
	 * @param commandCode
	 * @param sectionBlocks
	 * @throws IOException
	 */
	public static void getCardInfo(SocketChannel socketChannel, Device device, byte commandCode, List<Integer> sectionBlocks) throws IOException {
		String deviceNum = StringUtil.hexLeftPad(device.getDeviceNum(), 8);
		String commandCodeStr = "0000" + StringUtil.hexLeftPad(commandCode, 4);
		String sendBufStr = CommandCardReader.ReadCard + commandCodeStr + CommandCardReader.NoValidateCardSN + "44444444";
		for (int i : sectionBlocks) {
			int section = i / 10;
			int block = i % 10;
			String sectionStr = StringUtil.hexLeftPad(section, 2);
			String blockStr = StringUtil.hexLeftPad(block, 2);
			sendBufStr += sectionStr + blockStr + "0000000000000000000000000000000000";
		}
		sendBufStr += "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + deviceNum + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		CRC16.generate(sendBuf);
		ByteBuffer byteBuffer = ByteBuffer.wrap(sendBuf);
		socketChannel.write(byteBuffer);
	}

	/**
	 * 发送命令到读卡机
	 * 
	 * @param socketChannel
	 * @param b
	 * @throws IOException
	 */
	public static void sendToCardReader(SocketChannel socketChannel, byte[] b) throws IOException {
		CRC16.generate(b);
		ByteBuffer byteBuffer = ByteBuffer.wrap(b);
		socketChannel.write(byteBuffer);
	}

	// //////////////////////////////////////////////////////////////////////////////
	// ///////////////////////////////////////////// 消费机部分UDP
	// //////////////////////////////////////////////////////////////////////////////

	@SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	public void dispatchPosCommand(InetSocketAddress inetSocketAddress, byte[] b) {
		if (b == null)
			return;
		String sn = getSN(b);
		// 帧
		byte[] frameByte = getFrame(b);
		// 命令码
		int commandCode = getCommandCode(b);

		Map map = new HashMap();
		// 终端设备状态，设置sn与inetSocketAddress对照关系
		if (frameByte[0] == FramePos.Status && frameByte[1] == SubStatusFramePos.SysStatus) {
			// TerminalManager.SNToDatagramChannelList.put(sn, datagramChannel);
			TerminalManager.SNToInetSocketAddressList.put(sn, inetSocketAddress);

			map.put("'type'", "status");
			map.put("'sn'", sn);
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////消费机回复
			// //////////////////////////////////////////////////////////////////////////////
		} else {
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
			map.put("time", new Date().toLocaleString());
			map.put("from", device.getDeviceName());
			byte subFrame = frameByte[2];
			switch (frameByte[1]) {
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
			return;
		}
		if (map.size() > 0) {
			String msg = JSONUtil.convertToJson(map);
			Integer companyId = TerminalManager.SNToCompanyList.get(sn);
			TerminalManager.EngineInstance.sendToAll("Co" + companyId, msg);
		}
	}

	/**
	 * 发送命令到消费机， 改方法负责crc校验
	 * 
	 * @param socketChannel
	 * @param b
	 * @throws IOException
	 */
	public static void sendToPos(InetSocketAddress inetSocketAddress, byte[] b) throws IOException {
		CRC16.generate(b);
		StringUtil.print(StringUtil.toHexString(b[b.length - 2]) + " ");
		StringUtil.print(StringUtil.toHexString(b[b.length - 1]) + " ");
		ByteBuf buf = Unpooled.copiedBuffer(b);
		DatagramPacket datagramPacket = new DatagramPacket(buf, inetSocketAddress);
		TerminalManager.ctx.writeAndFlush(datagramPacket);
	}
}
