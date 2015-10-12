package com.singbon.dao.systemManager.systemSetting;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;

/**
 * 人员部门dao层
 * 
 * @author 郝威
 * 
 */
public interface UserDeptDAO extends BaseDAO {

	/**
	 * 人员部门列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(@Param("companyId") Integer companyId, @Param("parentId") Integer parentId);

}
