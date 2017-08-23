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
<script type="text/javascript" src="js/changePassword.js"></script>
<script type="text/javascript" src="js/myInfo.js"></script>

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
		<jsp:include page="/template/left.jsp"></jsp:include>
		<div class="member-right pull-right">
			<div class="table-title">个人信息</div>
			<!-- <div class="waringInfo">
				<div class="waringTitle">提示：</div>
				<div class="waringContent">
					如需修改会员号、手机号等信息请拨打客服电话400-116-1056进行修改</div>
			</div> -->
			<div class="formArea"
				style="padding-bottom: 1000px; margin-bottom: -1000px; overflow: hidden;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<input input="" type="hidden" class="r2" value="12486" id="user_Id">
					<tbody>
						<tr>
							<td width="20%" class="frr"><span style="color: Red;">*</span>注册会员名：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="${sessionScope.user.username }" id="user_acct" disabled="disabled"></td>
						</tr>
						<tr>
							<td width="20%" class="frr"><span style="color: Red;">*</span>注册手机号：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="${sessionScope.user.phone }" id="user_phone" disabled="disabled"></td>
						</tr>
						<!-- <tr>
							<td width="20%" class="frr"><span style="color: Red;">*</span>真实姓名：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="孙富山" id="user_name" disabled="disabled"></td>
						</tr>
						<tr>
							<td width="20%" class="frr"><span style="color: Red;">*</span>身份证号码：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="1421******0031" id="user_sid" disabled="disabled"></td>

						</tr>
						<tr>
							<td width="20%" class="frr">昵称：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="" id="nike_name"></td>

						</tr>
						<tr>
							<td width="20%" class="frr">QQ：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="" id="qq"></td>

						</tr>
						<tr>
							<td width="20%" class="frr">邮箱：</td>
							<td width="80%" class="fll"><input type="text" class="r2"
								value="" id="email"></td>

						</tr>
						<tr>
							<td class="frr"></td>
							<td class="fll"><a class="btn red_btn"
								href="javascript:void(0);" onclick="MyInfoComp.btn_submit();	">保存信息</a></td>
						</tr> -->
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>