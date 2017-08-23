$(function() {
	$("#dialog-form").dialog({
		autoOpen : false,
		height : 600,
		width : 800,
		modal : true,
		close : function() {
			allFields.val("").removeClass("ui-state-error");
		}
	});

	$("#create-add").button().click(function() {
		$("#dialog-form").dialog("open");
	});
	
	shopListComp.init();
});

var shopListComp = {
	submitFlag : null,
	basePath: null,
	init: function() {
		this.submitFlag = 1;
		this.basePath = basePath;
		this.bindEvent()
	},
	bindEvent: function() {
		$("#provinceId").on("change", this.loadEparchys);
		$("#eparchyId").on("change", this.loadCitys);
		$("#addNewAddrBtn").on("click",this.addNewAddr); 
		$("#submitOrderBtn").on("click",this.submitOrder); 
	},
	
	submitOrder : function(){
		var addrId = $('#addr:checked').val();
		$.ajax({
			type: "POST",
			url :  shopListComp.basePath + "/order/submitAjax/" + addrId,
			data : {
			},
			success : function(e) {
				var c = $.parseJSON(e);
				if (c.logicCode == '0') {
					window.location.href = c.url;
				} else if(c.logicCode == "1"){
					alert(c.resultMsg);
				} else{
					alert(c.resultMsg);
				}
			}
		});
	},
	addNewAddr : function(){
		var extra = $('#extra').val();
		var contacts = $('#contacts').val();
		var phone = $('#phone').val();
		
		if ($.trim(extra).length == 0) {
			alert("街道信息不能为空");
			return;
		}
		
		if ($.trim(contacts).length == 0) {
			alert("联系人不能为空!");
			return;
		}
		
		if ($.trim(phone).length == 0) {
			alert("手机号码不能为空!");
			return;
		}
		if (!/^0?(13|15|18|14|17)[0-9]{9}$/.test(phone)) {
			alert("请输入正确的手机号码!");
			return;
		}
		if ($("#cityId").val() == "") {
			alert("请选择常住地区!");
			return;
		}
		$.ajax({
			type: "POST",
			url :  shopListComp.basePath + "/order/add",
			data : {
				province: $("#provinceId").find("option:selected").text(),
				city: $("#eparchyId").find("option:selected").text(),
				area: $("#cityId").find("option:selected").text(),
				extra: extra,
				contacts: contacts,
				phone: phone,
			},
			success : function(e) {
				var c = $.parseJSON(e);
				if (c.logicCode == '0') {
					window.location.href = c.url;
				}
			}
		});
		
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
};
