package com.singbon.controller.systemManager;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;
import com.singbon.entity.PosParamGroup;
import com.singbon.entity.SysUser;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.service.systemManager.systemSetting.PosParamGroupService;

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
	public DeviceService deviceService;
	@Autowired
	public PosParamGroupService posParamGroupService;

	List<PosParamGroup> posParamGroupList = null;

	/**
	 * 消费机首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/posIndex.do")
	public String userIndex(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		posParamGroupList = (List<PosParamGroup>) this.posParamGroupService.selectListByCompanyId(company.getId());

		model.addAttribute("posParamGroupList", posParamGroupList);
		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/posIndex";
	}

	/**
	 * 添加修改分组
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEditGroup.do")
	public void addEditGroup(@ModelAttribute DeviceGroup deviceGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		deviceGroup.setCompanyId(company.getId());

		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (deviceGroup.getId() == null) {
				this.deviceService.insertGroup(deviceGroup);
			} else {
				this.deviceService.updateGroup(deviceGroup);
			}
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 删除分组
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/deleteGroup.do")
	public void deleteGroup(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {

		PrintWriter p = null;
		try {
			p = response.getWriter();
			Integer count = this.deviceService.selectDeviceCountByGroupId(id);
			if (count > 0) {
				p.print(2);
			} else {
				this.deviceService.deleteGroup(id);
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 分组列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/groupList.do")
	public String groupList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<DeviceGroup> list = this.deviceService.selectGroupListByCompanyId(company.getId());
		model.addAttribute("list", list);
		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/groupList";
	}

	/**
	 * 添加修改设备
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEditDevice.do")
	public void addEditDevice(@ModelAttribute Device device, String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		device.setCompanyId(company.getId());
		if (status != null) {
			device.setEnable(1);
		} else {
			device.setEnable(0);
		}
		device.setSn(device.getSn().toUpperCase());
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (device.getId() == null) {
				this.deviceService.insertDevice(device);
			} else {
				this.deviceService.updateDevice(device);
			}
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 删除设备
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/deleteDevice.do")
	public void deleteDevice(Integer id, String sn, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			Integer count = this.deviceService.selectDeviceCountByGroupId(id);
			if (count > 0) {
				p.print(2);
			} else {
				this.deviceService.deleteDevice(id, sn);
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 设备列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/posList.do")
	public String posList(Integer groupId, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Device> list = this.deviceService.selectPosListByGroupId(groupId, 0);
		List<Map> deviceList = new ArrayList<>();

		for (Device device : list) {
			Map map = new HashMap<>();
			map.put("device", device);
			if (device.getDeviceType() == 2) {
				map.put("deviceTypeDes", "点餐机");
			} else if (device.getDeviceType() == 3) {
				map.put("deviceTypeDes", "水控机");
			}
			for (PosParamGroup posParamGroup : posParamGroupList) {
				if (device.getPosParamGroupId() == posParamGroup.getId()) {
					map.put("posParamGroup", posParamGroup);
					break;
				}
			}
			deviceList.add(map);
		}
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/posList";
	}

	/**
	 * 读卡机首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/cardReaderIndex.do")
	public String cardReader(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/cardReaderIndex";
	}

	/**
	 * 删除读卡机
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/deleteCardReader.do")
	public void deleteCardReader(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			Integer count = this.deviceService.selectSysUserCountByDeviceId(id);
			if (count > 0) {
				p.print(2);
			} else {
				this.deviceService.deleteDevice(id, null);
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 读卡机列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/cardReaderList.do")
	public String cardReaderList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Device> list = this.deviceService.selectDeviceListByCompanyId(company.getId(), 1, 0);
		model.addAttribute("list", list);
		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/cardReaderList";
	}
}
