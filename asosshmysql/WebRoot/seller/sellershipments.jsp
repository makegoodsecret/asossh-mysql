<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>发货</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	 <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> 
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
	 </style>
  </head>
  
 <body   background="<%=basePath %>image/bg.jpg">
<div id="out">
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div class="classmain">
		<div style=" border: 2px solid #ff0011;border-radius:10px 10px 10px 10px ;">
			<label>订单简介:</label><br>
			 <label>收货人:</label> ${goodsOrderPojo.orderAddress.orderName }<br>
		</div>
		<form action="<%=basePath %>seller/simpleshipments.jsp" method=post target="_blank">
		<div style=" text-align:left; border: 2px solid #aa0011;border-radius:10px 10px 10px 10px ;">
			<label>发货方式一：</label>
			<p style="font-family: 楷体;font-size: 18px;">
				这种方式行货很简单(不需要第三方的物流公司)，只要简简单单的单击下面的按钮，就可以发货了。<br>
				但是这种方式需要人工收货上门。
			</p>
			
		</div>
		<div>
			一下参数不要修改:<br>
			<label>支付宝交易号：</label>
			<input size="30" name="WIDtrade_no" value="${goodsOrderPojo.alipayTradeNo }"/><br>
			<label>物流公司名称：</label>
			<input size="30" name="WIDlogistics_name" value="平邮"/><br>
			<label>物流运输类型：</label>
			<input size="30" name="WIDtransport_type" value="POST"/>
			<span>三个值可选：POST（平邮）、EXPRESS（快递）、EMS（EMS）</span><br>
		</div>
		<div style="text-align:center; border: 2px solid #eee;border-radius:10px 10px 10px 10px ;">
			<button type="submit" style="padding: 10px 10px ;">确认发货</button>
		</div>
		</form>
		<form action="<%=basePath %>seller/completshipments.jsp" method=post target="_blank">
		<div style=" text-align:left; border: 2px solid #aa0011;border-radius:10px 10px 10px 10px ;">
			<label>发货方式二：</label>
			<p style="font-family: 楷体;font-size: 18px;">
				这种方式比较复杂，需要第三方的物流公司
			</p>
		</div>
		<div>
			<label>支付宝交易号：</label>
			<input size="30" name="WIDtrade_no" value="${goodsOrderPojo.alipayTradeNo }"/><br>
			<label>物流公司名称：</label>
			<input size="30" name="WIDlogistics_name" value="平邮"/><br>
			<label>物流发货单号：</label>
			<input size="30" name="WIDinvoice_no" /><br>
			<label>物流运输类型：</label>
			<input size="30" name="WIDtransport_type" value="POST"/>
			<span>三个值可选：POST（平邮）、EXPRESS（快递）、EMS（EMS）</span><br>
		</div>
		<div style="text-align:center; border: 2px solid #eee;border-radius:10px 10px 10px 10px ;">
			<button type="submit" style="padding: 10px 10px ;">确认发货</button>
		</div>
		</form>
 	</div> 
<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
</div>
</body>
</html>
