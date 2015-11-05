package com.singbon.device;

/**
 * 消费类型
 * 
 * @author 郝威
 * 
 */
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

	public static String getTypeDes(int consumeType) {
		if (consumeType == 1) {
			return "普通消费";
		}
		return null;
	}

}
