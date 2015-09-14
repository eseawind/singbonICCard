package com.singbon.device;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.SocketChannel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.comet4j.core.CometContext;
import org.comet4j.core.CometEngine;
import org.comet4j.core.util.JSONUtil;

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
	private static CometEngine engineInstance = null;
	/**
	 * SN到公司映射，
	 */
	private static Map<String, Integer> snToCompanyList = new HashMap<String, Integer>();

	/**
	 * UUID到SN序列号映射列表
	 */
	private static Map<String, String> uuidToSNList = new HashMap<String, String>();

	/**
	 * SN序列号到套接字通道映射列表
	 */
	private static Map<String, SocketChannel> SNToSocketChannelList = new HashMap<String, SocketChannel>();

	/**
	 * SN序列号到Datagram套接字通道映射列表
	 */
	private static Map<String, DatagramChannel> SNToDatagramChannelList = new HashMap<String, DatagramChannel>();

	public static CometEngine getEngineInstance() {
		return engineInstance;
	}

	public static void setEngineInstance(CometEngine engineInstance) {
		TerminalManager.engineInstance = engineInstance;
	}

	public static Map<String, Integer> getSnToCompanyList() {
		return snToCompanyList;
	}

	public static void setSnToCompanyList(Map<String, Integer> snToCompanyList) {
		TerminalManager.snToCompanyList = snToCompanyList;
	}

	public static Map<String, String> getUuidToSNList() {
		return uuidToSNList;
	}

	public static void setUuidToSNList(Map<String, String> uuidToSNList) {
		TerminalManager.uuidToSNList = uuidToSNList;
	}

	public static Map<String, SocketChannel> getSNToSocketChannelList() {
		return SNToSocketChannelList;
	}

	public static void setSNToSocketChannelList(Map<String, SocketChannel> sNToSocketChannelList) {
		SNToSocketChannelList = sNToSocketChannelList;
	}

	public static Map<String, DatagramChannel> getSNToDatagramChannelList() {
		return SNToDatagramChannelList;
	}

	public static void setSNToDatagramChannelList(Map<String, DatagramChannel> sNToDatagramChannelList) {
		SNToDatagramChannelList = sNToDatagramChannelList;
	}

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
		return getSNToSocketChannelList().get(sn);
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
		return b[34] + b[35];
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
		for (int i = 37; i < 41; i++) {
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
			cardStatus = b[43];
			cardSN = getCardSN(b);
		}

		Map map = new HashMap();
		// 获取机器号序列号
		if (frameByte[0] == 0x03 && frameByte[1] == 0x08) {
			byte frame = FrameCardReader.Status;
			TerminalManager.getUuidToSNList().put(selectionKey.attachment().toString(), sn);
			TerminalManager.getSNToSocketChannelList().put(sn, (SocketChannel) selectionKey.channel());
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
			int baseLen = 41;
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
				for (byte b2 : b) {
					System.out.print(StringUtil.toHexString(b2) + " ");
				}
				System.out.println();
				map.put("'f1'", FrameCardReader.ReadCardCmd);
				map.put("'r'", cardStatus);
				map.put("'cardSN'", cardSN);
				int base0 = baseLen + 3;
				map.put("'userId'", Integer.parseInt(cardInfo(base0, base0 + 3, b), 16));
				map.put("'cardNO'", Integer.parseInt(cardInfo(base0 + 4, base0 + 7, b), 16));
				map.put("'invalidDate'", StringUtil.dateFromHexString(cardInfo(base0 + 10, base0 + 11, b)));
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

				int base2 = baseLen + 19 + 3;
				map.put("'cardSeq'", Integer.parseInt(cardInfo(base2 + 4, base2 + 4, b), 16));
				map.put("'cardTypeId'", Integer.parseInt(cardInfo(base2 + 5, base2 + 5, b), 16));
				map.put("'totalFare'", (float) Integer.parseInt(cardInfo(base2 + 10, base2 + 13, b), 16) / 100);

				int consume0 = baseLen + 19 * 2 + 3;
				map.put("'opCount'", Integer.parseInt(cardInfo(consume0, consume0 + 1, b), 16));
				map.put("'oddFare'", (float) Integer.parseInt(cardInfo(consume0 + 3, consume0 + 5, b), 16) / 100);

				int subsidy0 = baseLen + 19 * 3 + 3;
				map.put("'subsidyOpCount'", Integer.parseInt(cardInfo(subsidy0, subsidy0 + 1, b), 16));
				map.put("'subsidyOddFare'", (float) Integer.parseInt(cardInfo(subsidy0 + 2, subsidy0 + 5, b), 16) / 100);
				map.put("'subsidyVersion'", Integer.parseInt(cardInfo(subsidy0 + 8, subsidy0 + 9, b), 16));
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
			TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
		}
	}

	private String getCashierOperId(byte[] b) {
		String operId = "";
		String hex = Integer.toHexString(b[40] & 0x0F);
		operId += hex;
		hex = Integer.toHexString(b[41] & 0xFF);
		if (hex.length() == 1) {
			hex = '0' + hex;
		}
		operId += hex;
		hex = Integer.toHexString(b[42] & 0xFF);
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
		SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
		socketChannel.close();
		TerminalManager.getSNToSocketChannelList().remove(sn);
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
		String commandCodeStr = StringUtil.hexLeftPad(commandCode, 4);
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

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void dispatchPosCommand(SelectionKey selectionKey, byte[] b) {
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
			cardStatus = b[43];
			cardSN = getCardSN(b);
		}

		Map map = new HashMap();
		// 如果包含sn则设置sn与datagram对照关系
		if (TerminalManager.getSnToCompanyList().containsKey(sn)) {
			DatagramChannel datagramChannel = (DatagramChannel) selectionKey.channel();
			TerminalManager.getSNToDatagramChannelList().put(sn, datagramChannel);

			byte frame = FramePos.Status;
			map.put("'f1'", frame);
			map.put("'sn'", sn);
			// //////////////////////////////////////////////////////////////////////////////
			// /////////////////////////////////////////////写卡回复
			// //////////////////////////////////////////////////////////////////////////////
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x01, 0x01 })) {

		}
		if (map.size() > 0) {
			String msg = JSONUtil.convertToJson(map);
			Integer companyId = TerminalManager.getSnToCompanyList().get(sn);
			TerminalManager.getEngineInstance().sendToAll("Co" + companyId, msg);
		}
	}
}
