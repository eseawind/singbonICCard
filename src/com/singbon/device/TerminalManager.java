package com.singbon.device;

import java.io.IOException;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.comet4j.core.CometContext;
import org.comet4j.core.CometEngine;

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

	/**
	 * 分发处理命令
	 * 
	 * @param b
	 *            命令
	 */
	public void dispatchCommand(SelectionKey selectionKey, byte[] b) {
		if (b == null)
			return;
		if (btoInt(b[23]) == FrameType.Result && btoInt(b[24]) == SubFrameType.Heart) {
			String sn = "";
			for (int i = 0; i < 16; i++) {
				String hex = Integer.toHexString(b[i] & 0xFF);
				if (hex.length() == 1) {
					hex = '0' + hex;
				}
				sn += hex;
			}
			if (!TerminalManager.getUuidToSNList().containsKey(selectionKey.attachment())) {
				TerminalManager.getUuidToSNList().put(selectionKey.attachment().toString(), sn);
				TerminalManager.getSNToSocketChannelList().put(sn, (SocketChannel) selectionKey.channel());
			}
		}

		// 校时
		if (b[0] == 1 && b[1] == 1) {

			// MonitorListener.sendMsg(sn, "校时");
		}
		if (b[0] == 1 && b[1] == 2) {
			// MonitorListener.sendMsg(sn, "消费数据："+b[0]+b[1]);
			try {
				JdbcDao.save("1", "insert into consume (money,uploadTime) values ('" + b[2] + "',now())");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
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
	 * 测试
	 * 
	 * @param sn
	 * @throws IOException
	 */
	public static void test(String sn) throws IOException {
		SocketChannel channel = getSocketChannel(sn);
		if (channel != null) {
			ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x02, 0x0b, 0x01 });
			channel.write(byteBuffer);
		} else {
			getEngineInstance().sendToAll("c" + sn, "");
		}
	}

	/**
	 * 寻卡
	 * 
	 * @param sn
	 * @throws IOException
	 */
	public static void search(String sn) throws IOException {
		ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x02, 0x02, 0x26 });
		// s.write(byteBuffer);
	}

	/**
	 * 获取卡号
	 * 
	 * @param sn
	 * @throws IOException
	 */
	public static void cardno(String sn) throws IOException {
		ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x01, 0x03 });
		// s.write(byteBuffer);
	}

	public class SendCmdToCardReader implements Runnable {

		private String sn;

		public String getSn() {
			return sn;
		}

		public void setSn(String sn) {
			this.sn = sn;
		}

		@Override
		public void run() {
			List<String> list = TerminalManager.getCmdList().get(sn);
			if (list != null) {
				while (list.size() > 0) {
					
				}
			}
		}

	}
}
