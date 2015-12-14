package com.singbon.device;

import org.comet4j.core.CometConnection;
import org.comet4j.core.CometContext;
import org.comet4j.core.event.ConnectEvent;
import org.comet4j.core.event.DropEvent;
import org.comet4j.core.listener.ConnectListener;
import org.comet4j.core.listener.DropListener;

import com.singbon.util.StringUtil;

/**
 * 服务器端推送消息服务注册
 * 
 * @author 郝威
 * 
 */
public class CometServer {

	public void init() {
		CometContext cc = CometContext.getInstance();

		TerminalManager.EngineInstance = cc.getEngine();
		// 添加连接监听
		TerminalManager.EngineInstance.addConnectListener(new ConnectListener() {
			@Override
			public boolean handleEvent(ConnectEvent event) {
				CometConnection connection = event.getConn();
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
					Thread oldCommandThread = TerminalManager.CompanyIdToMonitorCommandThreadList.get(Integer.valueOf(companyId));
					if (oldCommandThread != null && oldCommandThread.isAlive()) {
						oldCommandThread.interrupt();
					}
					Thread oldColectThread = TerminalManager.CompanyIdToMonitorCollectThreadList.get(Integer.valueOf(companyId));
					if (oldColectThread != null && oldColectThread.isAlive()) {
						oldColectThread.interrupt();
					}
					TerminalManager.CompanyIdToMonitorRunningList.remove(Integer.valueOf(companyId));
				}
				String ip = connection.getClientIp();
				StringUtil.println("d " + ip);
				return false;
			}
		});
	}
}
