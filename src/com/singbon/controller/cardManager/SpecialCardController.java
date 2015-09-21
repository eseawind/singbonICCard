package com.singbon.controller.cardManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.comet4j.core.util.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.CommandCodeCardReader;
import com.singbon.device.FrameCardReader;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.SysUser;
import com.singbon.service.SysUserService;
import com.singbon.service.mainCard.SpecialCardService;
import com.singbon.service.system.CompanyService;
import com.singbon.util.StringUtil;

/**
 * 功能卡制作控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager/specialCard")
public class SpecialCardController extends BaseController {

	@Autowired
	public SysUserService sysUserService;
	@Autowired
	public SpecialCardService specialCardService;
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
	 * 出纳员列表
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/cashierList.do")
	public String cashierList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		List<SysUser> list = this.sysUserService.selectCashierList(company.getId());
		model.addAttribute("list", list);
		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.jsp", ""));
		return StringUtil.requestPath(request, "cashierList");
	}

	/**
	 * 制出纳卡
	 * 
	 * @param user
	 * @param editType
	 *            0制卡、1补卡
	 * @param invalidDate
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/makeCashierCard.do", method = RequestMethod.POST)
	public void makeCashierCard(@ModelAttribute SysUser user, Integer editType, Date invalidDate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = companyService.getSection(company.getId());

		int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
		if (cardSNCount > 0) {
			return;
		}
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
		if (socketChannel != null) {
			try {
				int cardNO = this.specialCardService.selectMaxCardNO(company.getId());
				byte commandCode = CommandCodeCardReader.MakeCashierCard;
				if (editType == 1) {
					commandCode = CommandCodeCardReader.RemakeCashierCard;
					String cardSN = user.getCardSN();
					user = this.sysUserService.selectByOperId(user.getOperId());
					user.setCardSN(cardSN);
				}
				user.setCardNO(cardNO);
				user.setStatus(1);
				this.specialCardService.makeCashierCard(company.getId(), device, socketChannel, user, commandCode, section);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 挂失
	 * 
	 * @param user
	 * @param invalidDate
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/loss.do", method = RequestMethod.POST)
	public void loss(@ModelAttribute SysUser sysUser, Integer lossType, String cardInfoStr, HttpServletRequest request, HttpServletResponse response, Model model) {
		Device device = (Device) request.getSession().getAttribute("device");
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		if (lossType == 0) {
			try {
				this.specialCardService.changeStatus(sysUser.getOperId(), 2);
				p.print(1);
			} catch (Exception e) {
				p.print(0);
				e.printStackTrace();
			}
		} else {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(device.getSn());
			if (socketChannel != null) {
				try {
					this.specialCardService.loss(sysUser, socketChannel, device, cardInfoStr);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 解挂
	 * 
	 * @param user
	 * @param invalidDate
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/unLoss.do", method = RequestMethod.POST)
	public void unLoss(@ModelAttribute SysUser sysUser, String cardInfoStr, HttpServletRequest request, HttpServletResponse response, Model model) {
		Device device = (Device) request.getSession().getAttribute("device");
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(device.getSn());
		if (socketChannel != null) {
			try {
				this.specialCardService.unloss(sysUser, socketChannel, device, cardInfoStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 修改出纳卡有效期
	 * 
	 * @param user
	 * @param invalidDate
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/doInvalidDate.do", method = RequestMethod.POST)
	public void doInvalidDate(@ModelAttribute SysUser sysUser, String cardInfoStr, HttpServletRequest request, HttpServletResponse response, Model model) {
		Device device = (Device) request.getSession().getAttribute("device");
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(device.getSn());
		if (socketChannel != null) {
			try {
				this.specialCardService.doInvalidDate(sysUser, cardInfoStr, socketChannel, device);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 获取重复物理卡号数量
	 * 
	 * @param companyId
	 * @param cardSN
	 * @param sn
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private int getCardSNCount(int companyId, String cardSN, String sn) {
		int cardSNCount = this.specialCardService.selectCountByCardSN(companyId, cardSN);
		if (cardSNCount > 0) {
			Map map = new HashMap();
			map.put("'f1'", FrameCardReader.ExsitCardSN);
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.EngineInstance.sendToAll("c" + sn, msg);
			return 1;
		}
		return 0;
	}

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
		int section = TerminalManager.getSection(company.getId());
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
						commandCode = CommandCodeCardReader.MakeCashierCard;
					} else if ("lossCashierCardInit".equals(comm)) {
						commandCode = CommandCodeCardReader.LossCashierCard;
					} else if ("unLossCashierCardInit".equals(comm)) {
						commandCode = CommandCodeCardReader.UnLossCashierCard;
					} else if ("remakeCashierCardInit".equals(comm)) {
						commandCode = CommandCodeCardReader.RemakeCashierCard;
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
					TerminalManager.getCardInfo(socketChannel, device, CommandCodeCardReader.ReadCashierCard, sectionBlocks);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
