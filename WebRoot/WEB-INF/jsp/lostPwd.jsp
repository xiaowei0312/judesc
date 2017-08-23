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
	
	var basePath = "<%=basePath %>";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<form id="personRegForm">
		<div class="container">
			<div class="member-right1 pull-right">
				<div class="table-title">找回密码-填写账户名</div>
				<div class="vip_a12 formArea"
					style="padding-bottom: 1000px; margin-bottom: -1000px; overflow: hidden;">
					<div style="width: 70%; height: 465px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tbody>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>账户名:</td>
									<td class="fll"><input type="text" id="userAcct"
										name="userAcct" placeholder="会员名/手机号" class="r3"
										onblur="RetrievePwdIndexComp.ret_UserAcct(this);"
										autocomplete="off"> <span class="error_msg"
										id="userAcct_error"> </span></td>
								</tr>
								<tr>
									<td class="frr"><span style="color: Red;">*</span>图形验证码:</td>
									<td class="fll"><input type="text" id="verifyCode"
										name="verifyCode" maxlength="4" placeholder="" class="r4"
										style="float: left; margin-right: 10px; margin-top: 10px;"
										onblur="RetrievePwdIndexComp.ret_validateCode(this)"
										autocomplete="off"> <a href="javascript:void(0);">
											<samp>
												<img id="verifyImg" src="<%=basePath%>imgVerifyCodeAjax"
													width="127" height="32"
													onclick="this.src='<%=basePath%>imgVerifyCodeAjax?t=' + new Date().getTime();"/>
											</samp>
									</a><%-- <a href="javascript:void(0)" class="changeImg"
										onclick="this.src='<%=basePath%>imgVerifyCodeAjax?t=' + new Date().getTime();">换一张</a> --%>
										<span id="verifyCode_error" class="error_msg"></span></td>
								</tr>
								<tr>
									<td class="frr"></td>
									<td class="fll"><a class="btn red_btn reg_btn"
										href="javascript:void(0)"
										onclick="RetrievePwdIndexComp.ret_next_btn();">下一步</a></td>
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