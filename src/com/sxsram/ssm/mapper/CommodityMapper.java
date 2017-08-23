package com.sxsram.ssm.mapper;

import java.util.List;

import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;

public interface CommodityMapper {

	List<OnlineCommodity> queryOnlineCommoditiesByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	Integer queryOnlineCommoditiesTotalNumByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	OnlineCommodity queryOnlineCommodityById(OnLineCommodityQueryVo onLineCommodityQueryVo)throws Exception;

	Integer queryOnlineCommoditiesTotalNum(OnLineCommodityQueryVo onLineCommodityQueryVo)throws Exception;

	List<OnlineCommodity> queryOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo)throws Exception;

	OnlineCommodityModel queryOnlineCommodityModelById(Integer modelId)throws Exception;
	
	void updateCommodityModel(OnlineCommodityModel onlineCommodityModel) throws Exception;
}
