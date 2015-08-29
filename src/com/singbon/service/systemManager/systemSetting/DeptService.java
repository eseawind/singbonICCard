package com.singbon.service.systemManager.systemSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.DeptDAO;
import com.singbon.entity.Dept;

/**
 * 营业部门业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeptService {

	@Autowired
	public DeptDAO deptDAO;

	/**
	 * 添加
	 * 
	 * @param Dept
	 */
	public void save(Dept dept) {
		if (dept.getParentId() == null) {
			dept.setParentId(0);
		}
		this.deptDAO.insert(dept);
	}

	/**
	 * 修改
	 * 
	 * @param Dept
	 */
	public void update(Dept dept) {
		this.deptDAO.update(dept);
	}

	/**
	 * 删除
	 * 
	 * @param Dept
	 */
	public void delete(Integer id) {
		this.deptDAO.delete(id);
	}

	/**
	 * 列表
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectByParentId(Integer parentId) {
		if (parentId == null) {
			parentId = 0;
		}
		return this.deptDAO.selectByParentId(parentId);
	}

	/**
	 * 树列表
	 * 
	 * @return
	 */
	public List<Dept> selectTreeList(Integer companyId) {
		return this.deptDAO.selectTreeList(companyId);
	}

	/**
	 * 根据主键获取部门
	 * 
	 * @return
	 */
	public Dept selectById(Integer id) {
		return (Dept) this.deptDAO.selectById(id);
	}
}
