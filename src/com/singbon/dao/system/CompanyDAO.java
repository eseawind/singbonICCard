package com.singbon.dao.system;

import java.util.List;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Company;

/**
 * 批次管理dao层
 * 
 * @author 郝威
 * 
 */
public interface CompanyDAO extends BaseDAO{

	/**
	 * 公司列表
	 * 
	 * @param obj
	 * @return
	 */
	public List<Company> selectCompanyList();

}
