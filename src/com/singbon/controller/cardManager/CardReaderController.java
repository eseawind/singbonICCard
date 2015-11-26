package com.singbon.controller.cardManager;

import java.io.IOException;
import java.nio.channels.SocketChannel;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.SysUser;
import com.singbon.service.mainCard.CardReaderService;

/**
 * 读卡机参数下载控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager/cardReader")
public class CardReaderController extends BaseController {

	@Autowired
	public CardReaderService cardReaderService;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		model.addAttribute("device", device);

		if (device != null) {
			model.addAttribute("sn", device.getSn());
			// 读卡机状态
			if (TerminalManager.SNToSocketChannelList.containsKey(device.getSn())) {
				model.addAttribute("cardStatus", 1);
			} else {
				model.addAttribute("cardStatus", 0);
			}
		} else {
			model.addAttribute("cardStatus", 0);
		}
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return url.replace(".do", "");
	}

	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(String comm, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();

		// 下载单位名称
		if ("name".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					cardReaderService.downloadName(company, socketChannel, device);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 下载读卡机密码
		else if ("pwd".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					cardReaderService.sysPwd(company, socketChannel, device);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 下载系统时间
		else if ("sysTime".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					cardReaderService.sysTime(company, socketChannel, device);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
