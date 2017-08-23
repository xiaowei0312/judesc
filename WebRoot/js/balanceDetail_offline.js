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
			+ "<td>${detail.journalTime}</td>"
			+ "<td>${detail.business.username}</td>"
			+ "<td>${detail.commodityName }</td>"
			+ "<td>${detail.amount }</td>"
			+ "<td>${detail.premiumRates }%</td>"
			+ "<td>${detail.giftJf }</td>"
			//+ "<td>{if detail.flag == '0'}未审核{else if detail.flag == '1'}已审核{else if detail.flag == '2'}已奖励{else if detail.flag == '3'}未通过{/if}</td></tr>{/for}",
			+ "<td>{if detail.flag == '0'}未审核{else}未通过{/if}</td></tr>{/for}",
	init : function() {
		var location = (window.location + '').split('/');
		this.basePath = location[0] + '//' + location[2] + '/' + location[3];
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
			url : this.basePath + "/member/offlineConsumeRecordAjax",
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
			var b = this.detailTemplate.process(a);
			$("#balanceDetailTbody").html(b);
			this.buildPager(a.totalCount, this.pageSize, this.pageNo)
		}
	}
};