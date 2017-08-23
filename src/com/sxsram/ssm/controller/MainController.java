package com.sxsram.ssm.controller;

import java.util.ArrayList;
import java.util.List;

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
import com.sxsram.ssm.entity.Notice;
import com.sxsram.ssm.entity.NoticeQueryVo;
import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;
import com.sxsram.ssm.exception.SQLOperatorNotSupportedException;
import com.sxsram.ssm.service.MainService;
import com.sxsram.ssm.service.MallService;
import com.sxsram.ssm.service.NoticeService;
import com.sxsram.ssm.util.CommonAddress;
import com.sxsram.ssm.util.IpAddressUtil;
import com.sxsram.ssm.util.JsonResult;
import com.sxsram.ssm.util.Pagination;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	@Autowired
	private MallService mallService;
	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value = "/main/getUserAddressAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getUserAddressAjax(HttpServletRequest request, HttpSession session, Model model) {
		String ipString = IpAddressUtil.getIpAddr(request);
		CommonAddress commonAddress = IpAddressUtil.getAddressByIp(ipString);
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");
		if (commonAddress != null)
			jsonResult.resultObj = commonAddress;
		else {
			jsonResult.logicCode = "1";
		}
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/main/onlineCommodityTypesAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String onlineCommodityTypes(HttpSession session, Model model) {
		Gson gson = new Gson();
		List<OnlineCommodityType> onlineCommodityTypes = null;
		try {
			onlineCommodityTypes = mainService.getOnlineCommodityTypes();
		} catch (Exception e) {
			e.printStackTrace();
		}
		JsonResult jsonResult = new JsonResult("0", "0");
		jsonResult.resultObj = onlineCommodityTypes;
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/main/index", method = { RequestMethod.GET })
	public String mainPage(HttpSession session, Model model) {
		List<OnlineCommodityType> onlineCommodityTypes = null;
		List<NoticeType> noticeTypes = null;
		List<OnlineCommodity> onlineCommodities = null;
		List<ShoppingMallExpand> shoppingMallExpands = null;

		try {
			onlineCommodityTypes = mainService.getOnlineCommodityTypes();
			noticeTypes = mainService.getNoticeTypes();
			OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
			onLineCommodityQueryVo.setPagination(new Pagination(10, 1, null, "{\"commodityPutawayTime\":\"desc\"}"));
			onlineCommodities = mainService.getOnlineCommodities(onLineCommodityQueryVo);

			ShoppingMallExpandQueryVo shoppingMallExpandQueryVo = new ShoppingMallExpandQueryVo();
			shoppingMallExpandQueryVo.setPagination(new Pagination(8, 1, null, "{\"s.createTime\":\"desc\"}"));
			shoppingMallExpands = mallService.getShoppingMalls(shoppingMallExpandQueryVo);

			session.setAttribute("onlineCommodityTypes", onlineCommodityTypes);
			session.setAttribute("noticeTypes", noticeTypes);

			model.addAttribute("onlineCommodityTypes", onlineCommodityTypes);
			model.addAttribute("noticeTypes", noticeTypes);
			model.addAttribute("onlineCommodities", onlineCommodities);
			model.addAttribute("shoppingMallExpands", shoppingMallExpands);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}

	@RequestMapping(value = "/main/noticeDetail/{id}", method = { RequestMethod.GET, RequestMethod.POST })
	public String noticeDetail(HttpSession session, Model model, @PathVariable("id") Integer id) {
		NoticeQueryVo noticeQueryVo = new NoticeQueryVo();
		List<QueryConditionItem> whereCondList = new ArrayList<QueryConditionItem>();
		whereCondList.add(new QueryConditionItem("n.id", id + "", QueryConditionOp.EQ));
		Notice notice = null;
		try {
			noticeQueryVo.setQueryCondition(new QueryCondition(whereCondList));
			notice = noticeService.getSingleNotice(noticeQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("notice", notice);
		return "noticeDetail";
	}
}