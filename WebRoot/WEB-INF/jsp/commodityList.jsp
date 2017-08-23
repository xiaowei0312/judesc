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
<script type="text/javascript" src="js/list.js"></script>

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
		<input id="cat" name="cat" type="hidden" value="${catId }">
		<input id="commName" name="commName" type="hidden" value="${commName }">
		<%-- <input id="totalNum" name="totalNum" type="hidden" value="${totalNum }">
		 --%>
		<ul class="prdouct-hot" id="prd-list">
			<!-- <li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10019.html">
						<img src="./居得购物商城_files/1.jpg"
						alt="小米（MI) L43M3-AA 小米电视3S 43英寸智能电视">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10019.html"
							title="小米（MI) L43M3-AA 小米电视3S 43英寸智能电视" target="_blank">
							小米（MI) L43M3-AA 小米电视3S 43英寸智能电视 </a>
					</div>
					<div class="pries">
						<strong>￥1899.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10018.html">
						<img src="./居得购物商城_files/1(1).jpg"
						alt="乐视超级电视 S50 Air 全配版 50英寸2D智能LED黑色（Letv S50 Air）">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10018.html"
							title="乐视超级电视 S50 Air 全配版 50英寸2D智能LED黑色（Letv S50 Air）"
							target="_blank"> 乐视超级电视 S50 Air 全配版 50英寸2D智能LED黑色（Letv S50
							Air） </a>
					</div>
					<div class="pries">
						<strong>￥2399.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10015.html">
						<img src="./居得购物商城_files/1(2).jpg"
						alt="西门子(SIEMENS) BCD-610W(KA92NV03TI) 610升">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10015.html"
							title="西门子(SIEMENS) BCD-610W(KA92NV03TI) 610升" target="_blank">
							西门子(SIEMENS) BCD-610W(KA92NV03TI) 610升 </a>
					</div>
					<div class="pries">
						<strong>￥7698.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10014.html">
						<img src="./居得购物商城_files/1(3).jpg"
						alt="美的(Midea) BCD-516WKM(E) 516升 风冷纤薄电脑控温对开门冰箱（泰坦银）">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10014.html"
							title="美的(Midea) BCD-516WKM(E) 516升 风冷纤薄电脑控温对开门冰箱（泰坦银）"
							target="_blank"> 美的(Midea) BCD-516WKM(E) 516升
							风冷纤薄电脑控温对开门冰箱（泰坦银） </a>
					</div>
					<div class="pries">
						<strong>￥3099.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10013.html">
						<img src="./居得购物商城_files/1(4).jpg"
						alt="美的(Midea) BCD-206TM(E) 206升 三门冰箱 节能保鲜 闪白银">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10013.html"
							title="美的(Midea) BCD-206TM(E) 206升 三门冰箱 节能保鲜 闪白银" target="_blank">
							美的(Midea) BCD-206TM(E) 206升 三门冰箱 节能保鲜 闪白银 </a>
					</div>
					<div class="pries">
						<strong>￥1396.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10012.html">
						<img src="./居得购物商城_files/2.png" alt="富信(Fuxin)BC-17S 迷你单门小冰箱">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10012.html"
							title="富信(Fuxin)BC-17S 迷你单门小冰箱" target="_blank">
							富信(Fuxin)BC-17S 迷你单门小冰箱 </a>
					</div>
					<div class="pries">
						<strong>￥369.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10011.html">
						<img src="./居得购物商城_files/1(5).jpg"
						alt="三星（SAMSUNG）BCD-265WMSSWW1 265L 智能变频 风冷三门冰箱">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10011.html"
							title="三星（SAMSUNG）BCD-265WMSSWW1 265L 智能变频 风冷三门冰箱"
							target="_blank"> 三星（SAMSUNG）BCD-265WMSSWW1 265L 智能变频 风冷三门冰箱 </a>
					</div>
					<div class="pries">
						<strong>￥4299.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10010.html">
						<img src="./居得购物商城_files/1(6).jpg"
						alt="松下（Panasonic）SR-CNK05-W 微电脑电饭煲1.5L 迷你型 不沾涂层">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10010.html"
							title="松下（Panasonic）SR-CNK05-W 微电脑电饭煲1.5L 迷你型 不沾涂层"
							target="_blank"> 松下（Panasonic）SR-CNK05-W 微电脑电饭煲1.5L 迷你型 不沾涂层
						</a>
					</div>
					<div class="pries">
						<strong>￥369.00</strong>
					</div>
				</div>
			</li>
			<li>
				<div class="p_img">
					<a target="_blank" href="http://www.58jude.com/items/10009.html">
						<img src="./居得购物商城_files/1(7).jpg"
						alt="海尔(Haier)10升大水量 6年质保 恒温燃气热水器(天然气)JSQ32-UT">
					</a>
				</div>
				<div class="product-detail">
					<div class="product-intro">
						<a href="http://www.58jude.com/items/10009.html"
							title="海尔(Haier)10升大水量 6年质保 恒温燃气热水器(天然气)JSQ32-UT" target="_blank">
							海尔(Haier)10升大水量 6年质保 恒温燃气热水器(天然气)JSQ32-UT </a>
					</div>
					<div class="pries">
						<strong>￥1299.00</strong>
					</div>
				</div>
			</li> -->
			<script type="text/javascript">
				var pageCount = ${totalNum};
				var onlineCommodImgPath = "<%=onlineCommodImgPath%>";
			</script>
		</ul>
	</div>
	<!-- 分页 -->
	<div class="container pages m20-b">
		<div id="pager" class="pager">
			<div class="mod_body list_page">
				<a href="javascript:void(0)" class="pgEmpty">首页</a><a
					href="javascript:void(0)" class="pgEmpty">上一页</a><span>1</span><a
					href="javascript:void(0)" class="pgEmpty">下一页</a><a
					href="javascript:void(0)" class="pgEmpty">末页</a>共<i
					style="font-weight: bold; font-style: normal;">1</i>页
			</div>
		</div>
		到第<input type="text" class="text-box" id="numberOfPages"> 页 <input
			type="button" value="GO" class="sub-btn"
			onclick="javascript:listComp.goToPage();">
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>