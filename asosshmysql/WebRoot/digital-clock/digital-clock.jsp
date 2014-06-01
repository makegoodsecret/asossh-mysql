<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 
		Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	 
		
		<link href="<%=basePath%>digital-clock/clockstyle.css" rel="stylesheet" />
	 <script type="text/javascript" src="<%=basePath%>js/html5.js"></script> 
	 <script src="<%=basePath%>digital-clock/moment.js"></script> 
	 <script src="<%=basePath%>digital-clock/clockscript.js"></script>
	 <%-- <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> --%>
	 
	</head>

	<body>

		<div id="clock" class="light">
			<div class="display">
				<div class="weekdays"></div>				
			 	<div class="ampm"></div>
				<div class="alarm"></div>
				<div class="digits"></div>
			</div>
		<!--   <div class="button-holder">
			<a class="button">白天/黑夜</a>
		  </div>   -->
		</div>
	</body>
</html>
