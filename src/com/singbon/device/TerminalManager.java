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
	 * 分发读卡器命令
	 * 
	 * @param selectionKey
	 * @param b
	 *            26 27指令 00 获取机器号序列号，01读卡，
	 */
	public void dispatchCardReaderCommand(SelectionKey selectionKey, byte[] b) {
		if (b == null)
			return;
		String sn = getSN(b);
		// 获取机器号序列号
		if (Arrays.equals(getCardReaderResponse(b), new byte[] { 0x03, (byte) 0xff, (byte) 0xaa, 0x01 })) {
			byte frame = FrameType.CardReaderStatus;
			if (b[27] == 1) {
				frame = FrameType.CardReaderHeartStatus;
			} else {
				TerminalManager.getUuidToSNList().put(selectionKey.attachment().toString(), sn);
				TerminalManager.getSNToSocketChannelList().put(sn, (SocketChannel) selectionKey.channel());
			}
			Map map = new HashMap();
			map.put("'f1'", frame);
			map.put("'r'", 1);
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			// 写卡
		} else if (Arrays.equals(getCardReaderResponse(b), new byte[] { 0x03, (byte) 0xcd, (byte) 0x01, 0x01 })) {
			Map map = new HashMap();
			map.put("'f1'", FrameType.CardReaderWriteResponse);
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
		} else if (Arrays.equals(getCardReaderResponse(b), new byte[] { 0x03, (byte) 0xFF, (byte) 0xAA, 0x01 })) {
			// 读卡
		}
	}

	// 获取读卡器回复类型
	private byte[] getCardReaderResponse(byte[] b) {
		return Arrays.copyOfRange(b, 22, 26);
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
