package com.singbon.controller.cardManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.comet4j.core.util.JSONUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
import com.singbon.device.CardReaderCommandCode;
import com.singbon.device.CardReaderResultCommandCode;
import com.singbon.device.TerminalManager;
import com.singbon.entity.Batch;
import com.singbon.entity.CardAllInfo;
import com.singbon.entity.CardParam;
import com.singbon.entity.Company;
import com.singbon.entity.ConsumeParam;
import com.singbon.entity.Device;
import com.singbon.entity.Discount;
import com.singbon.entity.Pagination;
import com.singbon.entity.SysUser;
import com.singbon.entity.User;
import com.singbon.entity.UserDept;
import com.singbon.service.CommonService;
import com.singbon.service.CompanyService;
import com.singbon.service.mainCard.MainCardService;
import com.singbon.service.systemManager.systemSetting.BatchService;
import com.singbon.service.systemManager.systemSetting.CardParamService;
import com.singbon.service.systemManager.systemSetting.ConsumeParamService;
import com.singbon.service.systemManager.systemSetting.DiscountService;
import com.singbon.service.systemManager.systemSetting.UserDeptService;
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
	public MainCardService mainCardService;
	@Autowired
	public UserDeptService userDeptService;
	@Autowired
	public BatchService batchService;
	@Autowired
	public CompanyService companyService;
	@Autowired
	public CommonService commonService;
	@Autowired
	public CardParamService cardParamService;
	@Autowired
	public ConsumeParamService consumeParamService;
	@Autowired
	public DiscountService discountService;

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
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/treeList.do")
	public String treeList(HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = (List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId());
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
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/list.do")
	public String userList(@ModelAttribute Pagination pagination, Integer deptId, String nameStr, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");

		String[] columns = { "userId", "userNO", "username", "sex", "cardID", "cardTypeId", "status" };
		String fromSql = "user";
		String whereSql = "companyId=" + company.getId();
		if (!StringUtils.isEmpty(nameStr)) {
			whereSql += String.format(" and (userNO like '%%%s%%' or username like '%%%s%%' or shortName like '%%%s%%')", nameStr, nameStr, nameStr);
		}

		if (!StringUtils.isEmpty(deptId) && deptId != -1) {
			whereSql += String.format(" and deptId = %s", deptId);
		}

		List<Map> userList = this.commonService.selectByPage(columns, null, fromSql, whereSql, pagination);
		int totalCount = Integer.valueOf(userList.get(0).get("userId").toString());
		userList.remove(0);

		for (Map m : userList) {
			int sex2 = Integer.valueOf(m.get("sex").toString());
			if (sex2 == 0) {
				m.put("sexDesc", "男");
			} else {
				m.put("sexDesc", "女");
			}
			int status2 = Integer.valueOf(m.get("status").toString());
			String statusDesc = "";
			if (status2 == 0) {
				statusDesc = "未发卡";
			} else if (status2 == 241) {
				statusDesc = "正常";
			} else if (status2 == 243) {
				statusDesc = "挂失";
			} else if (status2 == 244) {
				statusDesc = "注销";
			} else {
				statusDesc = "异常卡";
			}
			m.put("statusDesc", statusDesc);
		}

		model.addAttribute("list", userList);
		model.addAttribute("pageNum", pagination.getPageNum());
		model.addAttribute("numPerPage", pagination.getNumPerPage());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("nameStr", nameStr);
		model.addAttribute("deptId", deptId);

		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "userList");
	}

	/**
	 * 用户信息编辑页面
	 * 
	 * @param id
	 * @param deptId
	 * @param batchId
	 * @param editType
	 *            0信息录入、1修改、2单个发卡、3信息发卡、4批量发卡、5挂失、6补卡
	 * @param sn
	 * @param request
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/editUser.do", method = RequestMethod.GET)
	public String editUser(Long userId, Integer deptId, Integer batchId, Integer editType, HttpServletRequest request, HttpServletResponse response, Model model) {
		request.getSession().removeAttribute("companyId");
		Company company = (Company) request.getSession().getAttribute("company");

		// 批量发卡获取未发卡人员列表
		if (editType == 4) {
			List<User> list = this.mainCardService.selectNoCardByDeptId(deptId);
			model.addAttribute("list", list);

			model.addAttribute("cardID", "123456789012345678");
			model.addAttribute("cardTypeId", 0);

			CardParam cardParam = (CardParam) this.cardParamService.selectByCompanyId(company.getId());
			model.addAttribute("cardDeposit", cardParam.getCardDeposit());

			Batch batch = this.batchService.selectByDeptId(deptId);
			model.addAttribute("beginDate", batch.getBeginDate());
			model.addAttribute("endDate", batch.getEndDate());

			if (list.size() > 0) {
				User user = list.get(0);
				model.addAttribute("user", user);
				model.addAttribute("cardID", user.getCardID());
				model.addAttribute("cardTypeId", user.getCardTypeId());
				model.addAttribute("giveFare", user.getGiveFare());
				model.addAttribute("preOpFare", user.getPreOpFare());
				model.addAttribute("consumePwd", user.getConsumePwd());
			}
		} else {
			// 信息录入、单个发卡
			if (userId == null) {
				CardParam cardParam = (CardParam) this.cardParamService.selectByCompanyId(company.getId());
				model.addAttribute("cardDeposit", cardParam.getCardDeposit());
				model.addAttribute("giveFare", 0);
				model.addAttribute("preOpFare", cardParam.getPrepayFare());

				ConsumeParam consumeParam = (ConsumeParam) this.consumeParamService.selectByCompanyId(company.getId());
				model.addAttribute("consumePwd", consumeParam.getUserPwd());

				Batch batch = this.batchService.selectByDeptId(deptId);
				model.addAttribute("beginDate", batch.getBeginDate());
				model.addAttribute("endDate", batch.getEndDate());

				model.addAttribute("cardID", "123456789012345678");
				model.addAttribute("cardTypeId", 0);
			} else {
				User user = this.mainCardService.selectByUserId(userId);
				model.addAttribute("user", user);

				model.addAttribute("cardID", user.getCardID());
				model.addAttribute("cardTypeId", user.getCardTypeId());

				int status = user.getStatus();
				model.addAttribute("giveFare", user.getGiveFare());
				model.addAttribute("preOpFare", user.getPreOpFare());
				model.addAttribute("consumePwd", user.getConsumePwd());
				model.addAttribute("cardNO", user.getCardNO());
				// 未发卡、信息发卡
				if (status == 0 || status == 3) {
					CardParam cardParam = (CardParam) this.cardParamService.selectByCompanyId(company.getId());
					model.addAttribute("cardDeposit", cardParam.getCardDeposit());
					Batch batch = this.batchService.selectByDeptId(user.getDeptId());
					model.addAttribute("beginDate", batch.getBeginDate());
					model.addAttribute("endDate", batch.getEndDate());
				} else {
					model.addAttribute("cardDeposit", user.getCardDeposit());
					model.addAttribute("beginDate", user.getBeginDate());
					model.addAttribute("endDate", user.getEndDate());
				}
			}
		}

		// 判断读卡机状态
		if (editType == 2 || editType == 3 || editType == 4 || editType == 6) {
			Device device = (Device) request.getSession().getAttribute("device");
			if (device != null) {
				String sn = device.getSn();
				// 读卡机状态
				if (TerminalManager.SNToSocketChannelList.containsKey(sn)) {
					model.addAttribute("cardStatus", 1);
				} else {
					model.addAttribute("cardStatus", 0);
				}
			}
		}

		List<Discount> discountList = (List<Discount>) discountService.selectListByCompanyId(company.getId());
		model.addAttribute("discountList", discountList);
		model.addAttribute("deptId", deptId);
		model.addAttribute("batchId", batchId);
		model.addAttribute("editType", editType);
		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "editUser");

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
	private int getCardSNCount(Integer companyId, String cardSN, String sn) {
		int cardSNCount = this.mainCardService.selectCountByCardSN(companyId, cardSN);
		if (cardSNCount > 0) {
			Map map = new HashMap();
			map.put("'f1'", CardReaderResultCommandCode.ExsitCardSN);
			TerminalManager.sendToCardManager(map, sn);
			return 1;
		}
		return 0;
	}

	/**
	 * 添加修改人员信息和发卡
	 * 
	 * @param user用户信息
	 * @param editType操作类型
	 *            0信息录入，1信息修改，2单个发卡，3信息发卡，4批量发卡，5挂失，6补卡
	 * @param opCash预发金额
	 * @param giveCash赠送金额
	 * @param cardCost开户卡成本
	 * @param cardDeposit卡押金
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/saveUser.do", method = RequestMethod.POST)
	public void saveUser(@ModelAttribute User user, @ModelAttribute CardAllInfo cardAllInfo, Integer editType, Integer batchId, Integer lossReason, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = company.getBaseSection();
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		int allOpFare = 0;
		if (editType != 5 && editType != 6) {
			allOpFare = (user.getPreOpFare() + user.getGiveFare() - user.getCardDeposit()) * 100;
		}
		int cardOpCounter = allOpFare > 0 ? 1 : 0;
		// 单个发卡
		if (editType == 2) {
			int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					long cardNO = this.mainCardService.selectMaxCardNO(company.getId());
					user.setCompanyId(company.getId());
					user.setStatus(241);
					user.setCardSeq(1);
					user.setCardNO(cardNO);
					user.setTotalFare(allOpFare);
					user.setOddFare(allOpFare);
					user.setOpCount(cardOpCounter);

					initUserInfo(user, cardAllInfo);

					cardAllInfo.setCardBatch(batchId);

					this.mainCardService.makeCardByUserInfo(sysUser, device, socketChannel, user, cardAllInfo, CardReaderCommandCode.SingleCard, section);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// 信息发卡、批量发卡、补卡
		else if (editType == 3 || editType == 4 || editType == 6) {
			int cardSNCount = getCardSNCount(company.getId(), user.getCardSN(), sn);
			if (cardSNCount > 0) {
				return;
			}
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					User user2 = this.mainCardService.selectByUserId(user.getUserId());
					user2.setCardSN(user.getCardSN());
					long cardNO = this.mainCardService.selectMaxCardNO(company.getId());
					user2.setStatus(241);
					user2.setCardNO(cardNO);
					// 非补卡，金额信息以修改的为准
					if (editType != 6) {
						user2.setTotalFare(allOpFare);
						user2.setOddFare(allOpFare);
						user2.setOpCount(cardOpCounter);
					}
					initUserInfo(user2, cardAllInfo);

					Batch batch = this.batchService.selectByDeptId(user2.getDeptId());
					if (batch == null) {
						cardAllInfo.setCardBatch(0);
					} else {
						cardAllInfo.setCardBatch(batch.getId());
					}
					int commandCode = CardReaderCommandCode.InfoCard;
					if (editType == 6) {
						commandCode = CardReaderCommandCode.RemakeCard;
					}
					this.mainCardService.makeCardByUserInfo(sysUser, device, socketChannel, user2, cardAllInfo, commandCode, section);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 0信息录入，1信息修改
		} else if (editType == 0 || editType == 1) {
			user.setCompanyId(company.getId());
			user.setStatus(0);
			try {
				if (user.getUserId() == null) {
					int userNONum = this.mainCardService.selectCountByUserNO(company.getId(), user.getUserNO());
					if (userNONum > 0) {
						p.print(2);
						return;
					}
					this.mainCardService.insert(user);
				} else {
					Integer userNONum = this.mainCardService.selectCountByUserNOUserId(company.getId(), user.getUserNO(), user.getUserId());
					if (userNONum > 0) {
						p.print(2);
						return;
					}
					this.mainCardService.update(user);
				}
				p.print(1);
			} catch (Exception e) {
				e.printStackTrace();
				p.print(0);
			}
			// 5挂失
		} else if (editType == 5) {
			try {
				user.setCompanyId(company.getId());
				this.mainCardService.loss(sysUser, user, lossReason);
				p.print(1);
			} catch (Exception e) {
				p.print(2);
				e.printStackTrace();
			}
		}
	}

	// 初始化发卡信息
	private void initUserInfo(User user, CardAllInfo cardAllInfo) {
		user.setSubsidyOpCount(0);
		user.setSubsidyOddFare(0);
		user.setSubsidyVersion(0);
		user.setSubsidyDaySum(0);
		user.setSubsidyInvalidDate("2000-01-01");
		cardAllInfo.setLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });
		cardAllInfo.setSubsidyLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });
	}

	/**
	 * 删除未发卡人员
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public void delete(HttpServletRequest request, HttpServletResponse response, String checkedUserIds, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
			String[] userIds2 = checkedUserIds.split(",");
			Long[] userIds = new Long[userIds2.length];
			for (int i = 0; i < userIds2.length; i++) {
				userIds[i] = Long.parseLong(userIds2[i]);
			}
			this.mainCardService.delete(userIds);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
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
		int section = company.getBaseSection();
		PrintWriter p = null;
		try {
			p = response.getWriter();
			int userNONum = this.mainCardService.selectCountByUserNO(company.getId(), userNO);
			if (userNONum > 0) {
				p.print(2);
			} else {
				SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(device.getSn());
				if (socketChannel != null) {
					try {
						// 获取基本扇区0块
						List<Integer> sectionBlocks = new ArrayList<Integer>();
						sectionBlocks.add(section * 10);
						TerminalManager.getCardInfo(socketChannel, device, CardReaderCommandCode.SingleCard, sectionBlocks);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				p.print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 命令处理
	 * 
	 * @param comm
	 * @param editType
	 *            0信息发卡、1补卡、2解挂、3注销、4读卡修正、读取卡余额(存取款用)
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(Integer editType, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = company.getBaseSection();

		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
		if (socketChannel == null) {
			return;
		}
		byte commandCode = 0;
		List<Integer> sectionBlocks = new ArrayList<Integer>();

		// 信息发卡和补卡初始化
		if (editType == 0 || editType == 1) {
			sectionBlocks.add(section * 10);
		} else {
			sectionBlocks.add(section * 10);
			sectionBlocks.add(section * 10 + 2);
			sectionBlocks.add((section + 1) * 10);
			sectionBlocks.add((section + 2) * 10);
		}

		switch (editType) {
		// 信息发卡初始化
		case 0:
			commandCode = CardReaderCommandCode.InfoCard;
			break;
		// 补卡初始化
		case 1:
			commandCode = CardReaderCommandCode.RemakeCard;
			break;
		// 解挂初始化
		case 2:
			commandCode = CardReaderCommandCode.Unloss;
			break;
		// 卡注销初始化
		case 3:
			commandCode = CardReaderCommandCode.CardOff;
			break;
		// 读卡
		case 4:
			commandCode = CardReaderCommandCode.ReadCard;
			break;
		// 读取卡余额
		case 5:
			commandCode = CardReaderCommandCode.ReadCardOddFare;
			break;
		default:
			break;
		}

		if (sectionBlocks.size() == 0)
			return;
		try {
			TerminalManager.getCardInfo(socketChannel, device, commandCode, sectionBlocks);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 变更卡首页
	 * 
	 * @param userId
	 * @param editType
	 *            3解挂，6注销，7读卡修正
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/changeCard.do")
	public String changeCard(Long userId, Integer editType, HttpServletRequest request, HttpServletResponse response, Model model) {
		request.getSession().removeAttribute("companyId");
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/changeCard.do", ""));
		if (editType == 4) {
			User user = this.mainCardService.selectByUserId(userId);
			model.addAttribute("user", user);
		}
		model.addAttribute("editType", editType);

		model.addAttribute("sn", sn);

		// 读卡机状态
		if (TerminalManager.SNToSocketChannelList.containsKey(sn)) {
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
	 *            2解挂、3注销、4读卡修正
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
	@RequestMapping(value = "/doChangeCard.do", method = RequestMethod.POST)
	public void doChangeCard(@ModelAttribute User user, Integer editType, Integer updateType, String cardInfoStr, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		int section = company.getBaseSection();
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}

		user.setCompanyId(company.getId());
		// 解挂
		if (editType == 2) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					this.mainCardService.unloss(sysUser, user, socketChannel, device, cardInfoStr);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 卡注销先注销卡
		} else if (editType == 3) {
			SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
			if (socketChannel != null) {
				try {
					this.mainCardService.cardOffWithInfo(user, socketChannel, device, company.getBaseSection());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 修正
		} else if (editType == 4) {
			// 按卡修正
			if (updateType == 0) {
				try {
					this.mainCardService.updateByCard(user);
					p.print(1);
				} catch (Exception e) {
					p.print(0);
					e.printStackTrace();
				}
			} else {
				SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(sn);
				if (socketChannel != null) {
					try {
						User user2 = this.mainCardService.selectByUserId(user.getUserId());

						CardAllInfo cardAllInfo = new CardAllInfo();
						initUserInfo(user2, cardAllInfo);
						cardAllInfo.setLimitPeriods(new Integer[] { 0, 0, 0, 0, 0, 0 });

						Batch batch = this.batchService.selectByDeptId(user2.getDeptId());
						if (batch == null) {
							cardAllInfo.setCardBatch(0);
						} else {
							cardAllInfo.setCardBatch(batch.getId());
						}
						this.mainCardService.makeCardByUserInfo(sysUser, device, socketChannel, user2, cardAllInfo, CardReaderCommandCode.UpdateByInfo, section);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	/**
	 * 注销人员信息
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/offUserInfoWithInfo.do")
	public void offUserInfoWithInfo(Long userId, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		PrintWriter p = null;
		try {
			p = response.getWriter();
			this.mainCardService.offUserInfoWithInfo(sysUser, userId);
			p.print(1);
		} catch (Exception e) {
			e.printStackTrace();
			p.print(0);
		}
	}

	/**
	 * 通过userId和cardSN获取用户信息
	 * 
	 * @param userId
	 * @param cardSN
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/selectUserInfoByUserIdCardSN.do", method = RequestMethod.POST)
	public void selectUserInfoByUserIdCardSN(Long userId, String cardSN, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map map = new HashMap();
		User user = this.mainCardService.selectByUserIdCardSN(company.getId(), userId, cardSN);
		if (user == null) {
			map.put("'r'", 0);
		} else {
			UserDept userDept = (UserDept) this.userDeptService.selectById(user.getDeptId());
			map.put("'r'", 1);

			map.put("deptName", userDept.getDeptName());
			map.put("'userName'", user.getUsername());
			map.put("'userNO'", user.getUserNO());

			map.put("'cardSN'", user.getCardSN());
			map.put("'userId'", user.getUserId());
			map.put("'cardNO'", user.getCardNO());
			map.put("'endDate'", user.getEndDate());
			map.put("'statusDesc'", user.getStatusDesc());
			map.put("'cardSeq'", user.getCardSeq());
			map.put("'cardTypeId'", user.getCardTypeId());
			map.put("'totalFare'", (float) user.getTotalFare() / 100);
			map.put("'oddFare'", (float) user.getOddFare() / 100);
			map.put("'opCount'", user.getOpCount());
			map.put("'subsidyOddFare'", (float) user.getSubsidyOddFare() / 100);
			map.put("'subsidyOpCount'", user.getSubsidyOpCount());
			map.put("'subsidyVersion'", user.getSubsidyVersion());
		}
		String msg = JSONUtil.convertToJson(map);
		p.print(msg);
	}

	/**
	 * 部门调整首页
	 * 
	 * @param userDept
	 * @param request
	 * @param model
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deptAdjust.do")
	public String deptAdjust(Long userId, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		List<UserDept> list = (List<UserDept>) this.userDeptService.selectListByCompanyId(company.getId());
		model.addAttribute("list", list);
		if (userId != -1) {
			User user = this.mainCardService.selectByUserId(userId);
			model.addAttribute("user", user);
		}
		model.addAttribute("base", StringUtil.requestBase(request));
		return StringUtil.requestPath(request, "deptAdjust");
	}

	/**
	 * 部门调整用户列表
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/adjustUserList.do")
	public String adjustUserList(Integer deptId, String searchStr, Integer selectedUserId, Integer[] userIds, boolean load, HttpServletRequest request, HttpServletResponse response, Model model) {
		if ("".equals(searchStr) || "null".equals(searchStr)) {
			searchStr = null;
		}
		List<User> list = new ArrayList<User>();
		if (load) {
			list = this.mainCardService.selectByCondition(deptId, searchStr);
		}
		model.addAttribute("list", list);
		model.addAttribute("base", StringUtil.requestBase(request));
		model.addAttribute("searchStr", searchStr);
		return StringUtil.requestPath(request, "deptAdjustUserList");
	}

	/**
	 * 部门调整
	 * 
	 * @param adjustType
	 * @param fromDeptId
	 * @param toDeptId
	 * @param selectedUserId
	 * @param userIds
	 * @param request
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/doDeptAdjust.do")
	public void doDeptAdjust(Integer adjustType, Integer fromDeptId, Integer toDeptId, Long selectedUserId, Long[] userIds, HttpServletRequest request, HttpServletResponse response, Model model) {
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (adjustType == 0 || adjustType == 2) {
			if (adjustType == 0) {
				userIds = new Long[1];
				userIds[0] = selectedUserId;
			}
			try {
				this.mainCardService.changeToNewDept(userIds, toDeptId);
				p.print(1);
			} catch (Exception e) {
				p.print(0);
				e.printStackTrace();
			}
		} else if (adjustType == 1) {
			try {
				this.mainCardService.changeFromDeptToNew(fromDeptId, toDeptId);
				p.print(1);
			} catch (Exception e) {
				p.print(0);
				e.printStackTrace();
			}
		}
	}

	/**
	 * 存取款首页
	 * 
	 * @param request
	 * @param model
	 * @param module
	 * @return
	 */
	@RequestMapping(value = "/charge.do")
	public String charge(HttpServletRequest request, HttpServletResponse response, Model model) {
		request.getSession().removeAttribute("companyId");
		Device device = (Device) request.getSession().getAttribute("device");
		model.addAttribute("device", device);
		String sn = device.getSn();
		model.addAttribute("sn", sn);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/charge.do", ""));

		// 读卡机状态
		if (TerminalManager.SNToSocketChannelList.containsKey(sn)) {
			model.addAttribute("cardStatus", 1);
		} else {
			model.addAttribute("cardStatus", 0);
		}
		return url.replace(".do", "");
	}

	/**
	 * 通过userId和cardSN获取卡余额
	 * 
	 * @param userId
	 * @param cardSN
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/selectOddFareByUserIdCardSN.do", method = RequestMethod.POST)
	public void selectOddFareByUserIdCardSN(Long userId, String cardSN, HttpServletRequest request, HttpServletResponse response, Model model) {
		Company company = (Company) request.getSession().getAttribute("company");
		PrintWriter p = null;
		try {
			p = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map map = new HashMap();
		User user = this.mainCardService.selectByUserIdCardSN(company.getId(), userId, cardSN);
		if (user == null) {
			map.put("'r'", 0);
		} else {
			map.put("'r'", 1);

			map.put("'username'", user.getUsername());

			map.put("'userId'", user.getUserId());
			map.put("'userNO'", user.getUserNO());
			map.put("'cardNO'", user.getCardNO());
			map.put("'cardSN'", user.getCardSN());
			map.put("'status'", user.getStatus());
			map.put("'statusDesc'", user.getStatusDesc());

			map.put("'oddFare'", (float) user.getOddFare() / 100);
			map.put("'cardDeposit'", (float) user.getCardDeposit() / 100);
		}
		String msg = JSONUtil.convertToJson(map);
		p.print(msg);
	}

	/**
	 * 存取款
	 * 
	 * @param user
	 * @param chargeType
	 * @param opFare
	 * @param giveFare
	 * @param oddFare
	 * @param cardInfoStr
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/doCharge.do", method = RequestMethod.POST)
	public void doCharge(@ModelAttribute User user, Integer chargeType, String backDeposit, Float oldOddFare, Float newOpFare, Float newGiveFare, String cardInfoStr, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		SocketChannel socketChannel = TerminalManager.SNToSocketChannelList.get(device.getSn());
		if (socketChannel != null) {
			try {
				this.mainCardService.doCharge(sysUser, user, oldOddFare, newOpFare, newGiveFare, socketChannel, device, chargeType, backDeposit, cardInfoStr);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
