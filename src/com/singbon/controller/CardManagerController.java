package com.singbon.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.device.FrameType;
import com.singbon.entity.Company;
import com.singbon.entity.SysUser;
import com.singbon.entity.User;
import com.singbon.service.CardManagerService;

/**
 * 读卡器操作类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager")
public class CardManagerController {

	@Autowired
	CardManagerService cardManagerService;
	
	/**
	 * 获取用户列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/userList.do", method = RequestMethod.GET)
	public String userList(HttpServletRequest request,Integer deptId,String searchStr, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
//		List<User> list= this.cardManagerService.getUserList(user.getCompany(), deptId, searchStr);
//		model.addAttribute("userList", list);
		model.addAttribute("deptId", deptId);
		return "cardManager/userList";
	}
	
	/**
	 * 用户部门列表
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/userDept.do", method = RequestMethod.GET)
	public String userDept(HttpServletRequest request, Model model) {
		SysUser user = (SysUser) request.getSession().getAttribute("sysUser");		
		
		return "cardManager/userDept";
	}
	
	/**
	 * 制卡
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/cardMake.do", method = RequestMethod.GET)
	public String cardMake(HttpServletRequest request,Integer deptId, Model model) {
		SysUser user = (SysUser) request.getSession().getAttribute("sysUser");		
		String sn= null;
		model.addAttribute("sn", sn);
		
		model.addAttribute("deptId", deptId);
		return "cardManager/cardMake";
	}

	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(HttpServletRequest request, String comm, Model model) throws IOException {
		SysUser user = (SysUser) request.getSession().getAttribute("sysUser");
		String sn= null;
	
		if ("getCardReaderStatus".equals(comm)) {
			// 获取读卡器状态
			Map map = new HashMap();
			map.put("'f1'", FrameType.CardReaderStatus);
			map.put("'r'", 1);
		}
	}

}
