package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.systemSetting.CardParamDAO;
import com.singbon.entity.CardParam;

/**
 * 制卡参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CardParamService {

	@Autowired
	public CardParamDAO CardParamDAO;

	/**
	 * 添加
	 * 
	 * @param CardParam
	 */
	public void insert(Integer companyId) {
		this.CardParamDAO.insert(companyId);
	}

	/**
	 * 修改
	 * 
	 * @param CardParam
	 */
	public void update(CardParam cardParam) {
		this.CardParamDAO.update(cardParam);
	}

	/**
	 * 根据公司id查询
	 * 
	 * @return
	 */
	public CardParam selectByCompanyId(Integer companyId) {
		return this.CardParamDAO.selectByCompanyId(companyId);
	}
}
