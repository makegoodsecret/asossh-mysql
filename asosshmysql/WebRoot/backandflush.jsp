<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>'backandflush.jsp'</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<!--<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>-->
	<style type="text/css">
	button{
		padding: 10px 20px;
	}
	
	</style>

  </head>
  
  <body>
    
	  <button type="button" onclick="javascript:history.go(-1)">返回history.go(-1)</button>
     <button type="button" onclick="javascript:history.back()">返回history.back()</button>
     <button  type="button" onclick="window.history.forward()">返回下一页window.history.forward()</button>
     <br>
  	  <button type="button" onclick="history.go(0)">刷新history.go(0)</button>
  	  <button type="button" onclick="location.reload()">刷新location.reload()</button>
  	  <button type="button" onclick="location=location">刷新location=location</button>
  	  <button type="button" onclick="location.assign(location)">刷新location.assign(location)</button>
  	  <button type="button" onclick="location.replace(location)">刷新location.replace(location)</button>
 



  </body>
</html>
