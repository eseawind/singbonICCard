package com.singbon.service.systemManager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.AuthorizationDAO;
import com.singbon.entity.AuthGroup;
import com.singbon.entity.AuthUserGroup;

/**
 * 人员权限业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class AuthorizationService {

	@Autowired
	public AuthorizationDAO authorizationDAO;

	/**
	 * 分组列表
	 * 
	 * @return
	 */
	public List<AuthGroup> selectGroup(Integer companyId) {
		return this.authorizationDAO.selectGroup(companyId);
	}

	/**
	 * 添加分组
	 * 
	 * @return
	 */
	public void insertGroup(AuthGroup authGroup) {
		this.authorizationDAO.insertGroup(authGroup);
	}

	/**
	 * 修改分组
	 * 
	 * @return
	 */
	public void updateGroup(AuthGroup authGroup) {
		this.authorizationDAO.updateGroup(authGroup);
	}

	/**
	 * 获取分组下用户个数
	 * 
	 * @return
	 */
	public Integer selectGroupUserCount(Integer groupId) {
		return this.authorizationDAO.selectGroupUserCount(groupId);
	}

	/**
	 * 删除分组
	 * 
	 * @return
	 */
	public void deleteGroup(Integer id) {
		this.authorizationDAO.deleteGroup(id);
	}

	/**
	 * 用户组列表
	 * 
	 * @return
	 */
	public List<Map> selectUserGroupList(Integer companyId) {
		return this.authorizationDAO.selectUserGroupList(companyId);
	}

	/**
	 * 保存用户组
	 * 
	 * @return
	 */
	public void saveUserGroup(String groupIds, Integer userId) {
		this.authorizationDAO.deleteUserGroup(userId);
		if (groupIds != null && !"".equals(groupIds)) {
			List<AuthUserGroup> list = new ArrayList<AuthUserGroup>();
			String[] groupIds2 = groupIds.split(",");
			for (String g : groupIds2) {
				AuthUserGroup group = new AuthUserGroup();
				group.setUserId(userId);
				group.setGroupId(Integer.valueOf(g));
				list.add(group);
			}
			this.authorizationDAO.insertUserGroup(list);
		}
	}
}
