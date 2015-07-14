package com.singbon.dao.systemManager;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.AuthGroup;
import com.singbon.entity.AuthUserGroup;

/**
 * 授权dao层
 * 
 * @author 郝威
 * 
 */
public interface AuthorizationDAO {

	/**
	 * 分组列表
	 * 
	 * @return
	 */
	public List<AuthGroup> selectGroup(@Param("companyId") Integer companyId);

	/**
	 * 添加分组
	 * 
	 * @return
	 */
	public void insertGroup(AuthGroup authGroup);

	/**
	 * 修改分组
	 * 
	 * @return
	 */
	public void updateGroup(AuthGroup authGroup);

	/**
	 * 获取分组下用户个数
	 * 
	 * @return
	 */
	public Integer selectGroupUserCount(@Param("groupId") Integer groupId);

	/**
	 * 删除分组
	 * 
	 * @return
	 */
	public void deleteGroup(@Param("id") Integer id);

	
	/**
	 * 用户组列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> selectUserGroupList(@Param("companyId") Integer companyId);
	

	/**
	 * 添加用户组
	 * 
	 * @return
	 */
	public void insertUserGroup(@Param("list") List<AuthUserGroup> list);

	/**
	 * 删除用户组
	 * 
	 * @return
	 */
	public void deleteUserGroup(@Param("userId") Integer userId);
}
