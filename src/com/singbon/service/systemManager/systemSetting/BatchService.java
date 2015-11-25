package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.BatchDAO;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Batch;
import com.singbon.entity.BatchBlack;
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

	/**
	 * 挂失
	 * 
	 * @return
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public void black(Integer companyId, Integer batchId) {
		this.batchDAO.black(batchId);
		BatchBlack batchBlack = new BatchBlack();
		batchBlack.setCompanyId(companyId);
		batchBlack.setBatchId(batchId);
		this.batchDAO.insertBatchBlack(batchBlack);
		TerminalManager.CompanyIdToLastBatchIdList.put(companyId, batchId);
	}
}
