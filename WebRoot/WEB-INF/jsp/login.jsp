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
<title>登录</title>
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
<script type="text/javascript" src="js/login.js"></script>
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
		
		$("#allkinds").hover(function(){
			$(".cont").css("display", "block")
		},function(){
			$(".cont").css("display", "none")
		});
	});
	
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<form method="post">
		<div class="container">
			<div class="login-box">
				<div class="login-right">
					<h3>会员登录</h3>
					<div class="input-box">
						<img src="img/deng5_03.png" style="float: left" width="40"
							height="40"> <input id="loginname" name="loginname"
							maxlength="16" placeholder="会员名/手机号" autocomplete="off"
							type="text">
					</div>
					<div class="input-box">
						<img src="img/deng6_03.png" style="float: left" width="40"
							height="40"> <input id="loginpass" name="loginpass"
							maxlength="16" placeholder="密码" type="password">
					</div>
					<div class="input-box1">
						<input id="verifyCode" name="verifyCode" maxlength="4"
							placeholder="请输入验证码" autocomplete="off" type="text"> <img
							id="verifyCodeImg" src="<%=basePath %>imgVerifyCodeAjax"
							style="margin-left: 13px;" title="点击切换"
							onclick="this.src='<%=basePath %>imgVerifyCodeAjax?t=' + new Date().getTime();"
							width="127" height="40">
					</div>
					<div class="input-box set-password">
						<a href="<%=basePath %>/member/lostPwd"
							class="pull-right">忘记密码？</a>
					</div>
					<input id="bsubmit" value="登 录" class="login-btn" type="button">
				</div>
			</div>
		</div>
	</form>
	<jsp:include page="/template/footer.jsp" />

</body>
</html>