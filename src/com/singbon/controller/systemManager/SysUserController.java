package com.singbon.controller.systemManager;

import java.io.PrintWriter;
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
import com.singbon.entity.SysUser;
import com.singbon.service.SysUserService;
import com.singbon.service.systemManager.DeviceService;
import com.singbon.util.DesUtil;
import com.singbon.util.StringUtil;

/**
 * 系统用户控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/sysUser")
public class SysUserController {

	@Autowired
	public SysUserService sysUserService;
	@Autowired
	public DeviceService deviceService;

	/**
	 * 首页
	 * 
	 * @param sysUser
	 * @param request
	 * @param model
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Device> deviceList = this.deviceService.selectCardReaderListByCompanyId(company.getId());
		List<Map> userList = (List<Map>) this.sysUserService.selectListByCompanyId(company.getId());
		model.addAttribute("deviceList", deviceList);
		model.addAttribute("userList", userList);
		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "index");
	}

	/**
	 * 添加修改
	 * 
	 * @param sysUser
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute SysUser sysUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		sysUser.setCompanyId(company.getId());

		try {
			sysUser.setLoginName(DesUtil.encrypt(sysUser.getLoginName()));
			sysUser.setLoginPwd(DesUtil.encrypt(sysUser.getLoginPwd()));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (sysUser.getOperId() == null) {
				this.sysUserService.insert(sysUser);
			} else {
				this.sysUserService.update(sysUser);
			}
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 删除
	 * 
	 * @param sysUser
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/delete.do")
	public void delete(Integer operId, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.sysUserService.delete(operId);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param sysUser
	 * @param request
	 * @param model
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/list.do")
	public String list(Integer parentId, HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Map> list = (List<Map>) this.sysUserService.selectListByCompanyId(company.getId());
		for (Map m : list) {
			m.put("loginName", DesUtil.decrypt(m.get("loginName").toString()));
			m.put("loginPwd", DesUtil.decrypt(m.get("loginPwd").toString()));
		}
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
