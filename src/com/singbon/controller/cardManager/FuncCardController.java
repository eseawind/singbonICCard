package com.singbon.controller.cardManager;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.CardReaderCommandCode;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.service.CompanyService;
import com.singbon.service.SysUserService;
import com.singbon.service.mainCard.FuncCardService;

/**
 * 功能卡制作控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager/funcCard")
public class FuncCardController extends BaseController {

	@Autowired
	public SysUserService sysUserService;
	@Autowired
	public FuncCardService funcCardService;
	@Autowired
	public CompanyService companyService;

	/**
	 * 首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/index.do")
	public String index(HttpServletRequest request, Model model) {
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return url.replace(".do", "");
	}

	// /**
	// * 制出纳卡
	// *
	// * @param user
	// * @param editType
	// * 0制卡、1补卡
	// * @param invalidDate
	// * @param request
	// * @param response
	// * @param model
	// */
	// @RequestMapping(value = "/makeCashierCard.do", method =
	// RequestMethod.POST)
	// public void makeCashierCard(@ModelAttribute SysUser user, Integer
	// editType, Date invalidDate, HttpServletRequest request,
	// HttpServletResponse response, Model model) {
	// Company company = (Company) request.getSession().getAttribute("company");
	// Device device = (Device) request.getSession().getAttribute("device");
	// String sn = device.getSn();
	// int section = companyService.getSection(company.getId());
	//
	// int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
	// if (cardSNCount > 0) {
	// return;
	// }
	// SocketChannel socketChannel =
	// TerminalManager.SNToSocketChannelList.get(sn);
	// if (socketChannel != null) {
	// try {
	// int cardNO = this.funcCardService.selectMaxCardNO(company.getId());
	// byte commandCode = CardReaderCommandCode.MakeCashierCard;
	// if (editType == 1) {
	// commandCode = CardReaderCommandCode.RemakeCashierCard;
	// String cardSN = user.getCardSN();
	// user = this.sysUserService.selectByOperId(user.getOperId());
	// user.setCardSN(cardSN);
	// }
	// user.setCardNO(cardNO);
	// user.setStatus(1);
	// this.funcCardService.makeCashierCard(company.getId(), device,
	// socketChannel, user, commandCode, section);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// }

	// /**
	// * 挂失
	// *
	// * @param user
	// * @param invalidDate
	// * @param request
	// * @param response
	// * @param model
	// */
	// @RequestMapping(value = "/loss.do", method = RequestMethod.POST)
	// public void loss(@ModelAttribute SysUser sysUser, Integer lossType,
	// String cardInfoStr, HttpServletRequest request, HttpServletResponse
	// response, Model model) {
	// Device device = (Device) request.getSession().getAttribute("device");
	// PrintWriter p = null;
	// try {
	// p = response.getWriter();
	// } catch (IOException e1) {
	// e1.printStackTrace();
	// }
	// if (lossType == 0) {
	// try {
	// this.funcCardService.changeStatus(sysUser.getOperId(), 2);
	// p.print(1);
	// } catch (Exception e) {
	// p.print(0);
	// e.printStackTrace();
	// }
	// } else {
	// SocketChannel socketChannel =
	// TerminalManager.SNToSocketChannelList.get(device.getSn());
	// if (socketChannel != null) {
	// try {
	// this.funcCardService.loss(sysUser, socketChannel, device,
	// cardInfoStr);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// }
	// }

	// /**
	// * 解挂
	// *
	// * @param user
	// * @param invalidDate
	// * @param request
	// * @param response
	// * @param model
	// */
	// @RequestMapping(value = "/unLoss.do", method = RequestMethod.POST)
	// public void unLoss(@ModelAttribute SysUser sysUser, String cardInfoStr,
	// HttpServletRequest request, HttpServletResponse response, Model model) {
	// Device device = (Device) request.getSession().getAttribute("device");
	// SocketChannel socketChannel =
	// TerminalManager.SNToSocketChannelList.get(device.getSn());
	// if (socketChannel != null) {
	// try {
	// this.funcCardService.unloss(sysUser, socketChannel, device,
	// cardInfoStr);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// }
	//
	// /**
	// * 修改出纳卡有效期
	// *
	// * @param user
	// * @param invalidDate
	// * @param request
	// * @param response
	// * @param model
	// */
	// @RequestMapping(value = "/doInvalidDate.do", method = RequestMethod.POST)
	// public void doInvalidDate(@ModelAttribute SysUser sysUser, String
	// cardInfoStr, HttpServletRequest request, HttpServletResponse response,
	// Model model) {
	// Device device = (Device) request.getSession().getAttribute("device");
	// SocketChannel socketChannel =
	// TerminalManager.SNToSocketChannelList.get(device.getSn());
	// if (socketChannel != null) {
	// try {
	// this.funcCardService.doInvalidDate(sysUser, cardInfoStr,
	// socketChannel, device);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	// }
	//
	// /**
	// * 获取重复物理卡号数量
	// *
	// * @param companyId
	// * @param cardSN
	// * @param sn
	// * @return
	// */
	// @SuppressWarnings({ "unchecked", "rawtypes" })
	// private int getCardSNCount(int companyId, String cardSN, String sn) {
	// int cardSNCount = this.funcCardService.selectCountByCardSN(companyId,
	// cardSN);
	// if (cardSNCount > 0) {
	// Map map = new HashMap();
	// map.put("'f1'", CardReaderResultCommandCode.ExsitCardSN);
	// TerminalManager.sendToCardManager(map, sn);
	// return 1;
	// }
	// return 0;
	// }

	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(String comm, HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = company.getSerialNumber();
		if ("closeSocketChannel".equals(comm)) {
			try {
				TerminalManager.closeSocketChannel(sn);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 出纳卡
		else if ("makeCashierCardInit".equals(comm) || "lossCashierCardInit".equals(comm) || "unLossCashierCardInit".equals(comm) || "remakeCashierCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					// 获取基本信息区0块
					List<Integer> sectionBlocks = new ArrayList<Integer>();
					sectionBlocks.add(section * 10);
					byte commandCode = 0;
					if ("makeCashierCardInit".equals(comm)) {
						commandCode = CardReaderCommandCode.MakeCashierCard;
					} else if ("lossCashierCardInit".equals(comm)) {
						commandCode = CardReaderCommandCode.LossCashierCard;
					} else if ("unLossCashierCardInit".equals(comm)) {
						commandCode = CardReaderCommandCode.UnLossCashierCard;
					} else if ("remakeCashierCardInit".equals(comm)) {
						commandCode = CardReaderCommandCode.RemakeCashierCard;
					}
					TerminalManager.getCardInfo(socketChannel, device, commandCode, sectionBlocks);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 读取出纳卡
		else if ("readCashierCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					// 获取基本信息区2块
					List<Integer> sectionBlocks = new ArrayList<Integer>();
					sectionBlocks.add(section * 10);
					sectionBlocks.add(section * 10 + 2);
					TerminalManager.getCardInfo(socketChannel, device, CardReaderCommandCode.ReadCashierCard, sectionBlocks);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
