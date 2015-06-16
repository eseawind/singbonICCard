package com.singbon.controller.systemManager;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.controller.BaseController;
import com.singbon.entity.AuthGroup;
import com.singbon.entity.Company;
import com.singbon.entity.SysUser;
import com.singbon.service.systemManager.AuthorizationService;

/**
 * 用户授权控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/userRoles")
public class AuthorizationController extends BaseController {

	@Autowired
	public AuthorizationService authorizationService;

	/**
	 * 分组首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/groupIndex.do")
	public String groupIndex(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		model.addAttribute("base", "/systemManager/userRoles");

		return "/systemManager/userRoles/groupIndex";
	}

	/**
	 * 用户授权首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/userIndex.do")
	public String userIndex(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		model.addAttribute("base", "/systemManager/userRoles");

		return "/systemManager/userRoles/userIndex";
	}

	/**
	 * 添加修改分组
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEditGroup.do")
	public void addEditGroup(@ModelAttribute AuthGroup authGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		authGroup.setCompanyId(company.getId());

		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (authGroup.getId() == null) {
				this.authorizationService.insertGroup(authGroup);
			} else {
				this.authorizationService.updateGroup(authGroup);
			}
			p.print(1);
		} catch (Exception e) {
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
		List<AuthGroup> list = this.authorizationService.selectGroup(company.getId());
		model.addAttribute("list", list);
		model.addAttribute("base", "/systemManager/userRoles");
		return "/systemManager/userRoles/groupList";
	}

}
