package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.SysUserDAO;
import com.singbon.device.CommandCardReader;
import com.singbon.device.CommandCodeCardReader;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Device;
import com.singbon.entity.SysUser;
import com.singbon.util.StringUtil;

/**
 * 制功能卡业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class SpecialCardService {

	@Autowired
	public SysUserDAO sysUserDAO;

	/**
	 * 以物理卡号查询绑定数量
	 * 
	 * @param user
	 * @return
	 */
	public int selectCountByCardSN(Integer companyId, String cardSN) {
		return this.sysUserDAO.selectCountByCardSN(companyId, cardSN);
	}

	/**
	 * 查询最大卡号+1
	 * 
	 * @param user
	 * @return
	 */
	public int selectMaxCardNO(Integer companyId) throws Exception {
		return this.sysUserDAO.selectMaxCardNO(companyId);
	}

	/**
	 * 制出纳卡
	 * 
	 * @param companyId
	 * @param device
	 * @param socketChannel
	 * @param user
	 * @param commandCode
	 * @param section
	 * @throws Exception
	 */
	public void makeCashierCard(Integer companyId, Device device, SocketChannel socketChannel, SysUser user, int commandCode, int section) throws Exception {
		this.sysUserDAO.makeSpecailCard(user);
		Calendar c = Calendar.getInstance();

		String lSysID = StringUtil.hexLeftPad(companyId, 4);// 2
		String lCardType = "00";
		String lStatus = StringUtil.hexLeftPad(241, 3);
		String lAccountNO = StringUtil.hexLeftPad(user.getOperId(), 5);
		String lCardBat = "00";
		// 使用标识 0 启用， 1 停用
		String lUseID = StringUtil.hexLeftPad(0, 5);
		String lCardNO = StringUtil.hexLeftPad(user.getCardNO(), 5);
		String sPWD = StringUtil.hexLeftPad(0, 6);

		String lPWDError = StringUtil.hexLeftPad(0, 3);
		String lStatID = StringUtil.hexLeftPad(0, 3);
		String lDynamicPWD = StringUtil.hexLeftPad(0, 3);
		String s1 = "0";
		String strCardType = StringUtil.hexLeftPad(0, 2);
		String s2 = "0";

		String lPrivilege = StringUtil.hexLeftPad(0, 3);
		String sUpdatePWDDate = "0000";// 4
		c.setTime(user.getInvalidDate());
		String sValidPeriod = StringUtil.dateToHexString(c);// 4
		String sReserve = StringUtil.hexLeftPad(0, 6);
		String tmCheck1 = "00"; // 异或校验，以后补充

		String baseData = lSysID + lCardType + lStatus + lAccountNO + lCardBat + lUseID + lCardNO + sPWD + lPWDError + lStatID + lDynamicPWD + s1 + strCardType + s2 + lPrivilege + sUpdatePWDDate
				+ sValidPeriod + sReserve + tmCheck1;

		// 静态ID（16字节高字节在前）+设备机器号（4字节高字节在前）+数据长度（2字节高字节在前）+cd+01+是否校验卡号标志（1字节）+物理卡号（4字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+读卡扇区号（1字节）+读卡块号（1字节）+读写状态字节（1字节）+块数据（16字节高字节在前）+...+CRC校验（字节高字节在前）
		String baseInfoSection = StringUtil.hexLeftPad(section, 2);
		String baseBlock0 = baseInfoSection + "0000" + baseData.substring(0, 32);
		String baseBlock1 = baseInfoSection + "0100" + baseData.substring(0, 32);
		String baseBlock2 = baseInfoSection + "0200" + baseData.substring(32);

		String commandCodeStr = StringUtil.hexLeftPad(commandCode, 4);
		String sendStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + user.getCardSN() + baseBlock0 + baseBlock1 + baseBlock2 + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendStr.length() / 2, 4);
		sendStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendStr;

		byte[] buf = StringUtil.strTobytes(sendStr);
//		CRC16.generate(buf);
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
	public void changeStatus(Integer operId, Integer status) throws Exception {
		this.sysUserDAO.changeStatus(operId, status);
	}

	/**
	 * 挂失
	 * 
	 * @param userId
	 * @returncardInfoStr
	 * @throws Exception
	 */
	public void loss(SysUser sysUser, SocketChannel socketChannel, Device device, String cardInfoStr) throws Exception {
		this.sysUserDAO.changeStatus(sysUser.getOperId(), 2);

		cardInfoStr = cardInfoStr.substring(0, 12) + "0f0" + cardInfoStr.substring(15);
		String commandCodeStr = StringUtil.hexLeftPad(CommandCodeCardReader.LossCashierCard, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + sysUser.getCardSN() + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
//		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}

	/**
	 * 解挂
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void unloss(SysUser sysUser, SocketChannel socketChannel, Device device, String cardInfoStr) throws Exception {
		this.sysUserDAO.changeStatus(sysUser.getOperId(), 1);

		cardInfoStr = cardInfoStr.substring(0, 12) + "0f1" + cardInfoStr.substring(15);
		String commandCodeStr = StringUtil.hexLeftPad(CommandCodeCardReader.UnLossCashierCard, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + sysUser.getCardSN() + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
//		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}

	/**
	 * 修改出纳卡有效期
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void doInvalidDate(SysUser sysUser, String cardInfoStr, SocketChannel socketChannel, Device device) throws Exception {
		this.sysUserDAO.changeCashierInvalidDate(sysUser.getOperId(), sysUser.getInvalidDate());

		Calendar c = Calendar.getInstance();

		c.setTime(sysUser.getInvalidDate());
		String invalidDate = StringUtil.dateToHexString(c);// 4

		cardInfoStr = cardInfoStr.substring(0, 26) + invalidDate + cardInfoStr.substring(30);
		String commandCodeStr = StringUtil.hexLeftPad(CommandCodeCardReader.InvalidDateCashierCard, 4);
		String sendBufStr = CommandCardReader.WriteCard + commandCodeStr + CommandCardReader.ValidateCardSN + sysUser.getCardSN() + cardInfoStr;
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + "00000000" + "0000" + "0808" + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
//		CRC16.generate(sendBuf);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}
}
