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
	
	var basePath = "<%=basePath %>";
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>

	<div class="container">
		<div class="content">
			<!-- <div class="headImg">
            	<ul>
                	<li>查看购物车</li>
                    <li>拍下商品</li>
                    <li>付款到支付宝</li>
                    <li>确认收货</li>
                    <li>评价</li>
                </ul>
            </div> -->
			<div class="choose-add">
				<h2>选择收货地址</h2>
				<ul>
					<!-- <li><a class="modify-add">修改地址</a> <input type="radio" /> <strong>山西省
							太原市 小店区 南中环街体育路口软件园A座四层 (张张 收) 15132222222</strong></li>
					<li><a class="modify-add">修改地址</a> <input type="radio" /> <strong>山西省
							太原市 小店区 南中环街体育路口软件园A座四层 (王王 收) 15132222222</strong></li> -->
					<c:if test="${not empty addrList}">
						<c:forEach items="${addrList}" var="addr">
							<c:if test="${addr.isDefault == 1 }">
								<li><a class="modify-add" href="<%=basePath%>order/del/${addr.id}">删除地址</a> <input
									type="radio" name="addr" id="addr" checked="checked" value="${addr.id }"/> <strong>${addr.province }
										${addr.city } ${addr.area } ${addr.extra } (${addr.contacts }收) ${addr.phone }</strong></li>
							</c:if>
							<c:if test="${addr.isDefault == 0 }">
								<li><a class="modify-add"
									href="<%=basePath%>order/del/${addr.id}">删除地址</a> <input
									type="radio" name="addr" id="addr" value="${addr.id }"/> <strong>${addr.province }
										${addr.city } ${addr.area } ${addr.extra } (${addr.contacts }
										收) ${addr.phone }</strong></li>
							</c:if>

						</c:forEach>
					</c:if>
				</ul>
				<a class="newadd" id="create-add">使用新地址</a>
				<!---->
				<div
					class="New_address ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable"
					id="dialog-form" title="创建新地址">

					<div class="form-box">
							<table>
								<tr>
									<th width="135px">所在地区：</th>
									<td width="20px"><em>*</em></td>
									<td width="80%">
										<div class="form-box">
											<select id="provinceId" data-key="province"
												data-available="true">
												<option value="">---省份---</option>
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
											</select> <select id="eparchyId" name="city" data-key="city"
												data-available="true">
												<option value="">请选择城市...</option>
											</select> <select id="cityId" name="area" data-key="area"
												data-available="true">
												<option value="">请选择区/县...</option>
											</select>
										</div>
									</td>
								</tr>
								<!-- <tr>
								<th>邮政编码：</th>
								<td><em>*</em></td>
								<td><input type="text" /></td>
							</tr> -->
								<tr>
									<th>街道地址：</th>
									<td><em>*</em></td>
									<td><textarea data-ph="不需要重复填写省市区，必须大于5个字符，小于120个字符"
											data-msg="5-120个字符，一个汉字为两个字符"
											placeholder="不需要重复填写省市区，必须大于5个字符，小于120个字符"
											name="addressDetail" autocomplete="off" role="combobox" id="extra"
											aria-combobox="list"></textarea></td>
								</tr>
								<tr>
									<th>收货人姓名：</th>
									<td><em>*</em></td>
									<td><input type="text" id="contacts" value="" data-ph="长度不超过25个字"
										data-msg="2-25个字符，一个汉字为两个字符" placeholder="长度不超过25个字"
										name="fullName"></td>
								</tr>
								<tr>
								</tr>
								<!-- <tr>
								<th>电话号码：</th>
								<td>&nbsp;</td>
								<td><input class="i-text i-text-short" type="text" value=""
									data-ph="区号" placeholder="区号" name="phoneSection"> - <input
									class="i-text i-text-short" type="text" value="" data-ph="电话号码"
									placeholder="电话号码" name="phoneCode"> - <input
									class="i-text i-text-short" type="text" value="" data-ph="分机"
									placeholder="分机" name="phoneExt"> 格式：区号 - 电话号码 - 分机号</td>
							</tr> -->
								<th>手机号码：</th>
								<td><em>*</em></td>
								<td><input type="text" id="phone" value="" data-msg="6-20个数字"
									data-ph="电话号码、手机号码必须填一项6-20个数字" placeholder="电话号码、手机号码必须填一项"
									name="mobile"></td>
								<tr>
									<th>&nbsp;</th>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<th>&nbsp;</th>
									<td>&nbsp;</td>
									<td>
										<div class="skin-gray">
											<button class="submit-btn" type="button" id="addNewAddrBtn">确定</button>
										</div>
									</td>
								</tr>
								<!-- <tr>
								<th>&nbsp;</th>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr> -->
							</table>
					</div>
				</div>


				<!---->

			</div>
			<div class="choose-add choose-f2">
				<h2>支付方式</h2>
				<ul>
					<li><input type="radio" checked="checked" /><a>聚德币支付</a></li>
				</ul>

			</div>
			<div class="confirm">
				<h2>确认订单信息</h2>
				<form action="">
					<table class="confirm-list">
						<tr>
							<th style="text-align: left;"><a href="#">商品名</a></th>
							<th>单价（元）</th>
							<th>数量</th>
							<th>金额（元）</th>
						</tr>
						<c:if test="${not empty sessionScope.carts }">
							<c:forEach items="${sessionScope.carts }" var="entry">
								<tr>
									<td class="confirm-td confirm-left">${entry.key.onlineCommodity.commodityName }</td>
									<td class="confirm-td"><em>￥${entry.key.commodityPrice }</em></td>
									<td class="confirm-td">${entry.value }</td>
									<td class="confirm-td confirm-right"><span>${entry.key.commodityPrice *  entry.value}</span></td>
								</tr>
							</c:forEach>
						</c:if>
						<tr class="confirm-foot">
							<td colspan="3"><a>补充说明：<input type="text"
									value="选填，可告诉卖家您的特殊要求" /></a></td>
							<td colspan="1"><a>金额合计：￥${totalPrice - discountPrice}</a></td>
						</tr>
					</table>
				</form>
				<div class="confirm-btn">
					<a class="submit-btn" id="submitOrderBtn">提交订单</a> <a class="back" href="<%=basePath%>/cart/show">返回购物车修改</a>
				</div>
			</div>

		</div>

	</div>

	<jsp:include page="/template/footer.jsp" />
</body>
</html>