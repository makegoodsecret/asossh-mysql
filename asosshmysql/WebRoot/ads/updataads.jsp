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
 	 <title>闻道美食网--修改广告</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link rel="stylesheet" type="text/css" href="css/useregister.css"> -->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
    <style type="text/css">
	 	.formgoodsup{
	 		font-family: 仿宋;
	 		font-size: 20px;
	 	}
	 </style>
     <script type="text/javascript">
		$(function(){
		$("#images").change(function(){
			var src  ="<%=basePath%>asossh/ads!";
			if ($("#updateadsimage").val().trim().length==0) {  //上传图片
				src+="saveadsimage.action";
			}else{ //修改图片
				src+="updataadsimage.action";
			}
			 $("#myform1").ajaxSubmit({
				url:src,
				type:"post",
				beforeSubmit:validFunNameLogo,
				success:function(data ,type){
				if (data!="false") {
					var src ="<%=basePath%>photo/"+data+"?time="+new Date().getTime();
					$("#adsimageimg").attr("src",src);
					$("#gimageImageid").val(data);
					$("#updateadsimage").val(data)
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
	function subads(){
			messagerShow('正在修改');
			myform1.action="<%=basePath %>asossh/ads!isupdate.action";
			myform1.submit();
	}
	</script>
	</head>
<body  background="<%=basePath %>image/bg.jpg"  >
	<jsp:include page="../headfoot/head.jsp"></jsp:include>
	<form name="myform1" id="myform1"  class="formgoodsup"  action="<%=basePath %>asossh/ads!isupdate.action"  method="post"  enctype="multipart/form-data" >
	<table background="<%=basePath %>image/bg.jpg" align="center" width="90%" border="0">
		<tr><td colspan="2">
			<table align="center" width="100%">
				<tr align="center"><td><font size="6">修改广告</font></td></tr>
				<tr align="center"><td><hr color="ffdeee"/></td></tr>						
			</table>
			</td></tr>
		<tr>   
			<td width="50%">
			 <table border="0" width="60%" align="center">
					<tr>
					<td width="35%">
						<img src="<%=basePath %>photo/${adsPojo.adsImage}" id="adsimageimg"   width="200px" height="200px">
					</td>
					<td width="65%">
						<table width="100%" align="center" border="0">
							<tr>
								<td>广告的描述：</td>
								<td>
								 <textarea rows="2" class=f2_input name="adsPojo.adsDis" cols="35">${adsPojo.adsDis}</textarea>
								</td>
							</tr>
							<tr>
								<td>广告是否发布：</td>
								<td>
								<select name="adsPojo.adsStatu">
									<option value="0" ${adsPojo.adsStatu=='0' ?"selected=selected":""}>未发布</option>
									<option value="1" ${adsPojo.adsStatu=='1' ?"selected=selected":""}>发布</option>
								</select>
								</td>
							</tr>							
							<tr>
								<td>广告图片：</td>
								<td>
									<input type="file" name="images" id="images"/>
									<input type="hidden" value="${adsPojo.adsImage}" id="updateadsimage"  name="imagesname" >
									<input type="hidden" name="adsPojo.adsImage" id="gimageImageid">
								</td>
							</tr>														
							<tr>
								<td align="center" colspan="2">
								<input type="hidden" name="adsPojo.adsId" value="${adsPojo.adsId}">
									<button type="button" style="padding: 10px 30px ; " 
									onclick="subads()"
									 >修改</button>
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