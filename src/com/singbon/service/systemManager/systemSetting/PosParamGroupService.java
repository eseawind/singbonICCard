package com.singbon.service.systemManager.systemSetting;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.PosParamGroupDAO;
import com.singbon.service.BaseService;

/**
 * 消费机参数组设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class PosParamGroupService extends BaseService {

	@Autowired
	public PosParamGroupDAO posParamGroupDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return posParamGroupDAO;
	}

	/**
	 * 添加
	 * 
	 * @param posParamGroup
	 */
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int insert(Integer companyId, String groupName) {
		return this.posParamGroupDAO.insert(companyId, groupName);
	}

	/**
	 * 查询被设备关联数量
	 * 
	 * @param companyId
	 * @return
	 */
	public Integer selectCountWithPos(@Param("groupId") Integer groupId) {
		return this.posParamGroupDAO.selectCountWithPos(groupId);
	}
}
