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
<script type="text/javascript" src="js/reg.js"></script>
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
	<form id="personRegForm" method="post" autocomplete="off">
		<input name="reqUrl" value="register" type="hidden"> <input
			name="reqType" value="reg" type="hidden">
		<div class="container">
			<div class="member-right1 pull-right">
				<div class="table-title">会员注册</div>
				<div class="vip_a12 formArea">
					<table width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="frr" width="27%"><span style="color: Red;">*</span>会员名:</td>
								<td class="fll" width="73%"><input id="userAcct"
									name="username" placeholder="请输入会员名" class="r3" state="1"
									type="text"> <span id="userAcct_error"
									class="error_msg_new">会员名不能为空!</span></td>
							</tr>

							<tr>
								<td class="frr"></td>
								<td class="fll"><span class="reg_tip">
										以字母开头的6-16位会员名,中间可使用数字及下划线,不能为纯数字 </span></td>
							</tr>
							<tr>
								<td class="frr"><span style="color: Red;">*</span>密码:</td>
								<td class="fll"><input id="password" name="password"
									placeholder="" class="r3" type="password"> <span
									id="password_error" class=""></span></td>
							</tr>
							<tr>
								<td class="frr"></td>
								<td class="fll"><span class="reg_tip">
										6-16个字符，需使用字母、数字或特殊符号组合，不能使用纯数字、纯字母、纯符号 </span></td>
							</tr>


							<tr>
								<td class="frr"><span style="color: Red;">*</span>确认密码:</td>
								<td class="fll"><input id="repassword" name="repassword"
									placeholder="" class="r3" type="password"> <span
									id="repassword_error" class=""></span></td>
							</tr>
							<tr>
								<td class="frr"><span style="color: Red;">*</span>手机号:</td>
								<td class="fll"><input id="userPhone" name="phone"
									placeholder="请输入常用手机号" class="r3" type="text"> <span
									id="userPhone_error" class=""></span></td>
							</tr>
							<tr>
								<td class="frr">真实姓名:</td>
								<td class="fll"><input id="realName" name="realName"
									maxlength="10" placeholder="" class="r3" type="text"> <span
									id="realName_error" class=""></span></td>
							</tr>

							<tr>
								<td class="frr"></td>
								<td class="fll"><span class="reg_tip">
										请填写您身份证上的真实姓名,注册之后不能自行修改,提现时要验证真实姓名.否则无法提现.请认真填写. </span></td>
							</tr>


							<tr>
								<td class="frr"><span style="color: Red;">*</span>常住地区:</td>
								<td class="fll"><select name="province" id="provinceId"
									class="r1">
										<option value="" selected="selected">--请选择--</option>
										<option value="1">北京市</option>
										<option value="2">天津市</option>
										<option value="3">河北省</option>
										<option value="4">山西省</option>
										<option value="5">内蒙古</option>
										<option value="6">辽宁省</option>
										<option value="7">吉林省</option>
										<option value="8">黑龙江</option>
										<option value="9">上海市</option>
										<option value="10">江苏省</option>
										<option value="11">浙江省</option>
										<option value="12">安徽省</option>
										<option value="13">福建省</option>
										<option value="14">江西省</option>
										<option value="15">山东省</option>
										<option value="16">河南省</option>
										<option value="17">湖北省</option>
										<option value="18">湖南省</option>
										<option value="19">广东省</option>
										<option value="20">广 西</option>
										<option value="21">海南省</option>
										<option value="22">重庆市</option>
										<option value="23">四川省</option>
										<option value="24">贵州省</option>
										<option value="25">云南省</option>
										<option value="26">西 藏</option>
										<option value="27">陕西省</option>
										<option value="28">甘肃省</option>
										<option value="29">青海省</option>
										<option value="30">宁 夏</option>
										<option value="31">新 疆</option>
								</select> <select name="city" id="eparchyId" class="r1">
										<option value="" selected="selected">--请选择--</option>
								</select> <select name="area" id="cityId" class="r1">
										<option value="" selected="selected">--请选择--</option>
								</select> <span id="area_error" class=""></span></td>
							</tr>

							<tr>
								<td class="frr"><span style="color: Red;">*</span>图形验证码:</td>
								<td class="fll"><input id="verifyCode" name="verifyCode"
									maxlength="4" placeholder="" class="r4"
									style="float: left; margin-right: 10px; margin-top: 10px;"
									type="text"> <a href="javascript:void(0);"> <samp>
											<img id="verifyImg" src="<%=basePath%>imgVerifyCodeAjax"
												width="127" height="32">
										</samp>
								</a><a href="javascript:void(0);" class="changeImg">换一张</a> <span
									id="verifyCode_error"></span></td>
							</tr>
							<tr>
								<td class="frr"><span style="color: Red;">*</span>短信验证码:</td>
								<td class="fll"><input id="smsCode" name="smsCode"
									maxlength="6" placeholder="" class="r4" type="text"> <a
									class="btn" id="smsBtn"><span id="smsBtn_text">获取验证码</span></a>
									<span id="smsCode_error"></span> <span id="smsCode_success"></span>
								</td>
							</tr>
							<!-- <tr>
								<td class="frr"></td>
								<td class="fll"><label> <input id="readme"
										name="readme" checked="checked" value="1"
										style="margin-right: 4px;" type="checkbox">
								</label> 我已认真阅读并同意 <a class="reg_readme"
									href="http://www.58jude.com/helpCenter/help.do?id=1002"
									target="blank"> <span>《用户协议》</span>
								</a> 和 <a class="reg_readme"
									href="http://www.58jude.com/helpCenter/help.do?id=2003"
									target="blank"> <span>《赠送规则》</span>
								</a></td>
							</tr> -->

							<tr>
								<td class="frr"></td>
								<td class="fll"><a class="btn red_btn reg_btn"
									href="javascript:void(0);">立即注册</a> <a class="reg_gotoLogin"
									href="<%=basePath%>/member/loginPage"> <span
										style="color: #096cf2; margin-left: 20px;">已有账号，登陆</span>
								</a>
									<p id="reg_error"
										style="font-size: 14px; color: red; padding-left: 70px; line-height: 20px;"></p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</form>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>