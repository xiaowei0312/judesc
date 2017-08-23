package com.sxsram.ssm.test;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.Map.Entry;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sxsram.ssm.entity.OnlineCommodityModel;
import com.sxsram.ssm.entity.OnlineJournalBook;
import com.sxsram.ssm.entity.OnlineJournalBookItem;
import com.sxsram.ssm.entity.RecvCommodityAddress;
import com.sxsram.ssm.entity.RecvCommodityAddressQueryVo;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.mapper.OrderMapper;
import com.sxsram.ssm.mapper.UserMapper;
import com.sxsram.ssm.service.MemberService;
import com.sxsram.ssm.service.OrderService;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

public class TestOrderService {
	private ApplicationContext ctx = null;
	private SqlSessionFactory sqlSessionFactory;
	{
		ctx = new ClassPathXmlApplicationContext("classpath:spring/springmvc-junit.xml");
		sqlSessionFactory = ctx.getBean(SqlSessionFactory.class);
	}

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testPurchase() throws Exception {
		OrderService orderService = ctx.getBean(OrderService.class);
		OnlineJournalBook newOrder = new OnlineJournalBook();
		newOrder.setOrderNo(UUID.randomUUID().toString());
		newOrder.setTotalAmount(16101.0);
		newOrder.setReceiveType(1);// 邮寄
		newOrder.setPostage(15d);
		newOrder.setStatus(0);// 0已付款 1已发货 2确认收货
		newOrder.setRecvCommodityAddressId(1);
		newOrder.setUserId(3);

		for (int i = 0; i < 5; i++) {
			newOrder.getItems().add(new OnlineJournalBookItem(i + 1, 1000.0, i + 1));
		}
		orderService.purchase(newOrder, newOrder.getTotalAmount() * -1, "线上消费测试用例", 3);
	}

	@Test
	public void testGetOrderById() throws Exception {
		OrderService orderService = ctx.getBean(OrderService.class);
		OnlineJournalBook order = orderService.getOnlineOrderById(258);
		System.out.println(order);
	}
}