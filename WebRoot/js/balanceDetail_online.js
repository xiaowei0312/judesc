$(function() {
	balanceDetailComp.init();
	balanceDetailComp.loadData(1);
});
var balanceDetailComp = {
	basePath : null,
	pageNo : null,
	pageSize : null,
	totalSize : null,
	detailTemplate : "{for detail in balanceDetail}<tr>"
		+ "<td>${detail.onlineJournalBook.journalTime}</td>"
		+ "<td>${detail.onlineCommodityModel.onlineCommodity.commodityName}</td>"
		+ "<td>${detail.onlineCommodityModel.commodityModel }</td>"
		+ "<td>${detail.onlineCommodityModel.commodityPrice }</td>"
		+ "<td>${detail.amount }</td>"
		+ "<td>${detail.num }</td>" 
		+ "</tr>{/for}",
	init : function() {
		var location = (window.location+'').split('/');  
		this.basePath = location[0]+'//'+location[2]+'/'+location[3];  
		this.initPage($("#pager"))
	},
	initPage : function(b) {
		if (b.length > 0) {
			var a = b.attr("data_page").split(",");
			this.totalSize = $.trim(a[0]);
			this.pageSize = $.trim(a[1]);
			this.buildPager(a[0], a[1], a[2])
		}
	},
	buildPager : function(e, b, a) {
		var c = e / b;
		var d = (e % b == 0) ? (c) : (parseInt(c) + 1);
		$("#pager").pager({
			pagenumber : a,
			pagecount : d,
			totalRecords : e,
			buttonClickCallback : this.loadData
		})
	},
	loadData : function(a) {
		balanceDetailComp.queryData(a)
	},
	queryData : function(a) {
		this.pageNo = a;
		$.ajax({
			type : "POST",
			url :  this.basePath + "/member/onlineConsumeRecordAjax",
			data : {
				page : a,
				size : this.pageSize,
				totalSize : this.totalSize
			},
			success : function(e) {
				var b = $.parseJSON(e);
				if (b.resultCode == "0") {
					balanceDetailComp.buildData(b.resultObj)
				}
			}
		})
	},
	buildData : function(a) {
		if (a && a.balanceDetail && a.balanceDetail.length > 0) {
			console.log(a.totalCount);
			console.log(a.balanceDetail);
			var b = this.detailTemplate.process(a);
			$("#balanceDetailTbody").html(b);
			this.buildPager(a.totalCount, this.pageSize, this.pageNo)
		}
	}
};