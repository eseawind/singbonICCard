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
import com.singbon.entity.CardRecord;
import com.singbon.entity.Company;
import com.singbon.entity.Pagination;
import com.singbon.entity.SysUser;
import com.singbon.service.CommonService;
import com.singbon.service.SysUserService;
import com.singbon.util.DesUtil;
import com.singbon.util.ExportUtil;
import com.singbon.util.StringUtil;

/**
 * 卡操作记录查询控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/balanceCenter/cardRecord")
public class CardRecordController extends BaseController {

	@Autowired
	public CommonService commonService;
	@Autowired
	public SysUserService sysUserService;

	private List<SysUser> sysUserList = null;

	/**
	 * 通用导航到各模块首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("company", company);
		sysUserList = (List<SysUser>) this.sysUserService.selectCashierList(company.getId());
		for (SysUser sysUser : sysUserList) {
			sysUser.setLoginName(DesUtil.decrypt(sysUser.getLoginName()));
		}
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return url.replace(".do", "");
	}

	/**
	 * 列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/detailList.do")
	public String detailList(@ModelAttribute Pagination pagination, Integer export, Integer exportType, Integer queryType, Integer operId, Integer recordType, String beginDate, String endDate,
			String includeOff, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		if (exportType != null && 1 == exportType) {
			pagination.setPageNum(1);
			pagination.setNumPerPage(pagination.getTotalCount());
		}

		String[] columns = { "o.loginName", "u.username", "u.userNO", "c.cardNO", "c.cardSN", "c.recordType", "c.opFare", "c.opTime" };
		String fromSql = "cardRecord c left join user u on c.userId=u.userId left join sysUser o on c.operId=o.operId";
		String whereSql = "u.companyId=" + company.getId();

		if (!StringUtils.isEmpty(operId) && operId != 0) {
			whereSql += String.format(" and c.operId = %s", operId);
		}
		if (!StringUtils.isEmpty(recordType) && recordType != -1) {
			whereSql += String.format(" and c.recordType = %s", recordType);
		}

		if (!StringUtils.isEmpty(beginDate)) {
			whereSql += String.format(" and c.opTime >= '%s'", beginDate);
		}
		if (!StringUtils.isEmpty(endDate)) {
			whereSql += String.format(" and c.opTime <= '%s'", endDate);
		}
		if (StringUtils.isEmpty(includeOff)) {
			whereSql += " and u.status != 244";
		}

		List<Map> list = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(list.get(0).get("loginName").toString());
		list.remove(0);

		for (Map map : list) {
			map.put("recordTypeDes", CardRecord.recordTypes[StringUtil.objToInt(map.get("recordType"))]);
		}

		if (export != null && 1 == export) {
			String[] expColumns = { "出纳员姓名", "姓名", "编号", "卡号", "物理卡号", "操作类型", "操作额", "操作时间" };

			List<List<String>> exportList = new ArrayList<List<String>>();
			for (Map m : list) {
				List<String> list2 = new ArrayList<String>();

				list2.add(StringUtil.getString(m.get("loginName")));
				list2.add(StringUtil.getString(m.get("username")));
				list2.add(StringUtil.getString(m.get("userNO")));
				list2.add(StringUtil.getString(m.get("cardNO")));
				list2.add(StringUtil.getString(m.get("cardSN")));
				list2.add(StringUtil.getString(m.get("recordTypeDes")));
				list2.add(StringUtil.getString(m.get("opFare")));
				list2.add(StringUtil.getString(m.get("opTime")));
				exportList.add(list2);
			}

			ExportUtil.exportExcel("卡操作明细表", expColumns, exportList, response);
			return null;
		}

		model.addAttribute("list", list);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("queryType", queryType);
		model.addAttribute("operId", operId);
		model.addAttribute("recordType", recordType);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("includeOff", includeOff);
		model.addAttribute("sysUserList", sysUserList);
		model.addAttribute("recordTypes", CardRecord.recordTypes);

		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "detailList");
	}
}
