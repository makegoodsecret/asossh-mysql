<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>行货成功</title>
    
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
 		font-size: 25px;
 		float: left;
 		margin-left: 5%;
 		margin-top: 10px;
 		text-align:center;
 		width: 90%;
 		border: 2px solid #aa0011;
 		border-radius:10px 10px 10px 10px ;
 	}
</style>
  </head>
  
<body   background="<%=basePath %>image/bg.jpg" >
<div id="out">
<!-- 隐藏域只能进入首页一次跳到action中读数据 -->
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div class="classmain">
		发货成功
	</div>
<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
</div>
</body>
</html>
