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

<title>聚德购物商城-名烟名酒城</title>
<meta name="Keywords" content="聚德购物|聚德购物商城|聚德养老购物">
<meta name="Description" content="聚德购物是社会新型消费养老电子商务平台！">
<link rel="shortcut icon" href="http://www.58jude.com/favicon.ico">
<link rel="bookmark" href="http://www.58jude.com/favicon.ico" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="common/doc.css">
<link rel="stylesheet" type="text/css" href="common/animate.min.css">
<script src="common/hm.js"></script><script type="text/javascript" src="common/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="common/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="common/layer.min.js"></script>
<link rel="stylesheet" href="common/layer.css" id="layui_layer_skinlayercss">
<script type="text/javascript" src="common/jquery.pager.js"></script>
<script type="text/javascript" src="common/template.min.js"></script>
<script type="text/javascript" src="common/base.js"></script>
<script type="text/javascript" src="common/headerNav.js"></script>
<script type="text/javascript" src="common/main_web.js"></script>
<script type="text/javascript" src="common/api"></script>
<script type="text/javascript" src="common/getscript"></script>

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
	<script type="text/javascript">
		var isInit = false;
		$(function() {
			$("#shopDetailTb li").on("click", switchTb);
		});
		function switchTb() {
			var contDiv = $($(this).attr("rel"));
			$(this).addClass("current").siblings().removeClass("current");
			contDiv.show().siblings().hide();
			if (contDiv.attr('id') == 's-position' && !isInit) {
				initMap();
			}
		}
		function initMap() {
			var map = new BMap.Map("container"); // 创建地图实例  
			var point = new BMap.Point("${mall.mallPos_lnt}","${mall.mallPos_lat}"); // 创建点坐标
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			map.centerAndZoom(point, 17);
			initMap = true;
		}
	</script>
	<div class="container">
		<div class="proinfo-main">
			<div class="proinfo-left">
				<img src="<%=mallPicImgPath %>${mall.mallMainPicUrl}">
			</div>
			<div class="proinfo-title">
				<h1 id="shopName">${mall.mallName }</h1>
			</div>
			<div class="proinfo-detail">
				<ul>
					<li>联系人：${mall.mallLinkMan }</li>
					<li>联系电话：${mall.mallPhone }</li>
					<li>商家地址：${mall.mallAddress }</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container mt15">
		<div class="procon-side">
			<div class="area-head">
				<h3>推荐商家</h3>
			</div>
			<div class="area-body">
				<ul>
				</ul>
			</div>
		</div>
		<div class="procon">
			<div class="procon-toolbar">
				<ul id="shopDetailTb" class="tabarea-items">
					<li rel="#s-images" class="current"><a
						href="javascript:void(0);">店内照片</a></li>
					<li rel="#s-position"><a href="javascript:void(0);">位置信息</a></li>
				</ul>
			</div>
			<div>
				<div id="s-images" style="display: block;">
					<c:if test="${not empty mall.mallPicUrl1 }">
						<img class="lazy"
						data-original=""
						src="<%=mallPicImgPath %>${mall.mallPicUrl1}"
						style="display: inline;">
					</c:if>
					<c:if test="${not empty mall.mallPicUrl2 }">
						<img class="lazy"
						data-original=""
						src="<%=mallPicImgPath %>${mall.mallPicUrl2}"
						style="display: inline;">
					</c:if>
					<c:if test="${not empty mall.mallPicUrl3 }">
						<img class="lazy"
						data-original=""
						src="<%=mallPicImgPath %>${mall.mallPicUrl3}"
						style="display: inline;">
					</c:if>
					<c:if test="${not empty mall.mallPicUrl4 }">
						<img class="lazy"
						data-original=""
						src="<%=mallPicImgPath %>${mall.mallPicUrl4}"
						style="display: inline;"> 
					</c:if>
					<c:if test="${not empty mall.mallPicUrl5 }">
						<img class="lazy"
						data-original=""
						src="<%=mallPicImgPath %>${mall.mallPicUrl5}"
						style="display: inline;"> 
					</c:if>
				</div>
				<div id="s-position" style="display: none;">
					<div id="container"></div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>