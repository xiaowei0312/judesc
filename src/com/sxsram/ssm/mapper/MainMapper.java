package com.sxsram.ssm.mapper;

import java.util.List;

import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;

public interface MainMapper {

	List<OnlineCommodityType> queryOnlineCommodityTypes() throws Exception;

	List<NoticeType> queryNoticeTypes()  throws Exception;

	List<OnlineCommodity> queryOnlineCommodities(OnLineCommodityQueryVo onLineCommodityQueryVo) throws Exception;

}
