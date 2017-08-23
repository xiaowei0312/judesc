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
<script type="text/javascript" src="js/lostPwd.js"></script>

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
	
	var basePath = "<%=basePath%>";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<form id="RetrievePwdForm" method="post">
		<input id="userAcct" name="phoneNo" type="hidden" value="${phone }">
		<div class="container">
			<div class="member-right1 pull-right">
				<div class="table-title">找回密码-设置新密码</div>
				<div class="vip_a12 formArea"
					style="padding-bottom: 1000px; margin-bottom: -1000px; overflow: hidden;">
					<div style="width: 70%; height: 465px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>会员手机号码:</td>
									<td class="fll"><input type="text" disabled="disabled"
										name="userphone" placeholder="" class="r3" value="${phone }"
										autocomplete="off"></td>
								</tr>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>新登入密码:</td>
									<td class="fll"><input type="password" id="newPwd"
										name="newPwd" placeholder="请输入新的登入密码" class="r3"
										onblur="RetrievePwdResetComp.newPwd(this);" autocomplete="off">
										<span class="error_msg" id="newPwd_error"> </span></td>
								</tr>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>确认新密码:</td>
									<td class="fll"><input type="password" id="SecondPwd"
										name="SecondPwd" placeholder="请重新输入新密码" class="r3"
										onblur="RetrievePwdResetComp.SecondPwd(this);"> <span
										class="error_msg" id="Second_error"> </span></td>
								</tr>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>短信验证码:</td>
									<td class="fll"><input type="text" id="smsCode"
										name="smsCode" maxlength="6" placeholder="短信验证码" class="r4"
										onblur="RetrievePwdResetComp.SMSValidate(this);"
										autocomplete="off"> <a class="btn" id="smsBtn"
										onclick="RetrievePwdResetComp.sendSMS()"><span
											id="smsBtn_text">获取验证码</span></a> <span class="error_msg"
										id="smsCode_error"></span> <span id="smsCode_success"></span>
									</td>
								</tr>
								<tr>
									<td class="frr"></td>
									<td class="fll"><a class="btn red_btn reg_btn"
										href="javascript:void(0);"
										onclick="RetrievePwdResetComp.Sumbit()">提交</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</form>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>