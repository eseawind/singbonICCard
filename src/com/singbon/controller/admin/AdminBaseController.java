package com.singbon.controller.admin;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.util.DesUtil;
import com.singbon.util.JdbcUtil;
import com.singbon.util.StringUtil;

/**
 * 后台基础控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/singbon/backgroud/system/admin")
public class AdminBaseController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/login.do")
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("base", StringUtil.requestBase(request));
		return "admin/login";
	}

	/***
	 * 主页
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/setting/index.do")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("base", StringUtil.requestBase(request));
		return "admin/setting/index";
	}

	/***
	 * 登录
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loginin.do")
	public void loginin(String loginName, String loginPwd, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String sql = String.format("select count(*) count from singbon where loginName='%s' and loginPwd='%s'", DesUtil.encrypt(loginName), DesUtil.encrypt(loginPwd));
			List<Map> list = JdbcUtil.baseDAO.selectBySql(sql);
			if (StringUtil.objToInt(list.get(0).get("count")) == 1) {
				request.getSession().setAttribute("adminLogin", DesUtil.encrypt(loginPwd));
				p.print(1);
			} else {
				p.print(0);
			}
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
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
	public String loginout(HttpServletRequest request, HttpServletResponse response, Model model) {
		request.getSession().removeAttribute("adminLogin");
		model.addAttribute("base", StringUtil.requestBase(request));
		return "admin/login";
	}

	/***
	 * 编辑密码首页
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editPwd.do")
	public String editPwd(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("base", StringUtil.requestBase(request));
		return "admin/setting/editPwd";
	}

	/***
	 * 保存密码
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/savePwd.do")
	public void savePwd(String oldPwd, String newPwd, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String pwd = request.getSession().getAttribute("adminLogin").toString();
			if (!DesUtil.encrypt(oldPwd).equals(pwd)) {
				p.print(2);
				return;
			}
			String sql = String.format("update singbon set loginPwd='%s'", DesUtil.encrypt(newPwd));
			JdbcUtil.baseDAO.updateSql(sql);
			request.getSession().setAttribute("adminLogin", DesUtil.encrypt(newPwd));
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
	}
}
