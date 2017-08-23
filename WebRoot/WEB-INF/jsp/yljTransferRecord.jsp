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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache,must-revalidate">
<meta http-equiv="Cache" content="no-cache">
<meta http-equiv="expires" content="0">
<title>余额变更明细</title>
<meta name="Keywords" content="居得购物|居得购物商城|居得养老购物">
<meta name="Description" content="居得购物是社会新型消费养老电子商务平台！">
<link rel="bookmark" href="http://www.58jude.com/favicon.ico"
	type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/doc.css">
<link rel="stylesheet" type="text/css" href="css/animate.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.selectlist.css">
<script src="js/hm.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/layer.min.js"></script>
<link rel="stylesheet" href="css/layer.css"
	id="layui_layer_skinlayercss">
<script type="text/javascript" src="js/jquery.pager.js"></script>
<script type="text/javascript" src="js/jquery.select.min.js"></script>
<script type="text/javascript" src="js/template.min.js"></script>
<script type="text/javascript" src="js/WdatePicker.js"></script>
<link href="css/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/base.js"></script>
<script type="text/javascript" src="js/headerNav.js"></script>
<script type="text/javascript" src="js/main_web.js"></script>
<script type="text/javascript" src="js/balanceDetail_ylj.js"></script>
<script>
	//百度统计
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?51a2a4a12de104b62e657fb0e62c4b5f";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>
</head>

<body>
	<jsp:include page="/template/header1.jsp"></jsp:include>
	<div class="container">
		<jsp:include page="/template/left.jsp"></jsp:include>
		<div class="member-right pull-right">
			<div class="table-title">养老金转存记录</div>
			<div class="resultTable">
				<table>
					<thead>
						<tr>
							<th width="25%">时间</th>
							<th width="25%">项目</th>
							<th width="25%">金额</th>
							<th width="25%">余额</th>
						</tr>
					</thead>
					<tbody id="balanceDetailTbody">
					</tbody>
				</table>
			</div>
			<div class="pager-box" id="pageDiv">
				<div class="pager" id="pager" data_page="${totalNum },20,1"></div>
			</div>
		</div>
	</div>
	</div>
	<jsp:include page="/template/footer.jsp" />
</body>
</html>