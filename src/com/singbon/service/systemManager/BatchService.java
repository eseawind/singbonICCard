package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.BatchDAO;
import com.singbon.entity.Batch;
import com.singbon.entity.Company;

/**
 * 批次业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class BatchService {

	@Autowired
	public BatchDAO batchDAO;

	/**
	 * 添加批次
	 * @param batch
	 */
	public void save(Batch batch){
		this.batchDAO.insert(batch);
	}
	/**
	 * 修改批次
	 * @param batch
	 */
	public void update(Batch batch){
		this.batchDAO.update(batch);
	}
	
	/**
	 * 批次列表
	 * 
	 * @return
	 */
	public List<Batch> selectList(Integer companyId) {
		
		return this.batchDAO.selectList(companyId);
	}
	
	/**
	 * 添加修改人员部门
	 * 
	 * @return
	 */
	public void addEditUserDept(Integer id, Integer parentDeptId, String deptName, Integer batchId, Company company) {
		
	}
}
