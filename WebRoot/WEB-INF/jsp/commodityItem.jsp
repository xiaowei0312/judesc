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

<title>商品详情</title>
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
<script type="text/javascript" src="js/item.js"></script>

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
	<c:if test="${not empty onlineCommodity }">
		<div class="container">
			<div id="itemInfo" class="clearfix">
				<c:if test="${not empty onlineCommodity.commodityModels }">
					<c:forEach items="${onlineCommodity.commodityModels }" var="model">
						<c:if test="${model.isDefaultModel == 1}">
							<div class="imgInfo">
								<div class="b" id="bigPic">
									<a href="javascript:void(0)"> <img
										src="<%=onlineCommodImgPath %>${model.commoditySmallPic1}"></a>
								</div>
								<div class="focusBox" id="focusBox">
									<div class="focusList">
										<span id="lbtn"></span> <span id="rbtn" class="spanR"></span>
										<div id="focusList" class="gallery">
											<ul>
												<li class="on"><a href="javascript:void(0)"
													target="_self"> <img
														src="<%=onlineCommodImgPath%>${model.commoditySmallPic1}">
												</a></li>
												<li class=""><a href="javascript:void(0)"
													target="_self"> <img
														src="<%=onlineCommodImgPath%>${model.commoditySmallPic2}">
												</a></li>
												<li class=""><a href="javascript:void(0)"
													target="_self"> <img
														src="<%=onlineCommodImgPath%>${model.commoditySmallPic3}">
												</a></li>
												<li class=""><a href="javascript:void(0)"
													target="_self"> <img
														src="<%=onlineCommodImgPath%>${model.commoditySmallPic4}">
												</a></li>
												<li class=""><a href="javascript:void(0)"
													target="_self"> <img
														src="<%=onlineCommodImgPath%>${model.commoditySmallPic5}">
												</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="textInfo">
								<div id="name">
									<h1>${onlineCommodity.commodityName }</h1>
									<c:if test="${not empty model.commodityDesc }">
										<div id="p-ad" class="p-ad">${model.commodityDesc }</div>
									</c:if>
									<%-- <c:if test="${empty model.commodityDesc }">
										<div id="p-ad" class="p-ad">暂无简介</div>
									</c:if> --%>
								</div>
								<div id="summary">
									<div id="summary-price">
										<div class="dt">价 格：</div>
										<div class="dd">
											<strong class="p-price" id="jd-price">￥${model.commodityPrice }</strong>
										</div>
									</div>
									<div id="summary-service">
										<div class="dt">服 务：</div>
										<c:if test="${not empty model.commodityDesc }">
											<div class="dd">${model.commodityService }</div>
										</c:if>
										<c:if test="${empty model.commodityDesc }">
											<div class="dd">由聚德发货并提供售后服务。</div>
										</c:if>
									</div>
									<div id="summary-service">
										<div class="dt">库 存：</div>
										<c:if test="${not empty model.commodityRepertory }">
											<div class="dd">
												<strong class="p-num" id="jd-num">${model.commodityRepertory }</strong>
											</div>
										</c:if>
										<c:if test="${empty model.commodityRepertory }">
											<div class="dd">
												<strong class="p-num" id="jd-num">无法获取库存</strong>
											</div>
										</c:if>
									</div>
								</div>
								<div id="choose" class="p-choose-wrap">
									<div id="choose-type" class="li">
										<div class="dt">选择型号：</div>
										<div class="dd">
											<c:if test="${not empty onlineCommodity.commodityModels }">
												<c:forEach items="${onlineCommodity.commodityModels }"
													var="subModel">
													<c:if test="${subModel.isDefaultModel == 1}">
														<div class="item skuInfos selected" data-sku="${subModel.id }"
															data-price="${subModel.commodityPrice }" data-num="${subModel.commodityRepertory }">
															<b></b> <a href="javascript:;"
																title="${subModel.commodityModel }"> <i>${subModel.commodityModel }</i>
															</a>
														</div>
													</c:if>
													<c:if test="${subModel.isDefaultModel != 1}">
														<div class="item skuInfos" data-sku="${subModel.id }"
															data-price="${subModel.commodityPrice }" data-num="${subModel.commodityRepertory }">
															<b></b> <a href="javascript:;"
																title="${subModel.commodityModel }"> <i>${subModel.commodityModel }</i>
															</a>
														</div>
													</c:if>
												</c:forEach>
											</c:if>
										</div>
									</div>
									<div id="choose-btns" class="li">
										<div class="choose-amount pull-left">
											<div class="wrap-input">
												<a class="btn-reduce" href="javascript:;"
													onclick="itemComp.reduce('#buy-num')">-</a> <a
													class="btn-add" href="javascript:;"
													onclick="itemComp.add('#buy-num')">+</a> <input
													class="text" id="buy-num" value="1"
													onkeyup="itemComp.modify('#buy-num');">
											</div>
										</div>
										<a class="btn red_btn" id="addToCart"
											href="javascript:void(0);">加入购物车<b></b></a>
										<!-- <a class="btn" id="addToCart" href="javascript:">加入收藏<b></b></a>  -->
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>
		<div class="container mt15">
			<div class="procon-side">
				<div class="area-head">
					<h3>热卖商品</h3>
				</div>
				<div class="area-body">
					<ul>
						<li>暂无商品</li>
					</ul>
				</div>
			</div>
			<div class="procon">
				<div class="procon-toolbar">
					<ul id="itemDetailTab" class="tabarea-items">
						<li rel="#s-images" class="current"><a
							href="javascript:void(0);">商品详情</a></li>
						<li rel="#s-params"><a href="javascript:void(0);">规格参数</a></li>
						<li rel="#s-remark"><a href="javascript:void(0);">商品评价</a></li>
					</ul>
				</div>
				<div>
					<div id="s-images" style="display: block;">
						<c:if test="${not empty onlineCommodity }">
							<script type="text/javascript">
								var content = "${onlineCommodity.commodityDetailFileName}";
								if(!content || $.trim(content).length == 0)
									$('#s-images').html('暂无详情');
								else
									$('#s-images').html(unescape(content));
							</script>
						</c:if>
						<!-- <p class="rowTip">暂无详情</p> -->
					</div>
					<div id="s-params" style="display: none;">
						<p class="rowTip">暂无规格</p>
					</div>
					<div id="s-remark" style="display: none;">
						<p class="rowTip">暂无评价</p>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>