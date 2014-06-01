<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>闻道美食网-发布广告界面--</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>ads/css/ImgShow.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript">
	$(function(){
 $.fn.extend({
  "SmohanScollImgShow":function(items){
	  items = $.extend({
		"scollbox":"#smohan_scroll", //横向滚动div
		"showImg":".show_image", //当前照片及信息显示div
		"btn_like":".btn_like", //按钮：还不错
		"btn_change":".btn_change", //按钮： 换一张
		"addfav":".addhot", //点击还不错，出现+1的层div
		"speed":200	//滚动速度
	  },items);
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
	  s_html += '<div class="textfl"></div>';
	  s_html += '<div class="textfr" title="广告管理"></div>';
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
	var statu = img.attr("statu");
	
	if(statu=="0"){
		//发布
		$("#btnstatus").html('<a href="javascript:void(0)" class="btn" id="issue" ><font color="#002000" size="4px">发布</font></a>');
	}else{
		//下架
		$("#btnstatus").html('<a href="javascript:void(0)" class="btn" id="undercarriage" ><font color="#002000" size="4px">下线</font></a>');
	}
	
	$('.pics').html('<img src="'+src+'" id="'+id+'">');
	//$('.textfl').html('<div class="text1"><font style="font-size:20px;font-weight:600;">'+alt+'</font>岁</div><span class="text2 '+name+'" title="'+title+'">'+title+'</span><a href="javascript:void(0)" class="text3" title="与 '+nick+' 搭讪" target="_blank">搭讪</a>');
	$('.textfr').html('<div class="text1"><font style="font-size:20px;font-weight:600; color :#000000"> &nbsp;&nbsp;&nbsp;&nbsp;'+alt+'</font>');
	$("#issue").attr("href","asossh/ads!updatestatu.action?adsPojo.adsId="+id);
	$("#undercarriage").attr("href","asossh/ads!updatestatu.action?adsPojo.adsId="+id);
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
});
	</script>
	<script type="text/javascript">
//注意：img传值信息： src:图片地址，name:代表性别：umale | ufemail ，id：用户ID，title：用户姓名 alt:用户年龄，data-type：个人简介	
$(document).ready(function(e) {
    $(".scroll_image").SmohanScollImgShow({
	    "scollbox":"#smohan_scroll", //横向滚动div id或者class
		"showImg":".show_image", //当前照片及信息显示div id或者class
		"btn_like":".btn_like", //按钮：还不错 id或者class
		"btn_change":".btn_change", //按钮： 换一张 id或者class
		"addfav":".addhot", //点击还不错，出现+1的div层 id或者class
		"speed":200	//滚动速度
	});
});
</script>
</head>
<body  background="<%=basePath %>image/bg.jpg" >
  <jsp:include page="../headfoot/head.jsp"></jsp:include>  
<div class="box" style="background-image: <%=basePath %>image/bg.jpg" >
<div id="accosted">
 <div class="show_image"></div>
 <!--button-->
 <div class="options">
  <div class="addhot"></div>
  <div id="btnstatus"></div>
  <a href="javascript:void(0)" class="btn_change" >换一张</a>
 </div>
 <!--/button-->
 <!--滚动-->
 <div id="smohan_scroll">
 <a href="javascript:void(0)" class="prev" title="上一张">
 	<img alt="aa" src="<%=basePath%>image/imagesshow/orderleft.png">
 </a>
 <div class="scroll_image">
  <ul>
     <s:iterator value="adsList" id="entity" status="status">
    <li>	
		<img src="<%=basePath%>photo/${adsImage}" name="umale" id="${adsId}" title="${adsDis}" alt="${adsDis}" data-type="${adsDis}" statu="${adsStatu}">	
	 </li>
  </s:iterator>
   </ul>
 </div>
 <a href="javascript:void(0)" class="next" title="下一张">
 	<img alt="aa" src="<%=basePath%>image/imagesshow/orderreght.png" >
 </a>
  
 </div>
 <!--/滚动-->
</div>
</div> 
<%-- <jsp:include page="../headfoot/footer.jsp"></jsp:include> --%>
</body>
</html>
