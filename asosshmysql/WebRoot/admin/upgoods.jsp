<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
 	 <title>闻道美食网--上传美食</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link rel="stylesheet" type="text/css" href="css/useregister.css"> -->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	
	<s:head/>
	<sx:head parseContent="true" extraLocales="zh-tw"/> 
	 <style type="text/css">
	 	.formgoodsup{
	 		font-family: 仿宋;
	 		font-size: 20px;
	 	}
	 </style>
	<script type="text/javascript">
		$(function(){
			$("#price").focus(function(){
			if($("#price").val().trim()==0){
				$("#price").val("");
			}
				$("#price").keyup(function(){
				if(($("#price").val().trim()/1)==0){
					$("#price").val("0");
				}else if(isNaN($("#price").val().trim())){
					alert("请输入数字");
				}else{
					var prices =$("#price").val().trim()*1+"."+$("#price1").val().trim()+$("#price2").val().trim();
					$("#price").val($("#price").val().trim()*1);
					$("#prices").val(prices);
					$("#pricesmgs").html("你输入的价格为：&yen;&nbsp;"+prices);
				};
				});
			}).blur(function(){
				if($("#price").val().trim()==""){
				$("#price").val(0);
			}
			});
			$("#price1").change(function(){
				var prices =$("#price").val().trim()+"."+$("#price1").val().trim()+$("#price2").val().trim();
					$("#prices").val(prices);
					$("#pricesmgs").html("你输入的价格为：&yen;&nbsp;"+prices);
			});
			$("#price2").change(function(){
				var prices =$("#price").val().trim()+"."+$("#price1").val().trim()+$("#price2").val().trim();
					$("#prices").val(prices);
					$("#pricesmgs").html("你输入的价格为：&yen;&nbsp;"+prices);
			});
			
		$("#images").change(function(){
			var src  ="<%=basePath%>asossh/goods!";
			if ($("#updategoodsimage").val().trim().length==0) {  //上传图片
				src+="savegoodsimage.action";
			}else{ //修改图片
				src+="updatagoodsimage.action";
			}
			 $("#myform1").ajaxSubmit({
				url:src,
				type:"post",
				beforeSubmit:validFunNameLogo,
				success:function(data ,type){
				if (data!="false") {
					var src ="<%=basePath%>photo/"+data+"?time="+new Date().getTime();
					$("#userimage").attr("src",src);
					$("#gimageImageid").val(data);
					$("#updategoodsimage").val(data)
				}else{
					 messagerShow("<font color='RED' size='2'>操作失败</font>");
				}
				},error:function(XmlHttpRequest, textStatus, errorThrown){
					 messagerShow("<font color='RED' size='2'>出错了</font>");
				}
			});
	 		
		});
		});
		
		 //上传图片的验证方法
	function validFunNameLogo(){    
			var imge=$("#images").val().trim(); 
			var strlist=imge.split(".");
	 		var imgesuffix="BMP、JPG、JPEG、PNG、GIF";
	 		if(imgesuffix.indexOf(strlist[1].toUpperCase())==-1){
	 		 	 messagerShow("<font color='RED' size='2'>上传的图片格式为BMP、JPG、JPEG、PNG、GIF</font>");
	 		 	return false;
	 		};
	 		return true;
		}
	function subgoods(){
		var goodsnameid=$("#goodsnameid").val().trim();
		var prices=$("#prices").val().trim();
		var sortname=dojo.widget.byId("auto").getText();
		if (goodsnameid.length==0) {
			messagerShow('美食名字不能为空');
			return false;
		}
		if (sortname.length==0) {
			messagerShow('美食种类不能为空');
			return false;
		}
		 if (prices.length==0) {
			messagerShow('美食价格不能为空');
			return false;
		}
			myform1.action="<%=basePath %>asossh/goods!save.action";
			myform1.submit();
			messagerShow('添加成功正在跳转');
	}
	function selecthotel(){
		var hotelautoname=dojo.widget.byId("hotelauto").getText();
		$("#selecthotelhidden").val(hotelautoname);
		$("#selecthotelbutton").attr("disabled",true);
		 
	}
	</script>
	
</head> 
<body  background="<%=basePath %>image/bg.jpg"  >
	<jsp:include page="../headfoot/head.jsp"></jsp:include>
	<form name="myform1" id="myform1"   class="formgoodsup" method="post"  enctype="multipart/form-data" >
	<table background="<%=basePath %>image/bg.jpg" align="center" width="90%" border="0">
		<tr><td colspan="2">
			<table align="center" width="100%">
				<tr align="center"><td><font size="6">上传美食</font></td></tr>
				<tr align="center"><td><hr color="#eee"/></td></tr>						
			</table>
			</td></tr>
		<tr>   
			<td >
			<input type="hidden" value="${user.userId }" name="userPojo.userId" >
				<table border="0" width="60%" align="center">
					<tr>
					<td width="35%">
						<img  id="userimage"   width="200px" height="200px">
					</td>
					<td width="65%">
						<table width="100%" align="center" border="1">
							<tr>
								<td nowrap="nowrap">菜名：</td>
								<td><input type="text" id="goodsnameid" class=f2_input name="goodsPojo.goodsName"></td>
							</tr>
							<tr>
								<td nowrap="nowrap">饭店名称:</td>
								<td>
									<s:set name="hotelPojosessionisempty">${hotelPojosession.hotelName==null }</s:set>
									<s:if test="#hotelPojosessionisempty">
								 	<s:set name="typeurl" >
										<%=basePath %>asossh/autocompleter!hotelfill.action
									</s:set>
									<sx:autocompleter name="hotelPojo.hotelName" href="%{typeurl}"   
										loadOnTextChange="true" loadMinimumCount="1" autoComplete="true"
										showDownArrow="true" forceValidOption="true"  cssStyle="padding:5px 5px ;" 
										id="hotelauto"
									></sx:autocompleter>
									<!--  forceValidOption="true"   只接受
											loadOnTextChange="true" 清除缓存
									-->
									</s:if>
									<s:else>
										${hotelPojosession.hotelName }
										<input type="hidden" value="${hotelPojosession.hotelName }" name="hotelPojo.hotelName">
									</s:else>
								</td>
							</tr>							
							<tr>
								<td nowrap="nowrap">种类：</td>
								<td>
								<s:set name="typeurl" >
										<%=basePath %>asossh/autocompleter!Goodssortfill.action
									</s:set>
									<sx:autocompleter name="sortPojo.sortName" href="%{typeurl}"
									 	 id="auto"  cssStyle="padding:5px 5px ;" 
										loadOnTextChange="true" loadMinimumCount="1" autoComplete="true"
										showDownArrow="true" forceValidOption="true"   
									></sx:autocompleter>
								</td>
							</tr>
							<tr>
								<td nowrap="nowrap">价格：</td>
								<td>
								<input type="text" size="5" id="price" name="price" value="0">
								.
								<select name="price1" id="price1">
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								</select>
								<select name="price2" id="price2">
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								</select>
								<div id="pricesmgs">你输入的价格为：&yen;&nbsp;0.00</div>
								<input type="hidden" id="prices" name="goodsPojo.goodsPrice">
								</td>
							</tr>													
							<tr>
								<td nowrap="nowrap">菜谱描述：</td><td><textarea rows="7" class=f2_input name="goodsPojo.goodsDis" cols="29"></textarea></td>
							</tr>
							<tr>
								<td nowrap="nowrap">菜谱图片：</td>
								<td>
									<input type="file" name="images" id="images"/>
									<input type="hidden" value="" id="updategoodsimage"  name="imagesname" >
									<input type="hidden" name="goodsImagePojo.gimageImage" id="gimageImageid">
								</td>
							</tr>														
							<tr>
								<td align="center" colspan="2">
									<button type="button" style="padding: 10px 30px ; " 
									onclick="subgoods()"
									 >提交</button>
								</td>
							</tr>		
						</table>
					</td>
					</tr>				
				</table>
			</td>
		</tr>			
	</table>
</form>
<jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
