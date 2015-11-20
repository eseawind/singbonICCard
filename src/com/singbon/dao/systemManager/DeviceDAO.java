package com.singbon.dao.systemManager;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Device;

/**
 * 终端设备dao层
 * 
 * @author 郝威
 * 
 */
public interface DeviceDAO extends BaseDAO {

	/**
	 * 添加消费机验证
	 * 
	 * @param groupId
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map selectCountByInfo(Device device);

	/**
	 * 读卡机被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectSysUserCountByDeviceId(@Param("deviceId") Integer deviceId);
	
	/**
	 * 中转设备被引用数量
	 * 
	 * @param groupId
	 * @return
	 */
	public Integer selectPosCountByTransferId(@Param("transferId") Integer transferId);

	/**
	 * 设备列表
	 * 
	 * @param companyId
	 * @param deviceType
	 * @param onlyEnable
	 * @return
	 */
	public List<Device> selectDeviceListByCompanyId(@Param("companyId") Integer companyId, @Param("deviceType") String deviceType, @Param("onlyEnable") Integer onlyEnable);

	/**
	 * 系统所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList();

}
