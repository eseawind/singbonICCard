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
import com.singbon.entity.WaterRateGroup;
import com.singbon.service.systemManager.systemSetting.WaterRateGroupService;
import com.singbon.util.StringUtil;

/**
 * 一控一水控费率控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/waterRateGroup")
public class WaterRateGroupController extends BaseController {

	@Autowired
	public WaterRateGroupService waterRateGroupService;

	/**
	 * 保存修改
	 * 
	 * @param waterRateGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/save.do")
	public void save(@ModelAttribute WaterRateGroup waterRateGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String rate1CardTypes = "," + waterRateGroup.getRate1CardTypes() + ",";
			String tempRate1CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate1CardTypes.indexOf("," + i + ",") != -1) {
					tempRate1CardTypes += i + ",";
				}
			}
			tempRate1CardTypes += ",";
			waterRateGroup.setRate1CardTypes(tempRate1CardTypes);
			
			String rate2CardTypes = "," + waterRateGroup.getRate2CardTypes() + ",";
			String tempRate2CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate2CardTypes.indexOf("," + i + ",") != -1) {
					tempRate2CardTypes += i + ",";
				}
			}
			tempRate2CardTypes += ",";
			waterRateGroup.setRate2CardTypes(tempRate2CardTypes);

			String rate3CardTypes = "," + waterRateGroup.getRate3CardTypes() + ",";
			String tempRate3CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate3CardTypes.indexOf("," + i + ",") != -1) {
					tempRate3CardTypes += i + ",";
				}
			}
			tempRate3CardTypes += ",";
			waterRateGroup.setRate3CardTypes(tempRate3CardTypes);

			String rate4CardTypes = "," + waterRateGroup.getRate4CardTypes() + ",";
			String tempRate4CardTypes = ",";
			for (int i = 0; i < 16; i++) {
				if (rate4CardTypes.indexOf("," + i + ",") != -1) {
					tempRate4CardTypes += i + ",";
				}
			}
			tempRate4CardTypes += ",";
			waterRateGroup.setRate4CardTypes(tempRate4CardTypes);

			this.waterRateGroupService.update(waterRateGroup);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 添加修改
	 * 
	 * @param waterRateGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute WaterRateGroup waterRateGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (waterRateGroup.getId() == null) {
				Integer id = this.waterRateGroupService.insert(company.getId(), waterRateGroup.getGroupName());
				p.print(id);
			} else {
				this.waterRateGroupService.update(waterRateGroup);
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 编辑
	 * 
	 * @param waterRateGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/edit.do")
	public String edit(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		WaterRateGroup waterRateGroup = (WaterRateGroup) this.waterRateGroupService.selectById(id);
		model.addAttribute("waterRateGroup", waterRateGroup);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/edit.do", ""));
		return StringUtil.requestPath(request, "edit");
	}

	/**
	 * 查询分组列表
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/list.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<WaterRateGroup> list = (List<WaterRateGroup>) this.waterRateGroupService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/list.do", ""));
		return StringUtil.requestPath(request, "list");
	}

	/**
	 * 删除
	 * 
	 * @param waterRateGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/delete.do")
	public void delete(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			int count = this.waterRateGroupService.selectCountWithPos(id);
			if (count > 0) {
				p.print(2);
			} else {
				this.waterRateGroupService.delete(id);
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}
}
