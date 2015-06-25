package com.singbon.device.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.comet4j.core.CometConnection;
import org.comet4j.core.CometContext;
import org.comet4j.core.event.ConnectEvent;
import org.comet4j.core.event.DropEvent;
import org.comet4j.core.listener.ConnectListener;
import org.comet4j.core.listener.DropListener;

import com.singbon.device.TerminalManager;

/**
 * 服务器端推送消息服务注册
 * 
 * @author 郝威
 * 
 */
public class CometListener implements ServletContextListener {
	
	public void contextInitialized(ServletContextEvent arg0) {
		CometContext cc = CometContext.getInstance();
		
		TerminalManager.setEngineInstance(cc.getEngine());
		// 添加连接监听
		TerminalManager.getEngineInstance().addConnectListener(new ConnectListener() {
			@Override
			public boolean handleEvent(ConnectEvent event) {

				CometConnection connection = event.getConn();
				String ip = connection.getClientIp();
				System.out.println(ip);
				return false;
			}
		});

		TerminalManager.getEngineInstance().addDropListener(new DropListener() {
			@Override
			public boolean handleEvent(DropEvent event) {

				CometConnection connection = event.getConn();
				String ip = connection.getClientIp();
				System.out.println("d " + ip);
				return false;
			}
		});
	}

	public void contextDestroyed(ServletContextEvent arg0) {

	}
}