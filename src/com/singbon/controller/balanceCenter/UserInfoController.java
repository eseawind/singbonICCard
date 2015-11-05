package com.singbon.controller.balanceCenter;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.controller.BaseController;
import com.singbon.entity.Company;
import com.singbon.entity.Pagination;
import com.singbon.entity.UserDept;
import com.singbon.service.CommonService;
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
	public UserDeptService userDeptService;
	@Autowired
	public CommonService commonService;

	/**
	 * 列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute Pagination pagination, Integer export, Integer exportType, String nameStr, Integer deptId, String deptName, Integer cardTypeId, Integer sex, Integer status,
			Integer dateType, String beginDate, String endDate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		if (exportType != null && 1 == exportType) {
			pagination.setPageNum(1);
			pagination.setNumPerPage(pagination.getTotalCount());
		}

		String[] columns = { "userId", "userNO", "username", "sex", "cardID", "cardTypeId", "status" };
		String fromSql = "user";
		String whereSql = "companyId=" + company.getId();
		if (!StringUtils.isEmpty(nameStr)) {
			whereSql += String.format(" and (userNO like '%%%s%%' or username like '%%%s%%' or shortName like '%%%s%%')", nameStr, nameStr, nameStr);
		}
		if (!StringUtils.isEmpty(deptId)) {
			whereSql += String.format(" and deptId = %s", deptId);
		}
		if (!StringUtils.isEmpty(cardTypeId) && cardTypeId != -1) {
			whereSql += String.format(" and cardTypeId = %s", cardTypeId);
		}
		if (!StringUtils.isEmpty(sex) && sex != -1) {
			whereSql += String.format(" and sex = %s", sex);
		}
		if (!StringUtils.isEmpty(status)) {
			if (status != -1 && status != -2) {
				whereSql += String.format(" and status = %s", status);
			} else if (status == -2) {
				whereSql += " and status not in(0,241,243,244)";
			}
		}
		if (!StringUtils.isEmpty(dateType) && dateType != -1) {
			String dateColumn = "cardMakeDate";
			if (dateType == 1) {
				dateColumn = "invalidDate";
			}
			if (!StringUtils.isEmpty(beginDate)) {
				whereSql += String.format(" and %s >= '%s'", dateColumn, beginDate);
			}
			if (!StringUtils.isEmpty(endDate)) {
				whereSql += String.format(" and %s <= '%s'", dateColumn, endDate);
			}
		}

		List<Map> userList = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(userList.get(0).get("userId").toString());
		userList.remove(0);

		for (Map m : userList) {
			int sex2 = Integer.valueOf(m.get("sex").toString());
			if (sex2 == 0) {
				m.put("sexDesc", "男");
			} else {
				m.put("sexDesc", "女");
			}
			int status2 = Integer.valueOf(m.get("status").toString());
			String statusDesc = "";
			if (status2 == 0) {
				statusDesc = "未发卡";
			} else if (status2 == 241) {
				statusDesc = "正常";
			} else if (status2 == 243) {
				statusDesc = "挂失";
			} else if (status2 == 244) {
				statusDesc = "注销";
			} else {
				statusDesc = "异常卡";
			}
			m.put("statusDesc", statusDesc);
		}

		if (export != null && 1 == export) {
			String[] expColumns = { "用户名", "性别" };

			List<List<String>> list = new ArrayList<List<String>>();
			for (Map m : userList) {
				List<String> list2 = new ArrayList<String>();
				list2.add(m.get("username").toString());
				list2.add(m.get("statusDesc").toString());
				list.add(list2);
			}

			ExportUtil.exportExcel("用户信息表", expColumns, list, response);
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
