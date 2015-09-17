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
import com.singbon.entity.MultiWaterRate;
import com.singbon.service.systemManager.systemSetting.MultiWaterRateService;
import com.singbon.util.StringUtil;

/**
 * 一控多水控费率控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/multiWaterRate")
public class MultiWaterRateController extends BaseController {

	@Autowired
	public MultiWaterRateService multiWaterRateService;

	/**
	 * 保存修改
	 * 
	 * @param multiWaterRate
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute MultiWaterRate multiWaterRate, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.multiWaterRateService.update(multiWaterRate);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param multiWaterRate
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		MultiWaterRate multiWaterRate = this.multiWaterRateService.selectByCompanyId(company.getId());
		if (multiWaterRate == null) {
			this.multiWaterRateService.insert(company.getId());
			multiWaterRate = this.multiWaterRateService.selectByCompanyId(company.getId());
		}
		model.addAttribute("multiWaterRate", multiWaterRate);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}
}
