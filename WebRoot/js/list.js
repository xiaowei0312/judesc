$(function() {
	listComp.init();
	listComp.pageClick(1);
});
var listComp = {
	listHtml : null,	
	pageNo : 1,
	pageSize : 20,
	pageCount : 0,
	totalCount : 0,
	basePath : null,
	onlineCommodImgPath : null,
	init : function() {
		var location = (window.location + '').split('/');
		this.basePath = location[0] + '//' + location[2] + '/' + location[3];
		this.onlineCommodImgPath = onlineCommodImgPath;
		this.totalCount = pageCount;
		
		this.listHtml = '{for good in items}<li><div class="p_img"><a target="_blank" href="' + this.basePath + '/commodity/item/${good.id}"><img style="width:170px;height:170px" src="'
			+ this.onlineCommodImgPath
			+ '${good.commodityMainPic}" alt="${good.commodityName}" /></a></div><div class="product-detail"><div class="product-intro"><a href="' + this.basePath + '/commodity/item/${good.id}" title="${good.commodityName}" target="_blank">${good.commodityName}</a></div><div class="pries">' 
			+ '{for model in good.commodityModels}{if model.isDefaultModel == 1}<strong>￥${model.commodityPrice}</strong>{/if}{/for}</div></div></li>{/for}',

		this.buildPager(this.totalCount, this.pageNo, this.pageSize)
	},
	loadItemList : function() {
		$.ajax({
			type : "POST",
			url : this.basePath + "/commodity/listAjax",
			data : {
				catId : $("#cat").val(),
				commName : $("#commName").val(),
				page : listComp.pageNo,
				size : listComp.pageSize,
				total: listComp.totalCount
			},
			success : function(e) {
				var a = $.parseJSON(e);
				var c = a.resultObj;
				if (c && c.items && c.items.length > 0) {
					var b = listComp.listHtml.process(c);
					$("#prd-list").html(b);
					listComp.buildPager(c.totalCount, listComp.pageNo,
							listComp.pageSize);
					gotoTop()
				}
			}
		})
	},
	buildPager : function(c, b, a) {
		var d = c / a;
		var e = (c % a == 0) ? (d) : (parseInt(d) + 1);
		listComp.pageCount = e;
		$("#pager").pager({
			pagenumber : b,
			pagecount : e,
			totalRecords : c,
			buttonClickCallback : listComp.pageClick
		})
	},
	pageClick : function(a) {
		listComp.pageNo = a;
		listComp.loadItemList()
	},
	goToPage : function() {
		var a = "";
		var c = "^[0-9]*$";
		var b = new RegExp(c);
		a = $.trim($("#numberOfPages").val());
		if (a == "" || !a.match(b)) {
			alert("页数不能为空，且必须是数字，请重新输入。")
		} else {
			if (parseInt(a) <= 0) {
				alert("页数不能小于零，请重新输入。")
			} else {
				if (parseInt(a) > shopListComp.pageCount) {
					alert("页数不能大于总页数，请重新输入。")
				} else {
					listComp.pageNo = a;
					listComp.loadItemList()
				}
			}
		}
	}
};