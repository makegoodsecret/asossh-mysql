<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我是卖家</title>
    
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
 		margin-top: 50px;
 		width: 90%;
 		border: 2px solid #aa0011;
 		border-radius:10px 10px 10px 10px ;
 	}
 	.classmain>div{
 		border: 2px solid #bb1111;
 		border-radius:10px 10px 10px 10px ;
 	}
 </style>
 <script type="text/javascript">
 	function createhotel(){ 
 		if (window.confirm("创建饭店必须有支付宝账号，你有吗？"+"\n"+"选择取消  ，去支付宝注册一个")) {
			window.location.href="<%=basePath%>asossh/hotelmanage!showhotelsave.action";
		}else{
			window.location.href="https://memberprod.alipay.com/account/reg/index.htm";
		}
 	}
 	function sellerinhotel(hotelId){
		 window.location.href="<%=basePath%>asossh/seller!sellerinhotel.action?hotelPojo.hotelId="+hotelId;
 	}
 </script>
  </head>
  
  <body background="<%=basePath %>image/bg.jpg">
  <jsp:include page="../headfoot/head.jsp"></jsp:include>
		<div class="classmain">
		<div style="font-size: 25px;">
			我是卖家管理入口界面,请在下面选择你管理的饭店
		</div>
		<s:set name="hotelPojoListiseampty">${hotelPojoList=='[]'||hotelPojoList=='{}' }</s:set>
		<s:if test="#hotelPojoListiseampty">
			<div >
				<label>还没有一家饭店呢？赶快创建吧</label>
				<button type="button" style="padding: 10px 10px;" onclick="createhotel()">创建饭店</button>
			</div>
		</s:if>
		<s:else>
		<div>
	       <s:iterator value="hotelPojoList">
	       	<div style="float: left; margin:10px 10px 10px 10px ; ">
	       		<button type="button" style="padding: 10px 10px;" onclick="sellerinhotel(${hotelId })">${hotelName }</button>
	       	</div>
	       </s:iterator>
	       <div style="float: left; margin:10px 10px 10px 10px ; ">
	       		<button type="button" style="padding: 15px 10px 15px 10px ; background-color: #eee;"
	       		 onclick="window.location.href='<%=basePath %>asossh/hotelmanage!showhotelsave.action'">
	       			添加一家新饭店
	       		</button>
	       	</div>
		</div>
		</s:else>
		</div>

	<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
