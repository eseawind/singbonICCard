package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Device;
import com.singbon.entity.DeviceGroup;

/**
 * 终端设备dao层
 * 
 * @author 郝威
 * 
 */
public interface DeviceDAO extends BaseDAO {

	/**
	 * 添加分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void insertGroup(DeviceGroup deviceGroup);

	/**
	 * 修改分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void updateGroup(DeviceGroup deviceGroup);

	/**
	 * 删除分组
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void deleteGroup(@Param("id") Integer id);

	/**
	 * 分组列表
	 * 
	 * @param groupId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<DeviceGroup> selectGroupListByCompanyId(@Param("companyId") Integer id);

	/**
	 * 分组被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectDeviceCountByGroupId(@Param("groupId") Integer groupId);

	/**
	 * 添加设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void insertDevice(Device device);

	/**
	 * 修改设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void updateDevice(Device device);

	/**
	 * 删除设备
	 * 
	 * @param deviceGroup
	 * @return
	 */
	public void deleteDevice(@Param("id") Integer id);

	/**
	 * 读卡机被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectSysUserCountByDeviceId(@Param("deviceId") Integer deviceId);

	/**
	 * 根据分组查询消费机列表
	 * 
	 * @param groupId
	 * @param onlyEnable
	 *            1只包含启用，0全部
	 * @return
	 */
	public List<Device> selectPosListByGroupId(@Param("groupId") Integer groupId, @Param("onlyEnable") Integer onlyEnable);

	/**
	 * 设备列表
	 * 
	 * @param companyId
	 * @param isCardReader
	 *            是否为读卡机 1是 0消费机
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectDeviceListByCompanyId(@Param("companyId") Integer companyId, @Param("isCardReader") Integer isCardReader, @Param("onlyEnable") Integer onlyEnable);

	/**
	 * 系统所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList();

}
