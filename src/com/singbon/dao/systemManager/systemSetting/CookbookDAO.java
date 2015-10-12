package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 菜肴清单dao层
 * 
 * @author 郝威
 * 
 */
public interface CookbookDAO extends BaseDAO {

	/**
	 * 编号最大值
	 * 
	 * @return
	 */
	public Integer selectMaxCode(@Param("companyId") Integer companyId);
}
