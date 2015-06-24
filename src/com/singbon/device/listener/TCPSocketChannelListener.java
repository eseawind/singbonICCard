package com.singbon.device.listener;

import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.comet4j.core.util.JSONUtil;

import com.singbon.device.CRC16;
import com.singbon.device.FrameType;
import com.singbon.device.TerminalManager;
import com.singbon.util.StringUtil;

/**
 * TCP服务监听和分发服务
 * 
 * @author 郝威
 * 
 */
public class TCPSocketChannelListener implements ServletContextListener {

	protected Selector selector;

	public void startServer() throws Exception {
		selector = Selector.open();

		ServerSocketChannel ssc = ServerSocketChannel.open();
		ssc.socket().bind(new InetSocketAddress(10001)); // port
		ssc.configureBlocking(false);
		ssc.register(selector, SelectionKey.OP_ACCEPT);// register

		while (true) {
			// selector 线程。select() 会阻塞，直到有客户端连接，或者有消息读入
			selector.select();
			Iterator<SelectionKey> iterator = selector.selectedKeys().iterator();
			while (iterator.hasNext()) {
				SelectionKey selectionKey = iterator.next();
				iterator.remove(); // 删除此消息
				// 并在当前线程内处理
				handleSelectionKey(selectionKey);
			}
		}
	}

	int i = 0;

	public void handleSelectionKey(SelectionKey selectionKey) throws Exception {
		if (selectionKey.isAcceptable()) {
			ServerSocketChannel ssc = (ServerSocketChannel) selectionKey.channel();
			SocketChannel socketChannel = ssc.accept();
			socketChannel.configureBlocking(false);
			// 立即注册一个 OP_READ 的SelectionKey, 接收客户端的消息
			SelectionKey key = socketChannel.register(selector, SelectionKey.OP_READ);

			String uuid = UUID.randomUUID().toString();
			key.attach(uuid);
			TerminalManager.getUuidToSNList().put(uuid, null);
			// 打印
			System.out.println(key.attachment() + " 连接成功");

			TerminalManager.getCardNOSN(socketChannel);
			//
			// TerminalManager.getUuidToSNList().put(uuid, sn);
			// TerminalManager.getSNToSocketChannelList().put(sn,
			// socketChannel);
		} else if (selectionKey.isReadable()) {
			// 有消息进来
			ByteBuffer byteBuffer = ByteBuffer.allocate(100);
			SocketChannel sc = (SocketChannel) selectionKey.channel();

			int len = 0;
			try {
				len = sc.read(byteBuffer);
			} catch (Exception e) {
				String uuid = selectionKey.attachment().toString();
				System.out.println(uuid);
				removeSockeckChannel(uuid);
				// 如果read抛出异常，表示连接异常中断，需要关闭 socketChannel
				e.printStackTrace();
				sc.close();
			}
			// 如果len>0，表示有输入。如果len==0, 表示输入结束。需要关闭 socketChannel
			if (len > 0) {
				System.out.println(++i);
				byteBuffer.flip();
				byte[] b = byteBuffer.array();
				int byteLen = 0;
				for (int i = b.length; i > 0; i--) {
					if (b[i - 1] != 0) {
						byteLen = i;
						break;
					}
				}
				b = Arrays.copyOf(b, byteLen);
				// CRC16.sd_crc16_table(b,b.length);
				for (byte b2 : b) {
					System.out.print(StringUtil.toHexString(b2) + " ");
				}
				System.out.println();
				
				//校验
				if(!CRC16.compareCRC16(b)){
					return;
				}
				
				if (b[23] == (byte) 0xff && b[24] == (byte) 0xaa) {
					System.out.println(11);
				}

				byteBuffer.clear();

				// 分发数据
				TerminalManager s = new TerminalManager();
				s.dispatchCardReaderCommand(selectionKey, b);
			} else {
				// 输入结束，关闭 socketChannel
				String uuid = selectionKey.attachment().toString();
				System.out.println(uuid + " 已关闭连接");
				sc.close();

				removeSockeckChannel(uuid);

				// Map map = new HashMap();
				// map.put("'f1'", FrameType.CardReaderStatus);
				// map.put("'r'", 0);

				// String msg = JSONUtil.convertToJson(map);
				// TerminalManager.getEngineInstance().sendToAll(sn, msg);
			}

			Thread.sleep(100);
		}
	}

	private void removeSockeckChannel(String uuid) {
		if (TerminalManager.getUuidToSNList().containsKey(uuid)) {
			String sn = TerminalManager.getUuidToSNList().get(uuid);
			TerminalManager.getUuidToSNList().remove(uuid);
			// 为null不在线
			TerminalManager.getSNToSocketChannelList().put(sn, null);
		}
	}

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		new TCPSocketChannelListener().startServer();
	}

	class TCPListenServer implements Runnable {

		@Override
		public void run() {
			try {
				new TCPSocketChannelListener().startServer();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {

	}

	public void contextInitialized(ServletContextEvent arg0) {
		Thread t = new Thread(new TCPListenServer());
		t.start();
	}
}