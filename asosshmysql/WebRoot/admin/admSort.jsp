<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("utf-8");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>闻道美食网--种类管理界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<s:head/>
	<sx:head parseContent="true"/>
<script type="text/javascript">
	$(function(){
	$("#saveSort").click(function(){ 
		var admin ="${user.power==1}"
		if (admin=="true") { //饭店管理员
			var hotelSort =dojo.widget.byId("autohotelname").getText();
			if (hotelSort.length==0) {
			alert("请先选择指定添加的饭店添加套餐");
			return false;
			}  
			$("#hotelNameid").val(hotelSort);
		}
		var sortNameid =$("#sortNameid").val().trim();
		 if(sortNameid.length==0){
			alert("你要添加点啥");
			return false;
		}else{
			
			savesortForm.action="<%=basePath%>asossh/admSort!addSort.action";
			savesortForm.submit();
		}
	});
	
	
	$("#updateSort").click(function(){
		if ($("#updatesortId").val().length==0) {
			alert("请先选择需要修改的套餐");
			return false;
		}else{
			updatesortForm.action="<%=basePath%>asossh/admSort!updateSort.action";
			updatesortForm.submit();
		}
	});
	});
	function buttonclick(){
 		var sortname=$("#updownselectid").find("option:selected").text();
 		var sortId =$("#updownselectid").val();
 		$("#updatesortId").val(sortId);  //注入需要修改的sortid
	    $("#needsort").val(sortname);
	  	$.getJSON(
	  		"<%=basePath%>asossh/admSort!showhotel.action",
	  		{"sortPojo.sortId":sortId},
	  		function(data){
	  		var hotelStatus= "歇业中";
	  		if (data.hotelStatus==1) {
				hotelStatus= "营业中";
			}
				$("#hiddenhotelId").val(data.hotelId);
	  			 var hotelmsg ="<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的logo:</lable>"+"<img src='<%=basePath%>photo/"+data.hotelLogo+"' width='120px;' height='100px'>"+"<br>"
	  			 			+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的名字:</lable>"+data.hotelName+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的描述:</lable>"+data.hotelAds+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的联系电话:</lable>"+data.hotelCellphone+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的地址:</lable>"+data.hotelProvince+data.hotelCity+data.hotelCounty+data.hotelOtherAddress+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的营业时间:</lable><br>"
	  						+"<em style=' float:left;font-family: 宋体;font-size: 10px;'>上午:</em>"+data.hotelShopAmStart+data.hotelShopAmEnd+"<br>"
	  						+"<em style=' float:left;font-family: 宋体;font-size: 10px;'>下午:</em>"+data.hotelShopPmStart+data.hotelShopPmEnd+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的注册时间:</lable>"+data.hotelTime+"<br>"
	  						+"<lable style=' float:left;font-family: 宋体;font-size: 10px;'>饭店的状态:</lable>"+hotelStatus+"<br>";
	  			$("#hotelmsg").html(hotelmsg);
	  		}
	  	)
	}
</script>


</head>
<body  background="<%=basePath %>image/bg.jpg">
<jsp:include page="../headfoot/head.jsp"></jsp:include>
	<table background="<%=basePath %>image/bg.jpg" align="center" width="80%">
		<tr>
			<td align="center">
				<font   style="font-family: 宋体; font-size: 40px;">美食种类管理</font>
			</td>
		</tr>
		<tr>
			<td>
				<table  width="100%" border="0" >
					<tr>
						<td >
							<div style="font-family: 宋体;font-size: 30px;">
								种类:
							</div>
						</td>
						<td>
							<div style="font-family: 宋体;font-size: 30px;">
							添加新种类
							</div>
						</td>
					</tr>
					<tr>
					<td width="60%" bordercolor="#ead">
							<table border="0" width="100%">
							<tr>
								<td>
								<s:updownselect 
									list="sortlist"  name="sortPojo.sortId"
									multiple="flase"	id="updownselectid"
									listKey="sortId" listValue="sortName"
									headerKey="-1" headerValue="-- 已存在的美食种类 --"
									allowMoveUp="true" moveUpLabel="↑"
									allowMoveDown="true" moveDownLabel="↓"
									allowSelectAll="false" selectAllLabel="全选"
									size="10"  onclick="buttonclick()"
								></s:updownselect><br>
								<!-- multiple="flase"表示单选  -->
								</td>
								<td width="70%" bordercolor="#bdf">
								<hr>
									<div style="width: 100%; height: 30px;margin-top: 0px;font-family: 宋体;font-size: 20px;">
										套餐所属饭店
									</div>
									<div id="hotelmsg" style="width: 100%; height: 300px; ">
										
									</div>
								</td>
							</tr>
							<form   method="post" id="updatesortForm">
							<tr>
								<td align="center" colspan="2">
								<hr>
									<div style="font-family: 黑体;font-size: 15px;">
										将
										<input type="text" size="20px" disabled="disabled"   placeholder="在先上面选择修改的套餐" id="needsort" name="sortPojo.sortName" style="padding: 7px 7px;">
										修改为
										<input type="text" size="20px"  placeholder="套餐修改后的名字" name="sortPojo.sortName" style="padding: 7px 7px;">
										<input type="hidden"  id="updatesortId" name="sortPojo.sortId"  >
										<input type="hidden" name="hotelPojo.hotelId"  id="hiddenhotelId"  >
									</div>
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2">
								<button type="submit" id="updateSort" style="padding: 10px 10px;">修改</button>
								</td>
							</tr>
							</form>
							</table>
						</td>
						<td bordercolor="red" >
						<form action="" method="post" id="savesortForm">
						<table  >
							<tr>
								<td>
									<div style="font-family: 仿宋; font-size: 20px;">
										<strong>所属饭店:</strong> 
										<s:if test="#session.user.power==1"> <!-- 网站管理员 -->
											<s:set name="url"><%=basePath %>asossh/autocompleter!hotelfill.action</s:set>
											<sx:autocompleter
												name="hotelName"  href="%{url}"  loadOnTextChange="true" 
												autoComplete="true"  showDownArrow="true" forceValidOption="true"
												id="autohotelname"  cssStyle="padding: 5px 5px ;margin-top: 10px; margin-bottom: 15px;"
											></sx:autocompleter>
										</s:if>
										<s:else>		<!-- 饭店管理员 -->
											 	${sortlist[0].hotelPojo.hotelName }
										</s:else>
									</div>
									<div>
									</div>
									<div>
									</div>
									<label style="font-family: 仿宋; font-size: 18px;">种类:</label>
									<input type="hidden" name="hotelPojo.hotelName" id="hotelNameid"  >
									<input type="hidden" name="hotelPojo.hotelId"  value="${hotelPojo.hotelId }" >
									<input type="text" name="sortPojo.sortName" style="padding: 5px 5px;"  id="sortNameid">
									<button type="button" id="saveSort" style="padding: 5px 5px;">添加</button>
								</td>
							</tr>
						</table>
						</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>		
	</table>
<jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
