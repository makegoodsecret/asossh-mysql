<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>闻道美食网--管理员登录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" rel=stylesheet href="<%=basePath%>css/messageShow.css">
<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
		font-size: 12px;
	}
	</style>
<script type=text/javascript>
		/*操作提示信息框*/
       function  messagerShow(messager){
      	 if ($('.msgbox_layer_wrap')) {
				$('.msgbox_layer_wrap').remove();
			}
		$("body").prepend("<div class='msgbox_layer_wrap'>"+
							"<span id='mode_tips_v2' style='z-index: 10000;' class='msgbox_layer'>"+
							"<span class='gtl_ico_clear'></span>"+messager+"<span class='gtl_end'></span></span></div>");
			$(".msgbox_layer_wrap").show();
       var st = setTimeout(function (){
				$(".msgbox_layer_wrap").hide();
				clearTimeout(st);
			},1500);
       }
		
		function validFunName(){
				var username = $("#username").val().trim();
				var password = $("#password").val().trim();
				var regzg = /[^\u4E00-\u9FA5\uf900-\ufa2d]/g ; 				//匹配中文的正则表达式
				if (username.length<=0) {
					$("#usernamemsg").html("管理员名称不能为空").css("color","red");
					messagerShow("管理员名称不能为空");
					return false;
				}else if(!isNaN(username)&&username.indexOf(".")<-1){
					$("#usernamemsg").html("管理员名称不能为纯数字").css("color","red");
					messagerShow("管理员名称不能为纯数字");
					 return false;
				}else if(!(/^[a-z0-9_-]{2,16}$/.test(username))&&(username.replace(regzg,'').length<=1)){
					messagerShow("管理员名称为2-16位的字母、数字、_或中文组成");
					$("#usernamemsg").html("管理员名称为2-16位的字母、数字、_或中文组成").css("color","red");
					 return false;
				};
				if (password.length<=0) {
					$("#passwordmsg").html("密码不能为空").css("color","red");
					messagerShow("密码不能为空");
					return false;
				}
		}
		$(function(){
			$("#myformuserlogin").submit(function(){ 
					$("#msg").html("");
					$("#usernamemsg").html("*").css("color","red");
					$("#passwordmsg").html("*").css("color","red");
				 $(this).ajaxSubmit({
				 	url:"<%=basePath%>asossh/userlogin!adminuserexist.action",
		 			type:"post" , 
		 			beforeSubmit:validFunName,
		 			success:function(data,type){
		 				if (data=="true") {
							$("#msg").html("正在登录...").css("color","green");
							messagerShow("登录成功正在跳转……");	
							 var href="<%=basePath %>asossh/index!showIndex.action?userlat=30.0&userlon=120.1";
							formsubmit(href);//提交为post 
					    	//获取用户当前城市的经纬度
						 	var userlat = geoip_latitude(); //纬度
							var userlon = geoip_longitude(); //经度
							  href="<%=basePath %>asossh/index!showIndex.action?userlat="+userlat+"&userlon="+userlon;
							formsubmit(href);//提交为post   
						}else{
							messagerShow("管理员名称或密码错误");	
							$("#msg").html("管理员名称或密码错误").css("color","red");
						}
		 			},error:function(XmlHttpRequest, textStatus, errorThrown){
		 				messagerShow("与服务器连接出错了");
		 				$("#msg").html("与服务器连接出错,请稍后再试或检查你的网络状况").css("color","red");	
		 			}
				 });
		 			return false;
			});
		})
		
</script>
</head>
<body  background="<%=basePath %>image/bg.jpg">
  <jsp:include page="../headfoot/head.jsp"></jsp:include>  
	<table align="center" width="90%" background="<%=basePath %>image/bg.jpg"><tr><td>
			<form   id="myformuserlogin"    method="post">
			<input type="hidden" name="action" value="login" ></input>
			<table width="40%" align="center" border="0">
				<tr align="center">
					<td colspan="3">
						<div style="margin-top:20px ;margin-bottom: 15px; margin-left: 65px; float: left;" >
							<font size="5" color="#B72E03" style="font-family: 黑体" >闻道美食网管理员登录界面</font>
						</div>
					</td>
				</tr>
						
						<tr align="center">
							<td width="100px">
								<label style="margin-right: 5px; float: right;"><font size="3" >管理员:</font></label>
							</td>
							<td  width="200px">
								<input type="text" class=f2_input name="userPojo.username" id="username"
								style="padding: 7px 7px" placeholder="Administrator Name"
								>
							</td>
							<td width="150px">
								<div id="usernamemsg" style="float: left;" ><font color="red">*</font> </div>
							</td>
							
						</tr>
						<tr align="center">
							<td width="100px">
								<label style="margin-right: 5px; float: right;"><font size="3">密&nbsp;&nbsp;码:</font></label>
							<td  width="200px">
							<input type="password" class=f2_input name="userPojo.password" id="password" 
							style="padding: 7px 7px" placeholder="Password"
							>
							</td>
							<td width="150px">
							<div id="passwordmsg" style="float: left;" ><font color="red">*</font></div>
							</td>
						</tr>
						<tr >
							<td colspan="3">
								<div class="meneame" style="height: 40px">
									<button type="submit" 
										style="padding: 10px 10px ; margin-left:80px;  margin-top :10px; float: left;"
										>登录</button>
									<button type="button"  onclick="  if(window.confirm('注册用户需要同意网站协议才能注册，你想好了吗？')){window.location.href='<%=basePath%>asossh/userlogin!gettreaty.action';}" 
										style="padding: 10px 10px ; margin-left:30px; margin-top :10px; float: left;"
										>注册</button>
									 <button type="button"  onclick="window.location.href='<%=basePath%>index.jsp';" 
										style="padding: 10px 10px ; margin-left:30px;margin-top :10px; float: left;"
										>去首页</button>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;
								<div id="msg"></div>
							</td>
						</tr>
					</table>
					<br><br><br><br><br><br><br><br><br><br>
			</form>
	</td>
	</tr>
	<tr>
</table>
	<jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>