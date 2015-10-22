package com.singbon.device;

import com.singbon.util.DesUtil;

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
	 * 发送消费参数命令
	 */
	public static String SendConsumeParam = "0b0015e3275115d11e3f80012baa3e365ff8847d2718fad891f2e222f1af8a27";
	/**
	 * 发送餐别限次命令
	 */
	public static String SendMeal = "37b4714f8f7d1dff4d72588ee6dd225e3f009086ed220eb591f2e222f1af8a27";
	/**
	 * 发送折扣费率命令
	 */
	public static String SendDiscount = "ec66aed2d16b487e4c0ecc868b8f2114165fe0d34cd91405c5f743040598dde8c7a221784bb367f1";
	/**
	 * 发送下载系统密码命令
	 */
	public static String SendSysPwd = "e5a2d4cd27ffdd33823ab584d508589128670a6fcfa0182db105234bd82351e2";
	/**
	 * 发送下载单位名称命令
	 */
	public static String SendCompanyName = "e5a2d4cd27ffdd33379857d9c43c47a138ca6bdac3d65046b105234bd82351e2";
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
	 * 执行校时命令
	 */
	public static String ExecSysTime = "b137826844568d21dc6ea22ce385c25b8bfddc4600b5973f3f9be93b874a5e4b";
	/**
	 * 执行消费参数成功
	 */
	public static String ExecConsumeParams = "bf8efbf283e53f571e3f80012baa3e362c2e7162d74ef87991f2e222f1af8a27";
	/**
	 * 执行餐别限次
	 */
	public static String ExecMeal = "c1fee4ac05c93efb4d72588ee6dd225e3f009086ed220eb53f9be93b874a5e4b";
	/**
	 * 执行折扣费率
	 */
	public static String ExecDiscount = "c44f569755aff39c4c0ecc868b8f2114165fe0d34cd9140531fb68d15ac3162a8c09701f385c4f0b";
	/**
	 * 执行下载系统密码成功
	 */
	public static String ExecSysPwd = "10469d0be16b70e5823ab584d508589128670a6fcfa0182d3f9be93b874a5e4b";
	/**
	 * 执行下载单位名称成功
	 */
	public static String ExecCompanyName = "10469d0be16b70e5379857d9c43c47a138ca6bdac3d650463f9be93b874a5e4b";
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
	/**
	 * 已经添加过菜单下载命令，不能重复添加
	 */
	public static String CookbookAdded = "c33c1de3b4061e1becf773956e3e6b09eb9ae5332ce8637408f0345a216caee428fb88937e928e3cc3b40662e9e8f8989abf8219795d5d22";
	/**
	 * 发送追加菜肴清单初始化命令
	 */
	public static String SendGetLastNumCookbook = "f0e28887812046680bd550dc89cb309e407a513b2afe27e4f0bc1d7f7943d6bed170faed669b6bdf";
	/**
	 * 执行追加菜肴清单初始化成功
	 */
	public static String ExecGetLastNumCookbook = "7f2bfe276f81e07a0bd550dc89cb309e407a513b2afe27e4f0bc1d7f7943d6be2d38c9d1b4370242";
	/**
	 * 不存在编号为%s的菜单
	 */
	public static String NotExsitCookbook = "822ae4dfd77f30e17e02247a5d8ac51fd7345a206e0523ab7ea035a4f9ada537";
	/**
	 * 发送修改菜肴命令：编号：%s，单价：%s，菜名：%s
	 */
	public static String SendModifyCookbook = "e4c30e0f68eb42d90a59c2f1cb65acb6fc718595944d9ed6ad688ba823b85352bd7f3ed733691eeeebc49cd6b5ed2557710ee81bd66d9ec91374e9ca7cb9d1e736a398ad21974e6b";
	/**
	 * 执行修改菜肴成功：编号：%s，单价：%s，菜名：%s
	 */
	public static String ExecModifyCookbook = "9c8c93cfc187831c0a59c2f1cb65acb6f1c054491c9ded39ad688ba823b85352bd7f3ed733691eeeebc49cd6b5ed2557710ee81bd66d9ec91374e9ca7cb9d1e736a398ad21974e6b";

	public static void main(String[] args) {
		try {
			String test = "执行修改菜肴成功：编号：%s，单价：%s，菜名：%s";

			DesUtil.desInit("ycsty");
//			System.out.println("加密前的字符：" + test);
			System.out.println(DesUtil.encrypt(test));
//			System.out.println("解密后的字符：" + DesUtil.decrypt("37b4714f8f7d1dff4d72588ee6dd225e3f009086ed220eb591f2e222f1af8a27"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}