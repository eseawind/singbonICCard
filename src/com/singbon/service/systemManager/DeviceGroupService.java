package com.singbon.service.systemManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.DeviceGroupDAO;
import com.singbon.service.BaseService;

/**
 * 终端设备分组业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeviceGroupService extends BaseService{

	@Autowired
	public DeviceGroupDAO deviceGroupDAO;
	
	@Override
	public BaseDAO getBaseDAO() {
		return deviceGroupDAO;
	}
}
