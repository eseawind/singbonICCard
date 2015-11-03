package com.singbon.service.systemManager;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;
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
	 * 添加分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void insertGroup(DeviceGroup deviceGroup) {
		this.deviceDAO.insertGroup(deviceGroup);
	}

	/**
	 * 修改分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void updateGroup(DeviceGroup deviceGroup) {
		this.deviceDAO.updateGroup(deviceGroup);
	}

	/**
	 * 删除分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void deleteGroup(Integer id) {
		this.deviceDAO.deleteGroup(id);
	}

	/**
	 * 分组被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectDeviceCountByGroupId(Integer groupId) {
		return this.deviceDAO.selectDeviceCountByGroupId(groupId);
	}

	/**
	 * 分组列表
	 * 
	 * @param groupId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<DeviceGroup> selectGroupListByCompanyId(Integer id) {
		return this.deviceDAO.selectGroupListByCompanyId(id);
	}

	/**
	 * 添加设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void insertDevice(Device device) {
		this.deviceDAO.insertDevice(device);
	}

	/**
	 * 修改设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void updateDevice(Device device) {
		this.deviceDAO.updateDevice(device);
	}

	/**
	 * 删除设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void deleteDevice(Integer id) {
		this.deviceDAO.deleteDevice(id);
	}

	/**
	 * 读卡机被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectSysUserCountByDeviceId(Integer deviceId) {
		return this.deviceDAO.selectSysUserCountByDeviceId(deviceId);
	}

	/**
	 * 根据分组查询消费机列表
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
	 * 设备列表
	 * 
	 * @param companyId
	 * @param isCardReader
	 *            是否为读卡机 1是 0消费机
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectDeviceListByCompanyId(Integer companyId, Integer isCardReader, Integer onlyEnable) {
		return this.deviceDAO.selectDeviceListByCompanyId(companyId, isCardReader, onlyEnable);
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
