package com.singbon.dao.systemManager;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 补助管理dao层
 * 
 * @author 郝威
 * 
 */
public interface SubsidyDAO extends BaseDAO {

	public Integer selectCountByUserId(@Param("userId") Integer userId);
}
