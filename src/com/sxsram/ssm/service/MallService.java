package com.sxsram.ssm.service;

import java.util.List;

import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;

public interface MallService {
	ShoppingMallExpand getShppingMallById(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo) throws Exception;

	List<ShoppingMallExpand> getShoppingMalls(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo) throws Exception;

	Integer getShoppingMallsTotalNum(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo)throws Exception;
}
