var INDEX_PARAM = 1;
/*$(function() {
	banner("#banner1");
});*/

$(function() {
	var location = (window.location+'').split('/');  
	var basePath = location[0]+'//'+location[2]+'/'+location[3];  

	/**
	 * 加载商品分类
	 */
	$.ajax({
		type : "POST",
		url : basePath + "/main/onlineCommodityTypesAjax",
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
				layer.alert(f.resultMsg, {
					icon : 5
				});
				return;
			}
			
			$.each(f.resultObj,function(index,value,array){
				$('.cont').append(
						'<dd class="kinds">' + 
							'<h3 class="title">' + 
								'<a href="' + basePath + '/commodity/list/' + value.id + '">'+ value.typeName +'</a>' + 
							'</h3>' + 
						'</dd>'
				);
			});
			$('.cont').append('<dd class="adver">');
		}
	});
	
	/**
	 * 加载购物车中商品数量
	 */
	$.ajax({
		type : "POST",
		url : basePath + "/cart/cartsNumAjax",
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
				layer.alert(f.resultMsg, {
					icon : 5
				});
				return;
			}
			$('#cart_totalCount').html(f.resultObj);
		}
	});
});