package com.sxsram.ssm.test;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sxsram.ssm.entity.RecvCommodityAddress;
import com.sxsram.ssm.entity.RecvCommodityAddressQueryVo;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.service.MemberService;
import com.sxsram.ssm.util.QueryCondition;
import com.sxsram.ssm.util.QueryConditionItem;
import com.sxsram.ssm.util.QueryConditionOp;

public class TestMemberService {
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
	public void testSetRecvCommodityAddressAsDefault() throws Exception {
		MemberService memberService = ctx.getBean(MemberService.class);
		memberService.setRecvCommodityAddressAsDefault(2, 3);
	}

	@Test
	public void testAddNewRecvCommodityAddress() throws Exception {
		MemberService memberService = ctx.getBean(MemberService.class);

		RecvCommodityAddress recvCommodityAddress = new RecvCommodityAddress();
		recvCommodityAddress.setProvince("山西省");
		recvCommodityAddress.setCity("运城市");
		recvCommodityAddress.setArea("盐湖区");
		recvCommodityAddress.setExtra("xxx街道xx小区");
		recvCommodityAddress.setContacts("MRSC");
		recvCommodityAddress.setPhone("111111111");

		UserExpand userExpand = new UserExpand();
		userExpand.setId(3);
		recvCommodityAddress.setUser(userExpand);

		memberService.addNewRecvCommodityAddress(recvCommodityAddress);
	}

	@Test
	public void testDelRecvCommodityAddress() throws Exception {
		MemberService memberService = ctx.getBean(MemberService.class);
		memberService.delRecvCommodityAddress(250);
	}

	@Test
	public void testQueryMultiRecvCommodityAddress() throws Exception {
		MemberService memberService = ctx.getBean(MemberService.class);
		List<QueryConditionItem> items = new ArrayList<QueryConditionItem>();
		items.add(new QueryConditionItem("userId", "3", QueryConditionOp.EQ));
		items.add(new QueryConditionItem("province", "西", QueryConditionOp.LIKE));
		//items.add(new QueryConditionItem("city", "同", QueryConditionOp.LIKE));
		RecvCommodityAddressQueryVo recvCommodityAddressQueryVo = new RecvCommodityAddressQueryVo();
		recvCommodityAddressQueryVo.setQueryCondition(new QueryCondition(items));
		List<RecvCommodityAddress> addresses = memberService.getRecvCommodityAddress(recvCommodityAddressQueryVo);
		System.out.println(addresses);
	}
}