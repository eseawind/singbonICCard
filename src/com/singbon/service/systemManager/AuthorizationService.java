package com.singbon.service.systemManager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.systemManager.AuthorizationDAO;
import com.singbon.entity.AuthGroup;
import com.singbon.entity.AuthGroupUser;

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
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void insertGroup(AuthGroup authGroup) {
		this.authorizationDAO.insertGroup(authGroup);
	}

	/**
	 * 修改分组
	 * 
	 * @return
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
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
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void deleteGroup(Integer id) {
		this.authorizationDAO.deleteGroup(id);
	}

	/**
	 * 用户组列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> selectGroupUserList(Integer companyId) {
		return this.authorizationDAO.selectGroupUserList(companyId);
	}

	/**
	 * 保存组用户
	 * 
	 * @return
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void saveGroupUser(String groupIds, Integer operId) {
		this.authorizationDAO.deleteGroupUser(operId);
		if (groupIds != null && !"".equals(groupIds)) {
			List<AuthGroupUser> list = new ArrayList<AuthGroupUser>();
			String[] groupIds2 = groupIds.split(",");
			for (String g : groupIds2) {
				AuthGroupUser user = new AuthGroupUser();
				user.setOperId(operId);
				user.setGroupId(Integer.valueOf(g));
				list.add(user);
			}
			this.authorizationDAO.insertGroupUser(list);
		}
	}
}
