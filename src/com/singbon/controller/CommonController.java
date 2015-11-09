package com.singbon.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.Dept;
import com.singbon.entity.Pagination;
import com.singbon.entity.SysUser;
import com.singbon.entity.UserDept;
import com.singbon.service.CommonService;
import com.singbon.service.SysUserService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.service.systemManager.systemSetting.DeptService;
import com.singbon.service.systemManager.systemSetting.UserDeptService;

/**
 * 公共通用控制类
 * 
 * @author 郝威
 * 
 */
@Controller
public class CommonController {

	@Autowired
	public SysUserService sysUserService;
	@Autowired
	public DeviceService deviceService;
	@Autowired
	public UserDeptService userDeptService;
	@Autowired
	public DeptService deptService;
	@Autowired
	public CommonService commonService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	/**
	 * 通用导航到各模块首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "**/index.do")
	public String index(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));

		return url.replace(".do", "");
	}

	/***
	 * 主页
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/main.do")
	public String main(@ModelAttribute SysUser user, HttpServletRequest request, Model model) {
		return "main";
	}

	/***
	 * 登出
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/loginout.do")
	public void loginout(@ModelAttribute SysUser user, HttpServletRequest request, HttpServletResponse response, Model model) {
		request.getSession().removeAttribute("sysUser");
		try {
			response.sendRedirect("/");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 选择人员部门树列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/selectUserDeptTree.do")
	public String selectUserDeptTree(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = (List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		return "common/selectUserDeptTree";
	}

	/**
	 * 选择消费机首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/selectPosIndex.do")
	public String userIndex(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Dept> deptList = (List<Dept>) this.deptService.selectListByCompanyId(company.getId());
		model.addAttribute("deptList", deptList);
		return "common/selectPos/index";
	}

	/**
	 * 选择消费机列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/selectPosList.do")
	public String selectPosList(@ModelAttribute Pagination pagination, String nameStr, Integer deptId, Integer includeSub, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "d.id", "d.deviceNum", "d.deviceName", "d.deviceType" };
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
		}

		model.addAttribute("deviceList", deviceList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptId", deptId);
		model.addAttribute("includeSub", includeSub);

		return "common/selectPos/list";
	}
}
