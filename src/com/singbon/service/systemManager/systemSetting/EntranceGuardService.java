package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.EntranceGuardDAO;
import com.singbon.service.BaseService;

/**
 * 门禁参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class EntranceGuardService extends BaseService {

	@Autowired
	public EntranceGuardDAO entranceGuardDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return entranceGuardDAO;
	}

	/**
	 * 添加
	 * 
	 * @param entranceGuard
	 */
	public void insert(Integer companyId) {
		this.entranceGuardDAO.insert(companyId);
	}
}
