<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	 <base href="<%=basePath%>">
	<title><s:text name="website_name"></s:text> </title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	  <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> 
	<script type="text/javascript" src="<%=basePath%>json_address/jquery.cityselect.js"></script>
	
  <style type="text/css">
	body {
		margin: 0;
		padding: 0;
		font-size: 12px;
		font-family:'georgia', "Times New Roman","宋体"; color:#333;
	}
 	.go {width: 47px;height: 150px;position: fixed;_position: absolute;
	_top: expression(eval(document.documentElement.scrollTop + 
			 document.documentElement.clientHeight-this.offsetHeight- (  
		parseInt(this.currentStyle.marginTop, 10)||200 )-(parseInt(this.currentStyle.marginBottom, 10)||0
		) ) );left: 12px;bottom: 10%;
	background-image: url("/imagesforcode/201208/tobg.png");background-repeat: no-repeat;}
	.go a {background: url(<%=basePath%>image/topbottom.png) no-repeat;
		display: block;text-indent: 999em;width: 37px;margin: 5px;
		border: 0;overflow: hidden;float: left;cursor: pointer;}
	.go .top {background-position: 0 0px;height: 22px}
	.go .feedback {background-position: 0 -22px;height: 32px}
	.go .bottom {background-position: 0 -55px;height: 22px}
	.go .top:hover {background-position: -38px -0px}
	.go .feedback:hover {background-position: -38px -22px}
	.go .bottom:hover {background-position: -38px -55px}
	</style>  

  <script type="text/javascript">
	    $(function () {
		    $(".top").click(//定义返回顶部点击向上滚动的动画
			    function () {
			    $('html,body').animate({ scrollTop: 0 }, 700);
			    });
		    $(".bottom").click(//定义返回顶部点击向上滚动的动画
		    function () {
		   	 $('html,body').animate({ scrollTop: document.body.clientHeight }, 700);
		    });
	    });
	   function  homeload(){
	    mygoodsCartLoad();
	   }
	    	
    </script>
</head>
<body  onload="homeload()" background="<%=basePath %>image/bg.jpg">
  <jsp:include page="headfoot/head.jsp"></jsp:include> 
	<s:if test="#session.user.username!=''">
<!-- 我的菜谱 -->
 		  <jsp:include page="order/mygoodsCart.jsp"></jsp:include> 
	</s:if>
	<s:else>
<!-- 提示登录 -->
		<div class="mycarthidden" style="display: none;"><!-- 我的菜谱(默认为隐藏) -->
			<jsp:include page="order/mygoodsCart.jsp"></jsp:include> 
		</div>
		<jsp:include page="user/popupuserlogin.jsp"></jsp:include>
	</s:else>
<!-- 返回顶 -->
    <div class="go">
	    <a title="返回顶部" class="top"></a>
	    <a title="如果您有意见，请反馈给我们！" class="feedback" href="javascript:void(0)" target="_blank"></a>
	    <a title="返回底部" class="bottom" ></a>
    </div>
    
<div id="out">
<!-- 头 -->
	<table background="<%=basePath %>image/bg.jpg" align="center" cellpadding="0" cellspacing="0" width="90%" border="0">
		<tr>
		<td colspan="2"   height="50px">
<!-- 收索 -->
			   <jsp:include page="pulldrowinput.jsp"></jsp:include>  
		</td>
		</tr>
		<tr>
<!-- 首页美食图片展示 -->	
			<td  height="350px" width="950" >
 					<jsp:include page="homegoodsshow.jsp"></jsp:include>	  
			</td>
			<td width="250px" height="350px">
				 <div style="height:350px; width:250px;	 border: 1px solid #eee;border-radius:10px 10px ;font-size: 18px;">
				 	<div style="height: 20px; width: 100%;border: 1px solid #aa0000;border-radius:10px 10px ; text-align: center;">
				 	  	最近交易
				 	</div>
				 	<div style="height: 330px;">
				 		<marquee height="330px" width="100%" behavior="alternate" 
								 scrollamount="1"  scrolldelay="5"
								 direction="up" loop="-1" onmouseover="this.stop()" onmouseout="this.start()">
							<s:set name="goodsAssessListisempty">${goodsAssessList=='[]'||goodsAssessList=='{}' }</s:set>
							<s:if test="#goodsAssessListisempty">
								<div style=" height:60px; width:100%; margin-top:2px;  border: 1px solid #eee; border-radius:5px 5px 5px 5px; ">
									没有任何交易
								</div>
							</s:if>
							<s:else>
							<s:iterator value="goodsAssessList" id="entity" status="status">
								<div style=" height:60px; width:100%; margin-top:2px;  border: 1px solid #eee; border-radius:5px 5px 5px 5px; ">
		  	 		 				 <img  src="<%=basePath %>photo/${userPojo.userHeadPojo.headImage}"  
		  	 		 				 			style="height: 45px;width: 50px; float: left;">
		  	 		 				<div style="  text-align:left; font-family: 楷体; font-size: 15px;">
											<nobr>
											${hotelPojo.hotelName }
											${mealPojo.mealName }
											${goodsInfoPojo.goodsName }
											</nobr>
									</div>
									<div style=" clear:none;text-align:left; font-family: 仿宋;font-size: 14px;">
										 评价: ${assStars }星
										 <br>
									</div>
									<div style="clear:none;font-family: 仿宋;font-size: 12px; margin-bottom: 5px;">
										<s:set name="assIp">${assIp }</s:set>
										<b>${userPojo.username }</b>
										(来自
											<s:property value="@com.secret.action.StaticAction@useripaddress(#assIp)"/>
										 ) <br>
										评价时间:${assTime }
									</div>
				  	 		 	</div>
  						 	</s:iterator>
  						 	</s:else>
						 </marquee>
				 	</div>
				 	</div>
			</td>
		</tr>
	<!-- 百度地图 -->
		<tr>
			<td >   
				  <jsp:include page="homemap.jsp"></jsp:include>  
	 		</td>	
			<td height="300px" width="250px" >
			<!-- coffee云标签 -->
			 <style type="text/css">
			.coffee{ margin-bottom:-200px; width:250px; height:250px; background:url(image/coffee_soundbooth.png); position:relative;  }
			</style>
			<div id="coffee" class="coffee"></div>
			<script type="text/javascript" src="<%=basePath%>js/jquery.coffee.js"></script>
			<script type="text/javascript">
				$(function(){
					$('#coffee').coffee();
				});
			</script>
			</td>
		</tr>
		<tr>
			<td  colspan="2">
			  <marquee height="100px" width="90%" behavior="alternate" 
							 scrollamount="1"  scrolldelay="1"
							 direction="left" loop="-1" onmouseover="this.stop()" onmouseout="this.start()">
						<s:iterator value="adsList" id="entity" status="status">
						<div style= " float:left; border: 1px solid c6cdd0 ;border-radius:5px  5px;">
						   	  <a href="javascript:void(0)" title="广告">
  	  								<img alt="广告赞助图片已经损坏"  src="<%=basePath%>photo/${adsImage}" title="${adsDis}" style="border-radius:10px 10px  10px 10px;" width="200px" height="100px">
     						  </a>
     						</div>
 						</s:iterator>
			 </marquee>
			</td>
		</tr>
	</table>	
  <jsp:include page="headfoot/footer.jsp"></jsp:include>  
</div>  
</body>
</html>
