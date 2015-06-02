package com.singbon.service;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.singbon.device.FrameType;
import com.singbon.entity.Company;
import com.singbon.entity.User;

/**
 * 卡操作业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CardManagerService {

//	@Autowired
	//public CardManagerDAO cardManagerDAO;

	@Transactional
	public void addUser() {

	}

	public List<User> getUserList(Company company, Integer deptId, String searchStr) {
		return null;
	}

	public void command(String sn, String comm) throws IOException {
		if ("getCardReaderStatus".equals(comm)) {
			// 获取读卡器状态
			Map map = new HashMap();
			map.put("'f1'", FrameType.CardReaderStatus);
			map.put("'r'", 1);
//			String msg = JSONUtil.convertToJson(map);
			// 获取终端状态
//			TerminalManager.getEngineInstance().sendToAll(sn, msg);
		} else if ("test".equals(comm)) {
			// 测试
			ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x02, 0x0b, 0x01 });
		} else if ("search".equals(comm)) {
			// 寻卡
			ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x02, 0x02, 0x26 });
		} else if ("cardno".equals(comm)) {
			// 获取卡号
			ByteBuffer byteBuffer = ByteBuffer.wrap(new byte[] { 0x0c, 0x01, 0x03 });
		} 
	}
}
