package com.singbon.controller.systemManager;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.Dept;
import com.singbon.entity.Device;
import com.singbon.entity.Pagination;
import com.singbon.entity.PosParamGroup;
import com.singbon.entity.SysUser;
import com.singbon.service.CommonService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.service.systemManager.systemSetting.DeptService;
import com.singbon.service.systemManager.systemSetting.PosParamGroupService;
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
	public DeviceService deviceService;
	@Autowired
	public PosParamGroupService posParamGroupService;
	@Autowired
	public DeptService deptService;
	@Autowired
	public CommonService commonService;

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
		List<Dept> deptList = (List<Dept>) this.deptService.selectListByCompanyId(company.getId());
		model.addAttribute("deptList", deptList);
		model.addAttribute("posParamGroupList", posParamGroupList);
		model.addAttribute("base", "/systemManager/deviceManager");
		return "/systemManager/deviceManager/posIndex";
	}

	/**
	 * 添加修改设备
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addEdit.do")
	public void addEditDevice(@ModelAttribute Device device, String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();

			Pattern pattern = Pattern.compile("^[0-9a-fA-F]{32}$");
			Matcher matcher = pattern.matcher(device.getSn());
			if (!matcher.matches()) {
				p.print(2);
				return;
			}
			Map map = this.deviceService.selectCountByInfo(device);
			if (StringUtil.objToInt(map.get("numCount")) > 0) {
				p.print(3);
				return;
			} else if (StringUtil.objToInt(map.get("snCount")) > 0) {
				p.print(4);
				return;
			}

			device.setCompanyId(company.getId());
			if (status != null) {
				device.setEnable(1);
			} else {
				device.setEnable(0);
			}
			device.setSn(device.getSn().toUpperCase());
			if (device.getId() == null) {
				this.deviceService.insert(device);
			} else {
				this.deviceService.update(device);
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
	@RequestMapping(value = "/delete.do")
	public void delete(Integer id, String sn, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.deviceService.deleteDevice(id, sn);
			p.print(1);
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
	public String list(@ModelAttribute Pagination pagination, String nameStr, Integer deptId, Integer includeSub, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		// <th width="80">机器号</th>
		// <th width="120">设备名称</th>
		// <th width="100">设备类型</th>
		// <th width="120">消费参数分组</th>
		// <th width="300">序列号</th>
		// <th width="80">状态</th>

		String[] columns = { "d.id", "d.deviceNum", "d.deviceName", "d.deviceType", "d.posParamGroupId", "d.sn", "d.enable" };
		String fromSql = "device d";
		String whereSql = String.format(" d.companyId=%s and deviceType!=8", company.getId());
		if (!StringUtils.isEmpty(nameStr)) {
			whereSql += String.format(" and (d.deviceNum like '%%%s%%' or d.deviceName like '%%%s%%')", nameStr, nameStr);
		}
		if (!StringUtils.isEmpty(deptId) && deptId != 0) {
			if (StringUtils.isEmpty(includeSub)) {
				whereSql += String.format(" and d.deptId = %s", deptId);
			} else {
				whereSql += String.format(" and find_in_set(d.deptId,getSubIds(%s,1))>0", deptId);
			}
		}

		List<Map> deviceList = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(deviceList.get(0).get("id").toString());
		deviceList.remove(0);

		for (Map m : deviceList) {
			int deviceType = Integer.valueOf(m.get("deviceType").toString());
			if (deviceType == 2) {
				m.put("deviceTypeDes", "点餐机");
			} else if (deviceType == 3) {
				m.put("deviceTypeDes", "水控机");
			}
			if (!StringUtils.isEmpty(m.get("posParamGroupId"))) {
				int posParamGroupId = Integer.valueOf(m.get("posParamGroupId").toString());
				for (PosParamGroup group : posParamGroupList) {
					if (group.getId() == posParamGroupId) {
						m.put("groupName", group.getGroupName());
						break;
					}
				}
			}
		}

		model.addAttribute("deviceList", deviceList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptId", deptId);
		model.addAttribute("includeSub", includeSub);

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
