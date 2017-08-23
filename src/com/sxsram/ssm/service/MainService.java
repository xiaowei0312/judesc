package com.sxsram.ssm.service;

import java.util.List;

import com.sxsram.ssm.entity.GlobalPrams;
import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;

public interface MainService {
	List<OnlineCommodityType> getOnlineCommodityTypes() throws Exception;

	List<NoticeType> getNoticeTypes() throws Exception;

	List<OnlineCommodity> getOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	//List<ShoppingMallExpand> getShoppingMalls(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo) throws Exception;
}