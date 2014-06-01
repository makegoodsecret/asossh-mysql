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
 	 <title>闻道美食网--美食修改界面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link rel="stylesheet" type="text/css" href="css/useregister.css"> -->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<s:head/>
	<sx:head parseContent="true"/>
	
	<script type="text/javascript">
		$(function(){
			
				//把价格注入
			var prices=$("#prices").val();
			$("#price").val(prices/1);
			$("#price1").val((prices%1)*10/1);		//下拉赋值
			$("#price2").val((prices%1)*100%10);
			
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
			$("#goodsDis").val($("#dis").val());
			$("#goodsDis").blur(function(){
				$("#goodsDis").val($("#goodsDis").val().trim());
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
			myform1.action="<%=basePath %>asossh/goods!updatagoods.action"
			myform1.submit();
			messagerShow('修改成功正在跳转');
	}
	</script>
	
</head> 
<body  background="<%=basePath %>image/bg.jpg"  >
	<jsp:include page="../headfoot/head.jsp"></jsp:include>
	<form name="myform1"  id="myform1"   style="font-family: 仿宋;font-size: 20px;" method="post"  enctype="multipart/form-data" >
	<input type="hidden" value="${goodsPojo.hotelPojo.hotelId }" name="hotelPojo.hotelId">
	<table background="<%=basePath %>image/bg.jpg" align="center" width="90%" border="0">
		<tr>   
			<td width="50%">
				<table border="0" width="100%" align="center">
					<tr><td>
						<input type="hidden" name="goodsPojo.goodsId" value="${goodsPojo.goodsId}">
						<table align="center" width="100%">
							<tr align="center"><td><font size="6">修改美食</font></td></tr>
							<tr align="center"><td><hr color="eee"/></td></tr>	
						</table>
					</td></tr>
					<tr><td>
						<table align="left">
							<tr>
								<td width="400px" height="300px" align="center">
									<img alt="图片已经损坏" id="userimage" width="300px" height="100%" src="<%=basePath %>photo/<s:property value="goodsPojo.goodsImagePojo.gimageImage"/>">
								</td>
							</tr>
						</table>
						<table align="left">
							<tr>
								<td>菜名：</td><td><input type="text" id="goodsnameid" class=f2_input name="goodsPojo.goodsName" value="${goodsPojo.goodsName}"></td>
							</tr>
							<tr>
								<td>饭店名称:</td><td><input type="text" class=f2_input name="goodsPojo.hotelName"  value="${goodsPojo.hotelPojo.hotelName }"></td>
							</tr>							
							<tr>
								<td>种类：</td>
								<td>
								<s:set name="sortName">${goodsPojo.sortPojo.sortName }</s:set>
								<s:set name="typeurl" >
									<%=basePath %>asossh/autocompleter!Goodssortfill.action
								</s:set>
									<sx:autocompleter name="sortName" href="%{typeurl}"
										id="auto"  cssStyle="padding:5px 5px ;" 
										loadOnTextChange="true" loadMinimumCount="1" autoComplete="true"
										showDownArrow="true" value="%{sortName}"
									></sx:autocompleter>
								</td>
							</tr>
							<tr>
								<td>价格：</td>
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
								<div id="pricesmgs">价格为：&yen;&nbsp;${goodsPojo.goodsPrice}</div>
								<input type="hidden" id="prices" name="goodsPojo.goodsPrice" value="${goodsPojo.goodsPrice}">
								</td>
							</tr>													
							<tr>
								<td>菜谱描述：</td><td>
								<textarea rows="2" id="goodsDis" name="goodsPojo.goodsDis" cols="20" >
								</textarea>
									<input type="hidden" id="dis" value="<s:property value='goodsPojo.goodsDis' />">
								</td>
							</tr>		
							<tr>
								<td>菜谱图片：</td>
								<td>
									<input type="file" name="images" id="images"/>
									<input type="hidden" value="<s:property value="goodsPojo.goodsImagePojo.gimageImage"/>" id="updategoodsimage"  name="imagesname" >
								</td>
							</tr>	
						</table>
					</td>
					</tr>				
				<tr>
					<td align="center">
						<button type="button" style="padding: 10px 30px ; " 
									onclick="subgoods()"
									 >修改</button>
							<button type="button" style="padding: 10px 30px ; " 
									onclick="window.location.href='<%=basePath %>asossh/goods!showGoods.action'"
									 >返回 </button>		 
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
