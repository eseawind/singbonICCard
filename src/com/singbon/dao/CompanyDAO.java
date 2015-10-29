package com.singbon.dao;

import java.util.List;

import com.singbon.entity.Company;

/**
 * 批次管理dao层
 * 
 * @author 郝威
 * 
 */
public interface CompanyDAO extends BaseDAO {

	/**
	 * 列表
	 * 
	 * @param obj
	 * @return
	 */
	public List<Company> selectCompanyList();

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Company> selectAllList();
	
	/**
	 * 更新补助版本号
	 * 
	 * @return
	 */
	public void updateSubsidy(Company company);
	
}
