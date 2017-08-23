package com.sxsram.ssm.mapper;

import java.util.List;

import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;

public interface MallMapper {
	ShoppingMallExpand queryShoppingMallById(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo);

	List<ShoppingMallExpand> queryShoppingMalls(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo) throws Exception;

	Integer queryShoppingMallsTotalNum(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo)throws Exception;

}
