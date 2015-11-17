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

	public Integer selectCountByUserId(@Param("userId") Long userId);

	/**
	 * 查询生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	public Integer selectCountByCompanyId(@Param("companyId") Integer companyId);

	/**
	 * 生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void generateSubsidy(@Param("companyId") Integer companyId, @Param("subsidyVersion") Integer subsidyVersion, @Param("invalidDate") String invalidDate) throws Exception;
}
