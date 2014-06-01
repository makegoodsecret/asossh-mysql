<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>${hotelName }饭店的管理界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<link rel="stylesheet" href="<%=basePath%>css/organictabsstyle.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
 	<script type="text/javascript" src="<%=basePath%>js/organictabs.jquery.js"></script>
	<style type="text/css">
		.classmain{
 		font-family: 仿宋;
 		font-size: 20px;
 		float: left;
 		margin-left: 5%;
 		margin-top: 10px;
 		width: 90%;
 		border: 2px solid #aa0011;
 		border-radius:10px 10px 10px 10px ;
 	}
 	#screenshot{ position:absolute; border:1px solid #ccc; background:#333; padding:5px; display:none; color:#fff;
	}
.screenshotaclass{
	font-family: 宋体;font-size:15px; color:#22F; border: 1px solid #555; border-radius:5px 5px 5px 5px; 
}
.screenshotaclass:hover{
	font-family: 宋体;font-size:15px; color:#22F; border: 1px solid #EE0000; border-radius:5px 5px 5px 5px; 
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
});


</script>
	<script>
		$(function() {
			$("#hoteltab").organicTabs({
				"speed": 100,
				"param": "tab"
			});
			
		});
	</script>
  </head>
  <body background="<%=basePath %>image/bg.jpg">
  <jsp:include page="../headfoot/head.jsp"></jsp:include>
		<div class="classmain">
		<div style="width:100%; border: 1px solid #eae;border-radius:10px 10px 10px 10px ; height: 150px;">
			<div style="width:30%;float:left;">
			<div style="text-align: left;margin-top: 10px;margin-left: 10px;">
					<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }">
						<strong><font face="仿宋" size="5"><s:property value="hotelPojo.hotelName"/> </font></strong>
					</a>
					<button type="button" style="padding: 5px 10px;" 
					onclick="window.location.href='<%=basePath %>asossh/hotelmanage!showhotelupdate.action?hotelPojo.hotelId=${hotelPojo.hotelId }'" 
					> 修改饭店信息</button>
					<s:set name="hotelIdname">${hotelPojo.hotelId }</s:set>
					<s:set name="hotelNamename">${hotelPojo.hotelName }</s:set>
					<s:property value="@com.secret.action.StaticAction@sethotelsession(#hotelIdname,#hotelNamename)"/>
			</div> 
			<div style="text-align: left;margin-top: 10px;margin-left: 10px;">
				 <strong><font face="楷体" size="4">饭店简介:</font></strong>
				 <font face="微软雅黑" size="3"> <s:property value="hotelPojo.hotelAds"/> </font>
				</div>
				 <div style="text-align: left;margin-top: 10px;margin-left: 10px;">
				<strong><font face="仿宋" size="4"> 营业时间: </font></strong><br>
				<font face="楷体" size="2">
					<span style="margin-left: 30px;">
						上午：${hotelPojo.hotelShopAmStart }-${hotelPojo.hotelShopAmEnd }
						 下午:${hotelPojo.hotelShopPmStart }-${hotelPojo.hotelShopPmEnd }
					 </span>
				</font>
		   	</div  >
			 <div style="text-align: left;margin-top: 5px;margin-left: 10px;">
				<font face="楷体" size="2" >
					<strong><font face="仿宋" size="4">地址：</font></strong>${hotelPojo.hotelProvince}${hotelPojo.hotelCity}${hotelPojo.hotelCounty}${hotelPojo.hotelOtherAddress}
				</font>
		   	 </div>
		   	 </div>
		   	 <div  style="float:left; margin-top: 5px;margin-left: 10px; width: 28%;">
		   	 		 <div style="float:left;">
		   	 		 	<button type="button" onclick="window.location.href='<%=basePath %>asossh/admSort!findAllSort.action?hotelPojo.hotelId=${hotelPojo.hotelId }'" 
		   	 		 	style="padding: 10px 30px;">种类管理</button><br>
		   	 		 	<button type="button" onclick="window.location.href='<%=basePath %>asossh/goods!showGoods.action?hotelPojo.hotelId=${hotelPojo.hotelId }'" 
		   	 		 	style="padding: 10px 30px;">美食管理</button><br>
		   	 		 	<button type="button" onclick="alert('还没有开发')" 
		   	 		 	style="padding: 10px 30px;">套餐管理</button>
		   	 		 </div>
		   	 		 <div style="float:left;">
		   	 		 	<button type="button" onclick="alert('还没有开发')" 
		   	 		 	style="padding: 10px 30px;">订单管理 </button><br>
		   	 		 	<button type="button" onclick="alert('还没有开发')" 
		   	 		 	style="padding: 10px 30px;">评价管理 </button><br>
		   	 		 	<button type="button" onclick="window.location.href='<%=basePath %>report/reportForms!reportLoggers.action?hotelPojo.hotelId=${hotelPojo.hotelId }'" 
		   	 		 	style="padding: 10px 30px;">报表管理</button>
		   	 		 </div>
		   	 </div>
		  <!-- 右侧饭店logo和证书 -->
		   	 <div  style="float:left; margin-top: 5px;margin-left: 10px; width: 18%;">
		   	 		<img alt="logo" src="<%=basePath %>photo/${hotelPojo.hotelLogo }" width="100%" height="140px" style="border: 1px solid #ebe;border-radius:10px 10px 10px 10px ; ">
		   	 </div>
			  <div  style="float:left; margin-top: 5px;margin-left: 10px; width: 18%;">
		   	 		<img alt="logo" src="<%=basePath %>photo/${hotelPojo.hotelCertificate }" width="100%" height="140px" style="border: 1px solid #ebe;border-radius:10px 10px 10px 10px ; ">
		   	 </div>
		   	 
		</div>
	<!-- 主体显示区 -->	
			<div id="page-wrap">
				<div id="hoteltab">
				<ul class="nav">
					<li class="nav-one" ><a href="#meal" class="current">套餐</a></li>
					<li class="nav-two"  ><a href="#goodsInfo">美食</a></li>
					<li class="nav-three"  ><a href="#order">订单</a></li>
					<li class="nav-four last"  ><a href="#access">评价</a></li>
				</ul>
				<div class="list-wrap">
				<div id="meal">
					<s:set name="meallist">${hotelPojo.mealPojo=='[]'||hotelPojo.mealPojo=='{}' }</s:set>
					<s:if test="#meallist">
						<div style="text-align: center;font-family: 仿宋;font-size: 25px;">
								套餐为空
								<button type="button"  style="padding: 10px  30px ;"
								onclick="window.location.href='<%=basePath %>asossh/hotelmanage!mealShow.action?hotelPojo.hotelId=${hotelPojo.hotelId }'"
								>添加套餐</button>
						</div>
					</s:if>
					<s:else>
						<div style="text-align: center;font-family: 仿宋;font-size: 25px;">
								<button type="button"  style="padding: 10px  30px ;"
								onclick="window.location.href='<%=basePath %>asossh/hotelmanage!mealShow.action?hotelPojo.hotelId=${hotelPojo.hotelId }'"
								>添加套餐</button>
						</div>
						<s:iterator value="hotelPojo.mealPojo" >
						<div style="text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
								<label style="font-size: 25; font-family: 楷体; ">套餐名:</label> ${mealName }<br>
								<label style="font-size: 25; font-family: 楷体; ">套餐包含美食:</label>
								  <s:iterator  value="goodsInfoPojo"  status="status">
							  	 			 <span style="padding: 2px 2px; margin-left: 40px; margin-top: 10px;">
							  	 			 	 <a class="screenshot" rel="<%=basePath %>photo/${goodsImagePojo.gimageImage }" 
							  	 			 	 href=" <%=basePath %>asossh/hotelmanage!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" >
													<font class="screenshotaclass"  >
														${goodsName }
													</font> 
												</a>
							  	 			 </span>
						  	 			 </s:iterator>
								<br>
								<label style="font-size: 25; font-family: 楷体; ">套餐单价:</label>&yen;${mealPrice }<br>
								<button type="button"  style="padding: 10px  10px ;"
								onclick="window.location.href='<%=basePath %>asossh/hotelmanage!mealShowUpdate.action?hotelPojo.hotelId=${hotelPojo.hotelId }&mealPojo.mealId=${mealId}'"
								>修改此套餐</button>
						</div>
						</s:iterator>
					</s:else>
				</div>
				
				<div id="goodsInfo" class="hide">
					<s:set name="goodslist">${hotelPojo.goodsInfoPojo=='[]'||hotelPojo.goodsInfoPojo=='{}' }</s:set>
					<s:if test="#goodslist">
					<div style="text-align: center;font-family: 仿宋;font-size: 25px;">
								美食为空
								<button type="button"  style="padding: 10px  10px ;"
								onclick="window.location.href='<%=basePath%>admin/upgoods.jsp'"
								>添加美食</button>
					</div>
					</s:if>
					<s:else>
					<div style="text-align: center;font-family: 仿宋;font-size: 25px;">
								<button type="button"  style="padding: 10px  30px ;"
								onclick="window.location.href='<%=basePath%>admin/upgoods.jsp'"
								>添加美食</button>
					</div>
						<s:iterator value="hotelPojo.goodsInfoPojo" >
							<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
								<div style="float: left;">
										<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}">
				  	 			 	 	<img alt="${goodsName }" style="order: 1px solid #bb0000; border-radius:10px 10px 10px 10px;" 
				  	 			 	 	src="<%=basePath %>photo/${goodsImagePojo.gimageImage }" width="180px;" height="120px"></a>
								</div>
								<div style="float: left;">
										<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}">
											<font  style="font-family: 宋体; font-size: 20px;"   >
												${goodsName }
											</font> 
										</a>
										<br>
										<label style=" font-family: 仿宋 ;font-size: 20px;  ">描述:</label>
										${goodsDis }<br>
										<label style=" font-family: 仿宋 ;font-size: 20px;  ">单价&yen;</label>
		  	 			   				<font style=" font-family:仿宋;font-size: 21px; color: red;">${goodsPrice }</font> 
		  	 			   				<em>(1/份)</em>
		  	 			   				<button type="button"  style="padding: 10px  10px ;"
										onclick="window.location.href='<%=basePath %>asossh/goods!showupdategoods.action?goodsPojo.goodsId=${goodsId }'"
										>修改此美食</button>
								</div>
							</div>
						</s:iterator>
					</s:else>
				</div>
				
				<div id="order" class="hide">
					<s:set name="goodsOrdermapname">${goodsOrdermap=='[]'||goodsOrdermap=='{}'}</s:set>
					<s:if test="#goodsOrdermapname">
						<div style="text-align: center;font-family: 仿宋;font-size: 25px;">
								还没有人来购买
						</div>
					</s:if>
					<s:else>
						<!-- 只是下单，支付宝交易未创建 -->
						<s:iterator value="goodsOrdermap">
							<s:if test="key=='none'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label style="color: red; font-family: 楷体;font-size: 25px;">支付交易未创建(无支付宝交易号)</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
										</div>
									</s:iterator>
								</div>
							</s:if>
							<!-- 交易创建,没有付款 -->
							<s:if test="key=='WAIT_BUYER_PAY'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label style="color: red; font-family: 楷体;font-size: 25px;">买家没有付款</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
										</div>
									</s:iterator>
								</div>
							</s:if>
							<!-- 付款成功，但卖家没有发货 -->			
							<s:if test="key=='WAIT_SELLER_SEND_GOODS'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label style="color: red; font-family: 楷体;font-size: 25px;">待发货</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
											<div style="text-align:center; font-size: 25px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<button type="button" style="padding: 10px 10px ;" 
												 onclick="window.location.href='<%=basePath %>asossh/seller!shipments.action?goodsOrderPojo.orderNumber=${key }'"
												>确定发货</button>
											</div>
										</div>
									</s:iterator>
								</div>
							</s:if>
							<!-- 卖家已经发了货，但买家还没有做确认收货-->			
							<s:if test="key=='WAIT_BUYER_CONFIRM_GOODS'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label style="color: red; font-family: 楷体;font-size: 25px;" >待确认收货</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
										</div>
									</s:iterator>
								</div>
							</s:if>
							<!-- 交易成功-->			
							<s:if test="key=='TRADE_FINISHED'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label>交易成功</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
										</div>
									</s:iterator>
								</div>
							</s:if>
							<!-- 交易关闭-->			
							<s:if test="key=='TRADE_CLOSED'">
								<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;">
									<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
										<label>交易关闭</label>
									</div>
									<s:iterator value="value">
										<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
											<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${key }</font><br>
											<label>交易详情:</label>
											<s:iterator value="value"><!-- 具体内容 -->
											<s:if test="mealPojo!=null"><!-- 套餐   -->
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #ccc;border-radius:10px 10px 10px 10px ;">
													<label><strong>套餐</strong></label><br>
													<label style="font-size: 15px;">套餐名:</label> ${mealPojo.mealName }
													<label>套餐详情:</label>
													 <s:iterator  value="mealPojo.goodsInfoPojo"  status="status">
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
											</s:if>
											<s:else>
												<div style="font-size: 18px;padding-left:5px; padding-top:5px; border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
												<label><strong>美食</strong></label><br>
												<label style="font-size: 15px;">美食名:</label> 
												 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									  	 			 	 href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
															<font class="screenshotaclass"  >
													${goodsInfoPojo.goodsName }
												</font></a>
												</div>
											</s:else>
											 </s:iterator>
										</div>
									</s:iterator>
								</div>
							</s:if>
						</s:iterator>
					</s:else>
				</div>
<!-- 饭店收到的评价-->				
				<div id="access" class="hide">
					<div style="clear:both; text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #aa0011;border-radius:10px 10px 10px 10px ;"> 
						<s:set name="goodsAssessListname">${goodsAssessList=='[]'||goodsAssessList=='{}' }</s:set>
						<s:if test="#goodsAssessListname">
							<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
								<label>还没有人评过</label>
							</div>
						</s:if>
						<s:else>
						<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
							<label>最近收到的评价</label>
						</div>
						<s:iterator value="goodsAssessList" >
							<div style=" text-align: left;font-family: 仿宋;font-size: 20px;padding-left:5px; border: 1px solid #ddd;border-radius:10px 10px 10px 10px ;">
								<label>订单号：</label><font style="font-family: 仿宋;font-size: 15px;">${goodsOrderPojo.orderNumber }</font><br>
								<label>支付宝交易号：</label><font style="font-family: 仿宋;font-size: 15px;">${goodsOrderPojo.alipayTradeNo }</font><br>
								<label>对此次交易评价等级：</label>
								<font style="font-family: 仿宋;font-size: 15px; color: red;">${assStars }星</font>
								&nbsp;&nbsp;&nbsp;<em style="font-size: 15;">对评级不满意
								<button type="button" onclick="alert('功能还待开发');" style="padding: 10px 10px ;"> 联系买家</button></em>
								<br>
								<label>评价内容:</label>
								<font style="font-family: 楷体;font-size: 15px; color:#aaa;">
									${assDis }
								</font><br>
								<label>评价者:</label>${userPojo.username }
								<label>所在外网ip:</label>${assIp }
								<label>评价时间：</label><font style="font-family: 仿宋;font-size: 15px;">${assTime }</font><br>
							</div>
						</s:iterator>
						</s:else>
					</div>
				</div>
				</div>  
				</div>

	</div>
		</div>
	<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
