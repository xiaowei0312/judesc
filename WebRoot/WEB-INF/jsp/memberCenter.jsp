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
			<div class="table-title">账户概览</div>
			<div class="gailan1">
				<ul>
					<li>当前积分：<span>${user.jfAccount.accountBalance }</span></li>
					<li>当前聚财宝：<span>${user.dlbAccount.accountBalance }</span></li>
					<li>当前余额：<span>${user.moneyAccount.accountBalance }</span></li>
					<li>当前聚得币：<span>${user.jdbAccount.accountBalance }</span></li>
					<li>当前养老金：<span>${user.yljAccount.accountBalance }</span></li>

					<li>累计线下消费：<span>${user.totalConsumOffline }</span></li>
					<li>累计线上消费：<span>${user.totalConsumOnline }</span></li>
					<li>累计充值：<span>${user.totalRecharge }</span></li>
					<li>累计提现：<span>${user.totalWithDraw }</span></li>
					<li>累计奖励积分：<span>${user.totalRewardJf }</span></li>
					<li>累计转换聚财宝：<span>${user.totalTransferDlb }</span></li>
					<li>累计奖励人民币：<span>${user.moneyAccount.totalPlatformIncomings }</span></li>
					<li>累计奖励聚得币：<span>${user.totalRewardJdb }</span></li>
					<li>累计奖励养老金：<span>${user.totalRewardYlj }</span></li>
					<li>累计转存养老金：<span>${user.totalTransferYlj }</span></li>
					<c:if test="${user.role.roleName == '商家'}">
						<li>累计报单上交：<span>${user.totalSumbitOrderValue }</span></li>
					</c:if>
				</ul>
			</div>

			<div class="gailan2" style="margin-right: 10px;">
				<div class="gailan3">
					<samp></samp>
					近期收益
					<!-- <a href="http://www.58jude.com/member/incomeDetail.do"><span>更多&gt;</span></a> -->
				</div>
				<div class="resultTable">
					<table width="97%" cellspacing="0" cellpadding="0" border="0">
						<thead>
							<tr>
								<th width="35%">时 间</th>
								<th width="20%">聚财宝</th>
								<th width="18%">收益</th>
								<th width="27%">备注</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty syAccountRecordExpands }">
								<c:forEach items="${syAccountRecordExpands }" var="record">
									<tr>
										<td><fmt:formatDate value="${record.operationTime }"
												pattern="yyyy-MM-dd" /></td>
										<td>${record.dlbNum }</td>
										<td>${record.distributedMoney + record.distributedYlj}</td>
										<td>聚财宝赠送</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty syAccountRecordExpands }">
								<tr>
									<td colspan="4">没有查询到近期收益记录!</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="gailan2">
				<div class="gailan3">
					<samp></samp>
					近期聚财宝变更记录
					<!-- <a href="http://www.58jude.com/member/dlbDetail.do"><span>更多&gt;</span></a> -->
				</div>
				<div class="resultTable">
					<table width="97%" cellspacing="0" cellpadding="0" border="0">
						<thead>
							<tr>
								<th width="35%">时 间</th>
								<th width="20%">数量</th>
								<th width="18%">当前聚财宝</th>
								<th width="27%">备注</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty dlbAccountRecordExpands }">
								<c:forEach items="${dlbAccountRecordExpands }" var="record" varStatus="st">
									<tr>
										<td><fmt:formatDate value="${record.operateTime }"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>
											<c:if test="${record.operation == 0 }">
												<span class="modelUp"> +${record.operateNum }</span>
											</c:if> <c:if test="${record.operation == 1}">
												<span class="modelDown"> ${record.operateNum }</span>
											</c:if>
										</td>
											<td>${record.balance}</td>
										<td>
											<c:if test="${record.operation == 0 }">
												积分转化
											</c:if> <c:if test="${record.operation == 1}">
												赠送满600减1
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty dlbAccountRecordExpands }">
								<tr>
									<td colspan="4">没有查询到近期聚财宝变更记录!</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="vip_a2">
				<div class="gailan3">
					<samp></samp>
					近期消费记录
					<!--<a href="http://www.58jude.com/member/offlineConsume.do"><span>更多&gt;</span></a> -->
				</div>
				<div class="resultTable">
					<table width="97%" cellspacing="0" cellpadding="0" border="0">
						<thead>
							<tr>
								<th width="20%">时间</th>
								<th width="22%">商家</th>
								<th width="18%">商品</th>
								<th width="10%">交易金额</th>
								<th width="10">商家优惠</th>
								<th width="10%">获赠积分</th>
								<th width="9%">状态</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty journalBookExpands }">
								<c:forEach items="${journalBookExpands }" var="record">
									<tr>
										<td><fmt:formatDate
											value="${record.journalTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td>${record.business.username }</td>
										<td>${record.commodityName }</td>
										<td>${record.amount }</td>
										<td>${record.premiumRates }%</td>
										<td>${record.giftJf }</td>
										<c:if test="${record.flag == 0}">
											<td>未审核</td>
										</c:if>
										<c:if test="${record.flag == 1}">
											<td>已审核</td>
										</c:if>
										<c:if test="${record.flag == 2}">
											<td>已奖励</td>
										</c:if>
										<c:if test="${record.flag == 3}">
											<td>未通过审核</td>
										</c:if>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty journalBookExpands }">
								<tr>
									<td colspan="7">没有查询到近期消费记录!</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>