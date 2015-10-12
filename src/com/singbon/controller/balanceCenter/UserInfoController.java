package com.singbon.controller.balanceCenter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.controller.BaseController;
import com.singbon.entity.Company;
import com.singbon.entity.Pagination;
import com.singbon.entity.User;
import com.singbon.entity.UserDept;
import com.singbon.service.balanceCenter.UserInfoService;
import com.singbon.service.systemManager.systemSetting.UserDeptService;
import com.singbon.util.ExportUtil;
import com.singbon.util.StringUtil;

/**
 * 用户信息查询控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/balanceCenter/userInfo")
public class UserInfoController extends BaseController {

	@Autowired
	public UserInfoService userInfoService;
	@Autowired
	public UserDeptService userDeptService;

	/**
	 * 列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute Pagination pagination, Integer export, Integer exportType, String nameStr, Integer deptId,String deptName, Integer cardTypeId, Integer sex, Integer status, Integer dateType,
			String beginDate, String endDate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		if (exportType != null && 1 == exportType) {
			pagination.setPageNum(1);
			pagination.setNumPerPage(pagination.getTotalCount());
		}

		List<User> userList = this.userInfoService.selectByPage(company.getId(), pagination, nameStr, deptId, cardTypeId, sex, status, dateType, beginDate, endDate);
		int totalCount = userList.get(0).getUserId();
		userList.remove(0);

		if (export != null && 1 == export) {
			String[] columns = { "用户名", "性别" };

			List<List<String>> list = new ArrayList<List<String>>();
			for (User u : userList) {
				List<String> list2 = new ArrayList<String>();
				list2.add(u.getUsername());
				list2.add(u.getStatusDesc());
				list.add(list2);
			}

			ExportUtil.exportExcel("用户信息表", columns, list, response);
			return null;
		}

		model.addAttribute("list", userList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptId", deptId);
		model.addAttribute("deptName", deptName);
		model.addAttribute("cardTypeId", cardTypeId);
		model.addAttribute("sex", sex);
		model.addAttribute("status", status);
		model.addAttribute("dateType", dateType);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);

		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "list");
	}

	/**
	 * 人员部门树列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = (List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "userDeptTreeList");
	}
}
