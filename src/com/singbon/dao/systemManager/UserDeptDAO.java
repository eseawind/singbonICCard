package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.UserDept;

/**
 * 人员部门dao层
 * 
 * @author 郝威
 * 
 */
public interface UserDeptDAO {

	/**
	 * 添加部门
	 * 
	 * @param batch
	 * @return
	 */
	public void insert(UserDept userDept);

	/**
	 * 修改部门
	 * 
	 * @param batch
	 * @return
	 */
	public void update(UserDept userDept);

	/**
	 * 删除部门
	 * 
	 * @param batch
	 * @return
	 */
	public void delete(Integer id);

	/**
	 * 人员部门树列表
	 * 
	 * @return
	 */
	public List selectTreeList(@Param("companyId") Integer companyId);

	/**
	 * 人员部门列表
	 * 
	 * @return
	 */
	public List<UserDept> selectByParentId(@Param("parentId") Integer parentId);

}
