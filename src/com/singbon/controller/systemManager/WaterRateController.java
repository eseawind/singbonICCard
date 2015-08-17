package com.singbon.controller.systemManager;

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
import com.singbon.entity.WaterRate;
import com.singbon.service.systemManager.WaterRateService;
import com.singbon.util.StringUtil;

/**
 * 水控费率2、3、4控制类
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
			String authCard = "," + waterRate.getAuthCard() + ",";
			String tempAuthCard = "";
			for (int i = 0; i < 16; i++) {
				if (authCard.indexOf("," + i + ",") != -1) {
					tempAuthCard += "1";
				} else {
					tempAuthCard += "0";
				}
			}
			waterRate.setAuthCard(tempAuthCard);
			this.waterRateService.update(waterRate);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param waterRate
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/list.do")
	public String waterRateList(HttpServletRequest request, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		List<WaterRate> list = this.waterRateService.selectList(company.getId());
		if (list.size() == 0) {
			this.waterRateService.insert(company.getId());
			list = this.waterRateService.selectList(company.getId());
		}
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
