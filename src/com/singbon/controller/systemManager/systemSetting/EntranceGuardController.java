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
import com.singbon.entity.Company;
import com.singbon.entity.EntranceGuard;
import com.singbon.service.systemManager.systemSetting.EntranceGuardService;
import com.singbon.util.StringUtil;

/**
 * 门禁参数设置控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/entranceGuard")
public class EntranceGuardController extends BaseController {

	@Autowired
	public EntranceGuardService entranceGuardService;

	/**
	 * 保存修改
	 * 
	 * @param entranceGuard
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute EntranceGuard entranceGuard, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.entranceGuardService.update(entranceGuard);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param entranceGuard
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		EntranceGuard entranceGuard = this.entranceGuardService.selectByCompanyId(company.getId());
		if (entranceGuard == null) {
			this.entranceGuardService.insert(company.getId());
			entranceGuard = this.entranceGuardService.selectByCompanyId(company.getId());
		}
		model.addAttribute("entranceGuard", entranceGuard);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}
}
