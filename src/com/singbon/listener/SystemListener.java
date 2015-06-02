package com.singbon.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;

import com.singbon.service.CardManagerService;

/**
 * 系统监听
 * 
 * @author 郝威
 * 
 */
public class SystemListener implements ServletContextListener {

	@Autowired
	CardManagerService userService;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
//		WebApplicationContext app = WebApplicationContextUtils.getRequiredWebApplicationContext(arg0.getServletContext());
//		SystemService sys = (SystemService) app.getBean("systemService");
//		
//		//加载设备序列号到公司的映射和设备序列号到socketchannel的空映射
//		List<Device> list = sys.getDeviceList();
//		for (Device d : list) {
//			TerminalManager.getSnToCompanyList().put(d.getSn(), d.getCompany().getId());
//			//初始化添加空设备,以便查询设备
//			TerminalManager.getSNToSocketChannelList().put(d.getSn(), null);
//		}			
	}

}