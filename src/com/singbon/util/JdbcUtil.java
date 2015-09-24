package com.singbon.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.singbon.dao.BaseDAO;

public class JdbcUtil implements ApplicationContextAware {

	public static BaseDAO baseDAO;

	public void setApplicationContext(ApplicationContext context) throws BeansException {
		JdbcUtil.baseDAO = (BaseDAO) context.getBean("baseDAO");
	}

}
