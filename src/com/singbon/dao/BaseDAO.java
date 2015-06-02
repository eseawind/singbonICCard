package com.singbon.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

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
	public void insert(Object obj);

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
	public void deleteObject(Object obj);

	/**
	 * 查询对象
	 * 
	 * @param obj
	 * @return
	 */
	public List list(String hql, List<Object> paras);

	/**
	 * 查询单一实体对象
	 * 
	 * @param t泛型
	 * @param hql
	 * @param paras
	 * @return
	 */
	public <T> T getObject(Class<T> t, List<Object> paras);
	
	public Object selectByPrimaryKey();
}
