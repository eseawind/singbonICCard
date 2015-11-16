package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.device.CardReaderCommandCode;
import com.singbon.device.CardReaderFrame;
import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceType;
import com.singbon.device.TerminalManager;
import com.singbon.entity.CardAllInfo;
import com.singbon.entity.Device;
import com.singbon.entity.User;
import com.singbon.service.BaseService;
import com.singbon.util.StringUtil;

/**
 * 制功能卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class FuncCardService extends BaseService {

	@Autowired
	public SysUserDAO sysUserDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return sysUserDAO;
	}

	/**
	 * 制功能卡
	 * 
	 * @param device
	 * @param socketChannel
	 * @param section
	 * @throws Exception
	 */
	public void makeCardByUserInfo(Device device, SocketChannel socketChannel, int section) throws Exception {

		// 基本扇区
//		Calendar c = Calendar.getInstance();
//
//		String tmUserId = StringUtil.hexLeftPad(user.getUserId(), 8);// 4 0-3
//		String tmCardNo = StringUtil.hexLeftPad(Integer.valueOf(user.getCardNO()), 8);// 4
//																						// 4-7
//		String tmConsumePwd = StringUtil.hexLeftPad(Integer.valueOf(user.getConsumePwd()), 4);// 2
//																								// 8-9
//		c.setTime(user.getInvalidDate());
//		String tmInvalidDate = StringUtil.dateToHexStr(c);// 2 10-11
//		String tmCardMark = StringUtil.hexLeftPad(241, 2);// 1 12
//		String tmCardBatch = StringUtil.hexLeftPad(cardAllInfo.getCardBatch(), 4);// 2
//																					// 13-14
//		String tmCheck1 = "00"; // 异或校验，以后补充 1
//
//		String tmCardDeposit = StringUtil.hexLeftPad(cardAllInfo.getCardDeposit(), 2);// 1
//		String tmLimitTimesFare = StringUtil.hexLeftPad(cardAllInfo.getLimitTimesFare(), 2);// 2
//		String tmLimitDayFare = StringUtil.hexLeftPad(cardAllInfo.getLimitDayFare(), 4);// 1
//		String tmCardSeq = "01";// 1
//		if (commandCode != CardReaderCommandCode.SingleCard && commandCode != CardReaderCommandCode.InfoCard) {
//			tmCardSeq = StringUtil.hexLeftPad(user.getCardSeq(), 2);// 1
//		}
//		String tmCardType = StringUtil.hexLeftPad(user.getCardTypeId(), 2);// 1
//		String tmDeptId = StringUtil.hexLeftPad(user.getDeptId(), 8);// 4
//		String tmTotalFare = StringUtil.hexLeftPad(user.getTotalFare(), 8);// 4
//		String tmStandby = "06"; // 备用字段//1
//		String tmCheck2 = "00"; // 异或校验//1
//
//		String baseData = tmUserId + tmCardNo + tmConsumePwd + tmInvalidDate + tmCardMark + tmCardBatch + tmCheck1 + tmCardDeposit + tmLimitTimesFare + tmLimitDayFare + tmCardSeq + tmCardType
//				+ tmDeptId + tmTotalFare + tmStandby + tmCheck2;
//		String baseInfoSection = StringUtil.hexLeftPad(section, 2);
//		String baseBlock0 = baseInfoSection + "0000" + baseData.substring(0, 32);
//		String baseBlock1 = baseInfoSection + "0100" + StringUtil.strRightPad(StringUtil.strToGB2312(user.getUsername()), 32);
//		String baseBlock2 = baseInfoSection + "0200" + baseData.substring(32);
//
//		// 大钱包
//		String tmCardOPCount = StringUtil.hexLeftPad(user.getOpCount(), 4);// 2
//		String tmCardOddFare = StringUtil.hexLeftPad(user.getOddFare(), 8);// 4
//		String tmLastConsumeTime = "000000";// 3
//		String tmDaySumFare = StringUtil.hexLeftPad(user.getDaySumFare(), 6);// 3
//		String tmLimitPeriod1 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[0], 1);
//		String tmLimitPeriod2 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[1], 1);
//		String tmLimitPeriod3 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[2], 1);
//		String tmLimitPeriod4 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[3], 1);
//		String tmLimitPeriod5 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[4], 1);
//		String tmLimitPeriod6 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[5], 1);
//		String tmCheck = "00"; // 校验位，同或校验
//
//		String consumeData = tmCardOPCount + tmCardOddFare + tmLastConsumeTime + tmDaySumFare + tmLimitPeriod1 + tmLimitPeriod2 + tmLimitPeriod3 + tmLimitPeriod4 + tmLimitPeriod5 + tmLimitPeriod6
//				+ tmCheck;
//		String consumeSection = StringUtil.hexLeftPad(section + 1, 2);
//		String consumeBlock0 = consumeSection + "0000" + consumeData;
//		String zeroStr = StringUtil.strLeftPad("", 34);
//		String consumeBlock1 = consumeSection + "01" + zeroStr;
//		String consumeBlock2 = consumeSection + "02" + zeroStr;
//
//		// 补助钱包
//		String tmSubsidyCardOPCount = StringUtil.hexLeftPad(user.getSubsidyOpCount(), 4);// 2
//																							// 0-1
//		String tmCardOddSubsidy = StringUtil.hexLeftPad(user.getSubsidyOddFare(), 8);// 4
//																						// 2-5
//		String tmLastSubsidyConsumeTime = "0000";// 2 6-7
//		String tmSubsidyVersion = StringUtil.hexLeftPad(user.getSubsidyVersion(), 4);// 2
//																						// 8-9
//		c.setTime(user.getSubsidyInvalidDate());
//		String tmSubsidyValidPeriod = StringUtil.dateToHexStr(c);// 2 10-11
//		String tmSubsidyLimitPeriod1 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[0], 1);
//		String tmSubsidyLimitPeriod2 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[1], 1);
//		String tmSubsidyLimitPeriod3 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[2], 1);
//		String tmSubsidyLimitPeriod4 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[3], 1);
//		String tmSubsidyLimitPeriod5 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[4], 1);
//		String tmSubsidyLimitPeriod6 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[5], 1);
//		String tmSubsidyCheck = "00"; // 校验位，同或校验
//
//		String subsidyData = tmSubsidyCardOPCount + tmCardOddSubsidy + tmLastSubsidyConsumeTime + tmSubsidyVersion + tmSubsidyValidPeriod + tmSubsidyLimitPeriod1 + tmSubsidyLimitPeriod2
//				+ tmSubsidyLimitPeriod3 + tmSubsidyLimitPeriod4 + tmSubsidyLimitPeriod5 + tmSubsidyLimitPeriod6 + tmSubsidyCheck;
//		String subsidySection = StringUtil.hexLeftPad(section + 2, 2);
//		String subsidyBlock0 = subsidySection + "0000" + subsidyData;
//		String subsidyBlock1 = subsidySection + "01" + zeroStr;
//		String subsidyBlock2 = subsidySection + "02" + zeroStr;
//
//		String forthSection = StringUtil.hexLeftPad(section + 3, 2);
//		String forthBlock0 = forthSection + "00" + zeroStr;
//		String forthBlock1 = forthSection + "01" + zeroStr;
//		String forthBlock2 = forthSection + "02" + zeroStr;
//
//		// 静态ID（16字节高字节在前）+设备机器号（4字节高字节在前）+数据长度（2字节高字节在前）+cd+01+是否校验卡号标志（1字节）+物理卡号（4字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+...+CRC校验（字节高字节在前）
//		String commandCodeStr = "0000" + StringUtil.hexLeftPad(commandCode, 4);
//		String sendStr = CardReaderFrame.WriteCard + commandCodeStr + CardReaderFrame.ValidateCardSN + cardSN + baseBlock0 + baseBlock1 + baseBlock2 + consumeBlock0 + consumeBlock1 + consumeBlock2
//				+ subsidyBlock0 + subsidyBlock1 + subsidyBlock2 + forthBlock0 + forthBlock1 + forthBlock2 + "0000";
//		String bufLen = StringUtil.hexLeftPad(2 + sendStr.length() / 2, 4);
//		sendStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + "0000" + DeviceType.CardReader + bufLen + sendStr;
//
//		byte[] buf = StringUtil.strTobytes(sendStr);
//
//		TerminalManager.sendToCardReader(socketChannel, buf);
	}
}
