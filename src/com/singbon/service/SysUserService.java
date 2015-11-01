package com.singbon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.dao.systemManager.AuthorizationDAO;
import com.singbon.entity.SysUser;

/**
 * 系统用户业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SysUserService extends BaseService {

	@Autowired
	public SysUserDAO sysUserDAO;
	@Autowired
	public AuthorizationDAO authorizationDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return sysUserDAO;
	}

	public SysUser login(String companyName, String loginName, String loginPwd) {
		return (SysUser) this.sysUserDAO.login(companyName, loginName, loginPwd);
	}

	/**
	 * 获取出纳员列表
	 * 
	 * @param user
	 * @return
	 */
	public List<SysUser> selectCashierListByCompanyId(Integer companyId) {
		return this.sysUserDAO.selectCashierList(companyId);
	}
	
	/**
	 * 删除
	 * 
	 * @param user
	 * @return
	 * @throws Exception 
	 */
	public void delete(Integer operId) throws Exception {
		this.authorizationDAO.deleteGroupUser(operId);
		this.sysUserDAO.delete(operId);
	}
}
