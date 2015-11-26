package com.singbon.controller.systemManager.systemSetting;

import java.io.PrintWriter;
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
import com.singbon.entity.OrderTime;
import com.singbon.service.systemManager.systemSetting.OrderTimeService;
import com.singbon.util.StringUtil;

/**
 * 订餐时间段控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/orderTime")
public class OrderTimeController extends BaseController {

	@Autowired
	public OrderTimeService orderTimeService;

	/**
	 * 保存修改
	 * 
	 * @param orderTime
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute OrderTime orderTime, String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (status != null) {
				orderTime.setEnable(true);
			}
			this.orderTimeService.update(orderTime);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param orderTime
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<OrderTime> orderTimeList = (List<OrderTime>) this.orderTimeService.selectListByCompanyId(company.getId());
		if (orderTimeList.size() == 0) {
			this.orderTimeService.insert(company.getId());
			orderTimeList = (List<OrderTime>) this.orderTimeService.selectListByCompanyId(company.getId());
		}
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}

	/**
	 * 列表
	 * 
	 * @param OrderTime
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list.do")
	public String list(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<OrderTime> list = (List<OrderTime>) this.orderTimeService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
