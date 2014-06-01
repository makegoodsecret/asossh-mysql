<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>3D云标签</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript"  src="<%=basePath%>js/tags3D.js"></script>
  	<style type="text/css">
  	
 	#tagsList {position:relative; width:300px; height:350px; margin: 1px auto 0;  }
	#tagsList a {position:absolute; top:0px; left:0px; font-family: 新宋体; 
	color:#000000; font-weight:bold; text-decoration:none; padding: 3px 6px; }
	#tagsList a:hover { color:#FF0000; letter-spacing:2px;} 
  	</style>
  </head>
  
  <body background="<%=basePath %>image/bg.jpg">
  					
  </body>
</html>
