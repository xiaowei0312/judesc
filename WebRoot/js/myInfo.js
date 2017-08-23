var MyInfoComp = {
	btn_submit : function() {
		var c = $.trim($("#nike_name").val());
		var b = $.trim($("#qq").val());
		var d = $.trim($("#email").val());
		var a = $.trim($("#user_Id").val());
		$.syncReq({
			data : {
				reqUrl : "myInfo",
				nikeName : c,
				qq : b,
				email : d,
				user_id : a
			},
			success : function(e) {
				if (e.resultCode == "0") {
					if (e.logicCode == "1") {
						alert("保存成功！");
						window.location.reload()
					} else {
						alert("保存失败,请检查数据后重试！")
					}
				} else {
					alert("系统忙,请稍后！")
				}
			}
		})
	}
};