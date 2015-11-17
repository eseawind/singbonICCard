package com.singbon.controller.cardManager;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.WaterRateGroup;
import com.singbon.service.mainCard.FuncCardService;
import com.singbon.service.systemManager.systemSetting.WaterRateGroupService;

/**
 * 功能卡制作控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager/funcCard")
public class FuncCardController extends BaseController {

	@Autowired
	public FuncCardService funcCardService;
	@Autowired
	public WaterRateGroupService waterRateGroupService;

	private List<WaterRateGroup> waterRateGroupList = null;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		this.waterRateGroupList = (List<WaterRateGroup>) this.waterRateGroupService.selectListByCompanyId(company.getId());

		if (device != null) {
			model.addAttribute("sn", device.getSn());
			// 读卡机状态
			if (TerminalManager.SNToSocketChannelList.containsKey(device.getSn())) {
				model.addAttribute("cardStatus", 1);
			} else {
				model.addAttribute("cardStatus", 0);
			}
		} else {
			model.addAttribute("cardStatus", 0);
		}

		String url = request.getRequestURI();
		model.addAttribute("waterRateGroupList", waterRateGroupList);
		model.addAttribute("base", url.replace("/index.do", ""));
		return url.replace(".do", "");
	}

	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/make.do", method = RequestMethod.POST)
	public void make(Integer waterRateGroupId, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		WaterRateGroup waterRateGroup = null;
		for (WaterRateGroup water : waterRateGroupList) {
			if (water.getId() == waterRateGroupId) {
				waterRateGroup = water;
				break;
			}
		}
		

	}

}
