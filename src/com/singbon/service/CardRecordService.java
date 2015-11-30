package com.singbon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.CardRecordDAO;

/**
 * 卡操作记录业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CardRecordService extends BaseService {

	@Autowired
	public CardRecordDAO cardRecordDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return cardRecordDAO;
	}

}
