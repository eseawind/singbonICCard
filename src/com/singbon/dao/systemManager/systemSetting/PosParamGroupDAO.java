package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 消费机参数组dao层
 * 
 * @author 郝威
 * 
 */
public interface PosParamGroupDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @param companyId
	 * @return
	 */
	public int insert(@Param("companyId") Integer companyId, @Param("groupName") String groupName);

	/**
	 * 查询被设备关联数量
	 * 
	 * @param companyId
	 * @return
	 */
	public Integer selectCountWithPos(@Param("groupId") Integer groupId);
}
