package com.singbon.controller.monitor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.dao.systemManager.systemSetting.CookbookDAO;
import com.singbon.dao.systemManager.systemSetting.DiscountDAO;
import com.singbon.dao.systemManager.systemSetting.MealDAO;
import com.singbon.dao.systemManager.systemSetting.OrderTimeDAO;
import com.singbon.device.FramePos;
import com.singbon.device.SendCommand;
import com.singbon.device.SubCookbookFramePos;
import com.singbon.device.SubOtherFramePos;
import com.singbon.device.SubSysParaFramePos;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Cookbook;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;
import com.singbon.entity.Discount;
import com.singbon.entity.Meal;
import com.singbon.entity.OrderTime;
import com.singbon.entity.SysUser;
import com.singbon.service.monitor.MonitorService;
import com.singbon.service.systemManager.DeviceGroupService;
import com.singbon.service.systemManager.DeviceService;

/**
 * 监控平台控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/monitor/")
public class MonitorController extends BaseController {

	@Autowired
	public DeviceGroupService deviceGroupService;
	@Autowired
	public DeviceService deviceService;
	@Autowired
	public MonitorService monitorService;
	@Autowired
	public ConsumeParamDAO consumeParamDAO;
	@Autowired
	public MealDAO mealDAO;
	@Autowired
	public OrderTimeDAO orderTimeDAO;
	@Autowired
	public DiscountDAO discountDAO;
	@Autowired
	public CookbookDAO cookbookDAO;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		List<DeviceGroup> deviceGroupList = this.deviceGroupService.selectTreeList(company.getId());
		model.addAttribute("deviceGroupList", deviceGroupList);
		List<Device> deviceList = this.deviceService.selectPosList(company.getId(), 1);
		for (Device d : deviceList) {
			if (TerminalManager.SNToInetSocketAddressList.containsKey(d.getSn())) {
				d.setIsOnline(1);
			} else {
				d.setIsOnline(0);
			}
		}
		model.addAttribute("deviceList", deviceList);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));

		// 关闭老线程
		Thread oldThread = TerminalManager.CompanyToMonitorThreadList.get(company.getId());
		if (oldThread != null && oldThread.isAlive()) {
			oldThread.interrupt();
		}

		// 启动监控线程
		MonitorService monitorService = new MonitorService();
		monitorService.setDeviceList(deviceList);
		Thread thread = new Thread(monitorService);
		thread.setName("Co" + company.getId());
		TerminalManager.CompanyToMonitorThreadList.put(company.getId(), thread);
		thread.start();

		request.getSession().setAttribute("companyId", company.getId().toString());
		return url.replace(".do", "");
	}

	/**
	 * 关闭指定消费机连接
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/removeInetSocketAddress.do", method = RequestMethod.POST)
	public void removeInetSocketAddress(String sn, HttpServletRequest request, HttpServletResponse response, Model model) {
		TerminalManager.SNToInetSocketAddressList.remove(sn);
	}

	/**
	 * 命令
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(String sn, Integer groupId, String cmd, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		List<String> snList = new ArrayList<String>();
		// 对单个设备
		if (!StringUtils.isEmpty(sn)) {
			snList.add(sn);
			// 对整个组
		} else if (groupId != null) {
			List<Device> deviceList = this.deviceService.selectPosListByGroupId(groupId, 1);
			for (Device d : deviceList) {
				snList.add(d.getSn());
			}
		}

		for (String sn2 : snList) {
			int commandIndex = 1;
			synchronized (TerminalManager.sendCommandObject) {
				ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn2);
				if (sendCommandList == null) {
					sendCommandList = new ArrayList<SendCommand>();
					TerminalManager.SNToSendCommandList.put(sn, sendCommandList);
				} else {
					int size = sendCommandList.size();
					if (size > 0) {
						SendCommand sendCommand = sendCommandList.get(size - 1);
						commandIndex = sendCommand.getCommandCode() + 1;
					}
				}
				addCommand(company, sn2, cmd, commandIndex, sendCommandList);
			}
		}
	}

	/**
	 * 添加命令
	 * 
	 * @param sn
	 * @param cmd
	 * @param commandIndex
	 * @param sendCommandList
	 */
	private void addCommand(Company company, String sn, String cmd, int commandIndex, ArrayList<SendCommand> sendCommandList) {
		// 校时
		if ("sysTime".equals(cmd)) {
			if (sendCommandList.size() > 0) {
				SendCommand firstSendCommand = sendCommandList.get(0);
				if (firstSendCommand.getCommandCode() == 0) {
					return;
				}
			}
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(FramePos.SysTime);
			sendCommand.setSubFrame(SubOtherFramePos.SysTime);
			sendCommand.setCommandCode(0);
			sendCommandList.add(0, sendCommand);
			// 系统参数
		} else if ("sysPara".equals(cmd)) {
			// 设置消费参数
			ConsumeParam consumeParam = this.consumeParamDAO.selectByCompanyId(company.getId());
			// 设置订参别限次
			List<Meal> mealList = this.mealDAO.selectList(company.getId());
			// 设置订餐时间段
			List<OrderTime> orderTimeList = this.orderTimeDAO.selectByCompanyId(company.getId());

			// 系统参数
			SendCommand sendCommand1 = new SendCommand();
			sendCommand1.setFrame(FramePos.SysPara);
			sendCommand1.setSubFrame(SubSysParaFramePos.SysPara);
			sendCommand1.setCommandCode(commandIndex++);
			sendCommand1.setConsumeParam(consumeParam);

			// 参别限次
			SendCommand sendCommand2 = new SendCommand();
			sendCommand2.setFrame(FramePos.SysPara);
			sendCommand2.setSubFrame(SubSysParaFramePos.Meal);
			sendCommand2.setCommandCode(commandIndex++);
			sendCommand2.setMealList(mealList);

			// 订餐时间段
			SendCommand sendCommand3 = new SendCommand();
			sendCommand3.setFrame(FramePos.Cookbook);
			sendCommand3.setSubFrame(SubCookbookFramePos.OrderTime1);
			sendCommand3.setCommandCode(commandIndex++);
			sendCommand3.setOrderTimeList(orderTimeList);

			SendCommand sendCommand4 = new SendCommand();
			sendCommand4.setFrame(FramePos.Cookbook);
			sendCommand4.setSubFrame(SubCookbookFramePos.OrderTime2);
			sendCommand4.setCommandCode(commandIndex++);
			sendCommand4.setOrderTimeList(orderTimeList);

			sendCommandList.add(sendCommand1);
			sendCommandList.add(sendCommand2);
			sendCommandList.add(sendCommand3);
			sendCommandList.add(sendCommand4);
			// 折扣费率及管理费
		} else if ("discount".equals(cmd)) {
			List<Discount> discountList = this.discountDAO.selectList(company.getId());

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(FramePos.SysPara);
			sendCommand.setSubFrame(SubSysParaFramePos.Discount);
			sendCommand.setCommandCode(commandIndex);
			sendCommand.setDiscountList(discountList);
			sendCommandList.add(sendCommand);
			// 菜肴清单
		} else if ("cookbook".equals(cmd)) {
			List<Cookbook> cookbookList = this.cookbookDAO.selectList(company.getId());

			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(FramePos.Cookbook);
			sendCommand.setSubFrame(SubCookbookFramePos.Update);
			sendCommand.setCommandCode(commandIndex++);
			sendCommandList.add(sendCommand);

			int index = 0;
			for (Cookbook cookbook : cookbookList) {
				SendCommand sendCommand2 = new SendCommand();
				sendCommand2.setFrame(FramePos.Cookbook);
				sendCommand2.setSubFrame(SubCookbookFramePos.Append);
				sendCommand2.setCookbook(cookbook);
				sendCommand2.setCommandCode(commandIndex++);
				sendCommand2.setCookbookIndex(++index);
				sendCommand2.setCookbookTotal(cookbookList.size());
				sendCommandList.add(sendCommand2);
			}
			// 初始化
		} else if ("sysInit".equals(cmd)) {
			SendCommand sendCommand = new SendCommand();
			sendCommand.setFrame(FramePos.SysInit);
			sendCommand.setSubFrame(SubOtherFramePos.SysInit);
			sendCommand.setCommandCode(0);
			sendCommandList.clear();
			sendCommandList.add(sendCommand);
		}
	}
}
