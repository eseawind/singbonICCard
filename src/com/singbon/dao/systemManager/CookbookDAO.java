package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Cookbook;

/**
 * 菜肴清单dao层
 * 
 * @author 郝威
 * 
 */
public interface CookbookDAO extends BaseDAO {

	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Cookbook> selectList(@Param("companyId") Integer companyId);

	/**
	 * 编号最大值
	 * 
	 * @return
	 */
	public Integer selectMaxCode(@Param("companyId") Integer companyId);
}
