package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.entity.ConsumeParam;

/**
 * 消费参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class ConsumeParamService {

	@Autowired
	public ConsumeParamDAO consumeParamDAO;

	/**
	 * 添加
	 * 
	 * @param consumeParam
	 */
	public void insert(Integer companyId) {
		this.consumeParamDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param consumeParam
	 */
	public void update(ConsumeParam consumeParam) {
		this.consumeParamDAO.update(consumeParam);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public ConsumeParam selectByCompanyId(Integer companyId) {
		return this.consumeParamDAO.selectByCompanyId(companyId);
	}
}
