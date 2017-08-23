$(function() {
	loginComp.init()
});
var loginComp = {
	init : function() {
		$("#bsubmit").on("click", this.login);
		document.onkeydown = function(a) {
			if (getKeyCode(a) == 13) {
				$("#bsubmit").click()
			}
		}
	},
	login : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		var a = $("#loginname").val();
		var c = $("#loginpass").val();
		var b = $("#verifyCode").val();
		loginComp.validateLogin(a, c, b, function() {
			$.ajax({
				type: "POST",
				url :  basePath+"/member/loginSubmitAjax.action",
				data : {
					username : a,
					password : c,
					verifyCode : b,
				},
				success : function(e) {
					var f = $.parseJSON(e);
					if (f.resultCode!='0') {
						layer.alert("Error Request!", {
							icon : 5
						});
						loginComp.changeLoginVerifyCode();
						return;
					}
					if (f.logicCode!='0') {
						layer.alert(f.resultMsg,{
							icon : 5
						});
						loginComp.changeLoginVerifyCode();
						return;
					}
					window.location.href = f.url;
				}
			});
		})
	},
	validateLogin : function(b, d, c, a) {
		if (b == null || $.trim(b).length == 0) {
			alert("登录名不能为空!");
			$("#loginname").focus();
			return
		}
		if (d == null || $.trim(d).length == 0) {
			alert("登录密码不能为空!");
			$("#loginpass").focus();
			return
		}
		if (c == null || $.trim(c).length != 4) {
			alert("请填写验证码!");
			$("#verifyCode").focus();
			return
		}
		a()
	},
	treatKeyEvent : function(a) {
		if (pageEventComp.getKeyCode(a) == 13) {
			loginComponent.login()
		}
	},
	changeLoginVerifyCode : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		var a = new Date();
		var b = basePath + "/imgVerifyCodeAjax?t=?t="
				+ a.getTime();
		$("#verifyCodeImg").attr("src", b)
	}
};