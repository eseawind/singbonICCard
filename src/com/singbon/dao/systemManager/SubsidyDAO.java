package com.singbon.dao.systemManager;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 补助管理dao层
 * 
 * @author 郝威
 * 
 */
public interface SubsidyDAO extends BaseDAO {

	/**
	 * 添加人员
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void insert(@Param("companyId") Integer companyId, @Param("userIds") String[] userIds, @Param("subsidyVersion") Integer subsidyVersion, @Param("invalidDate") String invalidDate)
			throws Exception;

	/**
	 * 查询生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public Map selectSubsidyInfo(@Param("companyId") Integer companyId);

	/**
	 * 添加金额
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void addFare(@Param("companyId") Integer companyId, @Param("subsidyFare") float subsidyFare) throws Exception;

	/**
	 * 自动生成金额
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void autoFare(@Param("companyId") Integer companyId) throws Exception;

	/**
	 * 生成补助信息
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void generateSubsidy(@Param("companyId") Integer companyId, @Param("subsidyVersion") Integer subsidyVersion, @Param("invalidDate") String invalidDate) throws Exception;

	/**
	 * 转移补助
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void transferSubsidy(@Param("companyId") Integer companyId) throws Exception;

	/**
	 * 删除全部补助
	 * 
	 * @param list
	 * @throws Exception
	 */
	public void deleteAll(@Param("companyId") Integer companyId) throws Exception;
}
