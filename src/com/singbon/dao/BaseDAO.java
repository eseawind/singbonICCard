package com.singbon.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 基础数据库操作类
 * 
 * @author 郝威
 * 
 */
@Repository
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

	/**
	 * 自定义sql查询fan
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> selectBySql(@Param("sql") String sql);

}
