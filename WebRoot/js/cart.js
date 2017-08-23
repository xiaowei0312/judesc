$(function() {
	cartComp.init()
});
var cartComp = {
	basePath : null,
	min : 1,
	max : 99,
	init : function() {
		this.basePath = basePath;
		$("#goPay").on("click", cartComp.submitOrder)
	},
	reduce : function(c) {
		var b = parseInt($("#num_" + c).val(), 10);
		if (b > cartComp.min) {
			$.ajax({
				type : "POST",
				url : cartComp.basePath + "/cart/opAjax",
				data : {
					flag : "sub",
					num : 1,
					sku : c,
				},
				success : function(e) {
					var a = $.parseJSON(e);
					if (a.logicCode == '0') {
						window.location.reload(true)
					} else if(a.logicCode == "-1"){
						$("#num_" + c).val(a.resultObj);
						layer.alert(a.resultMsg);
					} else{
						layer.alert(a.resultMsg);
					}
				}
			})
		} else {
			layer.alert("已达到最小购买数量!")
		}
	},
	add : function(c) {
		var b = parseInt($("#num_" + c).val(), 10);
		if (b < cartComp.max) {
			$.ajax({
				type : "POST",
				url : cartComp.basePath + "/cart/opAjax",
				data : {
					flag : "add",
					num : 1,
					sku : c,
				},
				success : function(e) {
					var a = $.parseJSON(e);
					if (a.logicCode == '0') {
						window.location.reload(true)
					} else if(a.logicCode == "-1"){
						$("#num_" + c).val(a.resultObj);
						layer.alert(a.resultMsg);
					} else{
						layer.alert(a.resultMsg);
					}
				}
			})
		} else {
			console.log(b + "  " + cartComp.max);
			layer.alert("已超出购买最大数量!")
		}
	},
	modify : function(d) {
		var c = parseInt($("#num_" + d).val(), 10);
		var b = "" == $("#num_" + d).val() ? !1 : isNaN(c) || c < cartComp.min
				|| c > cartComp.max ? !1 : true;
		if (b) {
			$.ajax({
				type : "POST",
				url : cartComp.basePath + "/cart/opAjax",
				data : {
					flag : "set",
					sku : d,
					num : c
				},
				success : function(e) {
					var a = $.parseJSON(e);
					if (a.logicCode == '0') {
						window.location.reload(true)
					} else if(a.logicCode == "-1"){
						$("#num_" + d).val(a.resultObj);
						layer.alert(a.resultMsg);
					} else{
						layer.alert(a.resultMsg);
					}
				}
			})
		} else {
			layer.alert("输入的数量不正确!")
		}
	},
	del : function(a) {
		layer.confirm("确定要删除本商品吗？", {
			btn : [ "确定", "取消" ],
		}, function() {
			$.ajax({
				type : "POST",
				url : cartComp.basePath + "/cart/opAjax",
				data : {
					flag : "delete",
					sku : a
				},
				success : function(e) {
					var b = $.parseJSON(e);
					if (b.logicCode == '0') {
						window.location.reload(true)
					}
				}
			})
		}, function() {
		})
	},
	submitOrder : function() {
		$("#goPay").off("click").text("正在提交...");
		$.ajax({
			type : "POST",
			url : cartComp.basePath + "/cart/confirmAjax",
			data : {
				flag : "confirm",
			},
			success : function(e) {
				var a = $.parseJSON(e);
				if (a.logicCode == '0') {
					window.location.href = a.url;
				} else if (a.logicCode == '-1') {
					alert(a.resultMsg);
					window.location.href = a.url;
				} else {
					alert(a.resultMsg);
					$("#goPay").text("去结算").on("click", cartComp.submitOrder);
					//layer.alert("系统忙，请稍后再试!")
				}
			}
		})
	}
};