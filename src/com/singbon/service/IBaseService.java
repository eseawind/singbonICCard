package com.singbon.service;

import java.util.List;

/**
 * 公共通用业务层
 * 
 * @author 郝威
 * 
 */
public interface IBaseService{

	/**
	 * 添加对象
	 * 
	 * @param obj
	 * @return
	 */
	public Object insert(Object obj) throws Exception;

	/**
	 * 修改对象
	 * 
	 * @param obj
	 * @return
	 */
	public void update(Object obj) throws Exception;

	/**
	 * 删除对象
	 * 
	 * @param obj
	 * @return
	 */
	public void delete(Object obj) throws Exception;

	/**
	 * 根据id查询
	 * 
	 * @param id
	 * @return
	 */
	public Object selectById(Integer id);

	/**
	 * 根据公司id查询单个对象
	 * 
	 * @return
	 */
	public Object selectByCompanyId(Integer companyId);

	/**
	 * 根据公司id查询
	 * 
	 * @param companyId
	 * @return
	 */
	public List<?> selectListByCompanyId(Integer companyId);
}
