var LOAD_INTERVAL = 50,
	WAIT_TIMEOUT = 10000;
var GLOBAL_INFO = {
	REQ_URI: "/actionDispatcher.do",
	WEB_CONTEXT_PATH: "http://www.58jude.com",
	MEMBER_PATH: "http://www.58jude.com/member",
	UPLOAD_DOMAIN: "http://upload.58jude.com/",
	COOKIE_DOMAIN: ".58jude.com"
};
jQuery.extend({
	syncReq: (function() {
		var default_options = {
			type: "post",
			timeout: "60000",
			url: GLOBAL_INFO.REQ_URI + "?r=" + Math.random(),
			dataType: "jsonp",
			jsonp: "callback",
			success: function(data) {
				alert("Ajax Success!")
			},
			error: function(request, textStatus, errorThrown) {}
		};
		return function(user_options) {
			var options = {};
			var new_options = {};
			for (var key in user_options) {
				if (key != "success") {
					new_options[key] = user_options[key]
				}
			}
			new_options.success = function(data) {
				if (typeof(data) == "string" && data.indexOf("<script>") != -1) {
					data = data.replace("<script>", "");
					data = data.replace("<\/script>", "");
					eval(data);
					return
				}
				user_options.success(data)
			};
			$.extend(options, default_options, new_options);
			$.ajax(options)
		}
	})()
});

function showTitle(c, a) {
	if (c !== undefined && c !== null && (typeof c == "string")) {
		var b = "";
		while (this.getStringLen(c) > a) {
			c = c.substr(0, c.length - 2);
			b = "…"
		}
		c += b
	} else {
		c = ""
	}
	return c
}
function getStringLen(a) {
	return a.replace(/[^\x00-\xff]/g, "**").length
}
function curentNowTime() {
	var b = new Date();
	var f = b.getFullYear();
	var g = b.getMonth() + 1;
	var a = b.getDate();
	var e = b.getHours();
	var h = b.getMinutes();
	var d = b.getSeconds();
	var c = f + "-";
	if (g < 10) {
		c += "0"
	}
	c += g + "-";
	if (a < 10) {
		c += "0"
	}
	c += a + " ";
	if (e < 10) {
		c += "0"
	}
	c += e + ":";
	if (h < 10) {
		c += "0"
	}
	c += h + ":";
	if (d < 10) {
		c += "0"
	}
	c += d;
	return (c)
}
function loginOut() {
	$.syncReq({
		data: {
			reqUrl: "loginOut"
		},
		success: function(a) {
			top.window.location.href = "http://www.58jude.com"
		}
	})
};