package com.sxsram.ssm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sxsram.ssm.entity.AccountExpand;
import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.entity.OnlineJournalBook;
import com.sxsram.ssm.entity.OnlineJournalBookItem;
import com.sxsram.ssm.entity.RecvCommodityAddress;
import com.sxsram.ssm.entity.RecvCommodityAddressQueryVo;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.exception.CommodityModelNumNotEnoughException;
import com.sxsram.ssm.exception.SQLOperatorNotSupportedException;
import com.sxsram.ssm.service.CommodityService;
import com.sxsram.ssm.service.MemberService;
import com.sxsram.ssm.service.OrderService;
import com.sxsram.ssm.util.JsonResult;
import com.sxsram.ssm.util.OrderUtil;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

@Controller
public class OrderController {
	@Autowired
	private CommodityService commodityService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private OrderService orderService;

	@RequestMapping(value = "/order/confirm", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderConfirm(HttpServletRequest request, HttpSession session, Model model) {

		// 1.购物车操作
		Double totalPrice = 0d;
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");

		if (carts != null) {
			Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
			for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
				OnlineCommodityModel key = entry.getKey();
				totalPrice += key.getCommodityPrice() * entry.getValue();
			}
		}

		Integer totalNum = 0;
		if (carts != null) {
			totalNum = carts.size();
		}

		// 2.收获地址操作
		List<RecvCommodityAddress> recvCommodityAddresses = null;
		UserExpand userExpand = (UserExpand) session.getAttribute("user");
		RecvCommodityAddressQueryVo recvCommodityAddressQueryVo = new RecvCommodityAddressQueryVo();
		List<QueryConditionItem> items = new ArrayList<>();
		items.add(new QueryConditionItem("userId", userExpand.getId() + "", QueryConditionOp.EQ));
		try {
			recvCommodityAddressQueryVo.setQueryCondition(new QueryCondition(items));
			recvCommodityAddresses = memberService.getRecvCommodityAddress(recvCommodityAddressQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("addrList", recvCommodityAddresses);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("discountPrice", 0.0);
		model.addAttribute("totalNum", totalNum);
		return "orderConfirm";
	}

	@RequestMapping(value = "/order/del/{id}", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderDel(HttpServletRequest request, HttpSession session, Model model,
			@PathVariable("id") Integer addrId) {
		try {
			memberService.delRecvCommodityAddress(addrId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/order/confirm";
	}

	@RequestMapping(value = "/order/add", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String orderAdd(HttpServletRequest request, HttpSession session, Model model, RecvCommodityAddress addr) {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");
		UserExpand userExpand = (UserExpand) session.getAttribute("user");
		addr.setUser(userExpand);
		try {
			memberService.addNewRecvCommodityAddress(addr);
			jsonResult.url = request.getContextPath() + "/order/confirm";
		} catch (Exception e) {
			jsonResult.logicCode = "-1";
			e.printStackTrace();
		}
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/order/submitAjax/{addrId}", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String orderSubmit(HttpServletRequest request, HttpSession session, Model model,
			@PathVariable("addrId") Integer addrId) {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");
		UserExpand userExpand = (UserExpand) session.getAttribute("user");
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");

		synchronized (userExpand.getId()) {
			if (userExpand == null) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = "登录超时，请重新登录";
				return gson.toJson(jsonResult);
			}
			if (carts == null || carts.size() == 0) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = "购买商品超时，请返回主页重新购买.";
				return gson.toJson(jsonResult);
			}

			// 1.计算总金额
			Double totalPrice = 0d;
			Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
			for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
				OnlineCommodityModel key = entry.getKey();
				totalPrice += key.getCommodityPrice() * entry.getValue();
			}

			// 2.获取用户聚得币
			Double jdbBalance = 0d;
			try {
				AccountExpand jdbAccount = memberService.getJdbAccountByUserId(userExpand.getId());
				if (jdbAccount != null) {
					jdbBalance = jdbAccount.getAccountBalance();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (jdbBalance < totalPrice) {
				jsonResult.logicCode = "-3";
				jsonResult.resultMsg = "聚得币余额不足，您的当前可用余额为：￥" + jdbBalance;
				return gson.toJson(jsonResult);
			}

			// 3. 生成订单
			OnlineJournalBook newOrder = new OnlineJournalBook();
			newOrder.setOrderNo(OrderUtil.getOrderIdByUUId());
			newOrder.setTotalAmount(totalPrice);
			newOrder.setReceiveType(1);// 邮寄
			newOrder.setPostage(15d);
			newOrder.setStatus(0);// 0已付款 1已发货 2确认收货
			newOrder.setRecvCommodityAddressId(addrId);
			newOrder.setUserId(userExpand.getId());

			// Set<Entry<OnlineCommodityModel, Integer>> entrys =
			// carts.entrySet();
			for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
				OnlineCommodityModel key = entry.getKey();
				// totalPrice += key.getCommodityPrice() * entry.getValue();
				newOrder.getItems()
						.add(new OnlineJournalBookItem(entry.getValue(), key.getCommodityPrice(), key.getId()));
			}

			// 4.购买：更新余额 + 创建订单 + 创建订单项
			try {
				// 购买
				orderService.purchase(newOrder, -1 * totalPrice, "线上消费", userExpand.getId());

				// 更新余额
				// memberService.updateJdbBalance(-1 * totalPrice, "线上消费",
				// userExpand.getId());
				// 创建订单
				// orderService.addNewOrder(newOrder);
			} catch (CommodityModelNumNotEnoughException e) {
				e.printStackTrace();
				jsonResult.logicCode = "-4";
				jsonResult.resultMsg = e.getMessage();
				return gson.toJson(jsonResult);
			}catch (Exception e) {
				e.printStackTrace();
				jsonResult.logicCode = "-4";
				jsonResult.resultMsg = "购买失败，原因：【更新余额失败/生成订单失败】";
				return gson.toJson(jsonResult);
			}

			// 5.清空购物车
			((Map<OnlineCommodityModel, Integer>) session.getAttribute("carts")).clear();

			// 6.跳转到订单完成界面
			jsonResult.url = request.getContextPath() + "/order/completed/" + newOrder.getId();
		}
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/order/completed/{orderId}", method = { RequestMethod.GET, RequestMethod.POST })
	public String orderCompleted(HttpServletRequest request, HttpSession session, Model model,
			@PathVariable Integer orderId) {
		OnlineJournalBook order = null;
		try {
			order = orderService.getOnlineOrderById(orderId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("order", order);
		return "orderCompleted";
	}
}