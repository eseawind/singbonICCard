package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.MultiWaterRate;

/**
 * 一控多水控费率dao层
 * 
 * @author 郝威
 * 
 */
public interface MultiWaterRateDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @param companyId
	 * @return
	 */
	public void insert(@Param("companyId") Integer companyId);

	/**
	 * 根据公司id查询
	 * 
	 * @param companyId
	 * @return
	 */
	public MultiWaterRate selectByCompanyId(@Param("companyId") Integer companyId);
}
