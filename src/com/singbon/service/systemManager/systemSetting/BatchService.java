package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.BatchDAO;
import com.singbon.entity.Batch;
import com.singbon.service.BaseService;

/**
 * 批次业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class BatchService extends BaseService {

	@Autowired
	public BatchDAO batchDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return batchDAO;
	}

	/**
	 * 根据人员部门主键获取批次
	 * 
	 * @return
	 */
	public Batch selectByDeptId(Integer deptId) {
		return this.batchDAO.selectByDeptId(deptId);
	}
}
