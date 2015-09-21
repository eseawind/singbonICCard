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
import com.singbon.device.ExecCardReaderCommand;
import com.singbon.device.FrameCardReader;
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

	public void startServer() {
		try {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	int i = 0;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void handleSelectionKey(SelectionKey selectionKey) throws Exception {
		if (selectionKey.isAcceptable()) {
			ServerSocketChannel ssc = (ServerSocketChannel) selectionKey.channel();
			SocketChannel socketChannel = ssc.accept();
			socketChannel.configureBlocking(false);
			// 立即注册一个 OP_READ 的SelectionKey, 接收客户端的消息
			SelectionKey key = socketChannel.register(selector, SelectionKey.OP_READ);

			String uuid = UUID.randomUUID().toString();
			key.attach(uuid);
			// 打印
			StringUtil.println(key.attachment() + " 连接成功");
		} else if (selectionKey.isReadable()) {
			// 有消息进来
			ByteBuffer byteBuffer = ByteBuffer.allocate(273);
			SocketChannel sc = (SocketChannel) selectionKey.channel();

			int len = 0;
			try {
				len = sc.read(byteBuffer);
			} catch (Exception e) {
				e.printStackTrace();
				String uuid = selectionKey.attachment().toString();
				StringUtil.println(uuid);
				removeSockeckChannel(uuid);
				// 如果read抛出异常，表示连接异常中断，需要关闭 socketChannel
				sc.close();
			}
			// 如果len>0，表示有输入。如果len==0, 表示输入结束。需要关闭 socketChannel
			if (len > 0) {
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
//				for (byte b2 : b) {
//					StringUtil.print(StringUtil.toHexString(b2) + " ");
//				}
//				StringUtil.println("");

				// 校验
				if (!CRC16.compareCRC16(b)) {
					return;
				}

				byteBuffer.clear();

				// 处理数据
				try {
					ExecCardReaderCommand.execCommand(selectionKey, b);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				// 输入结束，关闭 socketChannel
				String uuid = selectionKey.attachment().toString();
				StringUtil.println(uuid + " 已关闭连接");
				sc.close();

				String sn = removeSockeckChannel(uuid);

				if (sn != null) {
					Map map = new HashMap();
					map.put("'f1'", FrameCardReader.Status);
					map.put("'r'", 0);

					String msg = JSONUtil.convertToJson(map);
					TerminalManager.EngineInstance.sendToAll("c" + sn, msg);
				}
			}

			Thread.sleep(100);
		}
	}

	private String removeSockeckChannel(String uuid) {
		String sn = null;
		if (TerminalManager.UuidToSNList.containsKey(uuid)) {
			sn = TerminalManager.UuidToSNList.get(uuid);
			TerminalManager.UuidToSNList.remove(uuid);
			TerminalManager.SNToSocketChannelList.remove(sn);
		}
		return sn;
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
