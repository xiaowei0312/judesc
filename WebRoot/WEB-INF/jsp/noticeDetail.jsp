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
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Cache" content="no-cache">
<meta http-equiv="expires" content="0">
<title>注册-个人用户</title>
<meta name="Keywords" content="聚德购物|聚德购物商城|聚德养老购物">
<meta name="Description" content="聚德购物是社会新型消费养老电子商务平台！">
<link rel="stylesheet" type="text/css" href="css/doc.css">
<link rel="stylesheet" type="text/css" href="css/animate.css">
<script src="js/hm.js"></script>
<script type="text/javascript" src="js/jquery-1.js"></script>
<script type="text/javascript" src="js/jquery_002.js"></script>
<script type="text/javascript" src="js/layer.js"></script>
<link rel="stylesheet" href="css/layer.css"
	id="layui_layer_skinlayercss" style="">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/template.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript" src="js/headerNav.js"></script>
<script type="text/javascript" src="js/main_web.js"></script>
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
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<div class="container">
		<div class="member-right1 pull-right">
			<div class="table-title">
				<div class="container local">
					<div>
						<a href="<%=basePath%>/main/index">首页</a>
						<code>&gt;</code>
						<a href="javascript:void(0);">${notice.noticeType.typeName }</a>
						<code>&gt;</code>
						${notice.noticeTitle }
					</div>
				</div>
			</div>
			<div class="notice-area">
				<div class="notice-title">
					<div class="notice-main-title">
						<span class="notice-title-type">[${notice.noticeType.typeName }]</span>
						<span class="notice-title-c">${notice.noticeTitle }</span>
					</div>
					<div class="notice-sub-title">
						<span>发布时间：<fmt:formatDate value="${notice.noticeAddTime }"
								pattern="yyyy-MM-dd HH:mm:ss" /></span>
					</div>
				</div>
				<div class="notice-content">${notice.noticeFileName }</div>
			</div>
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>