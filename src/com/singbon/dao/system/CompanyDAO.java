package com.singbon.dao.system;

import java.util.List;

import com.singbon.entity.Batch;
import com.singbon.entity.Company;

/**
 * 批次管理dao层
 * 
 * @author 郝威
 * 
 */
public interface CompanyDAO {

	/**
	 * 添加公司
	 * 
	 * @param obj
	 * @return
	 */
	public void insert(Company company);

	/**
	 * 获取公司
	 * 
	 * @param obj
	 * @return
	 */
	public Company selectById(Integer id);

	/**
	 * 公司列表
	 * 
	 * @param obj
	 * @return
	 */
	public List<Company> selectCompanyList();

}
