package com.sxsram.ssm.controller;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;
import com.sxsram.ssm.service.MallService;
import com.sxsram.ssm.util.JsonResult;
import com.sxsram.ssm.util.Pagination;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;
import com.sxsram.ssm.util.StringUtil;

@Controller
public class MallController {
	@Autowired
	private MallService mallService;

	// @RequestMapping(value = "/commodity/list/{id}", method = {
	// RequestMethod.GET })
	// public String getCommodity(HttpSession session, Model model,
	// @PathVariable("id") Integer catId) {
	// Integer totalNum = 0;
	// try {
	// OnLineCommodityQueryVo onLineCommodityQueryVo = new
	// OnLineCommodityQueryVo();
	// onLineCommodityQueryVo.setCommodityType(new OnlineCommodityType(catId));
	// // onLineCommodityQueryVo
	// // .setPagination(new Pagination(size, page, null,
	// // "{\"commodityPutawayTime\":\"desc\"}"));
	// totalNum =
	// commodityService.getOnlineCommoditiesTotalNumByCatId(onLineCommodityQueryVo);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// model.addAttribute("totalNum", totalNum);
	// model.addAttribute("catId", catId);
	// return "commodityList";
	// }
	//
	// class PageObj {
	// Integer totalCount;
	// Object items;
	//
	// public PageObj() {
	// }
	//
	// public PageObj(Integer totalCount, Object objList) {
	// this.totalCount = totalCount;
	// this.items = objList;
	// }
	// }
	//
	// @RequestMapping(value = "/commodity/listAjax", method = {
	// RequestMethod.GET, RequestMethod.POST })
	// @ResponseBody
	// public String getCommodityAjax(HttpSession session, Model model, Integer
	// catId, Integer page, Integer size,
	// Integer total) {
	// Gson gson = new Gson();
	// JsonResult jsonResult = new JsonResult("0", "0");
	//
	// List<OnlineCommodity> onlineCommodities = null;
	// try {
	// OnLineCommodityQueryVo onLineCommodityQueryVo = new
	// OnLineCommodityQueryVo();
	// onLineCommodityQueryVo.setCommodityType(new OnlineCommodityType(catId));
	// onLineCommodityQueryVo
	// .setPagination(new Pagination(size, page, null,
	// "{\"commodityPutawayTime\":\"desc\"}"));
	// onlineCommodities =
	// commodityService.getOnlineCommoditiesByCatId(onLineCommodityQueryVo);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// jsonResult.resultObj = new PageObj(total, onlineCommodities);
	// return gson.toJson(jsonResult);
	// }

	@RequestMapping(value = "/mall/item/{id}", method = { RequestMethod.GET })
	public String getMallItem(HttpSession session, Model model, @PathVariable("id") Integer mallId) {
		ShoppingMallExpand shoppingMallExpand = null;
		try {
			ShoppingMallExpandQueryVo shoppingMallExpandQueryVo = new ShoppingMallExpandQueryVo();
			shoppingMallExpandQueryVo.setId(mallId);
			// shoppingMallExpandQueryVo.setPagination(new Pagination(8, 1,
			// null, "{\"createTime\":\"desc\"}"));
			shoppingMallExpand = mallService.getShppingMallById(shoppingMallExpandQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("mall", shoppingMallExpand);
		return "mallItem";
	}

	class PageObj {
		Integer totalCount;
		Object objList;

		public PageObj() {
		}

		public PageObj(Integer totalCount, Object objList) {
			this.totalCount = totalCount;
			this.objList = objList;
		}
	}

	@RequestMapping(value = "/mall/list", method = { RequestMethod.GET })
	public String getMallList(HttpSession session, Model model) {
		return "mallList";
	}

	@RequestMapping(value = "/mall/listAjax", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String getMallListAjax(HttpSession session, Model model, Integer pageNo, Integer pageSize, String provinceId,
			String eparchyId, String cityId, String shopName) {
		// Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd
		// HH:mm:ss").create();
		Gson gson = new Gson();
		JsonResult jsonResult = new JsonResult("0", "0");

		List<ShoppingMallExpand> shoppingMallExpands = null;
		Integer totalNum = 0;

		ShoppingMallExpandQueryVo shoppingMallExpandQueryVo = new ShoppingMallExpandQueryVo();
		List<QueryConditionItem> whereCondList = new ArrayList<QueryConditionItem>();
		whereCondList.add(new QueryConditionItem("province", provinceId, QueryConditionOp.EQ));
		whereCondList.add(new QueryConditionItem("city", eparchyId, QueryConditionOp.EQ));
		whereCondList.add(new QueryConditionItem("area", cityId, QueryConditionOp.EQ));
		whereCondList.add(new QueryConditionItem("mallName", shopName, QueryConditionOp.LIKE));

		try {
			shoppingMallExpandQueryVo.setQueryCondition(new QueryCondition(whereCondList));
			totalNum = mallService.getShoppingMallsTotalNum(shoppingMallExpandQueryVo);
			shoppingMallExpandQueryVo
					.setPagination(new Pagination(pageSize, pageNo, null, "{\"createTime\":\"desc\"}"));
			shoppingMallExpands = mallService.getShoppingMalls(shoppingMallExpandQueryVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (totalNum == null)
			totalNum = 0;
		// model.addAttribute("totalNum", totalNum);
		// model.addAttribute("shoppingMallList", shoppingMallExpands);
		jsonResult.resultObj = new PageObj(totalNum, shoppingMallExpands);
		return gson.toJson(jsonResult);
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