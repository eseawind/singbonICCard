package com.singbon.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.entity.Company;
import com.singbon.entity.SysUser;

/**
 * 公共通用控制类
 * 
 * @author 郝威
 * 
 */
@Controller
public class CommonController {

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

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/userDeptTree.do", method = RequestMethod.GET)
	public String userDeptTree(HttpServletRequest request, String h, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		// List<UserDept>
		// list=this.commonService.getUserDeptList(user.getCompany());
		// model.addAttribute("list", list);
		model.addAttribute("h", h);
		return "common/userDeptTree";
	}

}
