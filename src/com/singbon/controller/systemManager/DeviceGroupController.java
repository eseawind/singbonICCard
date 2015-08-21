package com.singbon.controller.systemManager;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.DeviceGroup;
import com.singbon.service.systemManager.DeviceGroupService;
import com.singbon.util.StringUtil;

/**
 * 终端设备分组控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/deviceGroupManager")
public class DeviceGroupController {

	@Autowired
	public DeviceGroupService deviceGroupService;

	/**
	 * 终端设备分组树列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<DeviceGroup> treeList = this.deviceGroupService.selectTreeList(company.getId());
		model.addAttribute("treeList", treeList);
		return StringUtil.requestPath(request, "treeList");
	}

}
