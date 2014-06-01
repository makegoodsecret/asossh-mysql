<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>${hotelPojo.hotelName }</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	 <link rel="stylesheet" type="text/css" href="<%=basePath%>css/messageShow.css">
	<script type="text/javascript" src="<%=basePath%>js/makisu.min.js"></script>  
	 
<style type="text/css">
	body{ margin: 0; padding: 0; text-align:center;font-family:'georgia';font-size: 13px;  opacity:0.8;}
  .button{ background:#dd0000 ;  width:100%; height:30px; border:0px;  cursor:pointer;  margin-top:3px;
  		 border-radius:10px 10px 10px 10px;  font-family:'georgia'; font-size: 20px; }
  .button:HOVER{
  	background: #ff0000;
  }	 
  .buttonhover{ background:#ECBB00;  width:100%; height:30px; border:0px;  cursor:pointer;  margin-top:3px;
  		 border-radius:10px 10px 10px 10px;  font-family:'georgia'; font-size: 20px; }
   .buttonhover:HOVER{
   		background: #ff0000;
  	}	 
 pre{ display:block; font:100% "Courier New", Courier, monospace;
	padding:10px; border:1px solid #bae2f0; background:#e3f4f9;	 margin:.5em 0; overflow:auto; width:800px;}
#screenshot{ position:absolute; border:1px solid #ccc; background:#333; padding:5px; display:none; color:#fff;
	}
.screenshotaclass{
	font-family:'georgia';font-size:15px; color:#22F; border: 1px solid #555; border-radius:5px 5px 5px 5px; 
}
.screenshotaclass:hover{
	font-family:'georgia';font-size:15px; color:#22F; border: 1px solid #EE0000; border-radius:5px 5px 5px 5px; 
}
 .mealhotelclass{ text-align: left; width:24.5%;height: 200px; float:left ; border: 1px solid #FFE5D8; border-radius:10px 10px 10px 10px; 
 }
  .mealhotelclass:hover{ text-align: left; width:24.5%;height: 200px; float:left ;border: 1px solid #EE0000; border-radius:10px 10px 10px 10px; 
 }
</style>


<script type="text/javascript">
//鼠标移过形式图片
this.screenshotPreview = function(){	
		xOffset = 240;
		yOffset = -150;
	$("a.screenshot").hover(function(e){
		this.t = this.title;
		this.title = "";	
		var c = (this.t != "") ? "<br/>" + this.t : "";
		$("body").append("<p id='screenshot'><img src='"+ this.rel +"' alt='url preview' width='300px' height='200px' />"+ c +"</p>");								 
		$("#screenshot").css("top",(e.pageY - xOffset) + "px")
						.css("left",(e.pageX + yOffset) + "px")
						.fadeIn("fast") ;						
   		 },
	function(){
		this.title = this.t;	
		$("#screenshot").remove();
   	 });	
	$("a.screenshot").mousemove(function(e){
		$("#screenshot").css("top",(e.pageY - xOffset) + "px") 
						.css("left",(e.pageX + yOffset) + "px");
	});			
};
$(document).ready(function(){
	screenshotPreview();
	hotelAdminIsLogin();
});
function hotelAdminIsLogin(){
   $.ajax({
   	   url:"<%=basePath %>asossh/hotel!ajaxishoteladmin.action",
      type:"post",
      data:{"userPojo.userId":"${hotelPojo.userPojo.userId }"},
      success:function(data, type){
          if (data  == 1) {
		   var  hotelAdminUserName = "${hotelPojo.userPojo.username }";
			$("#hoteladminaid").attr("title","餐厅管理员${hotelPojo.userPojo.username }上线,点击与他聊天");
			$("#hoteladminaid").attr("src","<%=basePath %>image/hotelUserInfoUp.gif");
		}
      }
   });
}

</script>
<script>
if ($.fn.makisu.enabled) {
	var $nigiri = $('.nigiri');
	$nigiri.makisu({
		selector: 'dd',
		overlap: 0.85,
		speed: 1.7
	});
	$('.list').makisu('open');
	$('.toggle').on('click', function () {
		$('.list').makisu('toggle');
	});
   entDefault();
} else {
	$('.warning').show();
}

/* 点击按钮查看*/
	function showgoodsormeal(mealorgoodsname,buttonId){
		window.location.href="<%=basePath %>asossh/hotel!useroptionhotel.action?mealorgoodsname="
							+mealorgoodsname+"&hotelPojo.hotelId="
							+"${hotelPojo.hotelId}"+"&buttonId="+buttonId;
	}
	function hotelmainload(){
		  mygoodsCartLoad();//注入我 的侧边购物车
		  var buttonId="<s:property value='buttonId'/>";
		 $("#button"+buttonId).attr("class","buttonhover");
	}
	
</script>
 
  </head>
  
  <body  background="<%=basePath %>image/bg.jpg" onload="hotelmainload()">
   	<jsp:include page="../headfoot/head.jsp"></jsp:include>
   	<!-- 我的菜谱 -->
	<s:if test="#session.user.username!=''">
 		 <jsp:include page="../order/mygoodsCart.jsp"></jsp:include>   
	</s:if>
		<s:else>
<!-- 提示登录 -->
		<div class="mycarthidden" style="display: none;"><!-- 我的菜谱(默认为隐藏) -->
			<jsp:include page="../order/mygoodsCart.jsp"></jsp:include> 
		</div>
		<jsp:include page="../user/popupuserlogin.jsp"></jsp:include>
	</s:else>
   	<!-- 进入首页 -->
   	<s:set name="showhotelmainname"> <s:property value="@com.secret.action.StaticAction@inhotelmain"/> </s:set>
   	<!-- 饭店套餐按钮的操作状态 -->
	<s:set name="showmealname"><s:property value="@com.secret.action.StaticAction@inhotelmeal"/> </s:set>
	 <!-- 显示美食 -->
	 <s:set name="showinhotelgoods"> <s:property value="@com.secret.action.StaticAction@inhotelgoods"/> </s:set>
   	<!-- 显示饭店查询 -->
   	 <s:set name="showinhotelseek"> <s:property value="@com.secret.action.StaticAction@inhotelseek"/> </s:set>
   <div style="margin:auto;text-align:center; margin-left: 5%;margin-top:  1px; margin-right: 5%;   ">
			<div class="left_hotel" style="width:20% ; float:left; height: 800px;  " >
				<div style="width:100% ;  height: 35px;  ">
					<form  action="<%=basePath %>asossh/hotel!selectgoodsormeals.action" method="post" >
						<input type="text" name="hotelmealorgoodsnameseek" style="height: 100%; border: 1px ridge #dcf;  padding-left:10px;	padding-top:5px; padding-bottom:5px;
							border-radius: 10px 10px 10px 10px; "size= "20%"; placeholder="查询套餐、美食、饭店" >
						<button type="submit" style="padding: 5px 5px;">查询</button>
						<input type="hidden" name="hotelPojo.hotelId" value="${hotelPojo.hotelId }">
					</form>
				</div>
				<div class="left_hotel_top_top" style="width:100% ; height: 20px; border: 1px ridge #dcf; 
						border-radius: 10px 10px 10px 10px; margin: 0px 0px; text-align: center;" >
					<span style="font-family:微软雅黑;font-size: 15px; text-align: center;">本店特色菜</span>
				</div>
				<div class="left_hotel_top_centre"  style="width:100% ; height: 120px; border: 1px ridge #dcf; 
				border-radius: 30px 30px 30px 30px; margin: 0px 0px;text-align: center;"   >
		<!-- 滚动显示 -->
					<marquee  behavior="scroll" direction="up" loop="-1" scrollamount="8" scrolldelay="500"
					height="100%" width="100%" onmouseover="this.stop()" onmouseout="this.start()">
						<div style="border-radius: 10px 10px 0px 0px;text-align: center;"> 推荐美食开发找哦</div>
						<div style="border-radius: 10px 10px 0px 0px;text-align: center;"> 请等待</div>
						<div style="border-radius: 10px 10px 0px 0px;text-align: center;"> ……</div>
					</marquee>
				</div>
				<div  class="left_hotel_main">
						<div style="width: 100%; height: 30px; margin-top:1px; border: 1px ridge #dce; 
							border-radius:10px 10px 0px 0px;
							font-family: georgia; font-size: 25px; text-align: center;">
							菜品分类
						</div>
					<!-- 操作按钮区 -->	
						<div style="border: 1px ridge #dce; width: 100%; border-radius:0px 0px 10px 10px;  ">
							<!-- 饭店套餐按钮的操作状态 -->
								<s:set name="mealPojoname">${hotelPojo.mealPojo!='[]'||hotelPojo.mealPojo!='{}'}</s:set>
								<s:if test="#mealPojoname">  <!-- 判断套餐是否为空-->
									<button type="button" class="button" id="button0" onclick="showgoodsormeal('${showmealname}','0');" >套餐系列</button>
								</s:if>
						  <s:iterator value="sortList" id="entity" status="status">
								<button type="button" class="button" id="button${status.count }" onclick="showgoodsormeal('${sortName }','${status.count }');"  >${sortName }</button>
						  </s:iterator>  
						</div>
				</div>
			</div>
	<!-- 主体显示区 -->
		  	 <div class="centre_hotel_main" style="width:80% ;float: left;border-radius: 10px 10px 0px 0px;">
		  	 	<div class="centre_hotel_main_top" style="width: 100% ;height: 200px;" >
		  	 		<div style="width: 650px;float:left; height: 100% ;border: 1px ridge #dce;
		  	 				background-image:url('<%=basePath %>image/bghotel2.jpg');">
		  	 				<div style="width: 400px;float:left; height: 100%;">
			  	 				<div style="text-align: left;margin-top: 18px;margin-left: 10px;">
			  	 					<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }">
			  	 						<strong><font face="georgia" size="5"><s:property value="hotelPojo.hotelName"/> </font></strong>
			  	 					</a>
			   						 <button type="button" style="width: 50px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." 
			   						 id="colmanhuabutton"  onclick="userCol(<s:property value="hotelPojo.hotelId"/>,2);">
			   						 <font face="楷体">收藏</font> </button>
								 <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }" 
							    	target="_blank" style="color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 3px 3px ; "
							    	>二维码分享饭店</a>
							   	  <a  href="<%=basePath %>asossh/chat!gotoCallHotel.action?hotelPojo.userPojo.userId=${hotelPojo.userPojo.userId }&hotelPojo.hotelName=${hotelPojo.hotelName }&hotelPojo.userPojo.username=${hotelPojo.userPojo.username }" title="与他聊天">
							      <img alt="${hotelPojo.userPojo.username }" id="hoteladminaid"
							      		src="<%=basePath %>image/hotelUserInfoDrown.gif"
							      		title="餐厅管理员${hotelPojo.userPojo.username }未上线,点击与他聊天"
							      	 style="width:40px;height: 40px; margin-left:5px; position: absolute;border-radius:20px 20px; border: 0px solid #ffffff;">
			  	 				</a>  
			  	 				</div>
		   						<div style="text-align: left;margin-top: 10px;margin-left: 10px;">
		   						 <strong><font face="楷体" size="4">饭店简介:</font></strong>
		   						 <font face="微软雅黑" size="3"> <s:property value="hotelPojo.hotelAds"/> </font>
		   						</div>
		   						 <div style="text-align: left;margin-top: 10px;margin-left: 10px;">
			   						<strong><font face="georgia" size="4"> 营业时间: </font></strong><br>
									<font face="georgia" size="2">
										<span style="margin-left: 30px; ">
											上午：${hotelPojo.hotelShopAmStart }-${hotelPojo.hotelShopAmEnd }
											 下午:${hotelPojo.hotelShopPmStart }-${hotelPojo.hotelShopPmEnd }
										 </span>
									</font>
		   						 </div  >
		   						 <div style="text-align: left;margin-top: 5px;margin-left: 10px;">
									<font face="georgia" size="2" >
		   							<strong><font face="georgia" size="4">地址：</font></strong>${hotelPojo.hotelProvince}${hotelPojo.hotelCity}${hotelPojo.hotelCounty}${hotelPojo.hotelOtherAddress}
		   							</font>
		   						 </div>
		  	 				</div>
		  	 		<!-- 公告板右侧 -->
		  	 				<div style="width:250px;float:left; height: 100%; ">
		  	 					<div style="width:100%; margin-top: 50px; text-align: left; font-family: georgia; ">
		  	 					 	<strong><font  style="font-family: 楷体 ; font-size: 20px;color: red;">饭店公告</font></strong>
		  	 					 	<span  style="margin-left: 30px;">
		  	 					 		<s:if test="hotelPojo.hotelStatus==0">
			  	 					 		<font style=" font-family: 楷体;font-size: 15px;border: 1px solid #aa0000; color:red; border-radius:5px 5px 5px 5px; ">停业中</font>
		  	 					 		</s:if>
		  	 					 		<!-- 计算饭店是否是营业时间 -->
		  	 					 		<s:set name="hotelShopAmStart">${hotelPojo.hotelShopAmStart}</s:set>
		  	 					 		<s:set name="hotelShopAmEnd">${hotelPojo.hotelShopAmEnd}</s:set>
		  	 					 		<s:set name="hotelShopPmStart">${hotelPojo.hotelShopPmStart}</s:set>
		  	 					 		<s:set name="hotelShopPmEnd">${hotelPojo.hotelShopPmEnd}</s:set>
		  	 					 		<s:set name="hoteltimestatus" value="@com.secret.action.StaticAction@compareDate(#hotelShopAmStart,#hotelShopAmEnd,#hotelShopPmStart,#hotelShopPmEnd)"/>
		  	 					 		<s:elseif test="#hoteltimestatus==true" >
		  	 					 			 <font style="  font-family: 楷体;font-size: 15px; border: 1px solid #aa0000; border-radius:5px 5px 5px 5px; color:#bb0000; ">营业中</font>
		  	 					 		</s:elseif>
		  	 					 		 <s:else>
		  	 					 		 	 <font style="font-family: 楷体;font-size: 15px; border: 1px solid #aa0000; border-radius:5px 5px 5px 5px; ">休息中</font>	
		  	 					 		 </s:else>
		  	 					 	</span>
		  	 					</div>
		  	 					<div style="width: 100%; margin-top: 10px; text-align: left;">
		  	 						<font  style="font-family: 楷体 ; font-size: 15px;">饭店等级:</font>
		  	 						<s:if test="hotelPojo.hotelLevel<0.2">
		  	 								一星级<em>(极差)</em>
		  	 						</s:if>
		  	 						<s:if test="hotelPojo.hotelLevel<0.3">
		  	 								二星级<em>(太差了 )</em>
		  	 						</s:if>
		  	 						<s:elseif test="hotelPojo.hotelLevel<0.6">
		  	 								三星级<em>(一般般 )</em>
		  	 						</s:elseif>
		  	 						<s:elseif test="hotelPojo.hotelLevel<0.8">
		  	 								四星级<em>(真棒)</em>
		  	 						</s:elseif>
		  	 						<s:else>
		  	 								五星级<em>(简直就是山珍海味)</em>
		  	 						</s:else>
		  	 					</div>
		  	 					<div style="width:100%; margin-top: 10px; text-align: left;">
		  	 						<font  style="font-family: 楷体 ; font-size: 15px;">
		  	 						饭店收藏人气:
		  	 						<s:set name="goodsAssessListname">${goodsAssessList=='[]'||goodsAssessList=='{}' }</s:set>
		  	 						<s:if test="#goodsAssessListname">
		  	 						   <font style="font-family:georgia;">0</font> 
		  	 						</s:if>
		  	 						<s:else>
		  	 							<s:property value="goodsAssessList.size()"/>
		  	 						</s:else>
		  	 						人</font>
		  	 					</div>
		  	 					<div style="width:100%; margin-top: 10px; text-align: left;">
		  	 						<font  style="font-family: 楷体 ; font-size: 15px;">
		  	 							饭店始于:<font style="font-size: 10px; font-family: georgia;">
		  	 							<s:date name="hotelPojo.hotelTime" format="yyyy年MM月dd日"/>
		  	 							 </font>
		  	 						</font>
		  	 					</div>
		  	 				</div>
		  	 		</div >
		  	 		<div style=" width:310px; float:left;left:-1px; height: 100%; border: 1px ridge #dce; border-radius:0px 10px 0px 0px;">
		  	 		 		<div style="width: 100%; height: 30px;border: 1px solid #aa0000; border-radius:10px 10px 10px 10px;">
		  	 		 			<strong><font style="font-family: 楷体; font-size: 20px; ">最新评价</font> </strong>
		  	 		 		</div>
		  	 		 		<!-- 判断评价是否为空 -->
	  	 		 			<s:set name="goodsAssessListisemptyname">${goodsAssessList=='[]' }</s:set>
		  	 		 			<s:if test="#goodsAssessListisemptyname">
		  	 		 				<div style="width: 100% ; height: 30px;" >
			  	 		 			  	<font style="font-family: georgia; font-size: 20px;">还没有任何评价</font>
			  	 		 			</div>
		  	 		 			</s:if>
		  	 		 			<s:else>
			  	 		 			<marquee   height="80%"  width="100%" behavior="scroll"  direction="down" loop="-1" 
											scrollamount="8" scrolldelay="500"  onmouseover="this.stop()" onmouseout="this.start()" >
					  	 		 		<s:iterator value="goodsAssessList" >
				  	 		 				<div style=" height:50px; width:100%; margin-top:10px;  border: 1px solid #FFF606; border-radius:5px 5px 5px 5px; ">
					  	 		 				<div style="width: 50px; height:50px; float: left;">
					  	 		 					<img alt="" src="<%=basePath %>photo/${userPojo.userHeadPojo.headImage}" width="50px;" height="45px;" style="border: 1px solid #FFc606; border-radius:5px 5px 5px 5px; ">
					  	 		 				</div>
				 	  	 		 				<div style="text-align:left; margin-left:5px; width: 200px; height:50px; float: left; left: 0px;">
					  	 		 					<div style="height: 26px;">
					  	 		 						对
					  	 		 						<s:if test="showhotelmainname==#mealorgoodsname">
					  	 		 							${hotelPojo.hotelName }
					  	 		 						</s:if>
					  	 		 						<s:if test="showmealname==#mealorgoodsname">
					  	 		 							${mealPojo.mealName }
					  	 		 						</s:if>					  	 		 						
					  	 		 						<s:if test="showinhotelgoods==#mealorgoodsname">
					  	 		 							${goodsInfoPojo.goodsName }
					  	 		 						</s:if>					  	 		 						
					  	 		 						的评价: <br>
					  	 		 						<font style="font-family: georgia;font-size: 11px;">${assDis }</font> 
					  	 		 					</div>
					  	 		 					<div style=" height: 13px; font-family: georgia;font-size: 9px;">
					  	 		 						<s:set name="assIp">${assIp }</s:set>
					  	 		 						<b>${userPojo.username }</b>
					  	 		 						(来自
						  	 		 						<s:property value="@com.secret.action.StaticAction@useripaddress(#assIp)"/>
					  	 		 						 )
					  	 		 					</div>
					  	 		 					<div style="height: 13px; font-family: georgia;font-size: 8px;">
					  	 		 						评价时间:${assTime }
					  	 		 					</div>
					  	 		 				</div>
				  	 		 				</div>
					  	 		 		</s:iterator>
					  	 		 	</marquee>
		  	 		 			</s:else>
		  	 		 		 
		  	 		 		
		  	 		 		
		  	 		</div>
		  	 	</div>
		  	 	<div class="centre_hotel_main_centre">
					<!-- 套餐系列  -->
		  			<s:if test="mealorgoodsname==#showmealname">
		  			<!-- 判读集合是否为空 -->
		  				<s:set name="isemptymeal">${hotelPojo.mealPojo=='[]' }</s:set>
		  	 	  		<s:if test="#isemptymeal">
		  	 	  			<div class="mealhotelclass">
		  	 	  					<strong><font style="font-family: georgia;font-size: 30px;">该店铺套餐没有任何东西</font> </strong>
		  	 	  			</div>
		  	 	  		</s:if>
		  	 	  		<s:else>
		  	 	 	 	<s:iterator value="hotelPojo.mealPojo" status="mealPojostatus" >
		  	 	  			<div class="mealhotelclass" >
		  	 			 	 <div style="height:25px; margin-left:10px; margin-top:10px; font-size: 15px;">
			  	 			 	<label style=" font-family: georgia ;font-size: 20px; ">套餐名:</label> 
			  	 			 	${mealName }
		  	 			 	 </div>
		  	 			 	 <div style="height:120px ;border: 1px solid #F0F6F6; border-radius:10px 10px 10px 10px;">
		  	 			 	 		<div style=" height:20px ;margin-top:10px;">
		  	 			 	 			<label style=" font-family: georgia ; font-size: 18px; ">套餐包含:</label>
		  	 			 	 		</div> 
					  	 			 <div style="height:55px ; margin-top: 10px;">
						  	 			 <s:iterator  value="goodsInfoPojo"  status="status">
							  	 			 <span style="padding: 2px 2px; margin-left: 40px; margin-top: 10px;">
							  	 			 	 <a class="screenshot" rel="<%=basePath %>photo/${goodsImagePojo.gimageImage }" 
							  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" >
													<font class="screenshotaclass"  >
														${goodsName }
													</font> 
												</a>
							  	 			 </span>
						  	 			 </s:iterator>
					  	 			 </div>
					  	 			 <div style="height:35px ;">
					  	 			 	<label style=" font-family: georgia ;font-size: 20px;  ">套餐售价:&nbsp;&yen;</label>
					  	 			   <font style=" font-family:georgia;font-size: 21px; color: red;">${mealPrice }</font> 
					  	 			   <em>(1/份)</em>
					  	 			 </div>
		  	 			 	 </div>
		  	 			 	 <div style="height:30px; margin-top:10px; border: 1px solid #F0F0F0; border-radius:10px 10px 10px 10px;">
			  	 			 	 	<button type="button" style="margin-left: 30px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
					   				 onclick="addCart(${mealId},0);">预订</button>
					   				<a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?mealorgoodsname=inhotelmeal&&hotelPojo.hotelId=${hotelPojo.hotelId }" 
							    	target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
							    	> 分享 </a>
					   				<button type="button" style="margin-left: 10px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
									 onclick="userCol(${mealId},0);">收藏</button>
							 </div>
		  	 			 </div>
				  </s:iterator>  
		  	 	  </s:else>
		  	 	</s:if>
		  	 	<!-- 其他的按钮操作 -->
		  	 	<!-- 判读集合是否为空 -->
		  		<s:set name="isemptygoodsInfoPojo">${hotelPojo.goodsInfoPojo=='[]' }</s:set>
		  		 <s:if test="#isemptygoodsInfoPojo">
	  	 	  			<div style="width: 100%;  width: 300px; border: 1px solid #bb0000; border-radius:10px 10px 10px 10px; ">
	  	 	  					<strong><font style="font-family: georgia;font-size: 30px;">该店铺没有任何美食</font> </strong>
	  	 	  			</div>
		  	 	 </s:if>
		  	 	 <s:else>
			  	 	<s:iterator value="sortList" status="sortListstatus" >
			  	 			 <s:if test="mealorgoodsname==sortName">
				  	 			 <!-- 判断该美食分类下美食是否为空 --> 
				  	 			 <s:set name="isemptysortPojogoodsInfoPojo">${goodsInfoPojos=='[]'||goodsInfoPojos=='{}' }</s:set>
				  	 			 <s:if test="#isemptysortPojogoodsInfoPojo">
				  	 	  			<div class="width: 100%;  width: 300px; border: 1px solid #bb0000; border-radius:10px 10px 10px 10px;">
				  	 	  					<strong>
					  	 	  					<font style="font-family: georgia;font-size: 30px;">
					  	 	  						${sortName }没有任何美食
					  	 	  					</font> 
				  	 	  					</strong>
				  	 	  			</div>
			  	 	  		</s:if>
		  	 	  			<s:else>
		  	 	  			<s:iterator value="goodsInfoPojos" >
		  	 	  				<div class="mealhotelclass" >
		  	 	  						 <div style="padding: 2px 2px; margin-left: 5px; margin-right: 5px; ">
						  	 			 	 	<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}">
						  	 			 	 	<img alt="${goodsName }" style="order: 1px solid #bb0000; border-radius:10px 10px 10px 10px;" 
						  	 			 	 	src="<%=basePath %>photo/${goodsImagePojo.gimageImage }" width="100%;" height="120px"></a>
												<font  style="font-family: georgia; font-size: 20px;"   >
													${goodsName }
												</font> 
												<label style=" font-family: georgia ;font-size: 20px;  ">&yen;</label>
				  	 			   				<font style=" font-family:'georgia';font-size: 21px; color: red;">${goodsPrice }</font> 
				  	 			   				<em>(1/份)</em>
						  	 			 </div>
						  	 			  <div style="height:30px; margin-top:10px; border: 1px solid #F0F0F0; border-radius:10px 10px 10px 10px;">
					  	 			 	 	<button type="button" style="margin-left: 30px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
							   				 onclick="addCart(${goodsId},1);">预订</button>
							   				 <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" 
							    				target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
							    			> 分享 </a>
							   				<button type="button" style="margin-left: 10px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
											 onclick="userCol(${goodsId},1);">收藏</button>
										 </div>
		  	 	  				</div>
		  	 	  			</s:iterator>
		  	 	  			</s:else>
		  	 			 </s:if>
			  	 	</s:iterator> 
		  	 	 </s:else>
		  	 	 <!-- 进入首页 -->
		  	 	 <s:if test="mealorgoodsname==#showhotelmainname">
		  	 	 	 <div style=" clear:both; border: 1px solid #ab0000; margin-top:10px; border-radius:10px 10px 10px 10px ;width: 100%; height: 500xp; ">
		  	 	 	 	<div style="float: left; width: 50%; ">
		  	 	 	 		<div style="width:100%;border: 1px solid #fbe000;border-radius:10px 10px 10px 10px ; ">
		  	 	 	 			<strong ><font style="font-family: georgia;font-size: 20px;">饭店logo</font></strong>
		  	 	 	 		</div>
		  	 	 	 		<div style="width:100%; border: 1px solid #eee000;border-radius:10px 10px 10px 10px ; ">
		  	 	 	 			<img alt="" src="<%=basePath %>photo/${hotelPojo.hotelLogo }" width="100%" height="100%" >
		  	 	 	 		</div>
		  	 	 	 	</div>
		  	 	 	 	<div style="float: left; width: 50%; ">
		  	 	 	 		<div style="width:100%;border: 1px solid #fbe000;border-radius:10px 10px 10px 10px ; ">
		  	 	 	 			<strong ><font style="font-family: georgia;font-size: 20px;">饭店证书</font></strong>
		  	 	 	 		</div>
		  	 	 	 		<div style="width:100%; border: 1px solid #eee000;border-radius:10px 10px 10px 10px ; ">
		  	 	 	 			<img alt="" src="<%=basePath %>photo/${hotelPojo.hotelCertificate }" width="100%" height="100%" >
		  	 	 	 		</div>
		  	 	 	 	</div>
		  	 	 	 </div>
		  	 	 </s:if>
		  	 	 <!-- 显示美食 -->
		  	 	 <s:if test="mealorgoodsname==#showinhotelgoods">
		  	 	 	 <div style=" clear:both; border: 1px solid #abc000; border-radius:10px 10px 10px 10px ;width: 100%;  ">
		  	 	 		  <strong>
		  	 	 		  	<font style="font-family: georgia; font-size: 25px; ">
		  	 	 		  			${goodsInfoPojo.goodsName}
		  	 	 		  	</font> 
		  	 	 		  </strong>
		  	 	 		  <div style=" margin-top:10px;  width: 100%; height: 400xp; ">
  	 	 		  			 <div style="float: left; border: 2px solid #00aa00; border-radius:10px 10px 10px 10px ">
  	 	 		  			 		<img alt="" src="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" height="250px;" width="300px">
  	 	 		  			 </div>
  	 	 		  			  <div style="float: left;">
  	 	 		 					<div style="margin-top: 10px;margin-left: 10px; border:  1px solid #abc000; border-radius:10px 10px 10px 10px ; padding-right: 10px; padding-left: 10px;">
  	 	 		 						<label style="margin-right:10px; font-size: 25px ;font-family: georgia;">单&nbsp;&nbsp;价:</label> 
  	 	 		 						<font style="font-size: 20px ;font-family: georgia;">&yen;</font>  
  	 	 		 						<font style="font-size: 20px ;font-family: georgia; color: red;"> ${goodsInfoPojo.goodsPrice}</font>
  	 	 		 					</div>
  	 	 		 					<div style="margin-top: 10px;margin-left: 10px; border:  1px solid #abc000; border-radius:10px 10px 10px 10px;padding-right: 10px; padding-left: 10px;">
  	 	 		 						<label style="margin-right:10px; font-size: 20px ;font-family: georgia;">美食评价:</label> 
  	 	 		 						<font style="font-size: 20px ;font-family: georgia; color: red;">  5</font>
  	 	 		 						<font style="font-size: 20px ;font-family: georgia;"  >分</font>  
  	 	 		 					</div>
  	 	 		 					<div style="margin-top: 10px;margin-left: 10px; border:  1px solid #abc000; border-radius:10px 10px 10px 10px;padding-right: 10px; padding-left: 10px;">
  	 	 		 						<label style="margin-right:10px; font-size: 20px ;font-family: georgia;">成功订购:</label> 
  	 	 		 						<font style="font-size: 20px ;font-family: georgia; color: red;">  10</font>
  	 	 		 						<font style="font-size: 20px ;font-family: georgia;"  >次</font>  
  	 	 		 					</div>
  	 	 		 					<div style="margin-top: 10px;margin-left: 10px; border:  1px solid #abc000; border-radius:10px 10px 10px 10px;padding-right: 10px; padding-left: 10px;">
  	 	 		 						<label style="margin-right:10px; font-size: 20px ;font-family: georgia;">收藏人气:</label> 
  	 	 		 						<font style="font-size: 20px ;font-family: georgia; color: red;"> 10</font>
  	 	 		 						<font style="font-size: 20px ;font-family: georgia;"  >次</font>  
  	 	 		 					</div>
  	 	 		 					<div style="height:30px; margin-top:10px; border: 1px solid #F0F0F0; border-radius:10px 10px 10px 10px;">
					  	 			 	 	<button type="button" style="margin-left: 30px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
							   				 onclick="addCart(${goodsInfoPojo.goodsId},1);">预订</button>
							   				 <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" 
							    				target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
							    			> 分享 </a>
							   				<button type="button" style="margin-left: 10px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
											 onclick="userCol(${goodsInfoPojo.goodsId},1);">收藏</button>
								</div>
  	 	 		  			 </div>
		  	 	 		  </div>
		  	 	 	</div>
		  	 	 </s:if>
		  	 	  <!-- 查找 -->
		  	 	 <s:if test="mealorgoodsname==#showinhotelseek">
		  	 	 	 <div style=" clear:both; border: 1px solid #abc000; border-radius:10px 10px 10px 10px ;width: 100%;  ">
		  	 	 		  <s:set name="mapGoodsMealHotelisempty">${mapGoodsMealHotel=='[]'||mapGoodsMealHotel=='{}' }</s:set>
		  	 	 		  <s:if test="#mapGoodsMealHotelisempty">
		  	 	 		  	<font style="font-family: georgia;font-size: 25px;"> 对不起没有${hotelmealorgoodsnameseek }相关的饭店、美食、套餐的信息 </font>
		  	 	 		  </s:if>
		  	 	 		  <s:else>
		  	 	 		  <div style="width: 100%; height: 30px;border: 1px solid #aaa000; border-radius:10px 10px 10px 10px ;">
		  	 	 		  	<font style="font-family: georgia;font-size: 25px; ">有关
		  	 	 		  	<font style="font-family: 楷体;font-size: 28px; color: red;">
		  	 	 		  	${hotelmealorgoodsnameseek }</font>
		  	 	 		  	的搜索结果
		  	 	 		  	</font>
		  	 	 		  </div>
		  	 	 		  <s:iterator value="mapGoodsMealHotel">
		  	 	 		  		<s:if test="key=='goods'">
		  	 	 		  			<s:iterator value="value">
			  	 	 		  				<div class="mealhotelclass" >
			  	 	  						 <div style="padding: 2px 2px; margin-left: 5px; margin-right: 5px; ">
							  	 			 	 	<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}">
							  	 			 	 	<img alt="${goodsName }" style="order: 1px solid #bb0000; border-radius:10px 10px 10px 10px;" 
							  	 			 	 	src="<%=basePath %>photo/${goodsImagePojo.gimageImage }" width="100%;" height="120px"></a>
													<font  style="font-family: georgia; font-size: 20px;"   >
														${goodsName }
													</font> 
													<label style=" font-family: georgia ;font-size: 20px;  ">&yen;</label>
					  	 			   				<font style=" font-family:georgia;font-size: 21px; color: red;">${goodsPrice }</font> 
					  	 			   				<em>(1/份)</em>
							  	 			 </div>
							  	 			  <div style="height:30px; margin-top:10px; border: 1px solid #F0F0F0; border-radius:10px 10px 10px 10px;">
						  	 			 	 	<button type="button" style="margin-left: 30px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
								   				 onclick="addCart(${goodsId},1);">预订</button>
								   				 <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" 
								    				target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
								    			> 分享 </a>
								   				<button type="button" style="margin-left: 10px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
												 onclick="userCol(${goodsId},1);">收藏</button>
											 </div>
			  	 	  				</div>
		  	 	 		  			</s:iterator>
		  	 	 		  		</s:if>
		  	 	 		  		<s:elseif test="key=='meal'">
		  	 	 		  		 <s:iterator value="value">
					  	 	 		  	<div class="mealhotelclass" >
					  	 			 	 <div style="height:35px; margin-left:10px; margin-top:10px; font-size: 15px;">
						  	 			 	<label style=" font-family: georgia ;font-size: 20px; ">套餐名:</label> 
						  	 			 	${mealName }<br>
						  	 			 	<label style=" font-family: georgia ;font-size: 15px; ">所在饭店:</label>
						  	 			 	<font style="font-family: 楷体; font-size: 15px;">
						  	 			 	<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }">
						  	 			 	${hotelPojo.hotelName }
						  	 			 	</a>
						  	 			 	</font>
					  	 			 	 </div>
					  	 			 	 <div style="height:120px ;border: 1px solid #F0F6F6; border-radius:10px 10px 10px 10px;">
					  	 			 	 		<div style=" height:20px ;margin-top:10px;">
					  	 			 	 			<label style=" font-family: georgia ; font-size: 18px; ">套餐包含:</label>
					  	 			 	 		</div> 
								  	 			 <div style="height:55px ; margin-top: 10px;">
									  	 			 <s:iterator  value="goodsInfoPojo"  status="status">
										  	 			 <span style="padding: 2px 2px; margin-left: 40px; margin-top: 10px;">
										  	 			 	 <a class="screenshot" rel="<%=basePath %>photo/${goodsImagePojo.gimageImage }" 
										  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" >
																<font class="screenshotaclass"  >
																	${goodsName }
																</font> 
															</a>
										  	 			 </span>
									  	 			 </s:iterator>
								  	 			 </div>
								  	 			 <div style="height:35px ;">
								  	 			 	<label style=" font-family: georgia ;font-size: 20px;  ">套餐售价:&nbsp;&yen;</label>
								  	 			   <font style=" font-family:georgia;font-size: 21px; color: red;">${mealPrice }</font> 
								  	 			   <em>(1/份)</em>
								  	 			 </div>
					  	 			 	 </div>
					  	 			 	 <div style="height:30px; margin-top:0px; border: 1px solid #F0F0F0; border-radius:10px 10px 10px 10px;">
						  	 			 	 	<button type="button" style="margin-left: 30px;"  class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..."
								   				 onclick="addCart(${mealId},0);">预订</button>
								   				<a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!userShowgoods.action?mealorgoodsname=inhotelmeal&&hotelPojo.hotelId=${hotelPojo.hotelId }" 
										    	target="_blank" style="margin-left: 10px;color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 5px 5px ; "
										    	> 分享 </a>
								   				<button type="button" style="margin-left: 10px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." id="manhuabutton"
												 onclick="userCol(${mealId},0);">收藏</button>
										 </div>
					  	 			 </div>
		  	 	 		  		 </s:iterator>
		  	 	 		  		</s:elseif>
		  	 	 		  		<s:elseif test="key=='hotel'">
		  	 	 		  		 <s:iterator value="value">
		  	 	 		  		 <div class="mealhotelclass" >
		  	 	  						 <div style="padding: 2px 2px; margin-left: 5px; margin-right: 5px; ">
						  	 			 	 	<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }">
			  	 									<strong><font face="georgia" size="5"><s:property value="hotelPojo.hotelName"/> </font></strong>
			  	 								</a>
					  	 			 	 	 <button type="button" style="width: 50px;" class="manhuaTip" ty="loading" msg="正在提交您的请求，请稍候..." 
			   									 id="colmanhuabutton"  onclick="userCol(<s:property value="hotelPojo.hotelId"/>,2);">
			   						 			<font face="楷体">收藏</font> </button>
											<a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }" 
										    	target="_blank" style="color:#000000; border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 3px 3px ; "
										    	>二维码分享饭店</a>
						  	 				</div>
					   						<div style="text-align: left;margin-top: 10px;margin-left: 10px;">
					   						 <strong><font face="楷体" size="4">饭店简介:</font></strong>
					   						 <font face="微软雅黑" size="3"> <s:property value="hotelPojo.hotelAds"/> </font>
		   						 			<strong><font face="georgia" size="4"> 营业时间: </font></strong><br>
											<font face="楷体" size="2">
													上午：${hotelPojo.hotelShopAmStart }-${hotelPojo.hotelShopAmEnd }<br>
													 下午:${hotelPojo.hotelShopPmStart }-${hotelPojo.hotelShopPmEnd }
											</font>
											<br>
											<font face="georgia" size="3">地址：</font><br>
											${hotelPojo.hotelProvince}${hotelPojo.hotelCity}${hotelPojo.hotelCounty}${hotelPojo.hotelOtherAddress}
		   							 
										 </div>
		  	 	  				</div>
		  	 	 		  		 </s:iterator>
		  	 	 		  		</s:elseif>
		  	 	 		  </s:iterator>
		  	 	 		  </s:else>
		  	 	 	</div>
		  	 	 </s:if>
		  	 	 
		  	 	</div>
		  	 	
		  	 </div>
	  </div>
   	<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
