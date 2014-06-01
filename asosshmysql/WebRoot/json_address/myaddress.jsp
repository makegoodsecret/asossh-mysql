<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head> -->
    <base href="<%=basePath%>">
    
  <!--   <title>我的地址 下拉联动</title> -->
    
 
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
select{
	position:relative;
	font-size:14px;
	font-family:黑体;
	width:80px;
	line-height:14px;
	border:1px;
	color:#000;
} 
</style>
 <%-- <script type="text/javascript" src="<%=basePath%>/js/jquery-1.7.1.js"></script>  --%>
<script type="text/javascript" src="<%=basePath%>json_address/jquery.cityselect.js"></script>
<script type="text/javascript">
	function address_select(){
		var provmsg="请选择", citymsg="请选择";
		  provmsg  =$("#ipprovince").val().trim();
		  citymsg  =$("#ipcity").val().trim();
		 $("#my_address").citySelect({
			prov:provmsg,city:citymsg,dist:"请选择",nodata:"none",required:false
		});
	}
</script>
</head>

<body onload="address_select()">
    <span id="my_address">
  		<select class="prov" style="width: 80px ;padding: 5px 5px;border: 1px solid #afcecc;  " name="orderAddressPojo.province" id="province" ></select> 
    	<select class="city"  style="width: 100px ;padding: 5px 5px;border: 1px solid #afcecc;"   name="orderAddressPojo.city" id="city"></select>
        <select class="dist"  style="width: 150px;padding: 5px 5px;border: 1px solid #afcecc;" name="orderAddressPojo.county" id="county"></select>
    </span>
    	 	<input type="hidden"   id="iptype" value="<s:property value='@com.secret.action.StaticAction@iptype'/>"><br>
		 	 <input type="hidden" id="ipprovince" value="<s:property value='@com.secret.action.StaticAction@province'/>" >	<br>
		 	<input type="hidden" id="ipcity"  value="<s:property value='@com.secret.action.StaticAction@city'/>"> 
									
</body>
<!-- </html> -->

