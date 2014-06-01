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
    
    <title>查询结果</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
 	<style type="text/css">
		.classmain{
 		font-family: 仿宋;
 		font-size: 20px;
 		float: left;
 		margin-left: 5%;
 		margin-top: 10px;
 		width: 90%;
 		border: 2px solid #aa0011;
 		border-radius:10px 10px 10px 10px ;
 	}
</style>
 	<script type="text/javascript">
 		function topage(id){  
		window.location.href="<%=basePath%>asossh/seekinput!pageing.action?page="+id;
	}
 	</script>
  
  </head>
  
 <body   background="<%=basePath %>image/bg.jpg" >
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div class="classmain">
    	<div style="width: 100%;border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
    		  <form  name="formsearch" action="<%=basePath%>asossh/seekinput!seekGoodorHotel.action" method="post">
    		<input type="text" name="hotelPojo.hotelName" value="${hotelPojo.hotelName }" size="80%" style="padding: 5px 5px; font-family: 仿宋;font-size: 20px;">
    		<button type="submit"  style="font-family: 仿宋; font-size: 20px; padding: 10px 30px;"
    		>搜索一下</button>
    		</form>
    	</div>
		<div  style="width: 100%;height:800px; border: 1px solid #eee;border-radius:10px 10px 10px 10px ; ">
			<div style="float:left; width: 60%;border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
			<s:set name="pageViewisemply">${pageView.records=='[]'||pageView.records=='{}' }</s:set>
			<s:if test="#pageViewisemply">
				<div style="width: 50%;border: 1px solid #aaa;border-radius:10px 10px 10px 10px ;">
					没有此饭店
				</div>
			</s:if>
			<s:else>
			<s:iterator  value="pageView.records" id="entity" status="status">
					<div style="width:100%; border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
						<label style="font-family: 仿宋; margin:5px 5px; padding:5px 5px; font-size: 20px;">
							<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }">
							${hotelName }
							</a>
						</label>
						<br>
						<nobr>
						<em style="font-family: 仿宋; font-size: 18px;">地址:</em>
							<b style="font-family: 仿宋; font-size: 15px;">
								${hotelProvince}${hotelCity}${hotelCounty}${hotelOtherAddress }
							</b>
						</nobr>
					</div>
			</s:iterator>
			</s:else>
			</div>
			<div style=" float:left;width: 39.5%;border: 1px solid #bbb;border-radius:10px 10px 10px 10px ;">
				<div style="width: 100%;border: 1px solid #ff0000;border-radius:10px 10px 10px 10px ;
					font-family: 仿宋; font-size: 25px;	">
					猜你喜欢
				</div>
				<div  style="width: 100%;border: 1px solid #ffff00;border-radius:10px 10px 10px 10px ;
					font-family: 仿宋; font-size: 25px;	">
					<marquee  height="760px" width="100%" behavior="alternate" 
								 scrollamount="10"  scrolldelay="500"
								 direction="up" loop="-1" onmouseover="this.stop()" onmouseout="this.start()"
					>
					<s:iterator value="hotelPojoList">
					<div style="width: 100%; border: 1px solid #00ff00;border-radius:10px 10px 10px 10px ">
						<label style="font-family: 仿宋; margin:5px 5px; padding:5px 5px; font-size: 20px;">
							<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }">
							${hotelName }
							</a>
						</label>
						<br>
						<nobr>
						<em style="font-family: 仿宋; font-size: 18px;">地址:</em>
							<b style="font-family: 仿宋; font-size: 15px;">
								${hotelProvince}${hotelCity}${hotelCounty}${hotelOtherAddress }
							</b>
						</nobr>
					</div>
					</s:iterator>
					</marquee>
				</div>
			</div>
		</div>
		<div style="width: 100%; margin-top: 10px;  height:50px;">
			   <s:include value="../page/page.jsp"></s:include>
		</div>
    </div>
     <jsp:include page="../headfoot/footer.jsp"></jsp:include>
  </body>
</html>
