package com.sxsram.ssm.service;

import java.util.List;

import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityModel;

public interface CommodityService {
	List<OnlineCommodity> getOnlineCommoditiesByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	Integer getOnlineCommoditiesTotalNumByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	OnlineCommodity getOnlineCommodityById(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	Integer getOnlineCommoditiesTotalNum(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	List<OnlineCommodity> getOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

	OnlineCommodityModel getOnlineCommodityModelById(Integer modelId) throws Exception;
	
	void updateCommodityModel(OnlineCommodityModel onlineCommodityModel) throws Exception;

}