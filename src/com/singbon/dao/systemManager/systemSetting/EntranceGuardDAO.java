package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.EntranceGuard;

/**
 * 门禁参数设置dao层
 * 
 * @author 郝威
 * 
 */
public interface EntranceGuardDAO extends BaseDAO {

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
	public EntranceGuard selectByCompanyId(@Param("companyId") Integer companyId);
}
