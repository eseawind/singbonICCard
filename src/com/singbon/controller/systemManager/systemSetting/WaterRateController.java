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
import com.singbon.entity.WaterRate;
import com.singbon.service.systemManager.systemSetting.WaterRateService;
import com.singbon.util.StringUtil;

/**
 * 一控一水控费率控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/waterRate")
public class WaterRateController extends BaseController {

	@Autowired
	public WaterRateService waterRateService;

	/**
	 * 保存修改
	 * 
	 * @param waterRate
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute WaterRate waterRate, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String rate2CardTypes = "," + waterRate.getRate2CardTypes() + ",";
			String tempRate2CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate2CardTypes.indexOf("," + i + ",") != -1) {
					tempRate2CardTypes += i + ",";
				}
			}
			tempRate2CardTypes += ",";
			waterRate.setRate2CardTypes(tempRate2CardTypes);

			String rate3CardTypes = "," + waterRate.getRate3CardTypes() + ",";
			String tempRate3CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate3CardTypes.indexOf("," + i + ",") != -1) {
					tempRate3CardTypes += i + ",";
				}
			}
			tempRate3CardTypes += ",";
			waterRate.setRate3CardTypes(tempRate3CardTypes);

			String rate4CardTypes = "," + waterRate.getRate4CardTypes() + ",";
			String tempRate4CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate4CardTypes.indexOf("," + i + ",") != -1) {
					tempRate4CardTypes += i + ",";
				}
			}
			tempRate4CardTypes += ",";
			waterRate.setRate4CardTypes(tempRate4CardTypes);

			this.waterRateService.update(waterRate);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param waterRate
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		WaterRate waterRate = this.waterRateService.selectByCompanyId(company.getId());
		if (waterRate == null) {
			this.waterRateService.insert(company.getId());
			waterRate = this.waterRateService.selectByCompanyId(company.getId());
		}
		model.addAttribute("waterRate", waterRate);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}
}
