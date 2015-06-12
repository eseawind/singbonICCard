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
import com.singbon.entity.AuthGroup;
import com.singbon.entity.Batch;
import com.singbon.entity.Company;
import com.singbon.entity.SysUser;
import com.singbon.service.systemManager.AuthorizationService;
import com.singbon.util.StringUtil;

/**
 * 授权分组控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/userRoles/group")
public class AuthGroupController extends BaseController {

	@Autowired
	public AuthorizationService authorizationService;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		model.addAttribute("base", StringUtil.requestPath(request, "group"));

		return StringUtil.requestPath(request, "group/index");
	}

	/**
	 * 添加修改
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEditBatch.do")
	public void addEditBatch(@ModelAttribute Batch batch, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		batch.setCompanyId(company.getId());

		PrintWriter p = null;
		try {
			p = response.getWriter();
			if (batch.getId() == null) {
				// this.batchService.save(batch);
			} else {
				// this.batchService.update(batch);
			}
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/list.do")
	public String list(HttpServletRequest request, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		List<AuthGroup> list = this.authorizationService.selectGroup(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "group/list");
	}

}
