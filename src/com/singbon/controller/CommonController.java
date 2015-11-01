package com.singbon.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.entity.Company;
import com.singbon.entity.SysUser;
import com.singbon.service.SysUserService;
import com.singbon.service.systemManager.DeviceService;

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
}
