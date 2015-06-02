package com.singbon.device.listener;

import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.charset.Charset;
import java.util.Iterator;

public class UdpTest {

	public static void main(String[] args) throws Exception {

		for (int i = 10001; i <= 10100; i++) {
			UdpServer u = new UdpServer();
			u.setPort(i);
			Thread t = new Thread(u);
			System.out.println(i);
			t.start();
			System.out.println(i);
		}
		// server.close();
	}
}

class UdpServer implements Runnable {

	private int port;

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	@Override
	public void run() {
		try {
			Selector selector = null;
			try {
				DatagramChannel channel = DatagramChannel.open();
				DatagramSocket socket = channel.socket();
				channel.configureBlocking(false);

				socket.bind(new InetSocketAddress(port));

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
		} catch (Exception e) {

		}
	}
}