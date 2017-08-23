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
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.service.CommodityService;
import com.sxsram.ssm.util.JsonResult;
import com.sxsram.ssm.util.Pagination;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

@Controller
public class CommodityController {
	@Autowired
	private CommodityService commodityService;

	@RequestMapping(value = "/commodity/list/{id}", method = { RequestMethod.GET })
	public String getCommodity(HttpSession session, Model model, @PathVariable("id") Integer catId) {
		Integer totalNum = 0;
		List<QueryConditionItem> whereCondList = new ArrayList<QueryConditionItem>();
		if (catId != null && catId > 0)
			whereCondList.add(new QueryConditionItem("commodityTypeId", catId + "", QueryConditionOp.EQ));
		try {
			OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
			// onLineCommodityQueryVo.setCommodityType(new
			// OnlineCommodityType(catId));
			onLineCommodityQueryVo.setQueryCondition(new QueryCondition(whereCondList));
			totalNum = commodityService.getOnlineCommoditiesTotalNumByCatId(onLineCommodityQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("catId", catId);
		return "commodityList";
	}

	@RequestMapping(value = "/commodity/search/{name}", method = { RequestMethod.GET })
	public String getCommoditySearch(HttpSession session, Model model, @PathVariable("name") String commName) {
		Integer totalNum = 0;
		List<QueryConditionItem> whereCondList = new ArrayList<QueryConditionItem>();
		if (commName != null)
			whereCondList.add(new QueryConditionItem("commodityName", commName + "", QueryConditionOp.LIKE));
		try {
			OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
			onLineCommodityQueryVo.setQueryCondition(new QueryCondition(whereCondList));
			totalNum = commodityService.getOnlineCommoditiesTotalNumByCatId(onLineCommodityQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("commName", commName);
		return "commodityList";
	}

	class PageObj {
		Integer totalCount;
		Object items;

		public PageObj() {
		}

		public PageObj(Integer totalCount, Object objList) {
			this.totalCount = totalCount;
			this.items = objList;
		}
	}

	@RequestMapping(value = "/commodity/listAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getCommodityAjax(HttpSession session, Model model, Integer catId, String commName, Integer page,
			Integer size, Integer total) {
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");

		List<OnlineCommodity> onlineCommodities = null;
		List<QueryConditionItem> whereCondList = new ArrayList<QueryConditionItem>();
		if (catId != null && catId > 0)
			whereCondList.add(new QueryConditionItem("commodityTypeId", catId + "", QueryConditionOp.EQ));
		if (commName != null)
			whereCondList.add(new QueryConditionItem("commodityName", commName + "", QueryConditionOp.LIKE));
		try {
			OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
			// onLineCommodityQueryVo.setCommodityType(new
			// OnlineCommodityType(catId));
			onLineCommodityQueryVo.setQueryCondition(new QueryCondition(whereCondList));
			onLineCommodityQueryVo
					.setPagination(new Pagination(size, page, null, "{\"commodityPutawayTime\":\"desc\"}"));
			onlineCommodities = commodityService.getOnlineCommoditiesByCatId(onLineCommodityQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		jsonResult.resultObj = new PageObj(total, onlineCommodities);
		return gson.toJson(jsonResult);
	}

	@RequestMapping(value = "/commodity/item/{id}", method = { RequestMethod.GET })
	public String getCommodityItem(HttpSession session, Model model, @PathVariable("id") Integer itemId) {
		OnlineCommodity onlineCommodity = null;
		try {
			OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
			onLineCommodityQueryVo.setId(itemId);
			onlineCommodity = commodityService.getOnlineCommodityById(onLineCommodityQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("onlineCommodity", onlineCommodity);
		return "commodityItem";
	}

	// @RequestMapping(value = "/main/index", method = { RequestMethod.GET })
	// public String mainPage(HttpSession session, Model model) {
	// List<OnlineCommodityType> onlineCommodityTypes = null;
	// List<NoticeType> noticeTypes = null;
	// List<OnlineCommodity> onlineCommodities = null;
	// List<ShoppingMallExpand> shoppingMallExpands = null;
	//
	// try {
	// onlineCommodityTypes = mainService.getOnlineCommodityTypes();
	// noticeTypes = mainService.getNoticeTypes();
	// OnLineCommodityQueryVo onLineCommodityQueryVo = new
	// OnLineCommodityQueryVo();
	// onLineCommodityQueryVo.setPagination(new Pagination(10, 1, null,
	// "{\"commodityPutawayTime\":\"desc\"}"));
	// onlineCommodities =
	// mainService.getOnlineCommodities(onLineCommodityQueryVo);
	// ShoppingMallExpandQueryVo shoppingMallExpandQueryVo = new
	// ShoppingMallExpandQueryVo();
	// shoppingMallExpandQueryVo.setPagination(new Pagination(8, 1, null,
	// "{\"createTime\":\"desc\"}"));
	// shoppingMallExpands =
	// mainService.getShoppingMalls(shoppingMallExpandQueryVo);
	//
	// session.setAttribute("onlineCommodityTypes", onlineCommodityTypes);
	// session.setAttribute("noticeTypes", noticeTypes);
	//
	// model.addAttribute("onlineCommodityTypes", onlineCommodityTypes);
	// model.addAttribute("noticeTypes", noticeTypes);
	// model.addAttribute("onlineCommodities", onlineCommodities);
	// model.addAttribute("shoppingMallExpands", shoppingMallExpands);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// return "index";
	// }
}