package com.singbon.device.listener;

import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.channels.DatagramChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.singbon.device.TerminalManager;

/**
 * TCP服务监听和分发服务
 * 
 * @author 郝威
 * 
 */
public class UDPSocketChannelListener implements ServletContextListener {

	public void startServer() throws Exception {
		Selector selector = null;
		try {
			DatagramChannel channel = DatagramChannel.open();
			DatagramSocket socket = channel.socket();
			channel.configureBlocking(false);

			socket.bind(new InetSocketAddress(10001));

			selector = Selector.open();
			channel.register(selector, SelectionKey.OP_READ);
		} catch (Exception e) {
			e.printStackTrace();
		}

		int i = 0;
		ByteBuffer byteBuffer = ByteBuffer.allocate(65536);
		while (true) {
			try {
				selector.select();
				Iterator<SelectionKey> iterator = selector.selectedKeys().iterator();
				while (iterator.hasNext()) {
					SelectionKey sk = iterator.next();

					iterator.remove();
					if (sk.isReadable()) {

						DatagramChannel datagramChannel = (DatagramChannel) sk.channel();
						SocketAddress sa = datagramChannel.receive(byteBuffer);
						byteBuffer.flip();
						// System.out.print(++i);
						// System.out.println(sa);
						// 测试：通过将收到的ByteBuffer首先通过缺省的编码解码成CharBuffer 再输出
						String s = new String(byteBuffer.array()).trim();

						// datagramChannel.w
						// CharBuffer charBuffer = Charset.defaultCharset()
						// .decode(byteBuffer);
						// String k = charBuffer.toString();
						// if
						// (!"11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 12"
						// .equals(s)) {
						// continue;
						// }
						// int n = 0;
						// if (TerminalManager.list.containsKey(sa)) {
						// n = TerminalManager.list.get(sa) + 1;
						// }
						// TerminalManager.list.put(sa, n);
						// byteBuffer.clear();

						// System.out.println(sa + " " + n);
						//
						String echo = "This is the reply messageThis is the reply messageThis is the reply messageThis is the reply message";
						ByteBuffer buffer = Charset.defaultCharset().encode(echo);
						datagramChannel.send(buffer, sa);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	// int i = 0;
	//
	// public void handleSelectionKey(SelectionKey selectionKey) throws
	// Exception {
	// if (selectionKey.isAcceptable()) {
	// ServerSocketChannel ssc = (ServerSocketChannel) selectionKey.channel();
	// SocketChannel socketChannel = ssc.accept();
	// socketChannel.configureBlocking(false);
	// // 立即注册一个 OP_READ 的SelectionKey, 接收客户端的消息
	// SelectionKey key = socketChannel.register(selector,
	// SelectionKey.OP_READ);
	//
	// String uuid = (++i) + "";
	// // String uuid = UUID.randomUUID().toString();
	// key.attach(uuid);
	// // 打印
	// System.out.println(key.attachment() + " 连接成功");
	// } else if (selectionKey.isReadable()) {
	// // System.out.println(5);
	//
	// // 有消息进来
	// ByteBuffer byteBuffer = ByteBuffer.allocate(100);
	// SocketChannel sc = (SocketChannel) selectionKey.channel();
	// int len = 0;
	// try {
	// len = sc.read(byteBuffer);
	//
	// } catch (Exception e) {
	// String uuid = selectionKey.attachment().toString();
	// System.out.println(uuid);
	// removeSockeckChannel(uuid);
	// // 如果read抛出异常，表示连接异常中断，需要关闭 socketChannel
	// e.printStackTrace();
	// sc.close();
	// }
	// // 如果len>0，表示有输入。如果len==0, 表示输入结束。需要关闭 socketChannel
	// if (len > 0) {
	// byteBuffer.flip();
	//
	// // 41 59 a9 6e 83 8e 4d f5 bd ec d4 e2 d8 e9 40 f1 00 26 00
	// // 04 00 00 01 03 08 00 00 00 00 01 00 00 0c 00 00 02 00
	// // f1 00 00 10 03 0d 00 01 38 15 03 13 13 25 51 00 38
	//
	// // df d5 41 c5 1d 0d 45 43 81 30 9d 6d 0f f2 20 61 00 26 00
	// // 04 00 00 01 03 08 00 00 00 00 01 00 00 0c 00 00 02 00
	// // f1 00 00 10 03 0d 00 01 38 15 03 13 13 25 51 00 38
	//
	// // 39 af c4 4d 9e bd 4b 93 be 14 39 af c8 ac 3d f7 00 26 00
	// // 04 00 00 01 03 08 00 00 00 00 01 00 00 0c 00 00 02 00
	// // f1 00 00 10 03 0d 00 01 38 15 03 13 13 25 51 00 38
	// byte[] b = byteBuffer.array();
	//
	// byteBuffer.clear();
	//
	// sc.write(byteBuffer);
	//
	// // 分发数据
	// TerminalManager s = new TerminalManager();
	// s.dispatchCommand(selectionKey, b);
	// } else {
	// // 输入结束，关闭 socketChannel
	// String uuid = selectionKey.attachment().toString();
	// System.out.println(uuid + " 已关闭连接");
	// sc.close();
	//
	// removeSockeckChannel(uuid);
	// }
	//
	// Thread.sleep(100);
	// }
	// }

	private void removeSockeckChannel(String uuid) {
		if (TerminalManager.getUuidToSNList().containsKey(uuid)) {
			String sn = TerminalManager.getUuidToSNList().get(uuid);
			TerminalManager.getSNToSocketChannelList().put(sn, null);
			TerminalManager.getUuidToSNList().remove(uuid);
		}
	}

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		new UDPSocketChannelListener().startServer();
	}

	class TCPListenServer implements Runnable {

		@Override
		public void run() {
			try {
				new UDPSocketChannelListener().startServer();
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