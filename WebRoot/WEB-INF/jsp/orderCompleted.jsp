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
<link rel="stylesheet" type="text/css" href="css/gwc.css">
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
<script type="text/javascript" src="js/jquery.ui.min.js"></script>
<link type="text/css" href="css/jquery.ui.css" rel="stylesheet">
<script type="text/javascript" src="js/orderConfirm.js"></script>

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
	
	var basePath = "<%=basePath%>
	";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>

	<div class="container">
		<div class="content WS">
			<div class="Success">
				<h3>您已成功付款，订单号：${order.orderNo }</h3>
				<ul>
					<li><p>
							付款金额<em> ￥${order.totalAmount }</em>
						</p></li>
					<li><p>
							您可以<em>在用户中心</em>查看订单记录</em>
						</p></li>
				</ul>
				<div class="Success_f2">
					<!-- <p>
						免费<em>激活会员</em>，获得免费退货机会
					</p> -->
				</div>
			</div>

		</div>

	</div>

	<jsp:include page="/template/footer.jsp" />
</body>
</html>