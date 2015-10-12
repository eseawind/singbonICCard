package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 优惠方案dao层
 * 
 * @author 郝威
 * 
 */
public interface DiscountDAO extends BaseDAO{

	/**
	 * 添加优惠方案
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

}
