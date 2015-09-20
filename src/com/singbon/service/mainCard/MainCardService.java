package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.common.UserDAO;
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
	public UserDAO mainCardDAO;

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
	public void delete(Integer[] userIds) throws Exception {
		this.mainCardDAO.delete(userIds);
	}

	/**
	 * 根据主键查询人员
	 * 
	 * @param id
	 * @return
	 */
	public User selectById(Integer userId) {
		return this.mainCardDAO.selectByUserId(userId);
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
	 * 根据部门查询未发卡人员
	 * 
	 * @param id
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectNoCardByDeptId(Integer deptId) {
		return this.mainCardDAO.selectNoCardByDeptId(deptId);
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
	public List<User> selectByCondition(Integer deptId, String searchStr) {
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

		// 基本扇区
		Calendar c = Calendar.getInstance();

		String tmUserId = StringUtil.hexLeftPad(user.getUserId(), 8);// 4 0-3
		String tmCardNo = StringUtil.hexLeftPad(Integer.valueOf(user.getCardNO()), 8);// 4
																						// 4-7
		String tmConsumePwd = StringUtil.hexLeftPad(Integer.valueOf(user.getConsumePwd()), 4);// 2
																								// 8-9
		c.setTime(user.getInvalidDate());
		String tmInvalidDate = StringUtil.dateToHexString(c);// 2 10-11
		String tmCardMark = StringUtil.hexLeftPad(241, 2);// 1 12
		String tmCardBatch = StringUtil.hexLeftPad(cardAllInfo.getCardBatch(), 4);// 2
																					// 13-14
		String tmCheck1 = "00"; // 异或校验，以后补充 1

		String tmCardDeposit = StringUtil.hexLeftPad(cardAllInfo.getCardDeposit(), 2);// 1
		String tmLimitDayFare = StringUtil.hexLeftPad(cardAllInfo.getLimitDayFare(), 2);// 1
		String tmLimitTimesFare = StringUtil.hexLeftPad(cardAllInfo.getLimitTimesFare(), 4);// 2
		String tmCardSeq = "01";// 1
		if (commandCode != CommandCodeCardReader.SingleCard && commandCode != CommandCodeCardReader.InfoCard) {
			tmCardSeq = StringUtil.hexLeftPad(user.getCardSeq(), 2);// 1
		}
		String tmCardType = StringUtil.hexLeftPad(user.getCardTypeId(), 2);// 1
		String tmDeptId = StringUtil.hexLeftPad(user.getDeptId(), 8);// 4
		String tmTotalFare = StringUtil.hexLeftPad(user.getTotalFare(), 8);// 4
		String tmStandby = "06"; // 备用字段//1
		String tmCheck2 = "00"; // 异或校验//1

		String baseData = tmUserId + tmCardNo + tmConsumePwd + tmInvalidDate + tmCardMark + tmCardBatch + tmCheck1 + tmCardDeposit + tmLimitDayFare + tmLimitTimesFare + tmCardSeq + tmCardType
				+ tmDeptId + tmTotalFare + tmStandby + tmCheck2;
		String baseInfoSection = StringUtil.hexLeftPad(section, 2);
		String baseBlock0 = baseInfoSection + "0000" + baseData.substring(0, 32);
		String baseBlock1 = baseInfoSection + "0100" + StringUtil.stringRightPad(StringUtil.strToGB2312(user.getUsername()), 32);
		String baseBlock2 = baseInfoSection + "0200" + baseData.substring(32);

		// 大钱包
		String tmCardOPCount = StringUtil.hexLeftPad(user.getOpCount(), 4);// 2
		String tmCardOddFare = StringUtil.hexLeftPad(user.getOddFare(), 8);// 4
		String tmLastConsumeTime = "000000";// 3
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
		String consumeBlock0 = consumeSection + "0000" + consumeData;
		String consumeBlock1 = consumeSection + "010000000000000000000000000000000000";
		String consumeBlock2 = consumeSection + "020000000000000000000000000000000000";

		// 补助钱包
		String tmSubsidyCardOPCount = StringUtil.hexLeftPad(user.getSubsidyOpCount(), 4);// 2
																							// 0-1
		String tmCardOddSubsidy = StringUtil.hexLeftPad(user.getSubsidyOddFare(), 8);// 4
																						// 2-5
		String tmLastSubsidyConsumeTime = "0000";// 2 6-7
		String tmSubsidyVersion = StringUtil.hexLeftPad(user.getSubsidyVersion(), 4);// 2
																						// 8-9
		c.setTime(user.getSubsidyInvalidDate());
		String tmSubsidyValidPeriod = StringUtil.dateToHexString(c);// 2 10-11
		String tmSubsidyLimitPeriod1 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[0], 1);
		String tmSubsidyLimitPeriod2 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[1], 1);
		String tmSubsidyLimitPeriod3 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[2], 1);
		String tmSubsidyLimitPeriod4 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[3], 1);
		String tmSubsidyLimitPeriod5 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[4], 1);
		String tmSubsidyLimitPeriod6 = StringUtil.hexLeftPad(cardAllInfo.getSubsidyLimitPeriods()[5], 1);
		String tmSubsidyCheck = "00"; // 校验位，同或校验

		String subsidyData = tmSubsidyCardOPCount + tmCardOddSubsidy + tmLastSubsidyConsumeTime + tmSubsidyVersion + tmSubsidyValidPeriod + tmSubsidyLimitPeriod1 + tmSubsidyLimitPeriod2
				+ tmSubsidyLimitPeriod3 + tmSubsidyLimitPeriod4 + tmSubsidyLimitPeriod5 + tmSubsidyLimitPeriod6 + tmSubsidyCheck;
		String subsidySection = StringUtil.hexLeftPad(section + 2, 2);
		String subsidyBlock0 = subsidySection + "0000" + subsidyData;
		String subsidyBlock1 = subsidySection + "010000000000000000000000000000000000";
		String subsidyBlock2 = subsidySection + "020000000000000000000000000000000000";

		String forthSection = StringUtil.hexLeftPad(section + 3, 2);
		String forthBlock0 = forthSection + "000000000000000000000000000000000000";
		String forthBlock1 = forthSection + "010000000000000000000000000000000000";
		String forthBlock2 = forthSection + "020000000000000000000000000000000000";

		// 静态ID（16字节高字节在前）+设备机器号（4字节高字节在前）+数据长度（2字节高字节在前）+cd+01+是否校验卡号标志（1字节）+物理卡号（4字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+...+CRC校验（字节高字节在前）
		String commandCodeStr = "0000" + StringUtil.hexLeftPad(commandCode, 4);
		String sendStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + baseBlock0 + baseBlock1 + baseBlock2 + consumeBlock0 + consumeBlock1
				+ consumeBlock2 + subsidyBlock0 + subsidyBlock1 + subsidyBlock2 + forthBlock0 + forthBlock1 + forthBlock2 + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendStr.length() / 2, 4);
		sendStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendStr;

		byte[] buf = StringUtil.strTobytes(sendStr);

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

		String commandCodeStr = "0000" + StringUtil.hexLeftPad(CommandCodeCardReader.Unloss, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		sendBuf[sendBuf.length - 5] = (byte) 0xf1;
		// CRC16.generate(sendBuf);
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

		String cardNOStr = StringUtil.hexLeftPad(cardNO, 8);
		String cardSeq = StringUtil.hexLeftPad(Integer.valueOf(cardInfoStr.substring(52, 54), 16) + 1, 2);
		cardInfoStr = cardInfoStr.substring(0, 14) + cardNOStr + cardInfoStr.substring(22, 52) + cardSeq + cardInfoStr.substring(54);
		String commandCodeStr = "0000" + StringUtil.hexLeftPad(CommandCodeCardReader.ChangeNewCard, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + cardSN + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}

	/**
	 * 按卡修正
	 * 
	 * @param userId
	 * @param cardNO
	 * @param cardSN
	 */
	public void updateByCard(User user) throws Exception {
		this.mainCardDAO.updateByCard(user);
	}

	/**
	 * 指定人员调整到新部门
	 * 
	 * @param userId
	 * @param toDeptId
	 * @throws Exception
	 */
	public void changeToNewDept(Integer[] userIds, Integer toDeptId) throws Exception {
		this.mainCardDAO.changeToNewDept(userIds, toDeptId);
	}

	/**
	 * 调整人员从原部门到新部门
	 * 
	 * @param fromDeptId
	 * @param toDeptId
	 * @throws Exception
	 */
	public void changeFromDeptToNew(Integer fromDeptId, Integer toDeptId) throws Exception {
		this.mainCardDAO.changeFromDeptToNew(fromDeptId, toDeptId);
	}

	/**
	 * 存取款
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void doCharge(User user, float oddFare2, float opCash, SocketChannel socketChannel, Device device, Integer chargeType, String cardInfoStr) throws Exception {
		String totalFareString = cardInfoStr.substring(26, 34);
		int totalFare = Integer.parseInt(totalFareString, 16);
		int oddFare = 0;
		if (chargeType == 0) {
			oddFare = (int) (100 * (oddFare2 + opCash));
			totalFare += opCash * 100;
			this.mainCardDAO.changeFare(user.getUserId(), (int) opCash * 100);
		} else {
			oddFare = (int) (100 * (oddFare2 - opCash));
			totalFare -= opCash * 100;
			this.mainCardDAO.changeFare(user.getUserId(), -(int) opCash * 100);
		}

		cardInfoStr = cardInfoStr.substring(0, 26) + StringUtil.hexLeftPad(totalFare, 8) + cardInfoStr.substring(34, 50) + StringUtil.hexLeftPad(oddFare, 6) + cardInfoStr.substring(56);
		String commandCodeStr = "0000" + StringUtil.hexLeftPad(CommandCodeCardReader.Charge, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + user.getCardSN() + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		// CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}
}
