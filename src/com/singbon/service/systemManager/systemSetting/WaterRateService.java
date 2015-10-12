package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.WaterRateDAO;
import com.singbon.service.BaseService;

/**
 * 一控一水控费率业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class WaterRateService extends BaseService {

	@Autowired
	public WaterRateDAO waterRateDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return waterRateDAO;
	}

	/**
	 * 添加
	 * 
	 * @param WaterRate
	 */
	public void insert(Integer companyId) {
		this.waterRateDAO.insert(companyId);
	}

}
