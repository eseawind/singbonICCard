package com.singbon.service.systemManager;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.CompanyDAO;
import com.singbon.dao.systemManager.SubsidyDAO;
import com.singbon.entity.Company;
import com.singbon.entity.Subsidy;
import com.singbon.service.BaseService;

/**
 * 补助管理业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SubsidyService extends BaseService {

	@Autowired
	public SubsidyDAO subsidyDAO;
	@Autowired
	public CompanyDAO companyDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return subsidyDAO;
	}

	/**
	 * 添加补助准备
	 * 
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public void addSubsidy(Integer companyId, List<Map> list) throws Exception {
		for (Map m : list) {
			Integer userId = Integer.valueOf(m.get("userId").toString());
			int count = this.subsidyDAO.selectCountByUserId(userId);
			if (count > 0)
				continue;

			Subsidy subsidy = new Subsidy();
			subsidy.setUserId(userId);
			subsidy.setCompanyId(companyId);
			subsidy.setSubsidyFare(Float.valueOf(m.get("subsidyFare").toString()));
			this.subsidyDAO.insert(subsidy);
		}
	}

	/**
	 * 查询生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	public Integer selectCountByCompanyId(Integer companyId) {
		return this.subsidyDAO.selectCountByCompanyId(companyId);
	}

	/**
	 * 生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void generateSubsidy(Company company, String invalidDate, HttpServletRequest request) throws Exception {
		int subsidyVersion = company.getSubsidyVersion();
		this.subsidyDAO.generateSubsidy(company.getId(), subsidyVersion, invalidDate);
		company.setSubsidyVersion(subsidyVersion + 1);
		company.setSubsidyInvalidDate(invalidDate);
		this.companyDAO.updateSubsidy(company);
		request.getSession().setAttribute("company", company);
	}
}