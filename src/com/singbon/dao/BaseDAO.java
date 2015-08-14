package com.singbon.dao;

import org.apache.ibatis.annotations.Param;

/**
 * 基础数据库操作类
 * 
 * @author 郝威
 * 
 */
public interface BaseDAO {

	/**
	 * 添加对象
	 * 
	 * @param obj
	 * @return
	 */
	public Object insert(Object obj);

	/**
	 * 修改对象
	 * 
	 * @param obj
	 * @return
	 */
	public void update(Object obj);

	/**
	 * 删除对象
	 * 
	 * @param obj
	 * @return
	 */
	public void delete(Object obj);

	/**
	 * 根据主键获取对象
	 * 
	 * @param id
	 * @return
	 */
	public Object selectById(@Param("id") Integer id);

}
