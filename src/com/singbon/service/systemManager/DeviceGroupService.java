package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.systemManager.DeviceGroupDAO;
import com.singbon.entity.DeviceGroup;

/**
 * 终端设备分组业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeviceGroupService {

	@Autowired
	public DeviceGroupDAO deviceGroupDAO;

	/**
	 * 终端设备分组树列表
	 * F
	 * @return
	 */
	public List<DeviceGroup> selectTreeList(Integer companyId) {
		return this.deviceGroupDAO.selectTreeList(companyId);
	}
}
