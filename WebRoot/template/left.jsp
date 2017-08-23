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
<!-- <script type="text/javascript" src="js/header1.js"></script> -->
</head>
<body>
	<div class="member-left pull-left">
		<div class="person">
			<img src="img/person.jpg" alt=""> <a
				href="<%=basePath%>/member/exit" class="clearfix">退出登陆</a>
		</div>
		<dl>
			<dt>账户管理</dt>
			<dd>
				<a href="<%=basePath%>member/center">账户概况</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/moneyChangeRecord">余额变更记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/syChangeRecord">收益变更记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/jfChangeRecord">积分变更记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/dlbChangeRecord">得利宝变更记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/jdbChangeRecord">聚德币变更记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/yljTransferRecord">养老金转存记录</a>
			</dd>
		</dl>
		<dl>
			<dt>交易中心</dt>
			<dd>
				<a href="<%=basePath%>/member/onlineConsumeRecord">线上消费记录</a>
			</dd>
			<dd>
				<a href="<%=basePath%>/member/offlineConsumeRecord">线下消费记录</a>
			</dd>
		</dl>
		<dl>
			<dt>安全管理</dt>
			<dd>
				<a href="<%=basePath%>/member/changePwd">修改密码</a>
			</dd>
			<%-- <dd>
					<a href="<%=basePath %>/member/moneyChangeRecord">实名认证</a>
				</dd> --%>
			<dd>
				<a href="<%=basePath%>/member/selfInfo">个人信息</a>
			</dd>
			<%-- <dd>
					<a href="<%=basePath %>/member/moneyChangeRecord">收货地址</a>
				</dd> --%>
		</dl>
	</div>
</body>
</html>