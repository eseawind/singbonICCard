package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.EntranceGuardDAO;
import com.singbon.entity.EntranceGuard;

/**
 * 门禁参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class EntranceGuardService {

	@Autowired
	public EntranceGuardDAO entranceGuardDAO;

	/**
	 * 添加
	 * 
	 * @param entranceGuard
	 */
	public void insert(Integer companyId) {
		this.entranceGuardDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param entranceGuard
	 */
	public void update(EntranceGuard entranceGuard) {
		this.entranceGuardDAO.update(entranceGuard);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public EntranceGuard selectByCompanyId(Integer companyId) {
		return this.entranceGuardDAO.selectByCompanyId(companyId);
	}
}
