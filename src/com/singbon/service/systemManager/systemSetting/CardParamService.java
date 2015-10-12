package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.CardParamDAO;
import com.singbon.service.BaseService;

/**
 * 制卡参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CardParamService extends BaseService {

	@Autowired
	public CardParamDAO cardParamDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return cardParamDAO;
	}
}
