package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.WaterRateDAO;
import com.singbon.entity.WaterRate;

/**
 * 水控费率2、3、4业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class WaterRateService {

	@Autowired
	public WaterRateDAO waterRateDAO;

	/**
	 * 添加
	 * 
	 * @param WaterRate
	 */
	public void insert(Integer companyId) {
		this.waterRateDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param WaterRate
	 */
	public void update(WaterRate waterRate) {
		this.waterRateDAO.update(waterRate);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public WaterRate selectByCompanyId(Integer companyId) {
		return this.waterRateDAO.selectByCompanyId(companyId);
	}
}
