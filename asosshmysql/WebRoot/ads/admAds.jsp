<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>广告发布页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="styles.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/javascript.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/base.js"></script>
		<style type="text/css">
		//对表格以及单元格添加阴影
		 #tableid {
			border-spacing: 10px;
			box-shadow:10px 10px 6px #444;
		}
		#tdhidden{
			box-shadow:6px 6px  4px #444;
			padding: 10px;
		}
		#tdhiddenfirst{
			box-shadow:6px 6px  4px green;
			padding: 10px;
		}
		td>div>a{
				background-color: #efe;
				color  :#336600  ;
				font-family:"宋体";
		}
		td>div>a:HOVER{
			color  :#ee6600  ;
			font-weight: bold;
			font-family:"宋体";
		}
		td>div>a:VISITED {
				font-weight: bold;
				color  :#006600  ;
				font-family:"宋体";
		}
		</style>
<script type="text/javascript">
	$(function(){
	//全选
		$("#checkAll").click(function(){
			$("[name=checkbox]:checkbox").attr("checked",true);
			$("#checkAll").attr("style","display:none");
			$("#checkNo").attr("style","display:true");
		});
	//取消全选
	$("#checkNo").click(function(){
		$("[name=checkbox]:checkbox").attr("checked",false);
			$("#checkAll").attr("style","display:true");
			$("#checkNo").attr("style","display:none");
	});
	});
	function isIssue(adsId){
		window.location.href="<%=basePath%>asossh/ads!updateIssuse.action?adsPojo.adsId="+adsId;
	}
	function topage(paging){
		window.location.href="<%=basePath%>asossh/ads!paging.action?page="+paging;
	}
	function adsIssue(){
		window.location.href="<%=basePath%>asossh/ads!showadmIssueAds.action";
	}
</script>
  </head>
<body background="<%=basePath %>image/bg.jpg">
<jsp:include page="../headfoot/head.jsp"></jsp:include>
<center>
<form >
    <table width="90%" background="<%=basePath %>image/bg.jpg" border="0" bgcolor="#FFFFFF" id="tableid">
    <tr>
    	<td colspan="5" align="right" id="tdhiddenfirst">
    		<a href="<%=basePath%>asossh/ads!upads.action" class="btn" title="添加广告 ">  
    		<font face="微软雅黑" size="3"><strong>添加广告</strong></font> 
    		</a>
    	</td>
    	<td align="right" colspan="2" id="tdhiddenfirst" >
    		<button type="button" onclick="adsIssue()"  
					style="padding-left: 1pc;padding-right: 1pc; padding-bottom: 0.5pc;padding-top: 0.5pc;"
			>发布广告</button>
    	</td>
    </tr>
    <s:if test="pageView.totalRecord">
    	<tr align="center">
    		<td id="tdhidden" width="20px">
    			<input type="button" name="selectall" id="checkAll" value="全选">
    			<input type="button" name="selectall" id="checkNo" value="取消" style="display: none">
    		</td>
    	
    		<td id="tdhidden" nowrap="nowrap" align="center">
    		<h4><font face="新宋体"><strong><font color="#000000" >编号</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >图片</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >广告描述</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >上传的时间</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >状态</font></strong></font></h4>
    		</td>
    	</tr>
   <!-- 遍历结果 -->
    	<s:iterator  value="pageView.records" id="entity" status="status">
    <!-- 添加单双行变色 -->
    	<tr style=" 
    		<s:if test="#status.odd">background-color:#D9DFF0</s:if>
    		<s:else></s:else>"
    		align="center"
    		>
    		<td id="tdhidden">
    		<input type="checkbox" name="checkbox" id="checkbox" value="${adsId }"> </td>
    		<td id="tdhidden"><s:property value="#status.count"/></td>
    		<td id="tdhidden" width="100px" height="100px">
    			<img alt="图片已经损坏请重新上传" 
    			src="<%=basePath %>photo/${adsImage}" width="100%" height="100%">
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<a href="<%=basePath %>asossh/ads!updateads.action?adsPojo.adsId=${adsId }" class="btn" title="点击查看广告详情">
    			${adsDis }
    		</a>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    			${adsTime }
    		</td>
    		<td id="tdhidden" >
    			<s:if test="adsStatu==0">
    				<button type="button" onclick='isIssue("${adsId}")'  
					style="padding-left: 1pc;padding-right: 1pc; padding-bottom: 0.5pc;padding-top: 0.5pc;"
					>发布</button>
    			</s:if>
    			<s:else>
    				<button type="button" onclick='isIssue("${adsId}")'  
					style="padding-left: 1pc;padding-right: 1pc; padding-bottom: 0.5pc;padding-top: 0.5pc;"
					>下架</button>
    			</s:else>
    		</td>
    	</tr>
    	</s:iterator>
    </s:if>
    <s:else>
    	<h4>对不起没有任何广告，赶快去
    	<a href="<%=basePath%>asossh/ads!upads.action" >
	<font face="微软雅黑" size="3" color="#FBCD"><strong>添加</strong></font> 
	</a>吧...</h4>
    </s:else>
    </table>
    <table width="90%" border="0" bgcolor="#FFFFFF">
    <tr>
    	<td align="center">
    <!-- 分页的展示 -->  
		<br>    
    <s:if test="pageView.totalPage>1">	<!-- 只有当页数大于1页时才显示 -->
    	<s:include value="../page/page.jsp"></s:include>
    </s:if>
    <br> <hr><br>  
    <div id="view"></div>
    	</td>
    </tr>
    </table>
    </form>
</center>
 <jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
