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

import com.singbon.entity.Company;
import com.singbon.entity.Dept;
import com.singbon.service.systemManager.systemSetting.DeptService;
import com.singbon.util.StringUtil;

/**
 * 营业部门控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/dept")
public class DeptController {

	@Autowired
	public DeptService deptService;

	/**
	 * 添加修改
	 * 
	 * @param dept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute Dept dept, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		dept.setCompanyId(company.getId());

		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (dept.getId() == null) {
				this.deptService.insert(dept);
			} else {
				this.deptService.update(dept);
			}
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 删除
	 * 
	 * @param dept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/delete.do")
	public void delete(HttpServletRequest request, HttpServletResponse response, Model model, Integer id) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			List list = this.deptService.selectByParentId(company.getId(), id);
			if (list.size() > 0) {
				p.print(2);
				return;
			}
			this.deptService.delete(id);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param dept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/list.do")
	public String list(Integer parentId, HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List list = this.deptService.selectByParentId(company.getId(), parentId);
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

	/**
	 * 树形列表
	 * 
	 * @param dept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Dept> treeList = (List<Dept>) this.deptService.selectListByCompanyId(company.getId());
		model.addAttribute("treeList", treeList);
		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "treeList");
	}

}
