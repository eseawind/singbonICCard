package com.singbon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.CompanyDAO;
import com.singbon.entity.Company;

/**
 * 公司业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CompanyService extends BaseService{

	@Autowired
	public CompanyDAO companyDAO;
	
	@Override
	public BaseDAO getBaseDAO() {
		return companyDAO;
	}
	
	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Company> selectAllList() {
		return this.companyDAO.selectAllList();
	}

	public int getSection(Integer companyId) {
		return 1;
	}
}
