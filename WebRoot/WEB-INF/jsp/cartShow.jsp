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

<title>会员中心-账户概况</title>
<meta name="Keywords" content="聚德购物|聚德购物商城|聚德养老购物">
<meta name="Description" content="聚德购物是社会新型消费养老电子商务平台！">
<link rel="stylesheet" type="text/css" href="css/doc.css">
<link rel="stylesheet" type="text/css" href="css/animate.css">
<script src="js/hm.js"></script>
<script type="text/javascript" src="js/jquery-1.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/layer.js"></script>
<link rel="stylesheet" href="css/layer.css"
	id="layui_layer_skinlayercss">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/template.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript" src="js/headerNav.js"></script>
<script type="text/javascript" src="js/main_web.js"></script>
<script type="text/javascript" src="js/cart.js"></script>

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

		$("#allkinds").hover(function() {
			$(".cont").css("display", "block")
		}, function() {
			$(".cont").css("display", "none")
		});
	});
	
	var basePath = "<%=basePath %>";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>

	<div class="container">
		<div class="member-right1 pull-right">
			<div class="table-title">我的购物车</div>
			<div class="cartInfo">
				<div class="titleline">
					<div class="title title1">商品</div>
					<div class="title title2">型号</div>
					<div class="title title3">单价</div>
					<div class="title title4">数量</div>
					<div class="title title5">小计</div>
					<div class="title title6">操作</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="cartInfoCont">
				<div class="ordercont-cw-con">
					<c:if test="${not empty sessionScope.carts }">
						<c:forEach items="${sessionScope.carts }" var="entry">
							<div class="content_type">
								<div class="ct1 contype_cont1">
									<a target="_blank"
										href="<%=basePath %>/commodity/item/${entry.key.onlineCommodity.id}"
										class="img_a"> <img
										src="<%=onlineCommodImgPath%>/${entry.key.onlineCommodity.commodityMainPic}">
									</a>
									<div class="contype_cont_cent pull-left">
										<a target="_blank"
											href="<%=basePath %>/commodity/item/${entry.key.onlineCommodity.id}"
											class="content1_a"
											title="${entry.key.onlineCommodity.commodityName }"> <span>${entry.key.onlineCommodity.commodityName }</span>
										</a>
										<div class="sevendays-preference">
											<div class="clear"></div>
										</div>
									</div>
									<div class="clear"></div>
								</div>
								<div class="ct1 contype_cont2">${entry.key.commodityModel }</div>
								<div class="ct1 contype_cont3">￥${entry.key.commodityPrice }</div>
								<div class="ct1 contype_cont4">
									<div class="choose-amount">
										<div class="wrap-input">
											<a class="btn-reduce" href="javascript:;"
												onclick="cartComp.reduce(${entry.key.id});">-</a> <a class="btn-add"
												href="javascript:;" onclick="cartComp.add(${entry.key.id});">+</a> <input
												id="num_${entry.key.id }" class="text" value="${entry.value }"
												onblur="cartComp.modify(${entry.key.id});">
										</div>
									</div>
								</div>
								<div class="ct1 contype_cont5">￥
									${entry.key.commodityPrice *  entry.value}</div>
								<div class="ct1 contype_cont6">
									<div class="fath_div_1">
										<a onclick="cartComp.del(${entry.key.id})" href="javascript:void(0);">删除</a>
									</div>
								</div>
								<div class="clear"></div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<!-- 结算信息 -->
				<div class="order_amount">
					<div class="ordam_right">
						<div class="ordam-money">
							<span class="oar_title pull-left">商品金额：</span> <span
								class="oar-money pull-left">￥${totalPrice }</span>
							<div class="clear"></div>
						</div>
						<div class="ordam-money ordam-fav">
							<span class="oar_title pull-left">促销优惠：</span> <span
								class="oar-money pull-left">－￥${discountPrice }</span>
							<div class="clear"></div>
						</div>
						<div class="ordam-total">
							<span class="num pull-left">共 <em>${totalNum }</em> 件
							</span> <span id="j-totaltopay1" class="oar-money-total pull-left">￥${totalPrice - discountPrice}</span>
							<span class="oar_title-total pull-left">应付金额：</span>
							<div class="clear"></div>
						</div>
						<div class="pull-right">
							<a class="btn red_btn" href="javascript:void(0);" id="goPay">去结算</a>
							<div class="clear"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/template/footer.jsp" />
</body>
</html>