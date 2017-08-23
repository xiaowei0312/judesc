package com.sxsram.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;
import com.sxsram.ssm.mapper.MainMapper;
import com.sxsram.ssm.service.MainService;

@Service("mainService")
public class MainServiceImpl implements MainService {
	@Autowired
	private MainMapper mainMapper;

	@Override
	public List<OnlineCommodityType> getOnlineCommodityTypes() throws Exception {
		return mainMapper.queryOnlineCommodityTypes();
	}

	@Override
	public List<NoticeType> getNoticeTypes() throws Exception {
		return mainMapper.queryNoticeTypes();
	}

	@Override
	public List<OnlineCommodity> getOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception {
		return mainMapper.queryOnlineCommodities(onLineCommodityQueryVo);
	}

	
}
