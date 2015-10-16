package com.singbon.service.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.WaterRateGroupDAO;
import com.singbon.service.BaseService;

/**
 * 一控一水控费率业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class WaterRateGroupService extends BaseService {

	@Autowired
	public WaterRateGroupDAO waterRateGroupDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return waterRateGroupDAO;
	}

	/**
	 * 添加
	 * 
	 * @param posParamGroup
	 */
	public int insert(Integer companyId, String groupName) {
		return this.waterRateGroupDAO.insert(companyId, groupName);
	}

	/**
	 * 查询被设备关联数量
	 * 
	 * @param companyId
	 * @return
	 */
	public Integer selectCountWithPos(@Param("groupId") Integer groupId) {
		return this.waterRateGroupDAO.selectCountWithPos(groupId);
	}
}
