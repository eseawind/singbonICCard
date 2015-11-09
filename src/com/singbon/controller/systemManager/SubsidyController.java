package com.singbon.controller.systemManager;

import java.io.IOException;
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
import com.singbon.entity.Subsidy;
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
			Float subsidyFare, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "userId", "userNO", "username", "sex", "cardID", "cardTypeId", "status" };
		String fromSql = "user u";
		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);

		List<Map> userList = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = StringUtil.objToInt(userList.get(0).get("userId"));
		userList.remove(0);

		for (Map m : userList) {
			int sex2 = StringUtil.objToInt(m.get("sex"));
			if (sex2 == 0) {
				m.put("sexDesc", "男");
			} else {
				m.put("sexDesc", "女");
			}
			int status2 = StringUtil.objToInt(m.get("status"));
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
				int cardTypeId2 = StringUtil.objToInt(m.get("cardTypeId"));
				m.put("subsidyFare", discountList.get(cardTypeId2).getSubsidy());
			}
		} else {
			if (StringUtils.isEmpty(subsidyFare)) {
				subsidyFare = (float) 0;
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
	public void addSubsidy(String nameStr, String deptIds, String deptName, Integer cardTypeId, Integer cardIdentity, Integer sex, Integer autoSubsidyFare, Float subsidyFare,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		int count = this.subsidyService.selectCountByCompanyId(company.getId());
		if (count > 0) {
			p.print(2);
			return;
		}

		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);
		String fullSql = "select userId,cardTypeId from user u where " + whereSql;

		List<Map> userList = this.commonService.selectBySql(fullSql);

		if (!StringUtils.isEmpty(autoSubsidyFare)) {
			model.addAttribute("auto", autoSubsidyFare);
			List<Discount> discountList = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
			for (Map m : userList) {
				int cardTypeId2 = StringUtil.objToInt(m.get("cardTypeId"));
				m.put("subsidyFare", discountList.get(cardTypeId2).getSubsidy());
			}
		} else {
			if (StringUtils.isEmpty(subsidyFare)) {
				subsidyFare = (float) 0;
			}
			model.addAttribute("subsidyFare", subsidyFare);
			for (Map m : userList) {
				m.put("subsidyFare", subsidyFare);
			}
		}
		try {
			this.subsidyService.addSubsidy(company.getId(), userList);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
	}

	private String getWhereSql(String nameStr, String deptIds, Integer cardTypeId, Integer cardIdentity, Integer sex, Company company) {
		String whereSql = "u.companyId=" + company.getId();
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
			HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "s.id", "userNO", "username", "sex", "cardID", "cardTypeId", "s.status", "subsidyFare" };
		String fromSql = "user u,subsidy s ";
		String whereSql = getWhereSql(nameStr, deptIds, cardTypeId, cardIdentity, sex, company);
		whereSql = " u.userId=s.userId and " + whereSql;
		List<Map> userList = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = StringUtil.objToInt(userList.get(0).get("id"));
		userList.remove(0);

		for (Map m : userList) {
			int sex2 = StringUtil.objToInt(m.get("sex"));
			if (sex2 == 0) {
				m.put("sexDesc", "男");
			} else {
				m.put("sexDesc", "女");
			}
			int status2 = StringUtil.objToInt(m.get("status"));
			String statusDesc = "";
			if (status2 == 0) {
				statusDesc = "未生成";
			} else if (status2 == 1) {
				statusDesc = "未领取";
			} else if (status2 == 2) {
				statusDesc = "已领取";
			}
			m.put("statusDesc", statusDesc);
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

		model.addAttribute("base", "/systemManager/subsidy");
		return "/systemManager/subsidy/subsidyUserList";
	}

	/**
	 * 修改补助金额
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/edit.do")
	public void edit(Integer id, float subsidyFare, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			Subsidy subsidy = new Subsidy();
			subsidy.setId(id);
			subsidy.setSubsidyFare(subsidyFare);
			this.subsidyService.update(subsidy);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
	}

	/**
	 * 删除选中补助信息
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	public void delete(String checkedIds, HttpServletRequest request, HttpServletResponse response, Model model) {
		if (StringUtils.isEmpty(checkedIds))
			return;
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String[] ids = checkedIds.split(",");
			this.subsidyService.delete(ids);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
	}

	/**
	 * 生成补助信息
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/generateSubsidy.do")
	public void generateSubsidy(String invalidDate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			int count = this.subsidyService.selectCountByCompanyId(company.getId());
			if (count > 0) {
				p.print(2);
				return;
			}
			this.subsidyService.generateSubsidy(company, invalidDate, request);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
			e.printStackTrace();
		}
	}
}
