package com.singbon.service.systemManager;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.SubsidyDAO;
import com.singbon.entity.Company;
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

	@Override
	public BaseDAO getBaseDAO() {
		return subsidyDAO;
	}

	/**
	 * 添加人员
	 * 
	 * @param list
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insert(Integer companyId, String[] userIds, Integer subsidyVersion, String invalidDate) throws Exception {
		this.subsidyDAO.insert(companyId, userIds, subsidyVersion, invalidDate);
	}

	/**
	 * 查询生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map selectSubsidyInfo(Integer companyId) {
		return this.subsidyDAO.selectSubsidyInfo(companyId);
	}

	/**
	 * 添加金额
	 * 
	 * @param list
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void addFare(Integer companyId, float subsidyFare) throws Exception {
		this.subsidyDAO.addFare(companyId, subsidyFare);
	}

	/**
	 * 自动生成金额
	 * 
	 * @param list
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void autoFare(Integer companyId) throws Exception {
		this.subsidyDAO.autoFare(companyId);
	}

	/**
	 * 生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void generateSubsidy(Company company, String invalidDate, HttpServletRequest request) throws Exception {
		int subsidyVersion = company.getSubsidyVersion() + 1;
		company.setSubsidyVersion(subsidyVersion);
		company.setSubsidyInvalidDate(invalidDate);
		this.subsidyDAO.generateSubsidy(company.getId(), subsidyVersion, invalidDate);

		request.getSession().setAttribute("company", company);
	}
}
