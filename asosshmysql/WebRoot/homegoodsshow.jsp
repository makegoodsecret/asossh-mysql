<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页美食展示</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<%-- 	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>  --%>
	<style type="text/css">
	 .homegoodbody{width:"950px";text-align:center;font-family:'georgia';font-size: 13px; 
	 				background-image: url("image/bg.jpg"); }
	a,img{border:0;}
	a{color:#FFCC00;}
	.thumbnailWrapperclear{clear:both;}
	.manhuaTip {width: 48px;height: 32px;line-height: 20px;text-align: center;background: #82ce18;
				font-size: 12px;font-weight: bold;cursor: pointer;color: #000 ;}
	#manhuabutton{width: 48px;height: 32px;line-height: 20px;text-align: center;background: #ECBB00;
				font-size: 12px;font-weight: bold;cursor: pointer;color: #000;}
	.thumbnailWrapper{ margin:0px auto 0 auto;border: 1px solid #c6cdd0; width:950px; height:350px; border-radius:10px 10px ;}
	.thumbnailWrapper ul{width:950px; height:350px; margin:0;padding:0;list-style-type:none}
	.thumbnailWrapper ul li{float:left; position:relative;overflow:hidden;border: 1px solid #c6cdd0;border-radius: 5px 5px;}
	.thumbnailWrapper ul li a img{width:188px;height:173px;  position:relative;border:none;}
	.caption{position:absolute;bottom:0px;left:0px;width:100%;display:none;background:#cfcdd0;color:#000000;opacity:0.8;}
	.caption .captionInside{padding:10px;margin:0px;}
	</style>
 <script type="text/javascript">
$(window).load(function(){
	//设置和获取一些变量
	var thumbnail = {
		imgIncrease : 35, /* 增加图像像素（变焦） */
		effectDuration : 400, /* 效果的持续时间（变焦和标题） */
		/* 获取的图像的宽度和高度。要使用这些 2件事: 列表项大小相同,得到的图像缩放后恢复正常*/
		imgWidth : $('.thumbnailWrapper ul li').find('img').width(), 
		imgHeight : $('.thumbnailWrapper ul li').find('img').height()
	};
	//列表项相同的大小作为图像
	$('.thumbnailWrapper ul li').css({ 
		'width' : thumbnail.imgWidth, 
		'height' : thumbnail.imgHeight 
	});
	//当鼠标移到列表项
	$('.thumbnailWrapper ul li').hover(function(){
		$(this).find('img').stop().animate({
			/* 变焦效果，提高图像的宽度 */
			width: parseInt(thumbnail.imgWidth) + thumbnail.imgIncrease+"px",
			/* 我们需要改变的左侧和顶部的位置，才能有放大效应，因此我们将它们移动到一个负占据一半的img增加 */
			left: thumbnail.imgIncrease/2*(-1),
			top: thumbnail.imgIncrease/2*(-1)
		},{ 
			"duration": thumbnail.effectDuration,
			"queue": false
		});
		//使用slideDown事件显示的标题
		$(this).find('.caption:not(:animated)').slideDown(thumbnail.effectDuration);
		//当鼠标离开...
	}, function(){
		//发现图像和动画...
		$(this).find('img').animate({
			/* 回原来的尺寸（缩小） */
			width: thumbnail.imgWidth,
			/* 左侧和顶部位置恢复正常 */
			left: 0,
			top: 0
		}, thumbnail.effectDuration);
		//隐藏使用滑块事件的标题
		$(this).find('.caption').slideUp(thumbnail.effectDuration);
	});
});
</script>


  </head>

<body class="homegoodbody">
    <div class='thumbnailWrapper'>
		<ul>
		<s:iterator value="goodsInfoPojoList" >
				<li>
				<a onclick="getpostfunction(this)" href="javascript:void(0);" data-href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}">
					<img src="<%=basePath %>photo/${goodsImagePojo.gimageImage }" alt="${goodsName }"/>
				</a>
				<div class='caption'>
				<strong style="font-size: 15px; ">${goodsName }</strong> <br>
				&yen;<font style="color: red;">${goodsPrice }</font> (1/份) 
	   			<div>
				<button type="button" style="margin-left: 20px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
				 onclick="addCart(${goodsId},1);"  id="addcartid${goodsId}"  >预订</button>
				 <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" 
 				target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
 				> 分享 </a>
				<button type="button" style="margin-left: 10px;" class="manhuabutton" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
				 onclick="userCol(${goodsId},1);">收藏</button>
	   			</div>
				</div>
			</li>
		</s:iterator>
		</ul>		
		<div class='thumbnailWrapperclear'></div><!-- clear the float -->		
	</div>
  </body>
</html>
