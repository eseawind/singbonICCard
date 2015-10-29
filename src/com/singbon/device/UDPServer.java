package com.singbon.device;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.DatagramPacket;
import io.netty.channel.socket.nio.NioDatagramChannel;

/**
 * 
 * UDP监听和分发服务
 * 
 * @author 郝威
 * 
 */
public class UDPServer implements Runnable {

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

	public static void main(String[] args) {
		new UDPServer().startServer();
	}

	@Override
	public void run() {
		try {
			new UDPServer().startServer();
		} catch (Exception e) {
			e.printStackTrace();
		}
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

//		System.out.println(new Date().toLocaleString());
//		for (byte b2 : b) {
//			System.out.print((b2 & 0xff) + " ");
//		}
//		System.out.println("");

		// 处理数据
		try {
			PosCommandExec.execCommand(packet.sender(), b);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}