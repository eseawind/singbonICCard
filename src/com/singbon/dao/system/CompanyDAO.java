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
public interface CompanyDAO extends BaseDAO {

	/**
	 * 列表
	 * 
	 * @param obj
	 * @return
	 */
	public List<Company> selectCompanyList();

	/**
	 * 保存系统密码设置
	 * 
	 * @param obj
	 * @return
	 */
	public void updateSystemPwd(Company company);

}
