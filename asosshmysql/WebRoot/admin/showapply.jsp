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
    
    <title>饭店申请审核</title>
    
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
		var  maxResultPage  = $("#maxResultPage").val(); 
		window.location.href="<%=basePath%>asossh/applySeller!pageing.action?page="+id;
	}
 	</script>
  
  </head>
  
 <body   background="<%=basePath %>image/bg.jpg" >
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div class="classmain">
    	<div style="width: 100%;border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
    	
    	</div>
		<div  style="width: 100%;border: 1px solid #eee;border-radius:10px 10px 10px 10px ;">
			<s:set name="pageViewisemply">${pageView.records=='[]'||pageView.records=='{}' }</s:set>
			<s:if test="#pageViewisemply">
				<div style="width: 100%;border: 1px solid #aaa;border-radius:10px 10px 10px 10px ;">
					非没有人申请
				</div>
			</s:if>
			<s:else>
			<s:iterator  value="pageView.records" id="entity" status="status">
				<div style="width: 100%;border: 1px solid #aaa;border-radius:10px 10px 10px 10px ;">
				<s:if test="#status.first">
					<table width="100%" border="1" background="<%=basePath %>image/bg.jpg">
						<thead>
						<tr>
							<td width="10%">序号</td>
							<td width="15%">申请人</td>
							<td width="25%">饭店logo</td>
							<td width="25%">饭店证书</td>
							<td width="10%">申请时间</td>
							<td width="15%">操作</td>
						</tr>
						</thead>
						<tbody>
				</s:if>
					<tr>
						<td>${status.count }</td>
						<td>${userPojo.username }</td>
						<td>
							<img alt="" src="<%=basePath %>photo/${applysellerLogo}" width="200px" height="150px">
						</td>
						<td>
							<img alt="" src="<%=basePath %>photo/${applysellerCertificate}" width="200px" height="150px">
						</td>
						<td>
							<s:date name="applysellerTime" format="MM月dd天"/>
						</td>
						<td>
						<s:if test="applysellerStatus==0">
							<button type="button" style="padding: 10px 20px;"
								onclick="messagerShow('正在处理');window.location.href='<%=basePath %>asossh/applySeller!updateapplystatus.action?page=${page }&applySellerPojo.applysellerStatus=y&applySellerPojo.applysellerId=${applysellerId} ' ;messagerShow('邮件发送中……');"
							>审核通过</button><br>
							<button type="button" style="padding: 10px 20px;"
								onclick=" messagerShow('正在处理');window.location.href='<%=basePath %>asossh/applySeller!updateapplystatus.action?page=${page }&applySellerPojo.applysellerStatus=n&applySellerPojo.applysellerId=${applysellerId} '"
							>审核不通过</button>
						</s:if>
						<s:else>
							<s:if test="applysellerStatus==n">
								<button type="button" style="padding: 10px 20px;" disabled="disabled"
								>审核未通过</button>
							</s:if>
							<s:else>
								<button type="button" style="padding: 10px 20px;" disabled="disabled"
								>审核已通过</button>
							</s:else>
						</s:else>
						</td>
					</tr>
				<s:if test="#status.last">
					</tbody>
					<tfoot>
					<tr>
					<td colspan="6" height="50px;">
			    		<s:include value="../page/page.jsp"></s:include>
			   		 </td></tr>
					</tfoot>
					</table>	
				</s:if>
				</div>
			</s:iterator>
			</s:else>
		</div>
	
		 
    </div>
     <jsp:include page="../headfoot/footer.jsp"></jsp:include>
  </body>
</html>
