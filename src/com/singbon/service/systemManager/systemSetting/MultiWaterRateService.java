package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.MultiWaterRateDAO;
import com.singbon.service.BaseService;

/**
 * 一控多水控费率业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MultiWaterRateService extends BaseService {

	@Autowired
	public MultiWaterRateDAO multiWaterRateDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return multiWaterRateDAO;
	}

	/**
	 * 添加
	 * 
	 * @param multiWaterRate
	 */
	public void insert(Integer companyId) {
		this.multiWaterRateDAO.insert(companyId);
	}

}
