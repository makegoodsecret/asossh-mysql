<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'feedback.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=basePath %>js/jquery-1.7.1.js"></script>
  </head>
  
 <body  background="<%=basePath %>image/bg.jpg">
  <jsp:include page="headfoot/head.jsp"></jsp:include>
   	<center>
   		<div style="font-family: 仿宋;font-size: 30px;">
   			意见反馈功能正在开发中……<br>
   			敬请期待.
   		</div>
   		
   	</center>
 <jsp:include page="headfoot/footer.jsp"></jsp:include>
</body>
</html>
