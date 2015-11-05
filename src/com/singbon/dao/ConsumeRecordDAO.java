package com.singbon.dao;

import com.singbon.entity.ConsumeRecord;

/**
 * 消费记录dao层
 * 
 * @author 郝威
 * 
 */
public interface ConsumeRecordDAO extends BaseDAO {

	/**
	 * 添加
	 * 
	 * @return
	 */
	public void insert(ConsumeRecord consumeRecord);

}
