package com.singbon.listener;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.comet4j.core.CometContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.singbon.device.CometServer;
import com.singbon.device.TCPSocketChannelServer;
import com.singbon.device.TerminalManager;
import com.singbon.device.UDPServerServer;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.Meal;
import com.singbon.service.system.CompanyService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.service.systemManager.systemSetting.MealService;
import com.singbon.util.DesUtil;

/**
 * 系统监听
 * 
 * @author 郝威
 * 
 */
public class SystemListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		CometContext.getInstance().destroy();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		WebApplicationContext app = WebApplicationContextUtils.getRequiredWebApplicationContext(arg0.getServletContext());
		DeviceService deviceService = (DeviceService) app.getBean("deviceService");
		CompanyService companyService = (CompanyService) app.getBean("companyService");
		MealService mealService = (MealService) app.getBean("mealService");

		// 加载设备序列号到公司的映射,注册读卡机通道
		List<Device> deviceList = deviceService.selectAllList();
		for (Device d : deviceList) {
			TerminalManager.SNToCompanyList.put(d.getSn(), d.getCompanyId());
			if (d.getDeviceType() == 0) {
				TerminalManager.registChannel("c" + d.getSn());
			} else {
				TerminalManager.SNToDevicelList.put(d.getSn(), d);
			}
		}

		// 注册公司通道
		List<Company> companyList = companyService.selectAllList();
		for (Company c : companyList) {
			TerminalManager.registChannel("Co" + c.getId());
		}

		// 添加公司到餐别限次映射供采集消费记录和监控平台用
		List<Meal> mealList = mealService.selectAllList();
		for (Company c : companyList) {
			List<Meal> list = new ArrayList<Meal>();
			for (Meal m : mealList) {
				if (c.getId() == m.getCompanyId()) {
					list.add(m);
				}
				TerminalManager.CompanyToMealList.put(c.getId(), list);
			}
		}

		// 初始化消息推送
		CometContext cct = CometContext.getInstance();
		cct.init(arg0);

		// 服务器端推送消息服务注册
		CometServer cometServer = new CometServer();
		cometServer.init();

		// 启动UDP服务监听和分发服务
		Thread t = new Thread(new UDPServerServer());
		t.start();

		// 启动TCP服务监听和分发服务
		Thread t2 = new Thread(new TCPSocketChannelServer());
		t2.start();
		
		try {
			DesUtil.desInit("ycsty");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}
}
