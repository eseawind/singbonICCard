package com.singbon.device;


/**
 * 设备交互字符串
 * 
 * @author 郝威
 * 
 */
public class DeviceCommunicateStr {

	/**
	 * 未知
	 */
	public static String Unknow = "3211d73aab61859c";
	/**
	 * 校时
	 */
	public static String SendSysTime = "505c025133336813dc6ea22ce385c25b8bfddc4600b5973f91f2e222f1af8a27";
	/**
	 * 系统参数
	 */
	public static String SendSysPara = "3dd5c55bfb45dbdbcd85540efbb4c5fc5ff8847d2718fad891f2e222f1af8a27";
	/**
	 * 餐别限次
	 */
	public static String SendMeal = "37b4714f8f7d1dff4d72588ee6dd225e3f009086ed220eb591f2e222f1af8a27";
	/**
	 * 折扣费率
	 */
	public static String SendDiscount = "ec66aed2d16b487e4c0ecc868b8f2114165fe0d34cd91405c5f743040598dde8c7a221784bb367f1";
	/**
	 * 发送订餐时间段1-6命令
	 */
	public static String SendOrderTime1 = "bf45c9a3fed5536378a8cbc39e7e649d0238a4b7bef0ac42b105234bd82351e2";
	/**
	 * 发送订餐时间段7-12命令
	 */
	public static String SendOrderTime2 = "bf45c9a3fed5536378a8cbc39e7e649d2c7dcbcd0f41fb1187ff382206f3e236";
	/**
	 * 发送菜肴清单更新命令
	 */
	public static String SendUpdate = "a7f0b55cd83dc90d6fd5a3ecb6df81c3fe41eb33526731bcb105234bd82351e2";
	/**
	 * 发送菜肴清单追加命令：第%s/%s个，编号：%s，单价：%s，菜名：%s
	 */
	public static String SendAppend = "a7f0b55cd83dc90d6fd5a3ecb6df81c3aef17531c9bce4117a0464a7a0654e0d4b355a928a37d7b4b2fcb3de96af2a893d33e3faa4d02b91d71621b78339fd5d60f625cfd8ba9b9a5a314f2cc15de1ec6ff818a46dfac9a1";
	/**
	 * 发送初始化命令
	 */
	public static String SendSysInit = "dea6282e44b6866a1bf6868449a57195fcacfd2c9648104e";
	/**
	 * 执行校时
	 */
	public static String ExecSysTime = "b137826844568d21dc6ea22ce385c25b8bfddc4600b5973f3f9be93b874a5e4b";
	/**
	 * 执行系统参数
	 */
	public static String ExecSysPara = "306f7cdabf55f23ecd85540efbb4c5fc5ff8847d2718fad83f9be93b874a5e4b";
	/**
	 * 执行餐别限次
	 */
	public static String ExecMeal = "c1fee4ac05c93efb4d72588ee6dd225e3f009086ed220eb53f9be93b874a5e4b";
	/**
	 * 执行折扣费率
	 */
	public static String ExecDiscount = "c44f569755aff39c4c0ecc868b8f2114165fe0d34cd9140531fb68d15ac3162a8c09701f385c4f0b";
	/**
	 * 执行订餐时间段1-6命令
	 */
	public static String ExecOrderTime1 = "bfcb65ccf4f71fd078a8cbc39e7e649d0238a4b7bef0ac423f9be93b874a5e4b";
	/**
	 * 执行订餐时间段7-12命令
	 */
	public static String ExecOrderTime2 = "bfcb65ccf4f71fd078a8cbc39e7e649d2c7dcbcd0f41fb1114d4060023966d3c";
	/**
	 * 执行菜肴清单更新命令
	 */
	public static String ExecUpdate = "780242ee9595ed066fd5a3ecb6df81c3fe41eb33526731bc3f9be93b874a5e4b";
	/**
	 * 执行菜肴清单追加命令：第%s/%s个，编号：%s，单价：%s，菜名：%s
	 */
	public static String ExecAppend = "780242ee9595ed066fd5a3ecb6df81c3aef17531c9bce411cd91e220c70aa32b17f3be03f80c233af2dacc464511d0bade60a28819a608508c35378859b40a59ca09f39d183f72e4bd7f3ed733691eee0f17d7ed084391d1b038950c665229c4";
	/**
	 * 执行初始化命令
	 */
	public static String ExecSysInit = "225e35c022a93de81bf6868449a5719544b497015179595bd0ae5e940207a7a9";

//	public static void main(String[] args) {
//		try {
//			String test = "执行系统参数命令成功";
//
//			StringUtil.desInit("ycsty");
//			System.out.println("加密前的字符：" + test);
//			System.out.println("加密后的字符：" + StringUtil.encrypt(test));
//			System.out.println("解密后的字符：" + DesUtil.decrypt(StringUtil.encrypt(test)));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}