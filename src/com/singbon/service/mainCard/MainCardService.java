package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.mainCard.MainCardDAO;
import com.singbon.device.CRC16;
import com.singbon.device.CommandCardReader;
import com.singbon.device.CommandCodeCardReader;
import com.singbon.device.TerminalManager;
import com.singbon.entity.CardAllInfo;
import com.singbon.entity.Device;
import com.singbon.entity.User;
import com.singbon.util.StringUtil;

/**
 * 制卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class MainCardService {

	@Autowired
	public MainCardDAO mainCardDAO;

	/**
	 * 添加人员
	 * 
	 * @param user
	 * @throws Exception
	 */
	public Object save(User user) throws Exception {
		return this.mainCardDAO.insert(user);
	}

	/**
	 * 修改人员
	 * 
	 * @param user
	 */
	public void update(User user) throws Exception {
		this.mainCardDAO.update(user);
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param user
	 */
	public void delete(Integer deptId) throws Exception {
		this.mainCardDAO.delete(deptId);
	}

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(Integer userId) {
		return this.mainCardDAO.selectById(userId);
	}
	
	/**
	 * 根据主键和物理卡号查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectByUserIdCardSN(Integer companyId, Integer userId, String cardSN) {
		return this.mainCardDAO.selectByUserIdCardSN(companyId, userId, cardSN);
	}

	/**
	 * 以物理卡号查询绑定数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByCardSN(Integer companyId, String cardSN) {
		return this.mainCardDAO.selectCountByCardSN(companyId, cardSN);
	}

	/**
	 * 以用户编号查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNO(Integer companyId, String userNO) throws Exception {
		return this.mainCardDAO.selectCountByUserNO(companyId, userNO);
	}

	/**
	 * 以用户编号用户ID查询数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByUserNOUserId(Integer companyId, String userNO, Integer userId) throws Exception {
		return this.mainCardDAO.selectCountByUserNOUserId(companyId, userNO, userId);
	}

	/**
	 * 查询最大卡号+1
	 * 
	 * @param user
	 * @return
	 */
	public int selectMaxCardNO(Integer companyId) throws Exception {
		return this.mainCardDAO.selectMaxCardNO(companyId);
	}

	/**
	 * 人员列表
	 * 
	 * @return
	 */
	public List<User> selectByCondition(Integer deptId, String searchStr) throws Exception {
		return this.mainCardDAO.selectByCondition(deptId, searchStr);
	}

	/**
	 * 通过用户信息写卡： 单个发卡、信息发卡、补卡
	 * 
	 * @param device
	 * @param socketChannel
	 * @param user
	 * @param cardAllInfo
	 * @param commandCode
	 *            命令码
	 * @param section
	 *            开始扇区
	 * @throws Exception
	 */
	public void makeCardByUserInfo(Device device, SocketChannel socketChannel, User user, CardAllInfo cardAllInfo, String cardSN, int commandCode, int section) throws Exception {
		if (commandCode == CommandCodeCardReader.SingleCard) {
			this.mainCardDAO.insert(user);
		} else if (commandCode == CommandCodeCardReader.InfoCard) {
			this.mainCardDAO.infoCard(user);
		} else if (commandCode == CommandCodeCardReader.RemakeCard) {
			this.mainCardDAO.remakeCard(user);
		}
		// SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance();

		String tmUserId = StringUtil.hexLeftPad(user.getUserId(), 6);// 3
		String tmCardNo = StringUtil.hexLeftPad(Integer.valueOf(user.getCardNO()), 6);// 3
		String tmConsumePwd = StringUtil.hexLeftPad(Integer.valueOf(user.getConsumePwd()), 6);// 3
		String tmIdentityPwd = StringUtil.hexLeftPad(Integer.valueOf(user.getIdentityPwd()), 4);// 2
		c.setTime(user.getInvalidDate());
		String tmInvalidDate = StringUtil.dateToHexString(c);// 2
		String tmCardMark = StringUtil.hexLeftPad(241, 2);// 1
		String tmCardBatch = StringUtil.hexLeftPad(cardAllInfo.getCardBatch(), 2);// 1
		String tmCheck1 = "00"; // 异或校验，以后补充 1

		String tmCardDeposit = StringUtil.hexLeftPad(cardAllInfo.getCardDeposit(), 2);// 1
		String tmLimitDayFare = StringUtil.hexLeftPad(cardAllInfo.getLimitDayFare(), 2);// 1
		String tmLimitTimesFare = StringUtil.hexLeftPad(cardAllInfo.getLimitTimesFare(), 4);// 2
		String tmCardSeq = "01";// 1
		String tmCardType = StringUtil.hexLeftPad(user.getCardType(), 2);// 1
		String tmDeptId = StringUtil.hexLeftPad(user.getDeptId(), 8);// 4
		String tmTotalFare = StringUtil.hexLeftPad(user.getTotalFare(), 8);// 4
		String tmStandby = "06"; // 备用字段//1
		String tmCheck2 = "00"; // 异或校验//1

		String baseData = tmUserId + tmCardNo + tmConsumePwd + tmIdentityPwd + tmInvalidDate + tmCardMark + tmCardBatch + tmCheck1 + tmCardDeposit + tmLimitDayFare + tmLimitTimesFare + tmCardSeq
				+ tmCardType + tmDeptId + tmTotalFare + tmStandby + tmCheck2;

		// 大钱包
		String tmCardOPCount = StringUtil.hexLeftPad(user.getOpCount(), 4);// 2
		String tmCardOddFare = "01" + StringUtil.hexLeftPad(user.getOddFare(), 6);// 3
		String tmLastConsumeTime = "";
		tmLastConsumeTime = "000000";// 3
		String tmDaySumFare = StringUtil.hexLeftPad(user.getDaySumFare(), 6);// 3
		String tmLimitPeriod1 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[0], 1);
		String tmLimitPeriod2 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[1], 1);
		String tmLimitPeriod3 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[2], 1);
		String tmLimitPeriod4 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[3], 1);
		String tmLimitPeriod5 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[4], 1);
		String tmLimitPeriod6 = StringUtil.hexLeftPad(cardAllInfo.getLimitPeriods()[5], 1);
		String tmCheck = "00"; // 校验位，同或校验

		String consumeData = tmCardOPCount + tmCardOddFare + tmLastConsumeTime + tmDaySumFare + tmLimitPeriod1 + tmLimitPeriod2 + tmLimitPeriod3 + tmLimitPeriod4 + tmLimitPeriod5 + tmLimitPeriod6
				+ tmCheck;
		String consumeSection = StringUtil.hexLeftPad(section + 1, 2);
		consumeData = consumeSection + "0000" + consumeData;

		// 补助钱包
		String tmSubsidyCardOPCount = StringUtil.hexLeftPad(user.getSubsidyOPCount(), 4);// 2
		String tmCardOddSubsidy = StringUtil.hexLeftPad(user.getSubsidyOddFare(), 6);// 3
		String tmLastSubsidyConsumeTime = "0000";//2
		String tmSubsidyVersion = StringUtil.hexLeftPad(user.getSubsidyVersion(), 2);// 1
		c.setTime(user.getSubsidyInvalidDate());
		String tmSubsidyValidPeriod = StringUtil.dateToHexString(c);// 2
		String tmDaySumSubsidy = StringUtil.hexLeftPad(user.getSubsidyDaySum(), 4);// 2
		String tmSubsidyLimitPeriod1 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[0], 1);
		String tmSubsidyLimitPeriod2 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[1], 1);
		String tmSubsidyLimitPeriod3 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[2], 1);
		String tmSubsidyLimitPeriod4 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[3], 1);
		String tmSubsidyLimitPeriod5 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[4], 1);
		String tmSubsidyLimitPeriod6 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[5], 1);
		String tmSubsidyCheck = "00"; // 校验位，同或校验

		String subsidyData = tmSubsidyCardOPCount + tmCardOddSubsidy + tmLastSubsidyConsumeTime + tmSubsidyVersion + tmSubsidyValidPeriod + tmDaySumSubsidy + tmSubsidyLimitPeriod1
				+ tmSubsidyLimitPeriod2 + tmSubsidyLimitPeriod3 + tmSubsidyLimitPeriod4 + tmSubsidyLimitPeriod5 + tmSubsidyLimitPeriod6 + tmSubsidyCheck;
		String subsidySection = StringUtil.hexLeftPad(section + 2, 2);
		subsidyData = subsidySection + "0000" + subsidyData;

		// 静态ID（16字节高字节在前）+设备机器号（4字节高字节在前）+数据长度（2字节高字节在前）+cd+01+是否校验卡号标志（1字节）+物理卡号（4字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+...+CRC校验（字节高字节在前）
		String baseInfoSection = StringUtil.hexLeftPad(section, 2);
		String baseBlock0 = baseInfoSection + "0000" + baseData.substring(0, 32);
		String baseBlock1 = baseInfoSection + "0100" + baseData.substring(0, 32);
		String baseBlock2 = baseInfoSection + "0200" + baseData.substring(32);

		String commandCodeStr = StringUtil.hexLeftPad(commandCode, 4);
		String sendStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + baseBlock0 + baseBlock1 + baseBlock2 + consumeData + subsidyData + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendStr.length() / 2, 4);
		sendStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + bufLen + sendStr;

		byte[] buf = StringUtil.strTobytes(sendStr);
		CRC16.generate(buf);
		System.out.print(StringUtil.hexLeftPad(buf[buf.length - 2], 2) + " ");
		System.out.print(StringUtil.hexLeftPad(buf[buf.length - 1], 2));
		System.out.println();
		TerminalManager.sendToCardReader(socketChannel, buf);
	}

	/**
	 * 更改状态
	 * 
	 * @param userId
	 * @param status
	 *            2挂失、1解挂
	 * @return
	 * @throws Exception
	 */
	public void changeStatus(Integer userId, Integer status) throws Exception {
		this.mainCardDAO.changeStatus(userId, status);
	}

	/**
	 * 解挂
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void unloss(Integer userId, SocketChannel socketChannel, Device device, String cardSN, String cardInfoStr) throws Exception {
		this.mainCardDAO.changeStatus(userId, 1);

		String commandCodeStr = StringUtil.hexLeftPad(CommandCodeCardReader.Unloss, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		sendBuf[sendBuf.length - 5] = (byte) 0xf1;
		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}

	/**
	 * 换卡换新卡
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void changeNewCard(Integer companyId, Integer userId, SocketChannel socketChannel, Device device, String cardSN, String cardInfoStr) throws Exception {
		int cardNO = this.mainCardDAO.selectMaxCardNO(companyId);
		this.mainCardDAO.changeNewCard(userId, cardNO, cardSN);

		String cardNOStr = StringUtil.hexLeftPad(cardNO, 6);
		cardInfoStr = cardInfoStr.substring(0, 12) + cardNOStr + cardInfoStr.substring(18);
		String commandCodeStr = StringUtil.hexLeftPad(CommandCodeCardReader.ChangeNewCard, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}
}
