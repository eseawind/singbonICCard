package com.singbon.dao.systemManager;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.DeviceGroup;

/**
 * 终端设备分组dao层
 * 
 * @author 郝威
 * 
 */
public interface DeviceGroupDAO extends BaseDAO{

	/**
	 * 分组列表
	 * 
	 * @return
	 */
	public List<DeviceGroup> selectTreeList(@Param("companyId") Integer companyId);

}
