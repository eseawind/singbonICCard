package com.singbon.controller.cardManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.singbon.controller.BaseController;
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
import com.singbon.service.systemManager.BatchService;
import com.singbon.service.systemManager.DeviceService;
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
	public DeviceService deviceService;

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
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("company", company);

		String url = request.getRequestURI();
		model.addAttribute("base", url.replace("/index.do", ""));
		Device device = this.deviceService.selectByUserId(sysUser.getId());
		model.addAttribute("device", device);
		return url.replace(".do", "");
	}

	/**
	 * 添加修改人员信息和发卡
	 * 
	 * @param user用户信息
	 * @param editType操作类型
	 * @param opCash预发金额
	 * @param giveCash赠送金额
	 * @param cardCost开户卡成本
	 * @param cardDeposit卡押金
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(value = "/addEdit.do")
	public void addEdit(@ModelAttribute User user, Integer editType, Integer opCash, Integer giveCash, Integer cardCost, Integer cardDeposit, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		PrintWriter p = null;
		// 信息发卡
		if (editType == 3) {
			Device device = (Device) request.getSession().getAttribute("device");
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(device.getSn());
			if (socketChannel != null) {
				try {
					User user2 = this.mainCardService.selectById(user.getUserId());
					CardAllInfo cardAllInfo = new CardAllInfo();
					cardAllInfo.setCardCost(cardCost);
					cardAllInfo.setCardDeposit(cardDeposit);
					cardAllInfo.setLimitDayFare(0);
					cardAllInfo.setLimitTimesFare(0);
					cardAllInfo.setOpCash(opCash + giveCash);

					this.mainCardService.infoCard(device.getSn(), socketChannel, user2, cardAllInfo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (editType == 0 || editType == 1) {
			Company company = (Company) request.getSession().getAttribute("company");
			user.setCompanyId(company.getId());
			user.setStatus(0);
			try {
				p = response.getWriter();
				if (user.getUserId() == null) {
					this.mainCardService.save(user);
				} else {
					this.mainCardService.update(user);
				}
				p.print(1);
			} catch (Exception e) {
				p.print(0);
			}
		}
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
	 */
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String userList(HttpServletRequest request, Integer deptId, String searchStr, Model model) {
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
	public String userInfo(Integer id, Integer deptId, Integer batchId, Integer editType, HttpServletRequest request, Model model) {
		SysUser sysUser = (SysUser) request.getSession().getAttribute("sysUser");
		Company company = (Company) request.getSession().getAttribute("company");
		Device device = (Device) request.getSession().getAttribute("device");

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

		if (id != null) {
			User user = this.mainCardService.selectById(id);
			model.addAttribute("user", user);
		}
		model.addAttribute("sn", device.getSn());

		// 读卡机状态
		if (TerminalManager.getSNToSocketChannelList().containsKey(device.getSn())) {
			model.addAttribute("cardStatus", 1);
		} else {
			model.addAttribute("cardStatus", 0);
		}
		return StringUtil.requestPath(request, "userInfo");
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
	 * 命令处理
	 * 
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/command.do", method = RequestMethod.POST)
	public void command(String comm, HttpServletRequest request, Model model) {
		SysUser user = (SysUser) request.getSession().getAttribute("sysUser");
		Device device = (Device) request.getSession().getAttribute("device");
		String sn = device.getSn();
		// 获取读卡器状态
		if ("getCardReaderStatus".equals(comm)) {
			SocketChannel socketChannel = TerminalManager.getSNToSocketChannelList().get(sn);
			if (socketChannel != null) {
				try {
					TerminalManager.getCardReaderHeartStatus(socketChannel);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		// 关闭连接通道
		else if ("closeSocketChannel".equals(comm)) {
			try {
				TerminalManager.closeSocketChannel(sn);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
