package com.singbon.controller.systemManager;

import java.io.PrintWriter;
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
import com.singbon.entity.Discount;
import com.singbon.entity.Pagination;
import com.singbon.entity.SysUser;
import com.singbon.entity.UserDept;
import com.singbon.service.CommonService;
import com.singbon.service.systemManager.SubsidyService;
import com.singbon.service.systemManager.systemSetting.DiscountService;
import com.singbon.service.systemManager.systemSetting.UserDeptService;
import com.singbon.util.StringUtil;

/**
 * 补助控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/subsidy")
public class SubsidyController extends BaseController {

	@Autowired
	public UserDeptService userDeptService;
	@Autowired
	public CommonService commonService;
	@Autowired
	public DiscountService discountService;
	@Autowired
	public SubsidyService subsidyService;

	/**
	 * 添加补助首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addIndex.do")
	public String addIndex(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> userDeptList = ((List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId()));

		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		model.addAttribute("base", "/systemManager/subsidy");
		model.addAttribute("userDeptList", userDeptList);
		return "/systemManager/subsidy/addIndex";
	}

	/**
	 * 用户列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	@RequestMapping(value = "/userList.do")
	public String list(@ModelAttribute Pagination pagination, String nameStr, String deptIds, String deptName, Integer cardTypeId, Integer cardIdentity, Integer sex, Integer autoSubsidyFare,
			Integer subsidyFare, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "userId", "userNO", "username", "sex", "cardID", "cardTypeId", "status" };
		String fromSql = "user";
		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);

		List<Map> userList = this.commonService.selectByPage(columns, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(userList.get(0).get("count").toString());
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

		if (!StringUtils.isEmpty(autoSubsidyFare)) {
			model.addAttribute("auto", autoSubsidyFare);
			List<Discount> discountList = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
			for (Map m : userList) {
				int cardTypeId2 = Integer.valueOf(m.get("cardTypeId").toString());
				m.put("subsidyFare", discountList.get(cardTypeId2).getSubsidy());
			}
		} else {
			if (StringUtils.isEmpty(subsidyFare)) {
				subsidyFare = 0;
			}
			model.addAttribute("subsidyFare", subsidyFare);
			for (Map m : userList) {
				m.put("subsidyFare", subsidyFare);
			}
		}

		model.addAttribute("list", userList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptName", deptName);
		model.addAttribute("cardTypeId", cardTypeId);
		model.addAttribute("cardIdentity", cardIdentity);
		model.addAttribute("sex", sex);
		model.addAttribute("autoSubsidyFare", autoSubsidyFare);
		model.addAttribute("subsidyFare", subsidyFare);

		model.addAttribute("base", "/systemManager/subsidy");
		return "/systemManager/subsidy/userList";
	}

	/**
	 * 添加补助准备
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	@RequestMapping(value = "/addSubsidy.do")
	public void addSubsidy(String nameStr, String deptIds, String deptName, Integer cardTypeId, Integer cardIdentity, Integer sex, Integer autoSubsidyFare, Integer subsidyFare,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);
		String fullSql = "select userId,cardTypeId from user where " + whereSql;

		List<Map> userList = this.commonService.selectBySql(fullSql);

		if (!StringUtils.isEmpty(autoSubsidyFare)) {
			model.addAttribute("auto", autoSubsidyFare);
			List<Discount> discountList = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
			for (Map m : userList) {
				int cardTypeId2 = Integer.valueOf(m.get("cardTypeId").toString());
				m.put("subsidyFare", discountList.get(cardTypeId2).getSubsidy());
			}
		} else {
			if (StringUtils.isEmpty(subsidyFare)) {
				subsidyFare = 0;
			}
			model.addAttribute("subsidyFare", subsidyFare);
			for (Map m : userList) {
				m.put("subsidyFare", subsidyFare);
			}
		}
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.subsidyService.addSubsidy(company.getId(), userList);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
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

	private String getWhereSql(String nameStr, String deptIds, Integer cardTypeId, Integer cardIdentity, Integer sex, Company company) {
		String whereSql = "companyId=" + company.getId();
		if (!StringUtils.isEmpty(nameStr)) {
			whereSql += String.format(" and (userNO like '%%%s%%' or username like '%%%s%%' or shortName like '%%%s%%')", nameStr, nameStr, nameStr);
		}

		if (!StringUtils.isEmpty(deptIds)) {
			whereSql += String.format(" and deptId in (%s)", deptIds.substring(0, deptIds.length() - 1));
		}
		if (!StringUtils.isEmpty(cardTypeId) && cardTypeId != -1) {
			whereSql += String.format(" and cardTypeId = %s", cardTypeId);
		}
		if (!StringUtils.isEmpty(cardIdentity) && cardIdentity != -1) {
			whereSql += String.format(" and cardIdentity = %s", cardIdentity);
		}
		if (!StringUtils.isEmpty(sex) && sex != -1) {
			whereSql += String.format(" and sex = %s", sex);
		}
		return whereSql;
	}

	/**
	 * 生成补助首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/generateIndex.do")
	public String generateIndex(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> userDeptList = ((List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId()));

		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		model.addAttribute("base", "/systemManager/subsidy");
		model.addAttribute("userDeptList", userDeptList);
		return "/systemManager/subsidy/generateIndex";
	}

	/**
	 * 补助用户列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	@RequestMapping(value = "/subsidyUserList.do")
	public String subsidyUserList(@ModelAttribute Pagination pagination, String nameStr, String deptIds, String deptName, Integer cardTypeId, Integer cardIdentity, Integer sex,
			Integer autoSubsidyFare, Integer subsidyFare, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "userId", "userNO", "username", "sex", "cardID", "cardTypeId", "status" };
		String fromSql = "user";
		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);

		List<Map> userList = this.commonService.selectByPage(columns, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(userList.get(0).get("count").toString());
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

		if (!StringUtils.isEmpty(autoSubsidyFare)) {
			model.addAttribute("auto", autoSubsidyFare);
			List<Discount> discountList = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
			for (Map m : userList) {
				int cardTypeId2 = Integer.valueOf(m.get("cardTypeId").toString());
				m.put("subsidyFare", discountList.get(cardTypeId2).getSubsidy());
			}
		} else {
			if (StringUtils.isEmpty(subsidyFare)) {
				subsidyFare = 0;
			}
			model.addAttribute("subsidyFare", subsidyFare);
			for (Map m : userList) {
				m.put("subsidyFare", subsidyFare);
			}
		}

		model.addAttribute("list", userList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptName", deptName);
		model.addAttribute("cardTypeId", cardTypeId);
		model.addAttribute("cardIdentity", cardIdentity);
		model.addAttribute("sex", sex);
		model.addAttribute("autoSubsidyFare", autoSubsidyFare);
		model.addAttribute("subsidyFare", subsidyFare);

		model.addAttribute("base", "/systemManager/subsidy");
		return "/systemManager/subsidy/subsidyUserList";
	}
}
