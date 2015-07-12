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
import com.singbon.entity.Batch;
import com.singbon.entity.CardAllInfo;
import com.singbon.entity.CardFunc;
import com.singbon.entity.CardIdentity;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.SysUser;
import com.singbon.entity.User;
import com.singbon.entity.UserDept;
import com.singbon.service.mainCard.MainCardService;
import com.singbon.service.system.CompanyService;
import com.singbon.service.systemManager.BatchService;
import com.singbon.service.systemManager.DiscountService;
import com.singbon.service.systemManager.UserDeptService;
import com.singbon.util.StringUtil;

/**
 * 卡制作控制类
 * 
 * @author 郝威
 * 
 */
@Controller
@RequestMapping(value = "/cardManager/mainCard")
public class MainCardController extends BaseController {

	@Autowired
	MainCardService mainCardService;
	@Autowired
	public UserDeptService userDeptService;
	@Autowired
	public BatchService batchService;
	@Autowired
	public DiscountService discountService;
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

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		return url.replace(".do", "");
	}

	/**
	 * 人员部门树列表
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = this.userDeptService.selectTreeList(company.getId());
		model.addAttribute("list", list);
		return StringUtil.requestPath(request, "userDeptTreeList");
	}

	/**
	 * 获取用户列表
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String userList(HttpServletRequest request, Integer deptId, String searchStr, Model model) throws Exception {
		Company company = (Company) request.getSession().getAttribute("company");
		if ("".equals(searchStr) || "null".equals(searchStr)) {
			searchStr = null;
		}
		List<User> list = this.mainCardService.selectByCondition(deptId, searchStr);
		model.addAttribute("list", list);
		model.addAttribute("base", StringUtil.requestBase(request));
		model.addAttribute("searchStr", searchStr);
		return StringUtil.requestPath(request, "userList");
	}

	/**
	 * 用户信息页面
	 * 
	 * @param id
	 * @param deptId
	 * @param batchId
	 * @param editType
	 *            0信息录入，1修改，2单个发卡，3信息发卡
	 * @param sn
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/userInfo.do", method = RequestMethod.GET)
	public String userInfo(Integer userId, Integer deptId, Integer batchId, Integer editType, HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		List<CardFunc> cardFuncList = new ArrayList<CardFunc>();
		List<CardIdentity> cardIdentityList = new ArrayList<CardIdentity>();
		CardFunc m1 = new CardFunc();
		m1.setId(0);
		m1.setFuncName("银校卡");
		CardFunc m2 = new CardFunc();
		m2.setId(1);
		m2.setFuncName("临时卡");
		CardFunc m3 = new CardFunc();
		m3.setId(2);
		m3.setFuncName("身份卡");

		cardFuncList.add(m1);
		cardFuncList.add(m2);
		cardFuncList.add(m3);

		CardIdentity m4 = new CardIdentity();
		m4.setId(1);
		m4.setIdentityName("教师");
		CardIdentity m5 = new CardIdentity();
		m5.setId(2);
		m5.setIdentityName("学生");
		CardIdentity m6 = new CardIdentity();
		m6.setId(3);
		m6.setIdentityName("职工");
		CardIdentity m7 = new CardIdentity();
		m7.setId(4);
		m7.setIdentityName("临时人员");
		CardIdentity m8 = new CardIdentity();
		m8.setId(5);
		m8.setIdentityName("其他");

		cardIdentityList.add(m4);
		cardIdentityList.add(m5);
		cardIdentityList.add(m6);
		cardIdentityList.add(m7);
		cardIdentityList.add(m8);

		List<Discount> discountList = discountService.selectList(company.getId());
		Batch batch = batchService.selectById(batchId);
		model.addAttribute("discountList", discountList);
		model.addAttribute("cardFuncList", cardFuncList);
		model.addAttribute("cardIdentityList", cardIdentityList);

		model.addAttribute("batch", batch);
		model.addAttribute("base", StringUtil.requestBase(request));
		model.addAttribute("deptId", deptId);
		model.addAttribute("editType", editType);
		if (userId != null) {
			User user = this.mainCardService.selectById(userId);
			model.addAttribute("user", user);
		}
		if (device != null) {
			model.addAttribute("sn", sn);
			// 读卡机状态
			if (TerminalManager.getSNToSocketChannelList().containsKey(sn)) {
				model.addAttribute("cardStatus", 1);
			} else {
				model.addAttribute("cardStatus", 0);
			}
		} else {
			model.addAttribute("cardStatus", 0);
		}

		return StringUtil.requestPath(request, "userInfo");
	}

	/**
	 * 获取重复物理卡号数量
	 * 
	 * @param companyId
	 * @param cardSN
	 * @param sn
	 * @return
	 */
	private int getCardSNCount(int companyId, String cardSN, String sn) {
		int cardSNCount = this.mainCardService.selectCountByCardSN(companyId, cardSN);
		if (cardSNCount > 0) {
			Map map = new HashMap();
			map.put("'f1'", FrameCardReader.ExsitCardSN);
			String msg = JSONUtil.convertToJson(map);
			TerminalManager.getEngineInstance().sendToAll("c" + sn, msg);
			return 1;
		}
		return 0;
	}

	/**
	 * 添加修改人员信息和发卡
	 * 
	 * @param user用户信息
	 * @param editType操作类型
	 *            0信息录入，1信息修改，2单个发卡，3信息发卡
	 * @param opCash预发金额
	 * @param giveCash赠送金额
	 * @param cardCost开户卡成本
	 * @param cardDeposit卡押金
	 * @param request
	 * @param response
	 * @param model
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute User user, @ModelAttribute CardAllInfo cardAllInfo, Integer editType, Integer batchId, String cardSN, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = companyService.getSection(company.getId());
		PrintWriter p = null;
		int allOpCash = (cardAllInfo.getOpCash() + cardAllInfo.getGiveCash()) * 100;
		int cardOpCounter = allOpCash > 0 ? 1 : 0;
		// 单个发卡
		if (editType == 2) {
			int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					int cardNO = this.mainCardService.selectMaxCardNO(company.getId());
					user.setCompanyId(company.getId());
					user.setStatus(1);
					user.setCardSeq(1);
					user.setCardNO(cardNO);
					user.setCardMakeDate(new Date());
					user.setCardTotalFare(allOpCash);
					user.setCardOddFare(allOpCash);
					user.setDaySumFare(allOpCash);
					user.setCardOPCounter(cardOpCounter);

					cardAllInfo.setLimitDayFare(0);
					cardAllInfo.setLimitTimesFare(0);
					cardAllInfo.setLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });
					cardAllInfo.setCardBatch(batchId);

					this.mainCardService.makeCard(device, socketChannel, user, cardAllInfo, cardSN, CommandCodeCardReader.SingleCard, section);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 信息发卡
		else if (editType == 3) {
			int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					User user2 = this.mainCardService.selectById(user.getUserId());
					user2.setCardSN(user.getCardSN());
					int cardNO = this.mainCardService.selectMaxCardNO(company.getId());
					user2.setCardNO(cardNO);
					user2.setCardTotalFare(allOpCash);
					user2.setCardOddFare(allOpCash);
					user2.setDaySumFare(allOpCash);
					user2.setCardOPCounter(cardOpCounter);

					cardAllInfo.setLimitDayFare(0);
					cardAllInfo.setLimitTimesFare(0);
					cardAllInfo.setLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });

					Batch batch = this.batchService.selectByDeptId(user2.getDeptId());
					if (batch == null) {
						cardAllInfo.setCardBatch(0);
					} else {
						cardAllInfo.setCardBatch(batch.getId());
					}
					this.mainCardService.makeCard(device, socketChannel, user2, cardAllInfo, cardSN, CommandCodeCardReader.InfoCard, section);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (editType == 0 || editType == 1) {
			user.setCompanyId(company.getId());
			user.setStatus(0);
			try {
				p = response.getWriter();
				if (user.getUserId() == null) {
					int userNONum = this.mainCardService.selectCountByUserNO(company.getId(), user.getUserNO());
					if (userNONum > 0) {
						p.print(2);
						return;
					}
					this.mainCardService.save(user);
				} else {
					int userNONum = this.mainCardService.selectCountByUserNOUserId(company.getId(), user.getUserNO(), user.getUserId());
					if (userNONum > 0) {
						p.print(2);
						return;
					}
					this.mainCardService.update(user);
				}
				p.print(1);
			} catch (Exception e) {
				p.print(0);
			}
		}
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public void delete(HttpServletRequest request, HttpServletResponse response, Integer deptId, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.mainCardService.delete(deptId);
			p.print(1);
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 单个发卡初始化
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/singleCardInit.do", method = RequestMethod.POST)
	public void singleCardInit(String userNO, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			int userNONum = this.mainCardService.selectCountByUserNO(company.getId(), userNO);
			if (userNONum > 0) {
				p.print(2);
			} else {
				SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(device.getSn());
				if (socketChannel != null) {
					try {
						TerminalManager.getCardSNToMakeCard(socketChannel, device, CommandCodeCardReader.SingleCard, 1);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				p.print(1);
			}
		} catch (Exception e) {
			p.print(0);
		}
	}

	/**
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(String comm, HttpServletRequest request, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		SysUser user = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = TerminalManager.getSection(company.getId());
		// 获取读卡器状态
		if ("getCardReaderStatus".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getCardReaderHeartStatus(socketChannel);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 关闭连接通道
		else if ("closeSocketChannel".equals(comm)) {
			try {
				TerminalManager.closeSocketChannel(sn);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 信息发卡初始化
		else if ("infoCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getCardSNToMakeCard(socketChannel, device, CommandCodeCardReader.InfoCard, 1);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 解挂初始化
		else if ("unlossInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getBaseCardInfoToUnloss(socketChannel, device, 1);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 补卡初始化
		else if ("remakeCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getCardSNToMakeCard(socketChannel, device, CommandCodeCardReader.RemakeCard, 1);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 换卡读原卡
		else if ("readOldCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getOldCardInfoToChangeCard(socketChannel, device, section);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		// 换卡换新卡
		else if ("changeNewCardInit".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getCardSNToChangeCard(socketChannel, device, section);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 变更卡首页
	 * 
	 * @param userId
	 * @param editType
	 *            0挂失，1解挂，2补卡，3换卡，4注销
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/changeCard.do")
	public String changeCard(Integer userId, Integer editType, HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/changeCard.do", ""));
		User user = this.mainCardService.selectById(userId);
		model.addAttribute("user", user);
		model.addAttribute("device", device);
		model.addAttribute("editType", editType);

		model.addAttribute("sn", sn);

		// 读卡机状态
		if (TerminalManager.getSNToSocketChannelList().containsKey(sn)) {
			model.addAttribute("cardStatus", 1);
		} else {
			model.addAttribute("cardStatus", 0);
		}
		return url.replace(".do", "");
	}

	/**
	 * 变更卡
	 * 
	 * @param userId
	 * @param editType
	 *            0挂失，1解挂，2补卡，3换卡，4注销
	 * @param cardSN
	 *            物理卡号
	 * @param newCardSN
	 *            新物理卡号，换新卡用
	 * @param cardInfoStr
	 *            卡信息
	 * @param request
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/doChangeCard.do", method = RequestMethod.POST)
	public void doChangeCard(Integer userId, Integer editType, Integer lossReason, String cardSN, String newCardSN, String cardInfoStr, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();

		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 挂失
		if (editType == 0) {
			try {
				this.mainCardService.changeStatus(userId, 2);
				p.print(1);
			} catch (Exception e) {
				p.print(2);
				e.printStackTrace();
			}
		}
		// 解挂
		else if (editType == 1) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					this.mainCardService.unloss(userId, socketChannel, device, cardSN, cardInfoStr);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 补卡
		else if (editType == 2) {
			int cardSNCount = getCardSNCount(company.getId(), cardSN, sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					User user = this.mainCardService.selectById(userId);
					user.setCardSN(cardSN);
					int cardNO = this.mainCardService.selectMaxCardNO(company.getId());
					user.setCardNO(cardNO);
					user.setCardSeq(user.getCardSeq() + 1);

					CardAllInfo cardAllInfo = new CardAllInfo();
					cardAllInfo.setLimitDayFare(0);
					cardAllInfo.setLimitTimesFare(0);
					cardAllInfo.setLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });
					cardAllInfo.setCardDeposit(0);

					Batch batch = this.batchService.selectByDeptId(user.getDeptId());
					if (batch == null) {
						cardAllInfo.setCardBatch(0);
					} else {
						cardAllInfo.setCardBatch(batch.getId());
					}
					this.mainCardService.makeCard(device, socketChannel, user, cardAllInfo, cardSN, CommandCodeCardReader.RemakeCard, 1);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 换新卡
		else if (editType == 3) {
			int cardSNCount = getCardSNCount(company.getId(), newCardSN, sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					this.mainCardService.changeNewCard(company.getId(), userId, socketChannel, device, newCardSN, cardInfoStr);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
