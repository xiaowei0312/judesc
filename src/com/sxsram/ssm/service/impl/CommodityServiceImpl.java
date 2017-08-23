package com.sxsram.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.mapper.CommodityMapper;
import com.sxsram.ssm.service.CommodityService;

@Service("commodityService")
public class CommodityServiceImpl implements CommodityService {
	@Autowired
	private CommodityMapper commodityMapper;

	@Override
	public List<OnlineCommodity> getOnlineCommoditiesByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo)
			throws Exception {
		return commodityMapper.queryOnlineCommoditiesByCatId(onLineCommodityQueryVo);
	}

	@Override
	public Integer getOnlineCommoditiesTotalNumByCatId(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception {
		return commodityMapper.queryOnlineCommoditiesTotalNumByCatId(onLineCommodityQueryVo);
	}

	@Override
	public OnlineCommodity getOnlineCommodityById(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception {
		return commodityMapper.queryOnlineCommodityById(onLineCommodityQueryVo);
	}

	@Override
	public Integer getOnlineCommoditiesTotalNum(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception {
		return commodityMapper.queryOnlineCommoditiesTotalNum(onLineCommodityQueryVo);
	}

	@Override
	public List<OnlineCommodity> getOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception {
		return commodityMapper.queryOnlineCommodities(onLineCommodityQueryVo);
	}

	@Override
	public OnlineCommodityModel getOnlineCommodityModelById(Integer modelId) throws Exception {
		return commodityMapper.queryOnlineCommodityModelById(modelId);
	}
	
	@Override
	public void updateCommodityModel(OnlineCommodityModel onlineCommodityModel) throws Exception {
		commodityMapper.updateCommodityModel(onlineCommodityModel);
	}
}
