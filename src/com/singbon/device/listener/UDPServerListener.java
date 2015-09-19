package com.singbon.device.listener;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.DatagramPacket;
import io.netty.channel.socket.nio.NioDatagramChannel;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.singbon.device.CRC16;
import com.singbon.device.TerminalManager;

/**
 * 
 * UDP服务监听和分发服务
 * 
 * @author 郝威
 * 
 */
public class UDPServerListener implements ServletContextListener {

	public void startServer() {

		EventLoopGroup group = new NioEventLoopGroup();
		Bootstrap b = new Bootstrap();
		b.group(group).channel(NioDatagramChannel.class).option(ChannelOption.SO_BROADCAST, true).handler(new UDPSeverHandler());

		try {
			b.bind(10002).sync().channel().closeFuture().await();
		} catch (InterruptedException e) {
			e.printStackTrace();
			group.shutdownGracefully();
		}
	}

	class UDPServer implements Runnable {

		@Override
		public void run() {
			try {
				new UDPServerListener().startServer();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	public void contextInitialized(ServletContextEvent arg0) {
		Thread t = new Thread(new UDPServer());
		t.start();
	}

	public static void main(String[] args) {
		new UDPServerListener().startServer();
	}
}

class UDPSeverHandler extends SimpleChannelInboundHandler<DatagramPacket> {

	@Override
	public void channelRegistered(ChannelHandlerContext ctx) throws Exception {
		TerminalManager.ctx = ctx;
		super.channelRegistered(ctx);
	}

	protected void messageReceived(ChannelHandlerContext ctx, DatagramPacket packet) throws Exception {
		ByteBuf buf = (ByteBuf) packet.copy().content();
		byte[] b = new byte[buf.readableBytes()];
		buf.readBytes(b);
		
		// 校验
		if (!CRC16.compareCRC16(b)) {
			return;
		}
		
		// 分发数据
		TerminalManager s = new TerminalManager();
		try {
			s.dispatchPosCommand(packet.sender(), b);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		String body = new String(req, "UTF-8");
//		System.out.println(body);
//
//		ByteBuf buf2 = Unpooled.copiedBuffer(new byte[] { 11, 22, 33 });
//		DatagramPacket dp = new DatagramPacket(buf2, new InetSocketAddress("192.168.1.110", 10004));
//		TerminalManager.ctx.writeAndFlush(dp);
	}

}