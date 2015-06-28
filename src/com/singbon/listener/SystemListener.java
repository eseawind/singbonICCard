package com.singbon.listener;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.singbon.device.TerminalManager;
import com.singbon.entity.Device;
import com.singbon.service.CardManagerService;
import com.singbon.service.systemManager.DeviceService;

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
		WebApplicationContext app = WebApplicationContextUtils.getRequiredWebApplicationContext(arg0.getServletContext());
		DeviceService deviceService = (DeviceService) app.getBean("deviceService");

		// 加载设备序列号到公司的映射和设备序列号到socketchannel的空映射
		List<Device> list = deviceService.selectAllList();
		for (Device d : list) {
			TerminalManager.getSnToCompanyList().put(d.getSn(), d.getCompanyId());
			// 初始化添加空设备,以便查询设备
//			TerminalManager.getSNToSocketChannelList().put(d.getSn(), null);
			TerminalManager.registChannel(d.getSn());
		}

	}

}