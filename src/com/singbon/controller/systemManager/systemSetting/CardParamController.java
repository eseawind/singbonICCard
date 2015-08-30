package com.singbon.controller.systemManager.systemSetting;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.singbon.controller.BaseController;
import com.singbon.entity.CardParam;
import com.singbon.entity.Company;
import com.singbon.service.systemManager.systemSetting.CardParamService;
import com.singbon.util.StringUtil;

/**
 * 制卡参数设置控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/cardParam")
public class CardParamController extends BaseController {

	@Autowired
	public CardParamService cardParamService;

	/**
	 * 保存修改
	 * 
	 * @param CardParam
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute CardParam CardParam, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.cardParamService.update(CardParam);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param CardParam
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		CardParam cardParam = this.cardParamService.selectByCompanyId(company.getId());
		if (cardParam == null) {
			this.cardParamService.insert(company.getId());
			cardParam = this.cardParamService.selectByCompanyId(company.getId());
		}
		model.addAttribute("cardParam", cardParam);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}

}
