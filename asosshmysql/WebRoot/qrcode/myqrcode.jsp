<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>'myqrcode.jsp'</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<!--<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>-->
	<script type="text/javascript">
 document.write("<img src=\"https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl="+encodeURI(window.location.href)+"/></img>"); 
 window.location.href= "https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=ssss";
 //document.write('<img src =\"http://chart.googleapis.com/chart?chl=tel%3A18768011400&chs=200×200&cht=qr&chld=%7C1&choe=UTF-8" /></img>');
	 
	</script>

  </head>
  
  <body>
   
    <form action='https://chart.googleapis.com/chart' method="get" id='post_form'
          onsubmit="this.action = 'https://chart.googleapis.com/chart?chid=' + (new Date()).getMilliseconds(); return true;"> 
       <input type='hidden' name='choe' value='UTF-8' />
      <input type='hidden' name='cht' value='qr' />
      <input type='hidden' name='chs' value='300x300' />
      <input type="hidden" name="chld"  value="L|2">
      <!-- <input type='hidden' name='chl' value='This is my QR code' /> -->
      <input type="text" name="chl" value="tel:11111">
      <input type='submit'  />
      <button type="button" style="padding: 10px 10px " onclick="showqr()">查看 </button>
    </form>





  </body>
</html>
