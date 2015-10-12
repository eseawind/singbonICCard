package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 订餐时间段dao层
 * 
 * @author 郝威
 * 
 */
public interface OrderTimeDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

}
