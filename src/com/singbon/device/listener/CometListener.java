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
import com.singbon.util.StringUtil;

/**
 * 服务器端推送消息服务注册
 * 
 * @author 郝威
 * 
 */
public class CometListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent arg0) {
		CometContext cc = CometContext.getInstance();

		TerminalManager.EngineInstance = cc.getEngine();
		// 添加连接监听
		TerminalManager.EngineInstance.addConnectListener(new ConnectListener() {
			@Override
			public boolean handleEvent(ConnectEvent event) {
				CometConnection connection = event.getConn();
				String companyId = connection.getCompanyId();
				String ip = connection.getClientIp();
				StringUtil.println(ip);
				return false;
			}
		});

		TerminalManager.EngineInstance.addDropListener(new DropListener() {
			@Override
			public boolean handleEvent(DropEvent event) {
				CometConnection connection = event.getConn();
				// 停止监控线程
				String companyId = connection.getCompanyId();
				if (companyId != null) {
					Thread oldThread = TerminalManager.CompanyToMonitorThreadlList.get(Integer.valueOf(companyId));
					if (oldThread != null && oldThread.isAlive()) {
						oldThread.interrupt();
					}
				}
				String cid = connection.getId();
				String ip = connection.getClientIp();
				StringUtil.println("d " + ip);
				return false;
			}
		});
	}

	public void contextDestroyed(ServletContextEvent arg0) {

	}
}
