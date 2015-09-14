package com.singbon.controller.monitor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;
import com.singbon.entity.SysUser;
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
		List<Device> deviceList = this.deviceService.selectList(company.getId());
		for (Device d : deviceList) {
			if (TerminalManager.getSNToDatagramChannelList().containsKey(d.getSn())) {
				d.setIsOnline(1);
			} else {
				d.setIsOnline(0);
			}
		}
		model.addAttribute("deviceList", deviceList);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));

		return url.replace(".do", "");
	}

	/**
	 * 关闭连接
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/closeDatagramChannel.do", method = RequestMethod.POST)
	public void closeDatagramChannel(String sn, HttpServletRequest request, HttpServletResponse response, Model model) {
		TerminalManager.getSNToDatagramChannelList().remove(sn);
	}

}
