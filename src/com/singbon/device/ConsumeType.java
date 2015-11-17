package com.singbon.device;

import java.util.HashMap;
import java.util.Map;

/**
 * 消费类型
 * 
 * @author 郝威
 * 
 */
@SuppressWarnings("unchecked")
public class ConsumeType {
	// 餐费支出
	// 水控消费支出
	// 读卡机存款
	// 读卡机取款
	// 存取款机存款
	// 存取款机取款
	// 补助消费支出
	// 消费管理费
	// 消费优惠
	// 补助消费宏冲
	// 消费宏冲
	// 消费纠错
	// PC采集卡金额上传
	// 大钱包消费找零
	// 补助钱包消费找零
	// 混合消费找零
	//
	// 卡成本
	// 注销卡成本退款
	// 注销大钱包余额退款
	// PC存款
	// PC取款
	// 开户存款
	// 收取卡押金
	// 退还卡押金
	// 补助存款
	// 发卡
	// 挂失
	// 解挂
	// 补卡
	// 注销
	@SuppressWarnings("rawtypes")
	static Map map = new HashMap<>();

	static {
		map.put(1, "消费机普通消费");
		map.put(2, "消费机补助消费");
		map.put(3, "消费机混合消费");
		map.put(9, "消费机补助领取");
		map.put(39, "消费机补助清零");

		map.put(101, "水控普通消费");
		map.put(102, "水控补助消费");
		map.put(103, "水控混合消费");
		map.put(105, "水控大钱包找零");
		map.put(106, "水控补助找零");
		map.put(107, "水控混合找零");
		map.put(109, "水控补助领取");
		map.put(139, "水控补助清零");
	}

	/**
	 * 记录类型
	 * 
	 * @param consumeType
	 * @return
	 */
	public static String getTypeDes(Integer consumeType) {
		if (map.containsKey(consumeType)) {
			return (String) map.get(consumeType);
		}
		return null;
	}

}
