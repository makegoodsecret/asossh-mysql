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
    
    <title>饭店管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>css/mstx.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" language="javascript" src="<%=basePath%>js/javascript.js"></script>
	<script type="text/javascript" src="<%=basePath%>json_address/jquery.cityselect.js"></script>
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
		#aaddhotel{
				background-color: #efe;
				color  :#336600  ;
				font-family:"宋体";
		}
		#aaddhotel:HOVER{
			color  :#ee6600  ;
			font-weight: bold;
			font-family:"宋体";
		}
		#aaddhotel:VISITED {
				font-weight: bold;
				color  :#006600  ;
				font-family:"宋体";
		}
		select{ position:relative; font-size:14px; font-family:黑体;
	width:80px; line-height:14px; border:1px;color:#000;
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
		document.myForm.action="<%=basePath%>asossh/hotelmanage!showMaxResult.action";
		document.myForm.submit();
	});
	});
	function topage(id){  
		 $("#pageid").val(id);
		 formid.action="<%=basePath%>asossh/hotelmanage!seekpageing.action";
		 formid.submit(); 
	}
	 
</script>
  </head>
<body background="<%=basePath %>image/bg.jpg" >
<jsp:include page="../headfoot/head.jsp"></jsp:include>
<center>
<form action="<%=basePath%>asossh/hotelmanage!seekpageing.action" method="post" name="myForm" id="formid">
<!-- 隐藏域添加与处理数据 -->
<input type="hidden" name="maxResult" id="maxResult" />
<input type="hidden" name="maxResultPage" id="maxResultPage" value="5">
<input type="hidden" name="page" id="pageid"/>  <!-- 用来传递用户选择的页码 -->
    <table width="90%" border="0" bgcolor="#FFFFFF" id="tableid">
    <tr>
    	<td id="tdhiddenfirst" colspan="8" align="center" > 
    		<input type="text" value="${hotelPojo.hotelName }" name="hotelPojo.hotelName" id="hotelNameId" placeholder="饭店或饭店所在地" style="padding: 5px 10px ; " size="30">
    		<button type="submit" style="font-family: 楷体;font-size: 25px;margin-left: 20px; padding: 5px 20px;">搜索</button>
    		<a href="<%=basePath%>hotel/hotelsave.jsp" style="padding: 10px  10px; margin-left: 20px;" id="aaddhotel" title="点击添加饭店"> 
    		 	添加新饭店 
    		</a>
    	</td>
    </tr>
    <s:if test="pageView.totalRecord">
    	<tr align="center"  >
    		<td id="tdhidden" width="20px">
    			<input type="button" name="selectall" id="checkAll" value="全选">
    			<input type="button" name="selectall" id="checkNo" value="取消" style="display: none">
    		</td>
    		<td id="tdhidden" width="200px">
    		<h4><font face="新宋体"><font color="#000000" >饭店logo与证书图片</font></font></h4>
    		</td>
    		<td id="tdhidden" width="150px">
    		<h4><font face="新宋体"><font color="#000000" >饭店名称</font></font></h4>
    		</td>
    		<td id="tdhidden" width="80px">
    		<h4><font face="新宋体" ><font color="#000000" >是否营业</font></font></h4>
    		</td>
    		<td id="tdhidden" width="200px">
    		<h4><font face="新宋体"><font color="#000000" >营业时间</font></font></h4>
    		</td>
    		<td id="tdhidden" width="150px">
    		<h4><font face="新宋体"><font color="#000000" >上传的时间</font></font></h4>
    		</td>
    		<td id="tdhidden" width="80px">
    		<h4><font face="新宋体"><font color="#000000" >位置</font></font></h4>
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
    			<input type="checkbox" name="checkbox" id="checkbox" value="${hotelId }">
    			<s:property value="#status.count"/>
    		 </td>
    		<td id="tdhidden" width="100px" height="100px">
    			<img alt="图片已经损坏请重新上传" 
    			src="<%=basePath %>photo/<s:property value='#entity.hotelLogo'/>" width="100%" height="100%">
    			<img alt="图片已经损坏请重新上传" 
    			src="<%=basePath %>photo/<s:property value='#entity.hotelCertificate'/>" width="100%" height="100%">
    		</td>
    		<td id="tdhidden"  >
    		<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }" class="btn" title="点击查看饭店详情">
    			<s:property value="#entity.hotelName"/>
    		</a><hr>
    		<a href="<%=basePath %>asossh/hotelmanage!showhotelupdate.action?hotelPojo.hotelId=${hotelId }" class="btn" title="点击查看饭店详情">
    			查看详细饭店信息
    		</a>
    		</td>
    		<td id="tdhidden"  >
    			<s:set name="status">${hotelStatus==1 }</s:set>
    			<s:if test="#status">
    			营业
    			</s:if>
    			<s:else>
    			停业中
    			</s:else>
    		</td>
    		<td id="tdhidden"  >
    			中餐：${hotelShopAmStart }-${hotelShopAmEnd }<br>
    			晚餐:${hotelShopPmStart }-${hotelShopPmEnd }
    		</td>
    		<td id="tdhidden"  >
    			<s:date name="#entity.hotelTime" />
    		</td>
    		<td id="tdhidden"  >
    			<a href="<%=basePath %>asossh/hotelmanage!showhotelupdate.action?hotelPojo.hotelId=${hotelId }" class="btn" title="点击查看饭店详情">
    			饭店位置
    			</a>
    		</td>
    	</tr>
    	</s:iterator>
    </s:if>
    <s:else>
    	<h4>对不起没有饭店，赶快去
    		<a href="<%=basePath%>hotel/hotelsave.jsp"  title="点击添加饭店"> 
    			<font color="#ff0080"><b>添加新饭店</b></font>
    		</a>吧...</h4>
    </s:else>
    </table>
    <table width="90%" border="0" bgcolor="#FFFFFF">
    <tr>
    	<td id="tdhidden" align="center">
    <!-- 分页的展示 -->  
		<br>    
    <s:if test="pageView.totalPage>1">	<!-- 只有当页数大于1页时才显示 -->
    	<s:include value="../page/page.jsp"></s:include>
    	<select id="selectmaxpage"  >
    		<option value="5">显示</option>
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
    <div id="view"></div>
    	</td>
    </tr>
    </table>
    </form>
</center>
 <jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
