package com.singbon.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.SocketChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.comet4j.core.util.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.device.CommandCodeCardReader;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
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

	/**
	 * 出纳员登录
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/login.do")
	public void login(String loginName, String loginPwd, String companyName, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = this.sysUserService.login(companyName, loginName, loginPwd);
		request.getSession().setAttribute("sysUser", sysUser);
		PrintWriter print = null;
		Map map = new HashMap();
		try {
			print = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (sysUser == null) {
			// 用户不存在
			map.put("r", 0);
			print.print(JSONUtil.convertToJson(map));
			return;
		}
		Device device = this.deviceService.selectByOperId(sysUser.getOperId());
		request.getSession().setAttribute("device", device);
		if (device == null) {
			// 没有绑定读卡机
			map.put("r", 1);
			print.print(JSONUtil.convertToJson(map));
			return;
		}
		String sn = device.getSn();
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
		if (socketChannel == null) {
			// 读卡机不在线
			map.put("r", 2);
			print.print(JSONUtil.convertToJson(map));
			return;
		}
		// 可以正常操作，返回卡号和物理卡号
		map.put("r", 3);
		map.put("cardNO", sysUser.getCardNO());
		map.put("cardSN", sysUser.getCardSN());
		map.put("sn", device.getSn());
		print.print(JSONUtil.convertToJson(map));
	}

	/***
	 * 验证出纳员卡信息
	 * 
	 * @param user
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/valCashierCard.do")
	public void valCashierCard(HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		int section = TerminalManager.getSection(sysUser.getCompanyId());
		List<Integer> sectionBlocks = new ArrayList<Integer>();
		sectionBlocks.add(section * 10);
		try {
			SocketChannel socketChannel=TerminalManager.SNToSocketChannelList.get(device.getSn());
			TerminalManager.getCardInfo(socketChannel, device, CommandCodeCardReader.CashierCardBaseInfo, sectionBlocks);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
