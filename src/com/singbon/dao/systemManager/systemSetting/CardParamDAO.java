package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.CardParam;

/**
 * 制卡参数设置dao层
 * 
 * @author 郝威
 * 
 */
public interface CardParamDAO extends BaseDAO {

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
	public CardParam selectByCompanyId(@Param("companyId") Integer companyId);
}
