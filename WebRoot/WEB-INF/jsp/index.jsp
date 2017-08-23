<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userHeadImgPath = basePath + "upload/userHeadImg/";

	String mallPicImgPath = "http://www.0352jdw.com/mallImgs/";
	String onlineCommodImgPath = "http://www.0352jdw.com/onlineCommodImgs/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="UTF8">

<title>购物商城</title>
<meta name="Keywords" content="购物|购物商城|养老购物">
<meta name="Description" content="购物是社会新型消费养老电子商务平台！">
<link rel="shortcut icon" href="/favico.ico">
<link rel="bookmark" href="favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/doc.css">
<link rel="stylesheet" type="text/css" href="css/animate.css">
<script type="text/javascript" src="js/hm.js"></script>
<script type="text/javascript" src="js/jquery-1.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/layer.js"></script>
<link rel="stylesheet" href="css/layer.css"
	id="layui_layer_skinlayercss" style="">
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/template.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<!--<script type="text/javascript" src="js/headerNav.js"></script>-->
<script type="text/javascript" src="js/main_web.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<script>
	$(function() {
		$(".citybox li").hover(function() {
			$(this).addClass('hover');
		}, function() {
			$(this).removeClass('hover');
		});
		$("img.lazy").lazyload({
			effect : "fadeIn",
		});
	});
</script>
</head>

<body>
	<!-- 头 -->
	<!-- <iframe src="header.jsp"></iframe> -->
	<%-- <jsp:include page="/template/header.jsp" />
	
	<!-- 商品分类 -->
	<div class="wp nav-list">
		<div class="container_n">
			<div class="allkinds" id="allkinds">
				<div class="head">
					<a href="javascript:void(0);"> 全部商品分类 <img
						src="img/jint_03.png" style="margin-left: 11px; border: none;"
						width="12" height="6">
					</a>
				</div>
				<dl class="cont" style="display: block;" id="kinds">
					<c:if test="${not empty onlineCommodityTypes}">
						<c:forEach items="${onlineCommodityTypes }" var="type">
							<dd class="kinds">
								<h3 class="title">
									<a href="http://www.58jude.com/list.do?cat=${type.id }">${type.typeName}</a>
								</h3>
							</dd>
						</c:forEach>
					</c:if> 
					<dd class="adver">
				</dl>
			</div>
			<ul class="nav-list-ul">
				<li><a href="index.html">首页</a></li>
				<li><a href="store.html">实体店</a></li>
				<li><a href="About_store.html">关于商城</a></li>
				<li><a href="flow_path.htm">入驻流程</a></li>
				<li><a href="member_Center.html">会员中心</a></li>
				<li><a target="_blank" href="login.html">代理商入口</a></li>
			</ul>
			<div class="min_cart" id="smallcart" data-first="no">
				<div class="m_btn">
					<span class="cart-icon png"> <i id="cart_totalCount"
						class="smallcart_totalamount num png">0</i> <input
						id="smallcart_items_amount" name="smallcart_items_amount"
						value="0" data-count="0" type="hidden">
					</span> <span class="text"> <a id="cartlink"
						href="http://www.58jude.com/member/cart.do" class="">购物车</a>
					</span> <span class="arrow png"></span>
				</div>
				<div class="cart_cont" id="smallcart_cont" style="display: none;">
					<span class="loading"></span>
				</div>
			</div>
		</div>
	</div> --%>
	
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<!-- 通知区域 -->
	<div class="wp banner">
		<div class="m-bannerBox" id="banner1">
			<ul class="f-bannerMain" id="bannerMain">
				<li style="display: list-item;"><a href="javascript:void(0);"><img
						src="img/01.jpg"></a></li>
				<li style="display: none;"><a href="javascript:void(0);"><img
						src="img/03.jpg"></a></li>
				<li style="display: none;"><a href="javascript:void(0);"><img
						src="img/02.jpg"></a></li>
			</ul>
		</div>
		<div class="notice_area">
			<c:if test="${not empty noticeTypes }">
				<c:forEach items="${noticeTypes}" var="noticeType" varStatus="s">
					<c:if test="${s.first}">
						<div class="notice">
							<h1>${noticeType.typeName }</h1>
							<ul class="noticeList">
								<c:forEach items="${ noticeType.notices}" var="notice"
									varStatus="st">
									<c:if test="${st.index <= 4}">
										<li><a href="<%=basePath%>/main/noticeDetail/${notice.id}"><span>[${noticeType.typeName}]</span>${notice.noticeTitle }</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
					<c:if test="${!s.first}">
						<div class="notice" style="margin-top: 5px;">
							<h1>${noticeType.typeName }</h1>
							<ul class="noticeList">
								<c:forEach items="${ noticeType.notices}" var="notice"
									varStatus="st">
									<c:if test="${st.index <= 4}">
										<li><a href="<%=basePath%>/main/noticeDetail/${notice.id}"><span>[${noticeType.typeName}]</span>${notice.noticeTitle }</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</c:if>

		</div>
	</div>

	<!-- 实体店 -->
	<div class="container">
		<div class="offLineStore_title">
			<i class="icons icon_store"></i>
			<h1>线下实体店</h1>
			<p>
				<a href="<%=basePath%>mall/list">更多...</a>
			</p>
		</div>
		<div class="offLineStore_content">
			<c:if test="${not empty shoppingMallExpands}">
				<ul>
					<c:forEach items="${shoppingMallExpands }" var="shop">
						<li><a target="_blank"
							href="<%=basePath%>/mall/item/${shop.id}">
								<div class="img">
									<img class="lazy" alt="${shop.mallName }"
										title="${shop.mallName }"
										src="<%=mallPicImgPath %>${shop.mallMainPicUrl }"
										style="display: inline;">
								</div>
						</a>
							<h1>${shop.mallName }</h1>
							<p>
								联系电话：${shop.mallPhone }<br>商家地址：${shop.mallAddress }
							</p></li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
	</div>

	<!-- 主体 1楼 -->
	<div class="container">
		<div class="mainFloor floor1">
			<div class="offLineStore_title">
				<i class="icons icon_store"></i>
				<h1>自营商品店</h1>
				<p>
					<a href="<%=basePath%>commodity/list/-1"">更多...</a>
				</p>
			</div>
			<div class="middleSide">
				<c:if test="${not empty onlineCommodities }">
					<c:forEach items="${onlineCommodities }" var="commod">
						<div class="box">
							<div class="img">
								<a target="_blank" href="<%=basePath%>/commodity/item/${commod.id}">
									<img style="display:inline;width:170px;height:170px" class="lazy" alt="${commod.commodityName }"
									src="<%=onlineCommodImgPath %>${commod.commodityMainPic }">
								</a>
							</div>
							<div class="p_name">
								<a target="_blank" href="<%=basePath%>/commodity/item/${commod.id}"
									title="${commod.commodityName }"> <em>${commod.commodityName }</em>
								</a>
							</div>
							<c:if test="${not empty commod.commodityModels }">
								<c:forEach items="${commod.commodityModels }" var="model">
									<c:if test="${model.isDefaultModel == 1}">
										<label>￥${model.commodityPrice }</label>
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
			</div>
			<div class="clear"></div>
			<!-- <div class="brandList">
				<span>品牌推荐 &gt; </span> <a href="javascript:void(0)">海尔（Haier）</a> <a
					href="javascript:void(0)">三星（SAMSUNG）</a> <a
					href="javascript:void(0)">松下（Panasonic）</a> <a class="last"
					href="javascript:void(0)">美的（Midea）</a>
			</div> -->
		</div>
	</div>

	<!-- 尾 -->
	<jsp:include page="/template/footer.jsp" />

	<script src="js/t.js" charset="utf-8"></script>
</body>
</html>
