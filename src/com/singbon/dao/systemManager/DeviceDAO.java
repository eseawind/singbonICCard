package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.entity.Device;

/**
 * 终端设备dao层
 * 
 * @author 郝威
 * 
 */
public interface DeviceDAO {

	/**
	 * 添加
	 * 
	 * @param device
	 * @return
	 */
	public void insert(Device device);

	/**
	 * 修改
	 * 
	 * @param device
	 * @return
	 */
	public void update(Device device);

	/**
	 * 通过userId查找
	 * 
	 * @return
	 */
	public Device selectByUserId(@Param("userId") Integer userId);
	
	/**
	 * 列表
	 * 
	 * @return
	 */
	public List<Device> selectList(@Param("companyId") Integer companyId);

	/**
	 * 所有列表
	 * 
	 * @return
	 */
	public List<Device> selectAllList();

}
