package com.singbon.dao.systemManager.systemSetting;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 营业部门dao层
 * 
 * @author 郝威
 * 
 */
public interface DeptDAO extends BaseDAO {

	/**
	 * 列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(@Param("companyId") Integer companyId, @Param("parentId") Integer parentId);

}
