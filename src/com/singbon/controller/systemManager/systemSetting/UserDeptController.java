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

import com.singbon.entity.Batch;
import com.singbon.entity.Company;
import com.singbon.entity.UserDept;
import com.singbon.service.systemManager.systemSetting.BatchService;
import com.singbon.service.systemManager.systemSetting.UserDeptService;
import com.singbon.util.StringUtil;

/**
 * 人员部门控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/userDept")
public class UserDeptController {

	@Autowired
	public UserDeptService userDeptService;
	@Autowired
	public BatchService batchService;

	/**
	 * 添加修改
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute UserDept userDept, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		userDept.setCompanyId(company.getId());

		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (userDept.getId() == null) {
				this.userDeptService.save(userDept);
			} else {
				this.userDeptService.update(userDept);
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
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/delete.do")
	public void delete(HttpServletRequest request, HttpServletResponse response, Model model, Integer id) {

		PrintWriter p = null;
		try {
			p = response.getWriter();

			List list = this.userDeptService.selectByParentId(id);
			if (list.size() > 0) {
				p.print(2);
				return;
			}
			this.userDeptService.delete(id);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 人员部门树列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = this.userDeptService.selectTreeList(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "userDeptTreeList");
	}

	/**
	 * 人员部门列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/list.do")
	public String list(Integer parentId, HttpServletRequest request, Model model) {
		List list = this.userDeptService.selectByParentId(parentId);
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "userDeptList");
	}

	/**
	 * 人员部门首页
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<Batch> list = this.batchService.selectList(company.getId());
		model.addAttribute("batchList", list);
		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "index");
	}

}
