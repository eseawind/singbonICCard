package com.singbon.device;

import java.io.IOException;
import java.nio.ByteBuffer;
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

	public static Map<String, SocketChannel> getSNToSocketChannelList() {
		return SNToSocketChannelList;
	}

	public static void setSNToSocketChannelList(Map<String, SocketChannel> sNToSocketChannelList) {
		SNToSocketChannelList = sNToSocketChannelList;
	}

	/**
	 * 服务器推送连接引擎
	 */
	private static CometEngine engineInstance = null;

	/**
	 * SN到公司映射
	 */
	private static Map<String, Integer> snToCompanyList = new HashMap<String, Integer>();

	/**
	 * UUID到SN序列号映射列表
	 */
	private static Map<String, String> uuidToSNList = new HashMap<String, String>();

	public static Map<String, String> getUuidToSNList() {
		return uuidToSNList;
	}

	public static void setUuidToSNList(Map<String, String> uuidToSNList) {
		TerminalManager.uuidToSNList = uuidToSNList;
	}

	/**
	 * SN序列号到套接字通道映射列表
	 */
	private static Map<String, SocketChannel> SNToSocketChannelList = new HashMap<String, SocketChannel>();

	public static Map<String, Integer> getSnToCompanyList() {
		return snToCompanyList;
	}

	public static void setSnToCompanyList(Map<String, Integer> snToCompanyList) {
		TerminalManager.snToCompanyList = snToCompanyList;
	}

	public static CometEngine getEngineInstance() {
		return engineInstance;
	}

	public static void setEngineInstance(CometEngine engineInstance) {
		TerminalManager.engineInstance = engineInstance;
	}

	/**
	 * 设备命令列表
	 */
	public static Map<String, List<String>> cmdList = new HashMap<String, List<String>>();

	public static Map<String, List<String>> getCmdList() {
		return cmdList;
	}

	public static void setCmdList(Map<String, List<String>> cmdList) {
		TerminalManager.cmdList = cmdList;
	}

	private int btoInt(byte b) {
		return b & 0xff;
	}

	/**
	 * 注册通道
	 * 
	 * @param sn
	 */
	public static void registChannel(String sn) {
		if (!CometContext.getInstance().getAppModules().contains("c" + sn)) {
			CometContext.getInstance().registChannel("c" + sn);
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

	/**
	 * 分发读卡器命令
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
		// 状态码 1读卡器读写成功、2读卡器寻卡失败、3读卡器卡校验失败、4读卡器物理卡号不匹配、5读卡器读写卡失败
		byte b35 = 0;
		if (b.length > 35) {
			b35 = b[35];
		}
		// 物理卡号
		String cardSN = null;
		if (b.length > 33) {
			cardSN = getCardSN(b);
		}
		Map map = new HashMap();
		// 获取机器号序列号
		if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xff, (byte) 0xaa, 0x01 })) {
			byte frame = FrameCardReader.Status;
			if (b[27] == 1) {
				frame = FrameCardReader.HeartStatus;
			} else {
				TerminalManager.getUuidToSNList().put(selectionKey.attachment().toString(), sn);
				TerminalManager.getSNToSocketChannelList().put(sn, (SocketChannel) selectionKey.channel());
			}
			map.put("'f1'", frame);
			map.put("'r'", 1);
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			// 写卡回复
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x01, 0x01 })) {
			// 单个发卡完成
			if (commandCode == CommandCodeCardReader.SingleCard) {
				map.put("'f1'", FrameCardReader.SingleCardDone);
				map.put("'r'", b35);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 信息发卡完成
			else if (commandCode == CommandCodeCardReader.InfoCard) {
				map.put("'f1'", FrameCardReader.InfoCardDone);
				map.put("'r'", b35);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 解挂完成
			else if (commandCode == CommandCodeCardReader.Unloss) {
				map.put("'f1'", FrameCardReader.UnlossDone);
				map.put("'r'", b35);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 补卡完成
			else if (commandCode == CommandCodeCardReader.RemakeCard) {
				map.put("'f1'", FrameCardReader.RemakeCardDone);
				map.put("'r'", b35);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 读卡回复
		} else if (Arrays.equals(frameByte, new byte[] { 0x03, (byte) 0xcd, 0x00, 0x01 })) {
			// 发送单个发卡命令
			if (commandCode == CommandCodeCardReader.SingleCard) {
				map.put("'f1'", FrameCardReader.SingleCardCmd);
				map.put("'r'", b35);
				map.put("'cardSN'", cardSN);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 发送信息发卡命令
			else if (commandCode == CommandCodeCardReader.InfoCard) {
				map.put("'f1'", FrameCardReader.InfoCardCmd);
				map.put("'r'", b35);
				map.put("'cardSN'", cardSN);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 发解挂命令
			else if (commandCode == CommandCodeCardReader.Unloss) {
				map.put("'f1'", FrameCardReader.UnlossCmd);
				map.put("'r'", b35);
				map.put("'cardInfoStr'", cardAllInfo(b));
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(getUserId(b), 16));
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 发补卡命令
			else if (commandCode == CommandCodeCardReader.RemakeCard) {
				map.put("'f1'", FrameCardReader.RemakeCardCmd);
				map.put("'r'", b35);
				map.put("'cardSN'", cardSN);
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
			// 换卡读原卡命令
			else if (commandCode == CommandCodeCardReader.ReadOldCard) {
				map.put("'f1'", FrameCardReader.ReadOldCardCmd);
				map.put("'r'", b35);
				map.put("'cardSN'", cardSN);
				map.put("'userId'", Integer.parseInt(getUserId(b), 16));
				map.put("'cardInfoStr'", cardAllInfo(b));
				String msg = JSONUtil.convertToJson(map);
				TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			}
		}
	}

	// 获取读卡器回复帧
	private byte[] getFrame(byte[] b) {
		return Arrays.copyOfRange(b, 22, 26);
	}

	// 获取读卡器回复命令号
	private int getCommandCode(byte[] b) {
		return b[26] + b[27];
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
		for (int i = 29; i < 33; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sn += hex;
		}
		return sn;
	}

	// 获取userId
	private String getUserId(byte[] b) {
		String userId = "";
		for (int i = 36; i < 39; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			userId += hex;
		}
		return userId;
	}

	// cardAllInfo
	private String cardAllInfo(byte[] b) {
		String baseInfoStr = "";
		for (int i = 33; i < b.length; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			baseInfoStr += hex;
		}
		return baseInfoStr;
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
		TerminalManager.getSNToSocketChannelList().remove(sn);
	}

	/**
	 * 先获取物理卡号后发卡
	 * 
	 * @param socketChannel
	 * @param device
	 * @param commandCode
	 * @param section
	 * @throws IOException
	 */
	public static void getCardSNToMakeCard(SocketChannel socketChannel, Device device, int commandCode, int section) throws IOException {
		String deviceNum = StringUtil.leftPad(device.getDeviceNum(), 8);
		String commandCodeStr = StringUtil.leftPad(commandCode, 4);
		String sectionStr = StringUtil.leftPad(section, 2);
		String buf = device.getSn() + deviceNum + "0020cd00" + commandCodeStr + "0044444444" + sectionStr + "0000000000000000000000000000000000000000";
		byte[] sendBuf = StringUtil.strTobytes(buf);
		CRC16.generate(sendBuf);
		ByteBuffer byteBuffer = ByteBuffer.wrap(sendBuf);
		socketChannel.write(byteBuffer);
	}

	/**
	 * 先获取基本信息后解挂
	 * 
	 * @param socketChannel
	 * @param section
	 *            扇区号
	 * @throws IOException
	 */
	public static void getBaseCardInfoToUnloss(SocketChannel socketChannel, Device device, int section) throws IOException {
		String deviceNum = StringUtil.leftPad(device.getDeviceNum(), 8);
		String sectionStr = StringUtil.leftPad(section, 2);
		String commandCodeStr = StringUtil.leftPad(CommandCodeCardReader.Unloss, 4);
		String buf = device.getSn() + deviceNum + "0020CD00" + commandCodeStr + "0044444444" + sectionStr + "0000000000000000000000000000000000000000";
		byte[] sendBuf = StringUtil.strTobytes(buf);
		CRC16.generate(sendBuf);
		ByteBuffer byteBuffer = ByteBuffer.wrap(sendBuf);
		socketChannel.write(byteBuffer);
	}

	/**
	 * 先获取原卡信息后换卡
	 * 
	 * @param socketChannel
	 * @param section
	 *            扇区号
	 * @throws IOException
	 */
	public static void getOldCardInfoToChangeCard(SocketChannel socketChannel, Device device, int section) throws IOException {
		String deviceNum = StringUtil.leftPad(device.getDeviceNum(), 8);
		String baseSectionStr = StringUtil.leftPad(section, 2);
		String consumeSectionStr = StringUtil.leftPad(section + 1, 2);
		String subsidySectionStr = StringUtil.leftPad(section + 2, 2);
		String commandCodeStr = StringUtil.leftPad(CommandCodeCardReader.ReadOldCard, 4);
		String sendBufStr = "CD00" + commandCodeStr + "0044444444" + baseSectionStr + "000000000000000000000000000000000000" + baseSectionStr + "010000000000000000000000000000000000" + baseSectionStr
				+ "020000000000000000000000000000000000" + consumeSectionStr + "000000000000000000000000000000000000" + subsidySectionStr + "000000000000000000000000000000000000" + "0000";
		String bufLen = StringUtil.leftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + deviceNum + bufLen + sendBufStr;
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
}
