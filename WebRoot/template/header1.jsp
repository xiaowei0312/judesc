<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userHeadImgPath = basePath + "upload/userHeadImg/";
	String mallPicImgPath = "/mallImgs/";
	String onlineCommodImgPath = "/onlineCommodImgs/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link href="css/doc.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="js/header1.js"></script>
</head>
<body>
	<jsp:include page="/template/header.jsp" />
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
				<dl class="cont" style="display: none;">
				</dl>
			</div>
			<ul class="nav-list-ul">
				<li><a href="<%=basePath%>main/index">首页</a></li>
				<li><a href="<%=basePath%>mall/list">实体店</a></li>
				<li><a href="javascript:void(0);">关于商城</a></li>
				<li><a href="javascript:void(0);">入驻流程</a></li>
				<li><a href="<%=basePath %>member/center">会员中心</a></li>
				<!-- <li><a target="_blank" href="#">代理商入口</a></li> -->
			</ul>
			<div class="min_cart" id="smallcart" data-first="no">
				<div class="m_btn">
					<span class="cart-icon png"> <i id="cart_totalCount"
						class="smallcart_totalamount num png">0</i> <input
						id="smallcart_items_amount" name="smallcart_items_amount"
						value="0" data-count="0" type="hidden">
					</span> <span class="text"> <a id="cartlink"
						href="<%=basePath %>/cart/show" class="">购物车</a>
					</span> <span class="arrow png"></span>
				</div>
				<div class="cart_cont" id="smallcart_cont" style="display: none;">
					<span class="loading"></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>