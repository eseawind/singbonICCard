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
import com.singbon.entity.Batch;
import com.singbon.entity.Company;
import com.singbon.service.systemManager.systemSetting.BatchService;
import com.singbon.util.StringUtil;

/**
 * 批次控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/systemManager/systemSetting/batch")
public class BatchController extends BaseController {

	@Autowired
	public BatchService batchService;

	/**
	 * 添加修改
	 * 
	 * @param batch
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute Batch batch, HttpServletRequest request, HttpServletResponse response, Model model) {
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
			e.printStackTrace();
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
		List<Batch> list = this.batchService.selectList(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "list");
	}

}
