var smallCartHtml;
var cartLoadDelay;
var isSearch = 0;

function banner(l) {
	var f = $(l),
		d = f.find("li"),
		m = d.size(),
		c, k;
	var a = $("<div></div>").appendTo(f).addClass("f-numBarDiv");
	var g = $("<ul></ul>").appendTo(a);
	for (var e = 1; e <= m; e++) {
		var h = $("<li></li>").clone().appendTo(g).html(e);
		h.click(function() {
			clearInterval(k);
			c = b($(this).html());
			j()
		})
	}
	var h = g.find("li");
	d.eq(0).css({
		display: "block"
	});
	h.eq(0).addClass("selected");
	a.css("marginLeft", -a.width() / 2);
	if (m > 1) {
		c = 1;
		j()
	} else {
		h.unbind()
	}
	function b(n) {
		n = n - 1;
		d.eq(n).fadeIn().siblings().fadeOut();
		h.removeClass("selected").filter(":eq(" + n + ")").addClass("selected");
		var i = n + 1;
		if (i >= m) {
			i = 0
		}
		return (i)
	}
	function j() {
		k = setInterval(function() {
			c = b(c + 1)
		}, 10000)
	}
}
function setCookie(c, d, a) {
	var b = c + " = " + escape(d) + ";path=/;domain=" + GLOBAL_INFO.COOKIE_DOMAIN + ";";
	if (a) {
		var e = new Date();
		e.setTime(e.getTime() + a);
		b += "expires=" + e.toGMTString()
	}
	document.cookie = b
}
function getCookie(b) {
	var a = document.cookie.match(new RegExp("(^| )" + b + "=([^;]*)(;|$)"));
	if (a != null) {
		return unescape(a[2])
	}
	return null
}
function addFavorite(c, a) {
	try {
		window.external.addFavorite(a, c)
	} catch (b) {
		try {
			window.sidebar.addPanel(c, a, "")
		} catch (b) {
			alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请进入新网站后使用Ctrl+D进行添加")
		}
	}
}
function gotoTop() {
	$("html, documentElement").animate({
		scrollTop: 0
	}, 120);
	$("html, body").animate({
		scrollTop: 0
	}, 120)
}
function getKeyCode(c) {
	var b = 0;
	try {
		c = c || window.event || arguments.callee.caller.arguments[0];
		if (c.keyCode) {
			b = c.keyCode
		} else {
			if (c.which) {
				b = c.which
			}
		}
	} catch (a) {}
	return b
}
var categorys_t = -1,
	showlist_t = -1;

function initAllSortsMenu() {
	if ($("#allkinds").length < 1) {
		return
	}
	if (typeof(INDEX_PARAM) === "undefined") {
		$("#allkinds,#allkinds .cont").hover(function() {
			clearFstMenuTimer();
			categorys_t = setTimeout(showFstMenu, 50)
		}, function() {
			clearFstMenuTimer();
			categorys_t = setTimeout(hideFstMenu, 50)
		});
		$("#allkinds").bind("click", showFstMenu)
	}
	$("dd.kinds").hover(function() {
		var a = $(this);
		a.siblings().removeClass("cur").find(".sub_kinds").hide();
		a.addClass("cur").find(".sub_kinds").show()
	}, function() {
		var a = $(this);
		a.removeClass("cur").find(".sub_kinds").hide()
	})
}
function clearFstMenuTimer() {
	clearTimeout(categorys_t);
	categorys_t = -1
}
function showFstMenu() {
	$("#allkinds .cont").slideDown(50, clearFstMenuTimer);
	$("#allkinds").unbind("click").bind("click", hideFstMenu)
}
function hideFstMenu() {
	$("#allkinds .cont").slideUp(50, clearFstMenuTimer);
	$("#allkinds").unbind("click").bind("click", showFstMenu)
}
$(function() {
	initAllSortsMenu();
	initSmallcartInfo();
	smallCartHtml = '{var num = 0, totalPrice = 0.0}<h3 class="last-viewed">最近加入的商品</h3><div id="smallcart_scroll" class="item_scroll"><ul class="item_list">{for good in infos}{eval}num=num+parseInt(good.GOODS_NUM);totalPrice=totalPrice+parseFloat(good.GOODS_NUM * good.PRICE);{/eval}<li class="items" id="item_${good.SKU_ID}"><div class="pic"><a target="_blank" href="/items/${good.GOODS_ID}.html"><img src="' + GLOBAL_INFO.UPLOAD_DOMAIN + '${good.IMG_URL}" alt=""></a></div><div class="title"><a target="_blank" href="/items/${good.GOODS_ID}.html">${good.GOODS_NAME}</a></div><div class="pri_wrap"><div class="pir"><span class="red">￥${good.PRICE}</span><b>×${good.GOODS_NUM}</b></div><div class="del_btn"><a href="javascript:void(0);" onclick="deleteSmallCart(${good.SKU_ID});">删除</a></div></div></li>{/for}</div></ul><div class="account"><span class="text">共<span class="red">${num}</span>件商品</span><span class="text">合计：<span id="totalMustPayPrice" class="red em"><strong>￥${totalPrice.toFixed(2)}</strong><span class="a-btn"><a href="/member/cart.do" target="_self">去结算</a></span></div>'
});

function initSmallcartInfo() {
	$("#smallcart").mouseenter(smallCartEnter);
	$("#smallcart").mouseleave(smallCartLeave);
	setTimeout(loadCartCount, 1000)
}
function smallCartEnter() {
	$("#smallcart").unbind("mouseenter");
	cartLoadDelay = setTimeout(loadSmallCartInfo, 500);
	$("#smallcart").addClass("cur");
	$("#smallcart_cont").show()
}
function smallCartLeave() {
	clearTimeout(cartLoadDelay);
	$("#smallcart").removeClass("cur");
	$("#smallcart_cont").hide();
	$("#smallcart").mouseenter(smallCartEnter)
}
function loadCartCount() {
	$.syncReq({
		data: {
			reqUrl: "cart",
			flag: "count"
		},
		success: function(a) {
			$("#cart_totalCount").text(a.count)
		}
	})
}
function loadSmallCartInfo() {
	$.syncReq({
		data: {
			reqUrl: "cart",
			flag: "small"
		},
		success: function(a) {
			if (a && a.logic == 1) {
				if (a.infos.length == 0) {
					$("#smallcart_cont").html('<div class="free" style="display: block;"><span></span><p>购物车中还没有商品，赶紧选购吧！<a href="http://www.58jude.com">去首页看看</a></p></div>')
				} else {
					$("#smallcart_cont").html(smallCartHtml.process(a))
				}
			} else {
				$("#smallcart_cont").html('<div class="free" style="display: block;"><span></span><p>您尚未登录<a href="/member/login.do">去登录</a></p></div>')
			}
		}
	})
}
function deleteSmallCart(a) {
	$.syncReq({
		data: {
			reqUrl: "cart",
			flag: "del",
			sku: a
		},
		success: function(b) {
			if (b && b.result) {
				$("#item_" + a).fadeOut(200, function() {
					loadSmallCartInfo()
				})
			}
		}
	})
}
function search(a) {
	var b = $("#" + a).val();
	if (b = b.replace(/^\s*(.*?)\s*$/, "$1"), b.length > 100 && (b = b.substring(0, 100)), "" == b) {
		return void(window.location.href = window.location.href)
	}
	b = encodeURIComponent(b);
	("undefined" == typeof isSearch || 0 == isSearch) && (setTimeout(function() {
		window.location.href = "/judesc/commodity/search/" + b
	}, 10), isSearch = !0)
};