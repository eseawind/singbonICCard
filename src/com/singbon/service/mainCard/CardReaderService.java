package com.singbon.service.mainCard;

import java.nio.channels.SocketChannel;

import org.springframework.stereotype.Service;

import com.singbon.device.CardReaderFrame;
import com.singbon.device.CommandDevice;
import com.singbon.device.DeviceType;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.util.StringUtil;

/**
 * 下载读卡机参数业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CardReaderService{

	/**
	 * 单位名称
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public void downloadName(Company company, SocketChannel socketChannel, Device device) throws Exception {
		String sendBufStr = CardReaderFrame.CompanyName + "00000000" + StringUtil.strRightPad(StringUtil.strToGB2312(company.getCompanyName()), 64) + "0000";
		String bufLen = StringUtil.hexLeftPad(2 + sendBufStr.length() / 2, 4);
		sendBufStr = device.getSn() + StringUtil.hexLeftPad(device.getDeviceNum(), 8) + CommandDevice.NoSubDeviceNum + DeviceType.Main + DeviceType.CardReader + bufLen + sendBufStr;
		byte[] sendBuf = StringUtil.strTobytes(sendBufStr);
		TerminalManager.sendToCardReader(socketChannel, sendBuf);
	}
}
