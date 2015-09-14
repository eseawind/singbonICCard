package com.singbon.listener;

import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.service.system.CompanyService;
import com.singbon.service.systemManager.DeviceService;

/**
 * 系统监听
 * 
 * @author 郝威
 * 
 */
public class SystemListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		WebApplicationContext app = WebApplicationContextUtils.getRequiredWebApplicationContext(arg0.getServletContext());
		DeviceService deviceService = (DeviceService) app.getBean("deviceService");
		CompanyService companyService = (CompanyService) app.getBean("companyService");

		// 加载设备序列号到公司的映射,注册读卡机通道
		List<Device> deviceList = deviceService.selectAllList();
		for (Device d : deviceList) {
			TerminalManager.getSnToCompanyList().put(d.getSn(), d.getCompanyId());
			TerminalManager.registChannel("c" + d.getSn());
		}

		// 注册公司通道
		List<Company> companyList = companyService.selectAllList();
		for (Company c : companyList) {
			TerminalManager.registChannel("Co" + c.getId());
		}
	}
}
