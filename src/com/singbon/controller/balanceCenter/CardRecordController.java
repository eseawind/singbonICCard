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
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute Pagination pagination, Integer export, Integer exportType, Integer queryType, Integer operId, Integer recordType, String beginDate, String endDate,
			String includeOff, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		if (queryType == null)
			queryType = 0;

		List<Map> list = null;

		String fromSql = "cardRecord c left join user u on c.userId=u.userId left join sysUser o on c.operId=o.operId";
		String whereSql = "u.companyId=" + company.getId();

		if (!StringUtils.isEmpty(operId) && operId != 0) {
			whereSql += String.format(" and c.operId = %s", operId);
		}
		if (queryType == 1 && !StringUtils.isEmpty(recordType) && recordType != -1) {
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

		// 统计查询
		if (queryType == 0) {
			String sql = String.format(
					"select o.loginName,sum(case recordType when 0 then opFare else 0 end) makeCardFare,count(case recordType when 0 then 1 else 0 end) makeCardCount,"
							+ "sum(case recordType when 1 then opFare else 0 end) getCardDeposit,sum(case recordType when 2 then opFare else 0 end) makeCardGiveFare,"
							+ "count(case recordType when 3 then 1 else 0 end) remakeCard,count(case recordType when 4 then 1 else 0 end) loss,"
							+ "count(case recordType when 0 then 1 else 0 end) unloss,sum(case recordType when 6 then opFare else 0 end) PCSaving,"
							+ "sum(case recordType when 7 then opFare else 0 end) PCSavingGiveFare,sum(case recordType when 8 then opFare else 0 end) PCTake,"
							+ "sum(case recordType when 9 then opFare else 0 end) backCardDepostFare,sum(case recordType when 10 then opFare else 0 end) posSubsidySaving,"
							+ "sum(case recordType when 11 then opFare else 0 end) posSubsidyClear,sum(case recordType when 12 then opFare else 0 end) waterSubsidySaving,"
							+ "sum(case recordType when 13 then opFare else 0 end) waterSubsidyClear,count(case recordType when 14 then 1 else 0 end) cardOff from %s where %s group by c.operId",
					fromSql, whereSql);
			list = this.commonService.selectBySql(sql);
			for (Map map : list) {
				map.put("loginName", DesUtil.decrypt(StringUtil.objToString(map.get("loginName"))));
				map.put("makeCardFare", StringUtil.objToInt(map.get("makeCardFare")) / 100);
				map.put("getCardDeposit", StringUtil.objToInt(map.get("getCardDeposit")) / 100);
				map.put("makeCardGiveFare", StringUtil.objToInt(map.get("makeCardGiveFare")) / 100);
				map.put("PCSaving", StringUtil.objToInt(map.get("PCSaving")) / 100);
				map.put("PCSavingGiveFare", StringUtil.objToInt(map.get("PCSavingGiveFare")) / 100);
				map.put("PCTake", StringUtil.objToInt(map.get("PCTake")) / 100);
				map.put("backCardDepostFare", StringUtil.objToInt(map.get("backCardDepostFare")) / 100);
				map.put("posSubsidySaving", StringUtil.objToInt(map.get("posSubsidySaving")) / 100);
				map.put("posSubsidyClear", StringUtil.objToInt(map.get("posSubsidyClear")) / 100);
				map.put("waterSubsidySaving", StringUtil.objToInt(map.get("waterSubsidySaving")) / 100);
				map.put("waterSubsidyClear", StringUtil.objToInt(map.get("waterSubsidyClear")) / 100);
			}
			if (export != null && 1 == export) {
				String[] expColumns = { "出纳员", "发卡金额", "发卡数量", "收取卡押金", "发卡赠送金额", "补卡", "挂失", "解挂", "PC存款", "存款赠送金额", "PC取款", "退还卡押金", "消费机补助存款", "消费机补助清零", "水控补助存款", "水控补助清零", "卡注销" };

				List<List<String>> exportList = new ArrayList<List<String>>();
				for (Map m : list) {
					List<String> list2 = new ArrayList<String>();
					list2.add(StringUtil.objToString(m.get("loginName")));
					list2.add(StringUtil.objToString(m.get("makeCardFare")));
					list2.add(StringUtil.objToString(m.get("makeCardCount")));
					list2.add(StringUtil.objToString(m.get("getCardDeposit")));
					list2.add(StringUtil.objToString(m.get("makeCardGiveFare")));
					list2.add(StringUtil.objToString(m.get("remakeCard")));
					list2.add(StringUtil.objToString(m.get("loss")));
					list2.add(StringUtil.objToString(m.get("unloss")));
					list2.add(StringUtil.objToString(m.get("PCSaving")));
					list2.add(StringUtil.objToString(m.get("PCSavingGiveFare")));
					list2.add(StringUtil.objToString(m.get("PCTake")));
					list2.add(StringUtil.objToString(m.get("backCardDepostFare")));
					list2.add(StringUtil.objToString(m.get("posSubsidySaving")));
					list2.add(StringUtil.objToString(m.get("posSubsidyClear")));
					list2.add(StringUtil.objToString(m.get("waterSubsidySaving")));
					list2.add(StringUtil.objToString(m.get("waterSubsidyClear")));
					list2.add(StringUtil.objToString(m.get("cardOff")));
					exportList.add(list2);
				}

				ExportUtil.exportExcel("卡操作统计表", expColumns, exportList, response);
				return null;
			}
		} else {
			if (exportType != null && 1 == exportType) {
				pagination.setPageNum(1);
				pagination.setNumPerPage(pagination.getTotalCount());
			}
			String[] columns = { "o.loginName", "u.username", "u.userNO", "c.cardNO", "c.cardSN", "c.recordType", "c.opFare", "c.oddFare", "c.subsidyOddFare", "c.cardOddFare", "c.cardSubsidyOddFare",
					"c.opTime" };

			list = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
			int totalCount = Integer.valueOf(list.get(0).get("loginName").toString());
			list.remove(0);

			for (Map map : list) {
				map.put("loginName", DesUtil.decrypt(StringUtil.objToString(map.get("loginName"))));
				map.put("opFare", StringUtil.objToInt(map.get("opFare")) / 100);
				map.put("oddFare", StringUtil.objToInt(map.get("oddFare")) / 100);
				map.put("subsidyOddFare", StringUtil.objToInt(map.get("subsidyOddFare")) / 100);
				map.put("cardOddFare", StringUtil.objToInt(map.get("cardOddFare")) / 100);
				map.put("cardSubsidyOddFare", StringUtil.objToInt(map.get("cardSubsidyOddFare")) / 100);

				map.put("recordTypeDes", CardRecord.recordTypes[StringUtil.objToInt(map.get("recordType"))]);
			}

			if (export != null && 1 == export) {
				String[] expColumns = { "出纳员姓名", "姓名", "编号", "卡号", "物理卡号", "操作类型", "操作额", "操作时间" };

				List<List<String>> exportList = new ArrayList<List<String>>();
				for (Map m : list) {
					List<String> list2 = new ArrayList<String>();

					list2.add(StringUtil.objToString(m.get("loginName")));
					list2.add(StringUtil.objToString(m.get("username")));
					list2.add(StringUtil.objToString(m.get("userNO")));
					list2.add(StringUtil.objToString(m.get("cardNO")));
					list2.add(StringUtil.objToString(m.get("cardSN")));
					list2.add(StringUtil.objToString(m.get("recordTypeDes")));
					list2.add(StringUtil.objToString(m.get("opFare")));
					list2.add(StringUtil.objToString(m.get("opTime")));
					exportList.add(list2);
				}

				ExportUtil.exportExcel("卡操作明细表", expColumns, exportList, response);
				return null;
			}
			model.addAttribute("pageNum", pagination.getPageNum());
			model.addAttribute("numPerPage", pagination.getNumPerPage());
			model.addAttribute("totalCount", totalCount);
		}

		model.addAttribute("list", list);
		model.addAttribute("queryType", queryType);
		model.addAttribute("operId", operId);
		model.addAttribute("recordType", recordType);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("includeOff", includeOff);
		model.addAttribute("sysUserList", sysUserList);
		model.addAttribute("recordTypes", CardRecord.recordTypes);

		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "list");
	}
}
