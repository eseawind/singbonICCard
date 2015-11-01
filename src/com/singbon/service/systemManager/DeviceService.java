package com.singbon.service.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.entity.Device;
import com.singbon.service.BaseService;

/**
 * 终端设备业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class DeviceService extends BaseService {

	@Autowired
	public DeviceDAO deviceDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return deviceDAO;
	}

	/**
	 * 读卡机列表
	 * 
	 * @param companyId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectCardReaderListByCompanyId(@Param("companyId") Integer companyId) {
		return this.deviceDAO.selectCardReaderListByCompanyId(companyId);
	}

	/**
	 * 消费机列表
	 * 
	 * @param companyId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosList(Integer companyId, Integer onlyEnable) {
		return this.deviceDAO.selectPosList(companyId, onlyEnable);
	}

	/**
	 * 根据分组查询列表
	 * 
	 * @param groupId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosListByGroupId(Integer groupId, Integer onlyEnable) {
		return this.deviceDAO.selectPosListByGroupId(groupId, onlyEnable);
	}

	/**
	 * 系统所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList() {
		return this.deviceDAO.selectAllList();
	}
}
