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
import com.singbon.entity.Cookbook;
import com.singbon.service.systemManager.systemSetting.CookbookService;
import com.singbon.util.StringUtil;

/**
 * 菜肴清单控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/cookbook")
public class CookbookController extends BaseController {

	@Autowired
	public CookbookService cookbookService;

	/**
	 * 保存修改
	 * 
	 * @param cookbook
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute Cookbook cookbook, String status, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (status != null) {
				cookbook.setEnable(true);
			}
			if (cookbook.getId() == null) {
				Integer maxCode = this.cookbookService.selectMaxCode(company.getId());
				cookbook.setCookbookCode(maxCode);
				cookbook.setCompanyId(company.getId());
				this.cookbookService.insert(cookbook);
			} else {
				this.cookbookService.update(cookbook);
			}
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param cookbook
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/list.do")
	public String cookbookList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Cookbook> list = this.cookbookService.selectList(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
