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
	<title>闻道美食网</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.7.1.js"></script>
  
	 <style type="text/css">
	body {
			margin: 0;
			padding: 0;
			font-size: 12px;
		}
	</style>
    <script type="text/javascript">
		function  homeonload(){
			 var href="<%=basePath %>asossh/index!showIndex.action?userlat=30.0&userlon=120.1";
			formsubmit(href);//提交为post 
	    	//获取用户当前城市的经纬度
		 	var userlat = geoip_latitude(); //纬度
			var userlon = geoip_longitude(); //经度
			  href="<%=basePath %>asossh/index!showIndex.action?userlat="+userlat+"&userlon="+userlon;
			formsubmit(href);//提交为post   
		}
	</script>
</head>
<body   background="<%=basePath %>image/bg.jpg" onload="homeonload();">
<div id="out">
<!-- 隐藏域只能进入首页一次跳到action中读数据 -->
 <jsp:include page="headfoot/head.jsp"></jsp:include>
		<center>
		<h4>正在进入闻道食府网</h4>
		<img alt="正在加载" src="<%=basePath %>image/progressbars.gif" >
		</center>
		 
<jsp:include page="headfoot/footer.jsp"></jsp:include> 
</div>
</body>
</html>
