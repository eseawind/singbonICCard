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
import com.singbon.device.SendCommand;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Dept;
import com.singbon.entity.Device;
import com.singbon.entity.SysUser;
import com.singbon.service.monitor.MonitorService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.service.systemManager.systemSetting.DeptService;

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
	public DeviceService deviceService;
	@Autowired
	public MonitorService monitorService;
	@Autowired
	public DeptService deptService;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		List<Dept> deptList = (List<Dept>) this.deptService.selectListByCompanyId(company.getId());
		List<String> transferList = (List<String>) this.deviceService.selectTransferListByCompanyId(company.getId());		
		List<Device> deviceList = this.deviceService.selectDeviceListByCompanyId(company.getId(), new String[] { "2", "3" }, 1);
		for (Device d : deviceList) {
			if (TerminalManager.SNToInetSocketAddressList.containsKey(d.getTransferSn())) {
				d.setIsOnline(1);
			} else {
				d.setIsOnline(0);
			}
		}
		model.addAttribute("deptList", deptList);
		model.addAttribute("transferList", transferList);
		model.addAttribute("deviceList", deviceList);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));

		// 关闭老线程
		Thread oldThread = TerminalManager.CompanyIdToMonitorThreadList.get(company.getId());
		if (oldThread != null && oldThread.isAlive()) {
			oldThread.interrupt();
		}

		// 启动监控线程
		MonitorService monitorService = new MonitorService();
		monitorService.setDeviceList(deviceList);
		Thread thread = new Thread(monitorService);
		thread.setName("Co" + company.getId());
		TerminalManager.CompanyIdToMonitorThreadList.put(company.getId(), thread);
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
	public void command(String cmd, String sn, Integer deptId, Integer cookbookCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		List<String> snList = new ArrayList<String>();
		// 对单个设备
		if (!StringUtils.isEmpty(sn)) {
			snList.add(sn);
			// 对整个营业部门
		} else if (deptId != null) {
			List<Device> deviceList = this.deviceService.selectPosListByDeptId(deptId, 1);
			for (Device d : deviceList) {
				String sn2 = d.getSn();
				if (d.getTransferSn() != null) {
					sn2 = d.getTransferSn();
				}
				if (TerminalManager.SNToInetSocketAddressList.containsKey(sn2)) {
					snList.add(d.getSn());
				}
			}
		}

		for (String sn2 : snList) {
			int commandIndex = 1;
			synchronized (TerminalManager.sendCommandObject) {
				ArrayList<SendCommand> sendCommandList = TerminalManager.SNToSendCommandList.get(sn2);
				if (sendCommandList == null) {
					sendCommandList = new ArrayList<SendCommand>();
					TerminalManager.SNToSendCommandList.put(sn2, sendCommandList);
				} else {
					int size = sendCommandList.size();
					if (size > 0) {
						SendCommand sendCommand = sendCommandList.get(size - 1);
						commandIndex = sendCommand.getCommandCode() + 1;
					}
				}
				Device device = TerminalManager.SNToDeviceList.get(sn2);
				this.monitorService.addCommand(company, device, cmd, cookbookCode, commandIndex, sendCommandList);
			}
		}
	}
}
