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
import com.singbon.entity.Batch;
import com.singbon.entity.Company;
import com.singbon.service.systemManager.BatchService;
import com.singbon.util.StringUtil;

/**
 * 授权分组控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/batch")
public class UserRolesGroupController extends BaseController {

	@Autowired
	public BatchService batchService;

	/**
	 * 添加修改批次
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
				this.batchService.save(batch);
			} else {
				this.batchService.update(batch);
			}
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 批次列表
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/batchList.do")
	public String batchList(HttpServletRequest request, Model model) {

		Company company = (Company) request.getSession().getAttribute("company");
		List<Batch> list = this.batchService.selectList(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "batchList");
	}

}
