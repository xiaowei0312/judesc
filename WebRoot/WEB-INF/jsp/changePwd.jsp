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
			<div class="table-title">修改密码</div>
			<div class="formArea"
				style="padding-bottom: 1000px; margin-bottom: -1000px; overflow: hidden;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">

					<tbody>
						<tr>
							<td width="20%" class="frr"><span style="color: Red;">*</span>原始密码:</td>
							<td width="80%" class="fll"><input type="password"
								placeholder="请输入原始密码" class="r2"
								onblur="changePasswordComp.check_oldPassword(this);"
								id="oldPassword"><span class="error_msg"
								id="oldPassword_error"></span></td>
						</tr>

						<tr>
							<td class="frr"><span style="color: Red;">*</span>新密码:</td>
							<td class="fll"><input id="newPassword" type="password"
								placeholder="请输入新的密码" class="r2"
								onblur="changePasswordComp.check_newPassword(this);"
								autocomplete="off"><span class="error_msg"
								id="newPassword_error"></span></td>
						</tr>
						<tr>
							<td class="frr"></td>
							<td class="fll"><span
								style="color: #0a5599; display: block; line-height: 20px; font-size: 12px;">6-16个字符，需使用字母、数字或特殊符号组合，不能使用纯数字、纯字母、纯符号</span></td>
						</tr>

						<tr>
							<td class="frr"><span style="color: Red;">*</span>重复新密码:</td>
							<td class="fll"><input id="secondPassword" type="password"
								placeholder="请再次输入新的密码" class="r2"
								onblur="changePasswordComp.check_secondPassword(this);"><span
								class="error_msg" id="secondPassword_error"></span></td>
						</tr>
						<tr>
							<td class="frr"><span style="color: Red;">*</span>图形验证码：</td>
							<td class="fll"><input id="ImgCode" type="text"
								placeholder="请输入验证码" class="r4"
								style="float: left; margin-right: 10px; margin-top: 10px;"
								onblur="changePasswordComp.check_vailCode(this); "
								autocomplete="off"><a
								href="javascript:changePasswordComp.reImg()"><samp>
										<img src="<%=basePath %>imgVerifyCodeAjax" width="127"
											height="40" id="Img">
									</samp></a><span style="color: #BD022D; font-size: 12px;">点击图片切换</span> <span
								class="error_msg" id="vaildateCode_error"></span></td>
						</tr>
						<tr>
							<td class="frr"></td>
							<td class="fll"><a class="btn red_btn"
								href="javascript:void(0);"
								onclick="changePasswordComp.sub_changePassword();">提交</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>