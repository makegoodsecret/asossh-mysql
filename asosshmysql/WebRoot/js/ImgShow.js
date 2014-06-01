
;(function($){
 $.fn.extend({
  "SmohanScollImgShow":function(items){
	  items = $.extend({
		"scollbox":"#smohan_scroll", //横向滚动div
		"showImg":".show_image", //当前照片及信息显示div
		"btn_like":".btn_like", //按钮：还不错
		"btn_change":".btn_change", //按钮： 换一张
		"addfav":".addhot", //点击还不错，出现+1的层div
		"speed":200	//滚动速度
	  },items)
	  var showbox = $(items.showImg);
	  var speed = items.speed;
	  var btn_like = items.btn_like;
	  var btn_change = items.btn_change;
	  var addfav = items.addfav;
	  var smohan = $(this).get(0);
	  var prev =  $(items.scollbox).children(".prev");
	  var next =  $(items.scollbox).children(".next");
	  var mleft = parseInt($("ul li:first",this).css("margin-left"));
	  var mdistance = $("ul li:first",this).outerWidth()+mleft;
	  
	  /* Smohan_Movenext函数功能 ： 移动到下一项 */
	  function Smohan_Movenext(){
	   $("ul li:first",smohan).animate({"margin-left":-mdistance},speed,function(){
		 $(this).css("margin-left",mleft).appendTo($("ul",smohan));	
		});
	  }
	  next.click(function(){
		if(!$("ul li:first",smohan).is(":animated")){
		  Smohan_Movenext();	
		}	
	  });
	  prev.click(function(){
		  if(!$("ul li:first",smohan).is(":animated")){
		   $("ul li:last",smohan).prependTo($("ul",smohan));
		   $("ul li:first",smohan).css("margin-left",-mdistance).animate({"margin-left":mleft},speed);
		  }	
	  });
  
  //创建当前显示层
  var s_html = "";
	  s_html = '<div class="smh_show">';
	  s_html += '<div class="pics"></div>';
	  s_html += '<div class="text_info">';
	  s_html += '<div class="textfl"></div>';
	  s_html += '<div class="textfr" title="个人简介"></div>';
	  s_html += '</div>';
	  s_html += '</div>';
  showbox.prepend(s_html);
  
  /* Smohan_Show 函数功能：定义显示层当前显示内容*/
  function Smohan_Show(img){
	var src= img.attr("src");
	var alt = img.attr("alt");
	var id = img.attr("id");
	var name = img.attr("name");
	var nick = img.attr("title");;
	var date = img.attr("data-type");
	var title = (name=='umale') ? "男生" : "女生";
	$('.pics').html('<img src="'+src+'" id="'+id+'">');
	$('.textfl').html('<div class="text1">');
	$('.textfr').text(date);
  }
  //初始化
  var startImg = $("ul li:first img",this);
  Smohan_Show(startImg);
  $("ul li:first",this).addClass("checked").siblings("li").removeClass("checked");
  //点击单张图片进行切换
  $('ul li',smohan).each(function() {
	var li = $(this);
	var changeImg = li.children("img");
	changeImg.on("click",function(){
	 Smohan_Show(changeImg);
	 li.addClass("checked").siblings("li").removeClass("checked");
	});
 });
 /*Smohan_Shownext函数功能 ：查找选中项的下一项并赋值*/
 function Smohan_Shownext(){
   var now = $('ul li.checked',smohan).next();
   var nowImg = now.children("img");
   Smohan_Show(nowImg);
   Smohan_Movenext();
   now.addClass("checked").siblings("li").removeClass("checked");
 }

  //换一张
  $(btn_change).click(function(e) {
   if(!$("ul li:first",smohan).is(":animated")){
	  Smohan_Shownext();	
	}	
  });
 //还不错
  $(btn_like).click(function(e) {
   var id = $('.pics').find("img").attr("id");
   if(id != '' || id != null){
	  if(!$("ul li:first",smohan).is(":animated")){
		 $(addfav).slideDown(500).text("+1").hide(500);
	     Smohan_Shownext();
	    }
	}
   });
  }	
 });	
})(jQuery);