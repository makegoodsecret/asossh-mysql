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
    
    <title>管理美食</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="styles.css">
	<LINK href="<%=basePath%>css/mstx.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/javascript.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/base.js"></script>
	<s:head/>
	<sx:head parseContent="true"/>
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
	
	//第一次进入把最大的显示页数的最大值注入到隐藏域中,并且可以修改之后进入时的最大显示数
	$("#maxResultPage").val(<s:property value='maxResultPage' default='5'/>);
	//设置最大显示页数
	$("#selectmaxpage").change(function(){
		$("#maxResultPage").val($(this).val());
		setsortName();
		document.myForm.action="<%=basePath%>asossh/goods!goodsPaging.action";
		document.myForm.submit();
	});
	});
	function topage(id){  
		 $("#pageid").val(id);
		 setsortName();
		 formid.action="<%=basePath%>asossh/goods!goodsPaging.action";
		 formid.submit(); 
	}
	function setsortName(){
		 var sortNameid=dojo.widget.byId("auto").getText();
		 if (sortNameid.length==0) {
			$("#sortNameid").val("按套餐查询");
		}else{
		  $("#sortNameid").val(sortNameid.trim());
		}
	}
</script>
  </head>
<body background="<%=basePath %>image/bg.jpg">
<jsp:include page="../headfoot/head.jsp"></jsp:include>
<center  style="font-family: 仿宋;font-size: 20px;">
<form action="<%=basePath%>asossh/goods!goodsPaging.action" method="post" name="myForm"  id="formid">
<!-- 隐藏域添加与处理数据 -->
<input type="hidden" name="maxResult" id="maxResult" />
<input type="hidden" name="maxResultPage" id="maxResultPage" value="5">
<input type="hidden" name="page" id="pageid"/>  <!-- 用来传递用户选择的页码 -->
<input type="hidden" value="${hotelPojo.hotelId }" name="hotelPojo.hotelId">
    <table width="90%" border="0" background="<%=basePath %>image/bg.jpg" id="tableid">
    <tr>
    	<td  colspan="8" id="tdhiddenfirst">
    		<input type="text"   value="${goodsPojo.goodsName }" placeholder="搜索美食" name="goodsPojo.goodsName" style="padding: 5px 10px ; " size="20"  >
    		<s:set name="issortPojoisempty">${goodsPojo.sortPojo.sortName==null}</s:set>
    		<s:if test="#issortPojoisempty">
    			<s:set name="sortName">按套餐查询</s:set>
    		</s:if>
    		<s:else>
	    		<s:set name="sortName">${goodsPojo.sortPojo.sortName }</s:set>
    		</s:else>
			<s:set name="typeurl" >
				<%=basePath %>asossh/autocompleter!Goodssortfill.action
			</s:set>
			<sx:autocompleter name="sortName" href="%{typeurl}"
				id="auto"  cssStyle="padding:5px 5px ;" 
				loadOnTextChange="true" loadMinimumCount="1" autoComplete="true"
				showDownArrow="true" value="%{sortName}"
			></sx:autocompleter> 	
			<input type="hidden" name="goodsPojo.sortPojo.sortName" id="sortNameid" value="${goodsPojo.sortPojo.sortName }">
    		<button type="submit" style="font-family: 楷体;font-size: 25px; padding: 5px 20px;" onclick="setsortName()">搜索</button>
    	</td>
    	<td id="tdhiddenfirst" >
    		<div>
    			<a href="<%=basePath%>admin/upgoods.jsp" style="padding: 10px  10px;" id="aaddgoods" title="点击就可以添加美食了 ">  
    		 	添加  </a>
    		</div>
    	</td>
    </tr>
    <s:if test="pageView.totalRecord">
    	<tr align="center">
    		<td id="tdhidden" width="20px" >
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
    		<h4><font face="新宋体"><strong><font color="#000000" >美食名称</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >美食描述</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >美食的种类</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >美食的价格</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >上传的时间</font></strong></font></h4>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<h4><font face="新宋体"><strong><font color="#000000" >饭店名称</font></strong></font></h4>
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
    		<input type="checkbox" name="checkbox" id="checkbox" value="${goodsId }"> </td>
    		<td id="tdhidden"><s:property value="#status.count"/></td>
    		<td id="tdhidden" width="100px" height="100px">
    			<img alt="图片已经损坏请重新上传" 
    			src="<%=basePath %>photo/<s:property value='#entity.goodsImagePojo.gimageImage'/>" width="100%" height="100%">
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    		<a href="<%=basePath %>asossh/goods!showupdategoods.action?goodsPojo.goodsId=${goodsId }" class="btn" title="点击查看美食详情">
    			<s:property value="#entity.goodsName"/>
    		</a>
    		</td>
    		<td id="tdhidden"  >
    			<s:property value="#entity.goodsDis"/>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    			<s:property value="#entity.sortPojo.sortName"/>
    		</td>
    		<td id="tdhidden" nowrap="nowrap">
    			<s:property value="#entity.goodsPrice"/>
    		</td>
    		<td id="tdhidden" >
    			<s:date name="#entity.goodsTime" />
    		</td>
    		<td id="tdhidden"  >
	    		<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelPojo.hotelId }">
				 <font face="仿宋" size="4">${hotelPojo.hotelName } </font>
	    		</a>
    		</td>
    	</tr>
    	</s:iterator>
    </s:if>
    <s:else>
    	<h4>对不起没有美食，赶快去
		    <a href="<%=basePath%>admin/upgoods.jsp"  title="点击就可以添加美食了 ">  
    		    添加美食  
    		</a>
		吧...</h4>
    </s:else>
    </table>
    
    <table width="90%" border="0" background="<%=basePath %>image/bg.jpg">
    <tr>
    	<td id="tdhidden" align="center">
    <!-- 分页的展示 -->  
		<br>    
    <s:if test="pageView.totalPage>1">	<!-- 只有当页数大于1页时才显示 -->
    	<s:include value="../page/page.jsp"></s:include>
    	<select id="selectmaxpage">
    		<option value="5">更改每页最大的显示数</option>
    		<option value="1">1</option>
    		<option value="5">5</option>
    		<option value="8">8</option>
    		<option value="15">15</option>
    		<option value="20">20</option>
    		<option value="50">50</option>
    		<option value="100">100</option>
    		<option value="200">200</option>
    	</select>
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
