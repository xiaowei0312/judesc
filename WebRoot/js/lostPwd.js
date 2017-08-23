$(function(){
	RetrievePwdIndexComp.init();
	RetrievePwdResetComp.init();
})
var RetrievePwdIndexComp = {
	basePath : null,
	init: function(){
		this.basePath = basePath;
	},
	reImg : function() {
		var a = document.getElementById("verifyImg");
		a.src = this.basePath + "/imgVerifyCodeAjax?rnd=" + Math.random()
	},
	ret_UserAcct : function(a) {
		var c = $.trim(a.value);
		var b = /^0?(13|15|18|14|17)[0-9]{9}$/;
		var d = /^[a-zA-z]{1}[A-Za-z0-9_]{5,15}$/;
		if (c.length == 0) {
			$("#userAcct_error").text("请填写您的用户名/手机号");
			return
		} else {
			$("#userAcct_error").text("")
		}
		if (!d.test(c)) {
			if (!b.test(c)) {
				$("#userAcct_error").text("用户名/手机号填写不正确");
				return
			} else {
				$("#userAcct_error").text("")
			}
		} else {
			$("#userAcct_error").text("")
		}
	},
	ret_validateCode : function(a) {
		var b = $.trim(a.value);
		if (b.length == 0) {
			$("#verifyCode_error").text("请填入验证码")
		} else {
			$("#verifyCode_error").text("")
		}
	},
	ret_next_btn : function() {
		var a = $.trim($("#userAcct").val());
		var b = $.trim($("#verifyCode").val());
		if (a.length == 0) {
			$("#userAcct_error").text("请填写您的用户名/手机号");
			return
		} else {
			$("#userAcct_error").text("")
		}
		if (b.length == 0) {
			$("#verifyCode_error").text("请填入验证码");
			return
		} else {
			$("#verifyCode_error").text("")
		}
		$
				.ajax({
					type : "POST",
					url :  RetrievePwdIndexComp.basePath + "/member/lostPwdSubmitAjax",
					data : {
						phone : a,
						imgVerifyCode : b
					},
					success : function(e) {
						var c = $.parseJSON(e);
						if (c.resultCode == "0") {
							if (c.logicCode == "-1") {
								$("#userAcct_error").text(c.resultMsg);
								RetrievePwdIndexComp.reImg()
							} else if(c.logicCode == "-2") {
									$("#verifyCode_error").text(c.resultMsg)
							} else {
								var d = "<form id='successForm' method='post' action='" + RetrievePwdIndexComp.basePath + "/member/lostPwdSubmit'><input type='hidden' name='phone' value='"
										+ c.resultObj.phone + "'/></form>";
								$(document.body).append(d);
								$("#successForm").submit()
							}
						} else {
							alert("系统繁忙，稍后重试")
						}
					}
				})
	}
};
var RetrievePwdResetComp = {
	basePath : null,
	delayTime : 120,
	delayFlag : true,
	init : function(){
		this.basePath = basePath;
	},
	newPwd : function(a) {
		var c = $.trim(a.value);
		var d = $.trim($("#SecondPwd").val());
		if (d.length == 0) {
			if (c.length == 0) {
				$("#newPwd_error").text("新密码不能为空！！")
			} else {
				var b = /^((?=.*[a-zA-Z])(?=.*[\d])|(?=.*[a-zA-Z])(?=.*[\W])|(?=.*[\d])(?=.*[\W]))[a-zA-Z\d\W]{6,16}$/;
				if (!b.test(c)) {
					$("#newPwd_error").text("密码必须符合6-16个字符，需使用字母、数字或特殊符号组合")
				} else {
					$("#newPwd_error").text("")
				}
			}
		} else {
			if (c.length == 0) {
				$("#newPwd_error").text("新密码不能为空！！")
			} else {
				if (d != c) {
					$("#Second_error").text("两次密码不一致，请重新填写!")
				} else {
					var b = /^((?=.*[a-zA-Z])(?=.*[\d])|(?=.*[a-zA-Z])(?=.*[\W])|(?=.*[\d])(?=.*[\W]))[a-zA-Z\d\W]{6,16}$/;
					if (!b.test(c)) {
						$("#newPwd_error")
								.text("密码必须符合6-16个字符，需使用字母、数字或特殊符号组合")
					} else {
						$("#newPwd_error").text("")
					}
				}
			}
		}
	},
	SecondPwd : function(a) {
		var c = $.trim(a.value);
		var b = $.trim($("#newPwd").val());
		if (b.length == 0) {
			$("#newPwd_error").text("请输入新的密码！")
		} else {
			if (c.length == 0) {
				$("#Second_error").text("请再次输入新的密码！")
			} else {
				if (c == b) {
					$("#Second_error").text("")
				} else {
					$("#Second_error").text("两次密码不一致，请重新填写!")
				}
			}
		}
	},
	SMSValidate : function(a) {
		var b = $.trim(a.value).length > 0;
		$("#smsCode_error").text("");
		if (!b) {
			$("#smsCode_error").text("请填写短信验证码!")
		}
		return b
	},
	sendSMS : function() {
		var b = /^0?(13|15|18|14|17)[0-9]{9}$/;
		var a = $.trim($("#userAcct").val());
		if ($("#smsBtn").attr("disabled") || !RetrievePwdResetComp.delayFlag) {
			return
		}
		if (a.length == 0) {
			alert("账户名验证出错，跳入首页重新填写");
			window.location.href = this.basePath + "/member/lostPwd";
		} else {
			if (!b.test(a)) {
				alert("账户名验证出错，跳入首页重新填写");
				window.location.href = this.basePath + "/member/lostPwd";
			} else {
				$.ajax({
					type: "POST",
					url :  basePath + "/member/registerValidate.action",
					data : {
						reqType : "validMsg",
						lostPwdFlag : "1",
						phone : a,
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
								setTimeout(RetrievePwdResetComp.countDown, 1000)
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
		}
	},
	countDown : function() {
		RetrievePwdResetComp.delayTime--;
		$("#smsBtn").attr("disabled", "disabled");
		$("#smsBtn_text").html(RetrievePwdResetComp.delayTime + "秒后重新获取");
		if (RetrievePwdResetComp.delayTime == 1) {
			RetrievePwdResetComp.delayTime = 120;
			$("#smsBtn_text").html("获取短信验证码");
			$("#smsBtn").removeAttr("disabled");
			RetrievePwdResetComp.delayFlag = true
		} else {
			RetrievePwdResetComp.delayFlag = false;
			setTimeout(RetrievePwdResetComp.countDown, 1000)
		}
	},
	Sumbit : function() {
		var e = $.trim($("#newPwd").val());
		var d = $.trim($("#SecondPwd").val());
		var c = $.trim($("#smsCode").val());
		var b = /^0?(13|15|18|14|17)[0-9]{9}$/;
		var a = $.trim($("#userAcct").val());
		if (e.length == 0) {
			$("#newPwd_error").text("请输入新的密码！")
		} else {
			if (d.length == 0) {
				$("#Second_error").text("请再次输入新的密码！")
			} else {
				if (d != e) {
					$("#Second_error").text("两次密码不一致，请重新填写!")
				} else {
					if (c.length == 0) {
						$("#smsCode_error").text("请输入验证码！")
					} else {
						if (a.length == 0) {
							alert("账户名验证出错，跳入首页重新填写");
							window.location.href = this.basePath + "/member/lostPwd";
						} else {
							if (!b.test(a)) {
								alert("账户名验证出错，跳入首页重新填写");
								window.location.href = this.basePath + "/member/lostPwd";
							} else {
								$.ajax({
											type : "POST",
											url  : RetrievePwdResetComp.basePath + "/member/lostPwdSubmit1Ajax",
											data : {
												userPhone : a,
												newPwd : e,
												secondPwd : d,
												smsCode : c
											},
											success : function(e) {
												var f = $.parseJSON(e);
												if (f.resultCode == "0") {
													if (f.logicCode == "0") {
														window.location.href = RetrievePwdResetComp.basePath
																+ "/member/lostPwdSuccess"
													} else {
														if (f.logicCode == "-1") {
															alert(f.resultMsg);
															window.location.href = RetrievePwdResetComp.basePath + "/member/lostPwd";
														} else {
															if (f.logicCode == "-2") {
																$(
																		"#newPwd_error")
																		.text(
																				f.resultMsg)
															} else {
																if (f.logicCode == "-3") {
																	$(
																			"#Second_error")
																			.text(
																					f.resultMsg)
																} else {
																	if (f.logicCode == "-4") {
																		$(
																				"#Second_error")
																				.text(
																						f.resultMsg)
																	} else {
																		if (f.logicCode == "-5") {
																			$(
																					"#smsCode_success")
																					.addClass(
																							"info_msg")
																					.text(
																							"");
																			$(
																					"#smsCode_error")
																					.text(
																							f.resultMsg)
																		} else {
																			if (f.logicCode == "-6") {
																				$(
																						"#smsCode_success")
																						.addClass(
																								"info_msg")
																						.text(
																								"");
																				$(
																						"#smsCode_error")
																						.text(
																								f.resultMsg)
																			} else {
																				if (f.logicCode == "-7") {
																					alert(f.resultMsg)
																				} else {
																					alert("密码重置失败！")
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												} else {
													alert("系统忙，请稍后再试!")
												}
											}
										})
							}
						}
					}
				}
			}
		}
	}
};