package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 一控一水控费率dao层
 * 
 * @author 郝威
 * 
 */
public interface WaterRateDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

}
