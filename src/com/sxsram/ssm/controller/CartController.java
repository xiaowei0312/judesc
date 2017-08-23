package com.sxsram.ssm.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.exception.CommodityModelNotFoundException;
import com.sxsram.ssm.exception.CommodityModelNotFoundFromCartException;
import com.sxsram.ssm.exception.CommodityModelNumNotEnoughException;
import com.sxsram.ssm.service.CommodityService;
import com.sxsram.ssm.util.JsonResult;

@Controller
public class CartController {
	@Autowired
	private CommodityService commodityService;

	@RequestMapping(value = "/cart/cartsNumAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String cartsNum(HttpSession session, Model model) {
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		Integer cartsNum = 0;
		if (carts != null)
			cartsNum = carts.size();
		JsonResult jsonResult = new JsonResult("0", "0");
		jsonResult.resultObj = cartsNum;
		Gson gson = new Gson();
		return gson.toJson(jsonResult);
	}

	private void checkNum(OnlineCommodityModel model, Integer buyNum,Integer oldNum) throws CommodityModelNumNotEnoughException {
		if (model.getCommodityRepertory() < buyNum) {
			throw new CommodityModelNumNotEnoughException(model.getOnlineCommodity().getCommodityName(),
					model.getCommodityRepertory(), buyNum,oldNum);
		}
	}

	/**
	 * @param sku
	 * @param num
	 * @param session
	 * @return 购物车中商品数量
	 * @throws Exception
	 */
	private Integer addToCart(Integer sku, Integer num, HttpSession session) throws Exception {
		if (num == null || num <= 0)
			return null;
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts == null) {
			carts = new HashMap<OnlineCommodityModel, Integer>();
			session.setAttribute("carts", carts);
		}
		Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
		Boolean isFind = false;
		for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
			OnlineCommodityModel key = entry.getKey();
			if (key.getId() == sku) {
				// 检查库存，不足则抛出异常
				OnlineCommodityModel model = commodityService.getOnlineCommodityModelById(key.getId());
				checkNum(model, entry.getValue() + num,entry.getValue());
				carts.put(key, entry.getValue() + num);
				isFind = true;
				break;
			}
		}
		if (!isFind) {
			OnlineCommodityModel onlineCommodity = commodityService.getOnlineCommodityModelById(sku);
			// 检查库存，不足则抛出异常
			checkNum(onlineCommodity, num,0);
			if (onlineCommodity == null) {
				throw new CommodityModelNotFoundException(sku);
			}
			carts.put(onlineCommodity, num);
		}
		return carts.size();
	}

	private Integer subFromCart(Integer sku, Integer num, HttpSession session) throws Exception {
		if (num == null || num <= 0)
			return null;
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts == null) {
			throw new CommodityModelNotFoundFromCartException();
		}
		Integer finalNum = 0;
		Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
		Boolean isFind = false;
		for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
			OnlineCommodityModel key = entry.getKey();
			if (key.getId() == sku) {
				// 检查库存，不足则抛出异常
				OnlineCommodityModel model = commodityService.getOnlineCommodityModelById(key.getId());
				checkNum(model, entry.getValue() - num,entry.getValue());

				finalNum = entry.getValue() - num;
				if (finalNum > 0)
					carts.put(key, finalNum);
				else
					carts.remove(key);
				isFind = true;
				break;
			}
		}
		if (!isFind) {
			throw new CommodityModelNotFoundFromCartException();
		}
		return carts.size();
	}

	private Integer modifyFromCart(Integer sku, Integer num, HttpSession session) throws Exception {
		if (num == null || num <= 0)
			return null;
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts == null) {
			throw new CommodityModelNotFoundFromCartException();
		}
		Integer finalNum = 0;
		Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
		Boolean isFind = false;
		for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
			OnlineCommodityModel key = entry.getKey();
			if (key.getId() == sku) {
				// 检查库存，不足则抛出异常
				OnlineCommodityModel model = commodityService.getOnlineCommodityModelById(key.getId());
				checkNum(model, num,entry.getValue());

				finalNum = num;
				if (num > 0)
					carts.put(key, finalNum);
				else
					carts.remove(key);
				isFind = true;
				break;
			}
		}
		if (!isFind) {
			throw new CommodityModelNotFoundFromCartException();
		}
		return carts.size();
	}

	private Integer delFromCart(Integer sku, HttpSession session) throws Exception {
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts == null) {
			throw new CommodityModelNotFoundFromCartException();
		}
		Set<Entry<OnlineCommodityModel, Integer>> entrys = carts.entrySet();
		Boolean isFind = false;
		for (Entry<OnlineCommodityModel, Integer> entry : entrys) {
			OnlineCommodityModel key = entry.getKey();
			if (key.getId() == sku) {
				carts.remove(key);
				isFind = true;
				break;
			}
		}
		if (!isFind) {
			throw new CommodityModelNotFoundFromCartException();
		}
		return carts.size();
	}

	private Integer clearCart(HttpSession session) throws Exception {
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts != null)
			carts.clear();
		return 0;
	}

	@RequestMapping(value = "/cart/opAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String cartOperationAjax(HttpSession session, Model model, String flag, Integer sku, Integer num) {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");
		if (flag.equals("add")) {
			try {
				jsonResult.resultObj = addToCart(sku, num, session);
			} catch (CommodityModelNumNotEnoughException e) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = e.getMessage();
				jsonResult.resultObj = e.getOldNum();
			} catch (Exception e) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = e.getMessage();
			}
		} else if (flag.equals("sub")) {
			try {
				jsonResult.resultObj = subFromCart(sku, num, session);
			} catch (CommodityModelNumNotEnoughException e) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = e.getMessage();
				jsonResult.resultObj = e.getOldNum();
			} catch (Exception e) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = e.getMessage();
			}
		} else if (flag.equals("set")) {
			try {
				jsonResult.resultObj = modifyFromCart(sku, num, session);
			} catch (CommodityModelNumNotEnoughException e) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = e.getMessage();
				jsonResult.resultObj = e.getOldNum();
			} catch (Exception e) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = e.getMessage();
			}
		} else if (flag.equals("delete")) {
			try {
				jsonResult.resultObj = delFromCart(sku, session);
			} catch (CommodityModelNumNotEnoughException e) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = e.getMessage();
				jsonResult.resultObj = e.getOldNum();
			} catch (Exception e) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = e.getMessage();
			}
		} else if (flag.equals("clear")) {
			try {
				jsonResult.resultObj = clearCart(session);
			} catch (CommodityModelNumNotEnoughException e) {
				jsonResult.logicCode = "-1";
				jsonResult.resultMsg = e.getMessage();
				jsonResult.resultObj = e.getOldNum();
			} catch (Exception e) {
				jsonResult.logicCode = "-2";
				jsonResult.resultMsg = e.getMessage();
			}
		}
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/cart/show", method = { RequestMethod.GET, RequestMethod.POST })
	public String cartShow(HttpSession session, Model model) {
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
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("discountPrice", 0.0);
		model.addAttribute("totalNum", totalNum);

		return "cartShow";
	}

	@RequestMapping(value = "/cart/confirmAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String cartConfirmAjax(HttpServletRequest request, HttpSession session, Model model) {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");
		// 1.判断购物车中是否有商品
		Map<OnlineCommodityModel, Integer> carts = (Map<OnlineCommodityModel, Integer>) session.getAttribute("carts");
		if (carts == null || carts.size() == 0) {
			jsonResult.logicCode = "-2";
			jsonResult.resultMsg = "您并未选购任何商品.";
			return gson.toJson(jsonResult);
		}

		// 2.判断是否登录
		UserExpand userExpand = (UserExpand) session.getAttribute("user");
		if (userExpand == null) {
			jsonResult.logicCode = "-1";
			jsonResult.resultMsg = "您尚未登录，点击确定跳转到登录页面";
			jsonResult.url = request.getContextPath() + "/member/loginPage";
		} else {
			jsonResult.url = request.getContextPath() + "/order/confirm";
		}
		return gson.toJson(jsonResult);
	}
}