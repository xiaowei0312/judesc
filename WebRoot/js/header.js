$(function() {
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3];  

	/**
	 * 加载商品分类
	 */
	$.ajax({
		type : "POST",
		url : basePath + "/main/getUserAddressAjax",
		data : {
		},
		success : function(e) {
			var f = $.parseJSON(e);
			if (f.resultCode != '0') {
				layer.alert("Error Request!", {
					icon : 5
				});
				return;
			}
			if (f.logicCode != '0') {
				$('.curr_area').html('未知位置');
				return;
			}
			$('.curr_area').html(f.resultObj.city);
		}
	});
});