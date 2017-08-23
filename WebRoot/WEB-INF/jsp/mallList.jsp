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
<script type="text/javascript" src="js/mallList.js"></script>

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
	var mallPicImgPath = "<%=mallPicImgPath%>";
	var basePath = "<%=basePath%>";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<div class="container">
		<div class="prdouct-title">
			<h3>线下实体店</h3>
			<div class="search_area">
				<p
					style="float: right; color: #333; line-height: 35px; font-size: 14px;">
					入驻商家：<span id="totalShopNum">10966</span>家
				</p>
			</div>
		</div>
		<div class="product-area">
			<div class="search-area pull-left" style="width: 250px;">
				<div class="procon-side search-area">
					<div class="area-head">
						<h3>搜索商家</h3>
					</div>
					<div class="area-body">
						<div class="search-body">
							<select id="provinceId" name="provinceId" class="row_item">
								<option value="">---省份---</option>
								<option value="1">北京市</option>
								<option value="2">天津市</option>
								<option value="3">河北省</option>
								<option value="4">山西省</option>
								<option value="5">内蒙古</option>
								<option value="6">辽宁省</option>
								<option value="7">吉林省</option>
								<option value="8">黑龙江</option>
								<option value="9">上海市</option>
								<option value="10">江苏省</option>
								<option value="11">浙江省</option>
								<option value="12">安徽省</option>
								<option value="13">福建省</option>
								<option value="14">江西省</option>
								<option value="15">山东省</option>
								<option value="16">河南省</option>
								<option value="17">湖北省</option>
								<option value="18">湖南省</option>
								<option value="19">广东省</option>
								<option value="20">广 西</option>
								<option value="21">海南省</option>
								<option value="22">重庆市</option>
								<option value="23">四川省</option>
								<option value="24">贵州省</option>
								<option value="25">云南省</option>
								<option value="26">西 藏</option>
								<option value="27">陕西省</option>
								<option value="28">甘肃省</option>
								<option value="29">青海省</option>
								<option value="30">宁 夏</option>
								<option value="31">新 疆</option>
							</select> <select id="eparchyId" name="eparchyId" class="row_item">
								<option value="">---地市---</option>
							</select> <select id="cityId" name="cityId" class="row_item">
								<option value="">---区县---</option>
							</select>
							<!-- <div>
								<div class="area-head" style="padding: 0px;">
									<h3>按照行业搜索</h3>
								</div>
								<span>&nbsp;</span> <select id="busiClass" name="busiClass"
									class="row_item">
									<option value="">---行业类别---</option>
									<option value="1">餐饮、住宿</option>
									<option value="2">电子数码</option>
									<option value="3">电器</option>
									<option value="4">建材家具</option>
									<option value="5">运动户外</option>
									<option value="6">服装箱包</option>
									<option value="7">办公用品</option>
									<option value="8">特产礼品</option>
									<option value="9">厨卫用品</option>
									<option value="10">养生保健</option>
									<option value="11">汽车、房产</option>
									<option value="12">文化休闲</option>
									<option value="13">服务类</option>
									<option value="14">日用百货</option>
									<option value="15">珠宝饰品</option>
								</select>
							</div> -->
							<div>
								<div class="area-head" style="padding: 0px;">
									<h3>按照名称搜索</h3>
								</div>
								<span>&nbsp;</span> <input class="row_item" type="text"
									id="shopName" name="shopName" value="" placeholder="请输入店铺名称">
							</div>
							<div class="row_item">
								<a class="btn red_btn search_btn">搜索</a>
							</div>
						</div>
					</div>
				</div>
				<div class="procon-side search-area">
					<div class="area-head">
						<h3>区域商家推荐</h3>
					</div>
					<div class="area-body small_shop">
						<ul>
						</ul>
					</div>
				</div>
			</div>
			<div class="shop-area pull-right" style="width: 950px;">
				<ul class="prdouct-box" id="shopListArea">
				</ul>
			</div>
		</div>
		<!-- 分页 -->
		<div class="pages m20-b">
			<div id="pager" class="pager">
				<div class="mod_body list_page">
					<a href="javascript:void(0)" class="pgEmpty">首页</a><a
						href="javascript:void(0)" class="pgEmpty">上一页</a><span>1</span><a
						href="javascript:void(0)">2</a><a href="javascript:void(0)">3</a><a
						href="javascript:void(0)">4</a><a href="javascript:void(0)">5</a><a
						href="javascript:void(0)">6</a><a href="javascript:void(0)">7</a><a
						href="javascript:void(0)">8</a><a href="javascript:void(0)">9</a><a
						href="javascript:void(0)">下一页</a><a href="javascript:void(0)">末页</a>共<i
						style="font-weight: bold; font-style: normal;">1219</i>页
				</div>
			</div>
			到第<input type="text" class="text-box" id="numberOfPages"> 页 <input
				type="button" value="GO" class="sub-btn"
				onclick="javascript:shopListComp.goToPage();">
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>