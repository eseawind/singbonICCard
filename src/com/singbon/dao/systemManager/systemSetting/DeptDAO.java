package com.singbon.dao.systemManager.systemSetting;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Dept;

/**
 * 营业部门dao层
 * 
 * @author 郝威
 * 
 */
public interface DeptDAO extends BaseDAO {

	/**
	 * 树列表
	 * 
	 * @return
	 */
	public List<Dept> selectTreeList(@Param("companyId") Integer companyId);

	/**
	 * 列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(@Param("companyId") Integer companyId, @Param("parentId") Integer parentId);

}
