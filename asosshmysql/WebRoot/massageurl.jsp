<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>操作页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.7.1.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		 
	</style>
	<script type="text/javascript">
		function redireonload(){
		var i  =5;
		getnewtime=function(){
			if (i>0) {
				window.setTimeout( getnewtime,1000);
				$("#btime").html(i);
				i--;
			}else{
					window.location.href="<s:property value='redirecturl'/>";
			}
		};
		getnewtime();
		}
	</script>
  </head>
  
  <body  background="<%=basePath %>image/bg.jpg" onload="redireonload();">
 		<jsp:include page="headfoot/head.jsp"></jsp:include>
     <center>
     	<s:if test="#messagestatu">
	     	<div style="font-family: 宋体; font-size: 20px; margin: 20px 20px;">
			    <b style="font-size: 30px; ">你的当前操作不被允许</b><br><br>
			    原因:<s:property value="elsemessage"/>
	     	</div>
     	</s:if>
     	<s:else>
     		<div style="font-family: 宋体; font-size: 20px; margin: 20px 20px;">
			     <s:property value="elsemessage"/>
	     	</div>
     	</s:else>
		<div  style="font-family: 宋体; font-size: 15px; margin: 20px 20px;">	
			页面将在<b id="btime">5</b>s后跳转回操作前<a href="<%=basePath %><s:property value='redirecturl'/>" title="<s:property value='redirecturl'/>">页面</a>……<br>
			<img alt="正在加载" src="<%=basePath %>image/progressbars.gif" ><br>
		</div>
		<div  style="font-family: 宋体; font-size: 25px;margin: 20px 20px;">
			返回首页点击这<button type="button" onclick="window.location.href='<%=basePath %>asossh/index!showIndex.action'" style="padding: 5px 5px">去首页</button>
		</div>
	</center>
    <jsp:include page="headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
