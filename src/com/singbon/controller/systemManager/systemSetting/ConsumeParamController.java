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
import com.singbon.entity.ConsumeParam;
import com.singbon.service.systemManager.systemSetting.ConsumeParamService;
import com.singbon.util.StringUtil;

/**
 * 消费参数设置控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/consumeParam")
public class ConsumeParamController extends BaseController {

	@Autowired
	public ConsumeParamService consumeParamService;

	/**
	 * 保存修改
	 * 
	 * @param consumeParam
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute ConsumeParam consumeParam, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String cardMinFareCardTypes = "," + consumeParam.getCardMinFareCardTypes() + ",";
			String tempCardMinFareCardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (cardMinFareCardTypes.indexOf("," + i + ",") != -1) {
					tempCardMinFareCardTypes += i+",";
				}
			}
			tempCardMinFareCardTypes += ",";
			consumeParam.setCardMinFareCardTypes(tempCardMinFareCardTypes);

			String dayLimitFareCardTypes = "," + consumeParam.getDayLimitFareCardTypes() + ",";
			String tempDayLimitFareCardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (dayLimitFareCardTypes.indexOf("," + i + ",") != -1) {
					tempDayLimitFareCardTypes += i+",";
				}
			}
			tempDayLimitFareCardTypes += ",";
			consumeParam.setDayLimitFareCardTypes(tempDayLimitFareCardTypes);

			String timeLimitFareCardTypes = "," + consumeParam.getTimeLimitFareCardTypes() + ",";
			String tempTimeLimitFareCardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (timeLimitFareCardTypes.indexOf("," + i + ",") != -1) {
					tempTimeLimitFareCardTypes += i+",";
				}
			}
			tempTimeLimitFareCardTypes += ",";
			consumeParam.setTimeLimitFareCardTypes(tempTimeLimitFareCardTypes);

			this.consumeParamService.update(consumeParam);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 首页
	 * 
	 * @param consumeParam
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		ConsumeParam consumeParam = this.consumeParamService.selectByCompanyId(company.getId());
		if (consumeParam == null) {
			this.consumeParamService.insert(company.getId());
			consumeParam = this.consumeParamService.selectByCompanyId(company.getId());
		}
		model.addAttribute("consumeParam", consumeParam);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return StringUtil.requestPath(request, "index");
	}

}
