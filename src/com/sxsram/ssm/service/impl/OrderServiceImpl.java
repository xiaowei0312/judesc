package com.sxsram.ssm.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.entity.OnlineJournalBook;
import com.sxsram.ssm.entity.OnlineJournalBookItem;
import com.sxsram.ssm.entity.OnlineJournalBookQueryVo;
import com.sxsram.ssm.exception.CommodityModelNumNotEnoughException;
import com.sxsram.ssm.mapper.OrderMapper;
import com.sxsram.ssm.service.CommodityService;
import com.sxsram.ssm.service.MemberService;
import com.sxsram.ssm.service.OrderService;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

@Service("orderService")
public class OrderServiceImpl implements OrderService {
	@Autowired
	private MemberService memberService;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private CommodityService commodityService;

	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, readOnly = false, timeout = 3)
	@Override
	public void purchase(OnlineJournalBook newOrder, double changeBalance, String desc, Integer userId)
			throws Exception {
		// 更新余额
		memberService.updateJdbBalance(changeBalance, desc, userId);
		this.addNewOrder(newOrder);
	}

	// @Transactional(propagation = Propagation.REQUIRED, isolation =
	// Isolation.READ_COMMITTED, readOnly = false, timeout = 3)
	// @Override
	// public void addNewOrder(OnlineJournalBook newOrder) throws Exception {
	// orderMapper.insertNewOrder(newOrder);
	// for (OnlineJournalBookItem item : newOrder.getItems()) {
	// item.setJournalId(newOrder.getId());
	// orderMapper.insertNewOrderItem(item);
	// }
	// }

	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, readOnly = false, timeout = 3)
	@Override
	public void addNewOrder(OnlineJournalBook newOrder) throws Exception {
		orderMapper.insertNewOrder(newOrder);
		for (OnlineJournalBookItem item : newOrder.getItems()) {
			// 更新库存
			OnlineCommodityModel model = commodityService.getOnlineCommodityModelById(item.getCommodityModelId());
			try {
				model.setCommodityRepertory(model.getCommodityRepertory() - item.getNum());
			} catch (CommodityModelNumNotEnoughException e) {
				throw new CommodityModelNumNotEnoughException(
						model.getOnlineCommodity().getCommodityName() + "【" + model.getCommodityModel() + "】",
						model.getCommodityRepertory(), item.getNum());
			}
			commodityService.updateCommodityModel(model);

			// 添加订单项
			item.setJournalId(newOrder.getId());
			orderMapper.insertNewOrderItem(item);
		}
	}

	@Override
	public OnlineJournalBook getOnlineOrderById(Integer orderId) throws Exception {
		return orderMapper.queryOrderById(orderId);
	}
}
