$(function(){
	itemComp.init()
});
var itemComp={
	minCount:1,
	maxCount:99,
	currCount:1,
	basePath:null,
	init:function(){
		this.basePath = basePath;
		this.bindEvent();
		$(".skuInfos:first").click()
	},
	bindEvent:function(){
		this.FocusImg();
		this.changeSKU();
		this.bindAddToCart();
		this.tabEvent()
	},
	addImg:function(b){
		var a=new Image();
		a.src=b;
		return a
	},
	FocusImg:function(){
		var h=$("#focusList").find("img");
		var b=1,k=h.length;
		var j=$("#bigPic").find("a:first");
		var o=$("#rbtn");
		var g=$("#lbtn");
		var m=$("#focusList").find("ul:first");
		j.append(this.addImg(h[0].src));
		var l=j.find("img:first");
		var c=$("#focusList").find("li");
		var n=66;
		c[0].className="on";
		function a(p){
			c[p].onclick=function(){
				e(p,"right")
			}
		}
		for(var f=0;f<k;f++){
			a(f)
		}
		g.on("click",function(){
			if(b==0){
				b=k-2
			}else{
				b=b-2
			}
			if(b<=-1){
				b=0
			}
			e(b,"right")
		});
		o.on("click",function(){
			if(b==0){
				return
			}
			e(b,"left")
		});
		function d(q){
			if(!q){
				q="left"
			}
			uleft=m.position().left;
			l.attr("src",h[b].src);
			for(var p=0;p<k;p++){
				c[p].className=""
			}
			if(b==0){
				m.css("left","0px")
			}
			if(b%3==0&&b!=0&&q=="left"){
				m.css("left",(k-b>=3?uleft-3*n:uleft-(k-b)*n)+"px")
			}
			if((c[b].offsetLeft+m.position().left)<0 && q=="right"){
				m.css("left",(b>=3?uleft+3*n:uleft+b*n)+"px")
			}
			c[b].className="on";
			if(b<k-1){
				b++
			}else{
				b=0
			}
		}
		function e(q,i){
			b=q;
			d(i)
		}
	},
	tabEvent:function(){
		$("#itemDetailTab li").on("click",itemComp.switchTab)
	},
	switchTab:function(){
		var a=$($(this).attr("rel"));
		$(this).addClass("current").siblings().removeClass("current");
		a.show().siblings().hide()
	},
	changeSKU:function(){
		$(".item").on("click",function(){
			$(this).addClass("selected").siblings().removeClass("selected");
			$("#jd-price").text("￥"+$(this).attr("data-price"));
			$("#jd-num").text($(this).attr("data-num"));
		}
	)},
	bindAddToCart:function(){
		$("#addToCart").on("click",function(){
			var a=$(".selected:first").attr("data-sku");
			$.ajax({
				type: "POST",
				url : itemComp.basePath + "/cart/opAjax",
				data:{
					flag:"add",
					sku:a,
					num:$("#buy-num").val()
				},
				success:function(e){
					var b = $.parseJSON(e);
					if(b.logicCode == '0'){
						layer.alert("加入购物车完成!")
						$('#cart_totalCount').html(b.resultObj);
					}else{
						layer.alert(b.resultMsg)
					}
				}
			})
		})
	},
	reduce:function(a){
		this.currCount=this.currCount<=this.minCount?this.minCount:this.currCount-1;
		$(a).val(this.currCount)
	},
	add:function(a){
		this.currCount=this.currCount>=this.maxCount?this.maxCount:this.currCount+1;
		$(a).val(this.currCount)
	},
	modify:function(c){
		var b=parseInt($(c).val(),10);
		return this.disabled?!1:""==$(c).val()?!1:isNaN(b)||b<this.minCount||b>this.maxCount?true:(this.currCount=b,!1)
	}
};