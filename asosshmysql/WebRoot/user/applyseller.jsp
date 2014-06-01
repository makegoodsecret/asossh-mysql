<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>申请成为卖家的界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> 
 <script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
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
 	 //上传图片的验证方法
	function validFunNameLogo(applySellerimageid){   
			var imge=$("#"+applySellerimageid).val().trim(); 
			var strlist=imge.split(".");
	 		var imgesuffix="BMP、JPG、JPEG、PNG、GIF";
	 		if(imgesuffix.indexOf(strlist[1].toUpperCase())==-1){
	 		 	 messagerShow("<font color='RED' size='2'>上传的图片格式为BMP、JPG、JPEG、PNG、GIF</font>");
	 		 	return false;
	 		};
	 		return true;
		}
	//提交饭店logo图片
	function  onformapplySellerLogo(){
		ajaxsubmitimage("formapplySellerLogo","applySellerLogonameid","applySellerLogo",
						"applySellerlogoimg","applySellerlogesubid");
		}
	function onformapplySellerCertificate(){
		ajaxsubmitimage("formapplySellerCertificate","applySellerCertificatenameid",
						"applySellerCertificate","applySellerCertificateimg","applySellerCertificatesubid");
		};
	function  ajaxsubmitimage(formName,applySellerimageidvalue,applySellerimageid,applySellerimgshow,applySellerimgsubmitid){
		var src  ="<%=basePath%>asossh/applySeller!";
			if ($("#"+applySellerimageidvalue).val().trim().length==0) {  //上传图片
				src+="saveapplySellerimage.action";
			}else{ //修改图片
				src+="updataapplySellerimage.action";
			}
		if(validFunNameLogo(applySellerimageid)){ 
			$("#"+formName).ajaxSubmit({
				url:src,
				type:"post",
				success:function(data ,type){
				if (data!="false") {
					var src ="<%=basePath%>photo/"+data+"?time="+new Date().getTime();
					$("#"+applySellerimgshow).attr("src",src);
					$("#"+applySellerimageidvalue).val(data);
					$("#"+applySellerimgsubmitid).val(data);
				}else{
					 messagerShow("<font color='RED' size='2'>操作失败</font>");
				}
				},error:function(XmlHttpRequest, textStatus, errorThrown){
					 messagerShow("<font color='RED' size='2'>出错了</font>");
				}
			});
		};
	}
 
 </script>
  </head>
  
<body   background="<%=basePath %>image/bg.jpg" >
<!-- 隐藏域只能进入首页一次跳到action中读数据 -->
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div class="classmain">
		 <div style="text-align:center; border: 2px solid #eee;border-radius:10px 10px 10px 10px ;">
		 	申请成为卖家
		 </div>
		 <div style="text-align:left; border: 1px solid #aa0000;border-radius:10px 10px 10px 10px ;">
			<label>条件:</label>
			1.饭店卫生许可证<br>
			2.饭店的logo.
			3.申请成功后还需注册饭店，需一个有效的跟申请人绑定的支付宝账号.
		 </div>
		<div style="width: 100% ; height: 160px;" >
			<div style="float:left; border:1px solid #abcdef; display: inline;width: 30%  ; height: 160px;">
				<form id="formapplySellerLogo" method="post" enctype="multipart/form-data">
					<span>
					<font color="RED"  >*</font>
					<font style="font-family: 微软雅黑 ;font-size: 15px;">申请饭店的商标(图片)</font><br>
					<input type="file" id="applySellerLogo" name="images" style="height: 40px;width: 250px"  onchange="onformapplySellerLogo()" > 
					<input type="hidden" id="applySellerLogonameid" name="imagesname" >
					</span>
				</form>
				<hr>
				<form id="formapplySellerCertificate" method="post" enctype="multipart/form-data">
				<span>
					<font color="RED"  >*</font>
					<font style="font-family: 微软雅黑;font-size: 15px;">申请饭店的证书(图片)</font><br>
					<input type="file" id="applySellerCertificate" name="images" style="height: 40px;width:250px" onchange="onformapplySellerCertificate()" > 
					<input type="hidden" id="applySellerCertificatenameid" name="imagesname" >
				</span>
				</form>
			</div>
			<div style="float:left; border:1px solid #abcdef; display: inline; width: 34% ; height: 160px;">
				<img alt="选择上传饭店的logo" src=""  width="100%" height="160px;" id="applySellerlogoimg">
			</div>
			<div style="float:left; border:1px solid #abcdef; display: inline; width: 34% ; height: 160px;">
				<img alt="选择上传饭店的许可证" src=""  width="100%" height="160px;" id="applySellerCertificateimg">
			</div>
		</div>
		<div style=" clear: both;border:1px solid #abcdef; width: 100% ;   ">
				 <div  style="width: 100%;">
				 	申请饭店logo与许可证为必填项。
				 	申请的结果将会在2——5天内，经过人工审核，审核结果将以邮件的形式提醒.
				 </div>
				 <form action="<%=basePath %>asossh/applySeller!saveapplySeller.action" method="post" >
				 <div style="width: 100%; text-align: center;">
					 <input type="hidden" id="applySellerlogesubid" name="applySellerPojo.applysellerLogo" >
					 <input type="hidden" id="applySellerCertificatesubid" name="applySellerPojo.applysellerCertificate" >
				 	<button type="submit" style="padding: 10px 40px;"  onclick="messagerShow('成功提交申请');" >提交</button>
				 </div>
				 </form>
		</div>
	</div>
<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
</body>
</html>
 
