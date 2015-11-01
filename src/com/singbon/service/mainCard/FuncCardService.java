package com.singbon.service.mainCard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.service.BaseService;

/**
 * 制功能卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class FuncCardService extends BaseService{

	@Autowired
	public SysUserDAO sysUserDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return sysUserDAO;
	}

}
