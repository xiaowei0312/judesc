package com.sxsram.ssm.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.sxsram.ssm.entity.Address;
import com.sxsram.ssm.entity.CommodityType;
import com.sxsram.ssm.entity.Indent;
import com.sxsram.ssm.entity.JournalBook;
import com.sxsram.ssm.entity.JournalBookExpand;
import com.sxsram.ssm.entity.NoticeType;
import com.sxsram.ssm.entity.OnLineCommodityQueryVo;
import com.sxsram.ssm.entity.OnlineCommodity;
import com.sxsram.ssm.entity.OnlineCommodityType;
import com.sxsram.ssm.entity.ShoppingMallExpand;
import com.sxsram.ssm.entity.ShoppingMallExpandQueryVo;
import com.sxsram.ssm.entity.User;
import com.sxsram.ssm.entity.UserExpand;
import com.sxsram.ssm.mapper.MainMapper;
import com.sxsram.ssm.mapper.UserMapper;
import com.sxsram.ssm.util.Pagination;

public class MainMapperTest {
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
	public void testQueryOnlineCommodityTypes() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		MainMapper mainMapper = sqlSession.getMapper(MainMapper.class);
		List<OnlineCommodityType> types = mainMapper.queryOnlineCommodityTypes();
		System.out.println(types);
	}

	@Test
	public void testQueryNoticeTypes() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		MainMapper mainMapper = sqlSession.getMapper(MainMapper.class);
		List<NoticeType> types = mainMapper.queryNoticeTypes();
		System.out.println(types);
	}

	@Test
	public void testQueryOnlineCommodities() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		MainMapper mainMapper = sqlSession.getMapper(MainMapper.class);

		OnLineCommodityQueryVo onLineCommodityQueryVo = new OnLineCommodityQueryVo();
		onLineCommodityQueryVo.setPagination(new Pagination(8, 1, null, "{\"commodityPutawayTime\":\"desc\"}"));
		List<OnlineCommodity> types = mainMapper.queryOnlineCommodities(onLineCommodityQueryVo);
		System.out.println(types);
	}

	@Test
	public void testQueryShoppingMalls() throws Exception {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		MainMapper mainMapper = sqlSession.getMapper(MainMapper.class);

		ShoppingMallExpandQueryVo shoppingMallExpandQueryVo = new ShoppingMallExpandQueryVo();
		shoppingMallExpandQueryVo.setPagination(new Pagination(8, 1, null, "{\"createTime\":\"desc\"}"));
		//List<ShoppingMallExpand> types = mainMapper.queryShoppingMalls(shoppingMallExpandQueryVo);
		//System.out.println(types);
	}
}
