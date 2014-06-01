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
<title>闻道美食网--我的收藏</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK href="<%=basePath%>css/mstx.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
</head>
<body  background="<%=basePath %>image/bg.jpg">
	<jsp:include page="../headfoot/head.jsp"></jsp:include>
	<p style="font-size: 30px;">我的收藏</p>
	
<jsp:include page="../headfoot/footer.jsp"></jsp:include>	
</body>
</html>
