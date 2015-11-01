package com.singbon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	 * 插入初始数据
	 * 
	 * @return
	 */
	public void insertInit(@Param("companyId") Integer companyId);

	/**
	 * 更新补助版本号
	 * 
	 * @return
	 */
	public void updateSubsidy(Company company);

	/**
	 * 后台更新
	 * 
	 * @return
	 */
	public void updateAdmin(Company company);

}
