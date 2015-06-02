package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.Batch;

/**
 * 批次管理dao层
 * 
 * @author 郝威
 * 
 */
public interface BatchDAO {

	/**
	 * 添加批次
	 * 
	 * @param batch
	 * @return
	 */
	public void insert(Batch batch);

	/**
	 * 修改批次
	 * 
	 * @param batch
	 * @return
	 */
	public void update(Batch batch);

	/**
	 * 批次列表
	 * 
	 * @return
	 */
	public List<Batch> selectList(@Param("companyId") Integer companyId);

}
