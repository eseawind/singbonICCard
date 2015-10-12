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
import com.singbon.entity.PosParamGroup;
import com.singbon.service.systemManager.systemSetting.PosParamGroupService;
import com.singbon.util.StringUtil;

/**
 * 消费机参数组设置控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/posParamGroup")
public class PosParamGroupController extends BaseController {

	@Autowired
	public PosParamGroupService posParamGroupService;

	/**
	 * 添加修改
	 * 
	 * @param posParamGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute PosParamGroup posParamGroup, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (posParamGroup.getId() == null) {
				Integer id = this.posParamGroupService.insert(company.getId(), posParamGroup.getGroupName());
				p.print(id);
			} else {
				this.posParamGroupService.update(posParamGroup);
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
	 * @param posParamGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/edit.do")
	public String edit(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		PosParamGroup posParamGroup = (PosParamGroup) this.posParamGroupService.selectById(id);
		model.addAttribute("posParamGroup", posParamGroup);
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
		List<PosParamGroup> list = (List<PosParamGroup>) this.posParamGroupService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/list.do", ""));
		return StringUtil.requestPath(request, "list");
	}
	
	/**
	 * 删除
	 * 
	 * @param posParamGroup
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/delete.do")
	public void delete(Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			int count=this.posParamGroupService.selectCountWithPos(id);
			if(count>0){
				p.print(2);
			}else{
				this.posParamGroupService.delete(id);
				p.print(1);				
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}
}
