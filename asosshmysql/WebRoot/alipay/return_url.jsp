<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>'return_url.jsp'</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> 
   <script type="text/javascript">
		function  homeonload(){
			 window.location.href="<%=basePath %>asossh/index!showIndex.action";
		}
	</script>
  </head>
  <body  background="<%=basePath %>image/bg.jpg" onload="homeonload();">
    <jsp:include page="../headfoot/head.jsp"></jsp:include>
<center>
	 <h1>
	 	${returnurlmsg }
	 </h1>
	 <h4>正在前往首页</h4>
	<img alt="正在加载" src="<%=basePath %>image/progressbars.gif" >
</center>
<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
