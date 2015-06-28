package com.singbon.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.device.SubFrameType;
import com.singbon.device.TerminalManager;
import com.singbon.service.MonitorService;

/**
 * 采集监控控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/monitor")
public class MonitorController {

	@Autowired
	MonitorService monitorService;


	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public String command(String comm, Model model) throws IOException {

		if ("getDeviceStatus".equals(comm)) {
			Map map = new HashMap();
//			map.put("'f1'", FrameType.Result);
			map.put("'f2'", SubFrameType.Heart);
			Map map2 = new HashMap();

			Set<String> key = TerminalManager.getSNToSocketChannelList().keySet();
			for (Iterator it = key.iterator(); it.hasNext();) {
				String sn = (String) it.next();
				if(TerminalManager.getSNToSocketChannelList().get(sn)==null){
					map2.put("'"+sn+"'", 0);
				}else{
					map2.put("'"+sn+"'", 1);
				}
			}
			map.put("'msg'", map2);
		} else if ("time".equals(comm)) {
			// time 校时

		} else if ("start".equals(comm)) {
		}

		return null;
	}

}
