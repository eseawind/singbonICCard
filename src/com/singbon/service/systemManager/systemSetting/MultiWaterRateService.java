package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.MultiWaterRateDAO;
import com.singbon.entity.MultiWaterRate;

/**
 * 一控多水控费率业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MultiWaterRateService {

	@Autowired
	public MultiWaterRateDAO multiWaterRateDAO;

	/**
	 * 添加
	 * 
	 * @param multiWaterRate
	 */
	public void insert(Integer companyId) {
		this.multiWaterRateDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param multiWaterRate
	 */
	public void update(MultiWaterRate multiWaterRate) {
		this.multiWaterRateDAO.update(multiWaterRate);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public MultiWaterRate selectByCompanyId(Integer companyId) {
		return this.multiWaterRateDAO.selectByCompanyId(companyId);
	}
}
