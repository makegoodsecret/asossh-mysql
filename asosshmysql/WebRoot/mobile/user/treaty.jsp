<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>注册协议页面</title>

    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <!-- name="viewport" 说明:强制让文档的宽度与设备的宽度保持1:1，并且文档最大的宽度比例是1.0，并且不允许用户点击屏幕放大浏览 -->
    <meta name="viewport"  content="with=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0;">
    <!-- name="apple-moblie-web-app-capable"代表的是iPhone(iPhone私有属性)设备中的safari私有meta标签 -->
   	<meta name="apple-moblie-web-app-capable" content="yes">
   	<!-- name="apple-mobile-web-app-status-bar-style"iPhone私有便签，它指定iPhone中safari顶端的状态条 -->
   	<meta name="apple-mobile-web-app-status-bar-style"  content="black">
   	<!-- name="format-decation" 告诉设备忽略将页面中的数字识别为电话号码 -->
   	<meta name="format-detection" content="telephone=no">

   <link rel="stylesheet" type="text/css" href="<%=basePath%>mobile/css/jquery.mobile-1.3.2.min.css"> 
   <link rel="stylesheet" type="text/css" href="<%=basePath%>mobile/_assets/css/jqm-demos.css"> 
   <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
   <script type="text/javascript" src="<%=basePath%>mobile/js/jquery-1.9.0.min.js"></script> 
   <script type="text/javascript" src="<%=basePath%>mobile/js/mymobile.js"></script>
   <script type="text/javascript" src="<%=basePath%>mobile/_assets/js/index.js"></script>
   <script type="text/javascript" src="<%=basePath%>mobile/js/jquery.mobile-1.3.2.min.js"></script>	
	<style type="text/css">
	body,a,div,span,img {
		margin: 0px 0px;
		font-family: 仿宋;
	}
	</style>

  

  </head>
  
 <body>
   <div data-role="page">
		<div data-role="header">
			 
		</div>
		<div data-role="content">
			 
	 
		</div>	
		<div data-role="footer">
			 
		</div>
	</div>
  </body>
</html>
