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
import com.singbon.entity.Discount;
import com.singbon.entity.Company;
import com.singbon.service.systemManager.systemSetting.DiscountService;
import com.singbon.util.StringUtil;

/**
 * 优惠方案控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/discount")
public class DiscountController extends BaseController {

	@Autowired
	public DiscountService discountService;

	/**
	 * 保存修改
	 * 
	 * @param Discount
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute Discount discount, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.discountService.update(discount);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param Discount
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list.do")
	public String discountList(HttpServletRequest request, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		List<Discount> list = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
		if (list.size() == 0) {
			this.discountService.insert(company.getId());
			list = (List<Discount>) this.discountService.selectListByCompanyId(company.getId());
		}
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
