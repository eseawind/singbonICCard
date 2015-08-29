package com.singbon.controller.systemManager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;
import com.singbon.service.systemManager.DeviceGroupService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.util.StringUtil;

/**
 * 终端设备控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/deviceManager")
public class DeviceController {

	@Autowired
	public DeviceGroupService deviceGroupService;
	@Autowired
	public DeviceService deviceService;

	/**
	 * 列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/treeList.do")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		List<DeviceGroup> groupList = this.deviceGroupService.selectTreeList(company.getId());
		model.addAttribute("groupList", groupList);

		List<Device> deviceList = this.deviceService.selectList(company.getId());
		model.addAttribute("deviceList", deviceList);
		return StringUtil.requestPath(request, "treeList");
	}

	/**
	 * form
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/deviceForm.do")
	public String deviceForm(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("company", company);
		return StringUtil.requestPath(request, "deviceForm");
	}

}
