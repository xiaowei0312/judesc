package com.sxsram.ssm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sxsram.ssm.entity.Role;
import com.sxsram.ssm.entity.RoleExpand;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;
import com.sxsram.ssm.mapper.MallMapper;
import com.sxsram.ssm.mapper.UserMapper;
import com.sxsram.ssm.service.MallService;

@Service("mallService")
public class MallServiceImpl implements MallService {
	@Autowired
	private MallMapper mallMapper;

	@Override
	public ShoppingMallExpand getShppingMallById(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo) throws Exception {
		return mallMapper.queryShoppingMallById(shoppingMallExpandQueryVo);
	}
	
	@Override
	public List<ShoppingMallExpand> getShoppingMalls(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo)
			throws Exception {
		return mallMapper.queryShoppingMalls(shoppingMallExpandQueryVo);
	}

	@Override
	public Integer getShoppingMallsTotalNum(ShoppingMallExpandQueryVo shoppingMallExpandQueryVo)throws Exception {
		// TODO Auto-generated method stub
		return mallMapper.queryShoppingMallsTotalNum(shoppingMallExpandQueryVo);
	}

	
}
