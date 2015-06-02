package com.singbon.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.singbon.entity.Batch;
import com.singbon.entity.Company;

/**
 * 系统管理业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SystemManagerService {

	//@Autowired
	//public SystemManagerDAO systemManagerDAO;

	/**
	 * 批次列表
	 * 
	 * @return
	 */
	public List<Batch> getBatchList() {
		
		return null;
	}
	
	/**
	 * 添加修改人员部门
	 * 
	 * @return
	 */
	public void addEditUserDept(Integer id, Integer parentDeptId, String deptName, Integer batchId, Company company) {
		
	}
}
