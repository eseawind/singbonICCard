package com.singbon.device.listener;

import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.util.Arrays;
import java.util.Iterator;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.singbon.device.CRC16;
import com.singbon.device.TerminalManager;
import com.singbon.util.StringUtil;

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

			socket.bind(new InetSocketAddress(10002));

			selector = Selector.open();
			channel.register(selector, SelectionKey.OP_READ);
		} catch (Exception e) {
			e.printStackTrace();
		}

		while (true) {
			try {
				selector.select();
				Iterator<SelectionKey> iterator = selector.selectedKeys().iterator();
				while (iterator.hasNext()) {
					SelectionKey selectionKey = iterator.next();
					iterator.remove();
					if (selectionKey.isReadable()) {
						ByteBuffer byteBuffer = ByteBuffer.allocate(65536);
						DatagramChannel datagramChannel = (DatagramChannel) selectionKey.channel();

						SocketAddress socketAddress = datagramChannel.receive(byteBuffer);
						byteBuffer.flip();

						int byteLen = 0;
						byte[] b = byteBuffer.array();
						for (int i = b.length; i > 0; i--) {
							if (b[i - 1] != 0) {
								byteLen = i;
								break;
							}
						}
						b = Arrays.copyOf(b, byteLen);
//						for (byte b2 : b) {
//							System.out.print(StringUtil.toHexString(b2) + " ");
//						}
//						System.out.println();

						// 校验
						if (!CRC16.compareCRC16(b)) {
							return;
						}

						byteBuffer.clear();

						// String echo =
						// "This is the reply messageThis is the reply messageThis is the reply messageThis is the reply message";
						// ByteBuffer buffer =
						// Charset.defaultCharset().encode(echo);
						// datagramChannel.send(buffer, sa);
						//
						// 分发数据
						TerminalManager s = new TerminalManager();
						try {
							s.dispatchPosCommand(datagramChannel, socketAddress, b);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@SuppressWarnings("unused")
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

	class UDPListenServer implements Runnable {

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
		Thread t = new Thread(new UDPListenServer());
		t.start();

	}
}