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
<script type="text/javascript" src="js/header.js"></script>
</head>
<body>
	<div class="wp">
		<div class="header-top">
			<div class="container_n">
				<div class="pull-left areaSel">
					当前地区：<a href="javascript:void(0);" class="curr_area"></a> <a
						href="javascript:void(0);" class="other_area"
						title="点击切换地区">[其他地区]</a>
				</div>
				<ul class="menu-top pull-right">
					<c:if test="${not empty sessionScope.user }">
						<li>欢迎您，${sessionScope.user.username }</a></li>
						<li class="spacer"></li>
						<li><a href="<%=basePath%>member/exit" class="active">退出登录</a></li>
					</c:if>
					<c:if test="${empty sessionScope.user }">
						<li>Hi,请 <a href="<%=basePath%>member/loginPage" class="active">
								登录</a></li>
						<li class="spacer"></li>
						<li><a href="<%=basePath%>member/registPage" class="active">免费注册</a></li>
					</c:if>
					<li class="spacer"></li>
					<li><a href="<%=basePath %>member/center">会员中心</a></li>
					<li class="spacer"></li>
					<li><div class="top4">
							<div class="shu61">
								<img src="img/coding.jpg" style="border: 1px solid #ddd"
									width="115" height="115">
							</div>
						</div></li>
					<li class="spacer"></li>
					<li><a href="javascript:void(0);"
						onclick="addFavorite(document.title, window.location);">收藏本站</a></li>
				</ul>
			</div>
		</div>
		<!-- header_banner -->

		<div class="add-fff">
			<div class="container_n">
				<div class="menu-logo">
					<a class="logo" href="http://www.jdw0352.com/">购物商城</a>
				</div>
				<div id="search">
					<ul id="shelper" class="hide" style="display: none;"></ul>
					<div class="form">
						<input onkeydown="javascript:if(event.keyCode==13) search('key');"
							autocomplete="off" id="key" class="text" type="text">
						<button onclick="search('key');return false;"
							class="button cw-icon">
							<i></i>搜索
						</button>
					</div>
				</div>
				<div class="kf_phone">
					<img src="img/tel.jpg" alt="客服电话">
				</div>
				<!-- 
			    <div class="hot_keys">
			    	<span>热门搜索：</span>
			    	<a href="javascript:void(0);">iphone6s</a>
			    </div>
			     -->
			</div>
			<span class="clr"></span>
		</div>
	</div>

</body>
</html>