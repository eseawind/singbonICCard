package com.singbon.dao.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Batch;
import com.singbon.entity.BatchBlack;

/**
 * 批次管理dao层
 * 
 * @author 郝威
 * 
 */
public interface BatchDAO extends BaseDAO {

	/**
	 * 根据人员部门主键获取批次
	 * 
	 * @return
	 */
	public Batch selectByDeptId(@Param("deptId") Integer deptId);

	/**
	 * 挂失
	 * 
	 * @return
	 */
	public void black(@Param("id") Integer id);

	/**
	 * 添加批次黑名单
	 * 
	 * @return
	 */
	public void insertBatchBlack(BatchBlack batchBlack);
}
