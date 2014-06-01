<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户注册协议界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<LINK href="<%=basePath%>css/mstx.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
  <script type="text/javascript">
  $(function(){
  	$("#notaccept").mousedown(function(){
  		if(window.confirm("不接受协议将返回主页")){
	  		window.location.href="<%=basePath%>index.jsp";
  		}
  	});
  	});
  </script>
  </head>
  <body  background="<%=basePath %>image/bg.jpg">
  <center>
  <form action="<%=basePath%>user/useregister.jsp" name="myForm" method="post">
  	<table width="90%" height="130px" border="0" cellpadding="0" cellspacing="0">
  	
  		<tr>
  			<td align="center">
  			<br><br><br>
  				注册服务条款
  			</td>
  		</tr>
		<tr>
			<td height="27" align="center" >
			<br><br>
				<textarea rows="40" cols="100">
    				${treatytext }
				</textarea>
			</td>
		</tr>  	
		<tr>
			<td align="center" height="27"  >
			<br><br>
				   <input type="submit" value="我接受" style="padding: 10px 10px">
					<input type="button" value="不接受" id="notaccept" style="padding: 10px 10px">
				<br><br>
			</td>
		</tr>
	
  	</table>
  </form>
  
  </center>
    
  </body>
</html>
