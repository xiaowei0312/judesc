$(function() {
	regPersonComp.init()
});
var regPersonComp = {
	oldPhone : null,
	oldAcct : null,
	acctExists : false,
	phoneExists : false,
	delayFlag : true,
	delayTime : 120,
	init : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		this.bindSelectEvent();
		this.bindValidEvent();
		$(".changeImg").click(
				function() {
					$("#verifyImg").attr("src",
							basePath+"/imgVerifyCodeAjax?t=" + new Date().getTime())
				});
		$("#smsBtn").on("click", this.sendSMS);
		$(".reg_btn").on("click", this.reg)
	},
	bindSelectEvent : function() {
		$("#provinceId").on("change", this.loadEparchys);
		$("#eparchyId").on("change", this.loadCitys);
		$("#cityId").on("change", this.changeCity)
	},
	bindValidEvent : function() {
		this.regValid("#userAcct", this.regUserAcct);
		this.regValid("#userPhone", this.regUserPhone);
		this.regValid("#password", this.regPassword);
		this.regValid("#repassword", this.regRepassword);
		this.regValid("#realName", this.regRealName)
	},
	loadEparchys : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		regPersonComp.clearSelect("#eparchyId");
		regPersonComp.clearSelect("#cityId");
		var a = $(this).val();
		if ($.trim(a).length == 0) {
			return
		}
		$.ajax({
			type: "POST",
			url :  basePath + "/member/registerValidate.action",
			data : {
				reqType : "loadEparchy",
				addrId : a
			},
			success : function(b) {
				var c = $.parseJSON(b);
				if (c) {
					regPersonComp.loadSelectOptions("#eparchyId", c)
				}
			}
		})
	},
	loadCitys : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		regPersonComp.clearSelect("#cityId");
		var a = $(this).val();
		if ($.trim(a).length == 0) {
			return
		}
		$.ajax({
			type: "POST",
			url :  basePath + "/member/registerValidate.action",
			data : {
				reqType : "loadCity",
				addrId : a
			},
			success : function(b) {
				var c = $.parseJSON(b);
				if (c) {
					regPersonComp.loadSelectOptions("#cityId", c)
				}
			}
		})
	},
	changeCity : function() {
		if ($(this).val().length > 0) {
			$("#area_error").removeClass("error_msg_new").text("")
		}
	},
	clearSelect : function(a) {
		$(a).html("<option value=''>--请选择--</option>")
	},
	loadSelectOptions : function(a, c) {
		var b = "";
		$.each(c, function() {
			b += "<option value='" + this.id + "'>" + this.name
					+ "</option>"
		});
		$(a).append(b)
	},
	regValid : function(a, b) {
		$(a).bind("focus", function() {
			$(a + "_error").removeClass("error_msg_new").text("")
		});
		$(a).bind("blur", function() {
			var c = b.call($(a));
			if (!c.success) {
				$(a).attr("state", "1");
				$(a + "_error").addClass("error_msg_new").text(c.errorMsg)
			} else {
				$(a).attr("state", "0");
				$(a + "_error").removeClass("error_msg_new").text("")
			}
		})
	},
	regUserAcct : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		var b = this.val(), a = {
			success : false,
			errorMsg : ""
		};
		if ($.trim(b).length == 0) {
			a.errorMsg = "会员名不能为空!";
			return a
		}
		if (/^\d*$/.test(b)) {
			a.errorMsg = "不能使用纯数字!";
			return a
		}
		if (!/^[a-zA-z]{1}[A-Za-z0-9_]{5,15}$/.test(b)) {
			a.errorMsg = "用户名必须以字母开头并且长度在6-16位之间!";
			return a
		}
		if (regPersonComp.acctExists && b == regPersonComp.oldAcct) {
			a.errorMsg = "会员号已被注册!";
			return a
		}
		$.ajax({
			type: "POST",
			url :  basePath + "/member/registerValidate.action",
			data : {
				reqType : "validAcct",
				username : b
			},
			success : function(e) {
				regPersonComp.oldAcct = b;
				var c = $.parseJSON(e);
				if (c.resultCode == "0") {
					if (c.logicCode != "0") {
						regPersonComp.acctExists = true;
						$("#userAcct").attr("state", "1");
						$("#userAcct_error").addClass("error_msg_new").text(
								c.resultMsg)
					} else {
						regPersonComp.acctExists = false;
						$("#userAcct").attr("state", "0");
						$("#userAcct_error").removeClass("error_msg_new").text(
								"")
					}
				}
			}
		})
		a.success = true;
		return a
	},
	regUserPhone : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		var b = this.val(), a = {
			success : false,
			errorMsg : ""
		};
		if ($.trim(b).length == 0) {
			a.errorMsg = "手机号码不能为空!";
			return a
		}
		if (!/^0?(13|15|18|14|17)[0-9]{9}$/.test(b)) {
			a.errorMsg = "请输入正确的手机号码!";
			return a
		}
		if (regPersonComp.phoneExists && b == regPersonComp.oldPhone) {
			a.errorMsg = "手机号已被注册!";
			return a
		}
		if (b != regPersonComp.oldPhone) {
			$.ajax({
				type: "POST",
				url :  basePath + "/member/registerValidate.action",
				data : {
					reqType : "validPhone",
					phone : b
				},
				success : function(e) {
					var c = $.parseJSON(e);
					if (c.resultCode == "0") {
						regPersonComp.oldPhone = b;
						if (c.logicCode != "0") {
							regPersonComp.phoneExists = true;
							$("#userPhone").attr("state", "1");
							$("#userPhone_error").addClass("error_msg_new")
									.text(c.resultMsg)
						} else {
							regPersonComp.phoneExists = false;
							$("#userPhone").attr("state", "0");
							$("#userPhone_error").removeClass("error_msg_new")
									.text("")
						}
					}
				}
			})
		}
		a.success = true;
		return a
	},
	regPassword : function() {
		var b = this.val(), a = {
			success : false,
			errorMsg : ""
		};
		if ($.trim(b).length == 0) {
			a.errorMsg = "密码不能为空!";
			return a
		}
		if (!/^((?=.*[a-zA-Z])(?=.*[\d])|(?=.*[a-zA-Z])(?=.*[\W])|(?=.*[\d])(?=.*[\W]))[a-zA-Z\d\W]{6,16}$/
				.test(b)) {
			a.errorMsg = "密码不符合规则!";
			return a
		}
		if ($.trim($("#repassword").val()).length > 0) {
			$("#repassword").trigger("blur")
		}
		a.success = true;
		return a
	},
	regRepassword : function() {
		var b = this.val(), a = {
			success : false,
			errorMsg : ""
		};
		if ($.trim(b).length == 0) {
			a.errorMsg = "确认密码不能为空!";
			return a
		}
		if (b != $("#password").val()) {
			a.errorMsg = "两次密码不一致!";
			return a
		}
		a.success = true;
		return a
	},
	regRealName : function() {
		var b = this.val(), a = {
			success : false,
			errorMsg : ""
		};
		if ($.trim(b).length > 0 && !/^[\u4e00-\u9fa5]{2,4}$/.test(b)) {
			a.errorMsg = "姓名必须为中文并且长度在2-4之间,请认真填写!";
			return a
		}
		a.success = true;
		return a
	},
	validImgCode : function() {
		var a = $.trim($("#verifyCode").val()).length > 0;
		$("#verifyCode_error").removeClass("error_msg_new").text("");
		if (!a) {
			$("#verifyCode_error").addClass("error_msg_new").text("请填写验证码!")
		}
		return a
	},
	validSMSCode : function() {
		var a = $.trim($("#smsCode").val()).length > 0;
		$("#smsCode_error").removeClass("error_msg_new").text("");
		if (!a) {
			$("#smsCode_error").addClass("error_msg_new").text("请填写短信验证码!")
		}
		return a
	},
	sendSMS : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		if ($("#smsBtn").attr("disabled") || !regPersonComp.delayFlag) {
			return
		}
		$("#userPhone").trigger("blur");
		if ($("#userPhone").attr("state") == "1") {
			return
		}
		if (regPersonComp.validImgCode()) {
			$("#smsBtn").attr("disabled", "true");
			$.ajax({
					type: "POST",
					url :  basePath + "/member/registerValidate.action",
					data : {
						reqType : "validMsg",
						phone : $("#userPhone").val(),
						verifyCode : $("#verifyCode").val()
					},
					success : function(e) {
						var a = $.parseJSON(e);
						$("#smsCode_success").removeClass("info_msg").text("");
						$("#smsCode_error").removeClass("error_msg_new").text("");
						if (a.resultCode == "0") {
							if (a.logicCode == "0") {
								$("#smsCode_success").addClass("info_msg").text(
										"验证码已发送，请查收短信!");
								$("#smsBtn_text").html("120秒后重新获取");
								setTimeout(regPersonComp.countDown, 1000)
							} else {
								if (a.logicCode == "-1" || a.logicCode == "-3") {
									$("#smsCode_error").addClass("error_msg_new")
											.text(a.resultMsg);
									$("#smsBtn").removeAttr("disabled")
								} else {
									if (a.logicCode == "-2") {
										$("#verifyCode_error").addClass(
												"error_msg_new").text(a.resultMsg);
										$("#smsBtn").removeAttr("disabled")
									} else {
										if (a.logicCode == "-4") {
											$("#smsCode_success").addClass(
													"info_msg").text(
													"120秒内只能获取一次验证码!");
											$("#smsBtn").removeAttr("disabled")
										} else {
											$("#smsCode_error").addClass(
													"error_msg_new")
													.text("短信发送失败!");
											$("#smsBtn").removeAttr("disabled")
										}
									}
								}
							}
						} else {
							$("#smsCode_error").addClass("error_msg_new").text(
									"短信发送失败!");
							$("#smsBtn").removeAttr("disabled")
						}
					}
				})
		}
	},
	countDown : function() {
		regPersonComp.delayTime--;
		$("#smsBtn_text").html(regPersonComp.delayTime + "秒后重新获取");
		if (regPersonComp.delayTime == 1) {
			regPersonComp.delayTime = 120;
			$("#smsBtn_text").html("获取短信验证码");
			$("#smsBtn").removeAttr("disabled");
			regPersonComp.delayFlag = true
		} else {
			regPersonComp.delayFlag = false;
			setTimeout(regPersonComp.countDown, 1000)
		}
	},
	runValid : function(a) {
		var b = true;
		for (var c = 0; c < a.length; c++) {
			$(a[c]).trigger("blur");
			if ($(a[c]).attr("state") == 1) {
				b = false
			}
		}
		return b
	},
	reg : function() {
		var location = (window.location+'').split('/');  
		var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
		
		$("#reg_error").text("");
		var a = false;
		a = regPersonComp.runValid([ "#userAcct", "#userPhone", "#password",
				"#repassword", "#realName" ]);
		a = a && regPersonComp.validImgCode() && regPersonComp.validSMSCode();
		if ($("#cityId").val() == "") {
			a = false;
			$("#area_error").addClass("error_msg_new").text("请选择常住地区!")
		}
		if (a) {
			if (!$("#readme").attr("checked")) {
				alert("请勾选注册协议!");
				return
			}
			$(".reg_btn").off("click").addClass("disable_btn").text("提交中，请稍后");
//			$
//					.syncReq({
//						data : $("#personRegForm").serialize(),
//						success : function(b) {
//							if (b.resultCode == "0") {
//								if (b.logicCode == "0") {
//									var c = "<form id='successForm' method='post' action='/registerSuccess.do'><input type='hidden' name='u' value='"
//											+ b.resultObj.u
//											+ "'/><input type='hidden' name='t' value='"
//											+ b.resultObj.t + "' /></form>";
//									$(document.body).append(c);
//									$("#successForm").submit()
//								} else {
//									$(".reg_btn")
//											.on("click", regPersonComp.reg)
//											.removeClass("disable_btn").text(
//													"立即注册");
//									$("#reg_error").text(b.resultMsg)
//								}
//							} else {
//								$(".reg_btn").on("click", regPersonComp.reg)
//										.removeClass("disable_btn")
//										.text("立即注册");
//								$("#reg_error").text("系统忙，请稍后再试!")
//							}
//						}
//					})
					
			$.ajax({
							type: "POST",
							url :  basePath + "/member/registSubmitAjax.action",
							data : $("#personRegForm").serialize(),
							success : function(e) {
								var b = $.parseJSON(e);
								if (b.resultCode == "0") {
									if (b.logicCode == "0") {
										layer.alert("恭喜您，注册成功，点确定跳转!",{	icon : 1},function() {
											window.location.href=b.url;	
										})
									} else {
										$(".reg_btn").on("click", regPersonComp.reg).removeClass("disable_btn").text("立即注册");
										$("#reg_error").text(b.resultMsg)
									}
								} else {
									$(".reg_btn").on("click", regPersonComp.reg).removeClass("disable_btn").text("立即注册");
									$("#reg_error").text("系统忙，请稍后再试!")
								}
							}
						})		
		}
	}
};