$(function() {
	shopListComp.init()
});
var shopListComp = {
	mallPicImgPath: null,
	basePath: null,
	listHtml: null,
	pageNo: 1,
	pageSize: 9,
	pageCount: 0,
	init: function() {
		this.basePath = basePath;
		this.mallPicImgPath = mallPicImgPath;
		this.listHtml = '{for shop in objList}<li><a target="_blank" href="' + this.basePath + '/mall/item/${shop.id}"><div class="product-img"><img class="lazy" data-original="' + this.mallPicImgPath + '${shop.mallMainPicUrl}" alt="${shop.mallName }"/><span class="shopName">${shop.mallName }</span></div></a><p>电话：${shop.mallPhone }</p><p class="address">地址：${shop.mallAddress }</p></li>{/for}';
		
		this.loadShopList();
		this.bindEvent()
	},
	bindEvent: function() {
		$("#searchCity").on("click", function() {
			shopListComp.pageNo = 1;
			shopListComp.loadShopList()
		});
		$("#provinceId").on("change", this.loadEparchys);
		$("#eparchyId").on("change", this.loadCitys);
		$(".search_btn").on("click", this.loadShopList);
		$(".small_shop ul li").hover(function() {
			$(this).addClass("current").siblings().removeClass("current")
		})
	},
	/** ***********NEW*********** */
	loadEparchys : function() {
		shopListComp.clearSelect("#eparchyId", "---地市---");
		shopListComp.clearSelect("#cityId", "---区县---");
		var a = $(this).val();
		if ($.trim(a).length == 0) {
			return
		}
		$.ajax({
			type: "POST",
			url :  shopListComp.basePath + "/member/registerValidate.action",
			data : {
				reqType : "loadEparchy",
				addrId : a
			},
			success : function(b) {
				var c = $.parseJSON(b);
				if (c) {
					shopListComp.loadSelectOptions("#eparchyId", c)
				}
			}
		})
	},
	loadCitys : function() {
		shopListComp.clearSelect("#cityId", "---区县---");
		var a = $(this).val();
		if ($.trim(a).length == 0) {
			return
		}
		$.ajax({
			type: "POST",
			url :  shopListComp.basePath + "/member/registerValidate.action",
			data : {
				reqType : "loadCity",
				addrId : a
			},
			success : function(b) {
				var c = $.parseJSON(b);
				if (c) {
					shopListComp.loadSelectOptions("#cityId", c)
				}
			}
		})
	},
	loadSelectOptions : function(a, c) {
		var b = "";
		$.each(c, function() {
			b += "<option value='" + this.id + "'>" + this.name
					+ "</option>"
		});
		$(a).append(b)
	},
	clearSelect: function(a, b) {
		$(a).html("<option value=''>" + b + "</option>")
	},
	
	
	loadShopList: function() {
		$.ajax({
			type: "POST",
			url : "/judesc/mall/listAjax",
			data: {
				reqType: "query",
				provinceId: $("#provinceId").val(),
				eparchyId: $("#eparchyId").val(),
				cityId: $("#cityId").val(),
				shopName: $("#shopName").val(),
				busiClass: $("#busiClass").val(),
				pageNo: shopListComp.pageNo,
				pageSize: shopListComp.pageSize
			},
			success: function(e) {
				var a = $.parseJSON(e);
				var c = a.resultObj;
				if (c && c.objList && c.objList.length > 0) {
					var b = shopListComp.listHtml.process(c);
					$("#shopListArea").html(b);
					shopListComp.buildPager(c.totalCount, shopListComp.pageNo, shopListComp.pageSize);
					gotoTop()
				} else {
					$("#shopListArea").html("<div style='text-align:center;font-size:14px;'>抱歉，所选地区暂无商家，请切换其他地区进行查询!</div>");
					$(".pages").hide()
				}
				$("#totalShopNum").text(c.totalCount);
				$("img.lazy").lazyload({
					effect: "fadeIn",
					placeholder: "/userfiles/images/placeholder.gif"
				})
			}
		})
	},
	buildPager: function(c, b, a) {
		var d = c / a;
		var e = (c % a == 0) ? (d) : (parseInt(d) + 1);
		shopListComp.pageCount = e;
		$("#pager").pager({
			pagenumber: b,
			pagecount: e,
			totalRecords: c,
			buttonClickCallback: shopListComp.pageClick
		});
		$(".pages").show()
	},
	pageClick: function(a) {
		shopListComp.pageNo = a;
		shopListComp.loadShopList()
	},
	goToPage: function() {
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
					shopListComp.pageNo = a;
					shopListComp.loadShopList()
				}
			}
		}
	}
};