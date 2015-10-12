package com.singbon.service.systemManager.systemSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.systemSetting.ConsumeParamDAO;
import com.singbon.service.BaseService;

/**
 * 消费参数设置业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class ConsumeParamService extends BaseService {

	@Autowired
	public ConsumeParamDAO consumeParamDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return consumeParamDAO;
	}

}
