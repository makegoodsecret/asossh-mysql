<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8") ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    
    <title>用户注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link rel="stylesheet" type="text/css" href="css/useregister.css"> -->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>

	<style type="text/css">
		.csborder{
				border: 1px double  blue;
		}
		.csborder2{
				border: 1px double  red;
		}
		.cs1{
			color: red;
			font-size: 10px;
		 }
		 .cs2{
			color: blue;
			font-size: 10px;
		 }
		 .csfontsize{
		 	font-size: 8px;
		 	font-size: 10px;
		 }
		 #unmsg{
		 	height: 60
		 }
		.user_item {
				height: 60px;width: 500px;
				margin-right: auto;
				margin-left: auto;
				}
   		 .user_item span {
   		 			line-height: 30px;float: left;
   		 			height: 30px;width: 100px;
   		 			display: block;text-align: right;
   		 }
		 .userreg{
		 		background-image:<%=basePath %>image/bg.jpg;
		 		width: 90%;
		 		margin-left: 5%;
		 		font-family: 宋体;
		 }
		 .user_input{
		 		font-family: 宋体;
		 		font-size: 20px;
		 }
		 #sbr{
		 	width: 300px;
		 	margin-left: 33%
		 }
		 .user_attention{
			 width: 300px;
		 	margin-left: 35%
		 }
		 .user_passcode {
			 display: block;height: 13px !important;_height: 11px;
			 width: 104px;float: left;background-image: url(images/pwdstrength.gif);
			 background-repeat: no-repeat;background-position: left 60px;padding: 0px;
			 margin-top: 3px;margin-right: 0px;margin-bottom: 0px;margin-left: 0px;
		 }
		 .user_input {
		 			float: left;line-height: 28px;height: 60px;padding-left: 10px;width: 300px;
		 			}
		 .f2_input{
		 		float: right;
		 		 size: 20;
		 		 padding: 5px 5px 5px 5px ;
		 		
		 }
   		 .user_txt {
   		 			height: 24px;width: 200px;border: 1px solid #CCC;
   		 			background-color: #FFF;outline: 1px solid #FFF;
   		 			line-height: 24px;color: #333;text-decoration: none;
   		 			padding-right: 5px;padding-left: 5px;float: left;
   		 			}
     
    	.user_input div {
    					height: 30px;padding-top: 2px;
    					}
    	.user_passok {
    				background-image: url(images/passok.gif);background-position: center center;
    				display: block;height: 30px;width: 30px;float: left;background-repeat: no-repeat;
    				}
    	.user_passmessage {
    						line-height: 18px;float: left;padding-right: 5px;padding-left: 5px;color: #888;
    						}
    	  .user_btton {
    	  			height: 30px;width: 500px;padding-left:5px;padding-top: 10px; margin-left: 7%;
    	  			}
		   .user_btton input {background-image: url(images/btnn.jpg);
		    		height: 30px;width: 100px;font-size: 14px;font-weight: bold;
		    		color: #FFF;text-decoration: none;margin: 0px;padding: 0px;
		    		border-top-style: none;border-right-style: none;border-bottom-style: none;
		    		border-left-style: none;cursor: pointer;
    		}
	</style>
	<script type="text/javascript">
			function ajaxusername(){
				var uname = $("#username").val();	//取出用户输入的用户名
				if (uname.length==0) {
					$("#msgusername").html("用户名不能为空.").css("color","#F00");
					return false;
				}else{
	 				$.ajax({
	 					"url":"<%=basePath%>asossh/userlogin!checkgister.action",
	 					"type":"post" ,  
	 					"data":{"userPojo.username":uname},
	 					 "success":function(data,type){
		 					 if(data=="false"){
		 					 	$("#msgusername").html("用户名"+uname+"已经存在.").css("color","#F00");
		 					 	return false;
		 					 }else{
		 						$("#msgusername").html("<img src='<%=basePath%>image/passok.gif' />");
		 						return true;
		 					 }
	 					 },
	 					 "error":function(XMLHttpRequest, textStatus, errorThrown){
	 						$("#msgusername").html("在线验证失败").css("color","#F00");
	 					 }
	 				});
	 				return true;
 				}
			}
			function userpassword(){ 
				var password= $("#password").val().trim().length;
				if (password<6||password>16) {
					$("#msgpassword").html("<img src='<%=basePath%>image/usererror.gif'/>密码错误格式").css("color","#F00");
					return false;
				}else{
					$("#msgpassword").html("<img src='<%=basePath%>image/passok.gif' />");
					return true;
				}
			}
		function reuserpassword(){  
			var   repassword = $("#repassword").val().trim();
			var    password  = $("#password").val().trim();
			if(repassword==password){ 
				$("#msgrepassword").html("<img src='<%=basePath%>image/passok.gif' />");
				return true;
			}else{
				$("#msgrepassword").html("<img src='<%=basePath%>image/usererror.gif' />两次输入的密码不一致</p>").css("color","#F00");
				return false;
			};
		};
		//验证邮箱
		 function userEmail(){
			var email  =$("#uEmail").val().trim();
			//var pattern_e=/^\w+([-\.]\w)*@\w+([\.-]\w)*\.\w{2,4}$/;
		 	var pattern_e = /^(([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+)|(1[3458]\d{9})$/;
			if(pattern_e.exec(email)){
				$.ajax({
		 			"url":"<%=basePath%>asossh/userlogin!useremail.action",
		 			"type":"post" ,  
		 			"data":{"useremail":email},
		 			"success":function(data,type){
		 		 	if(data=="true"){
				 		$("#email").html("<img src='<%=basePath%>image/passok.gif' />");
						return true;
 					 }else{
 					 	$("#email").html("该邮箱已经注册").css("color","#F00");
 					 	return false;
 					 };
 					 },"error":function(){
 						$("#codemsg").html("无法验证").css("color","#F00");
 					 }
 				});
 				return true;
			}else{
				$("#email").html("<img src='<%=basePath%>image/usererror.gif' />邮件格式不对").css("color","RED");
				return false;
			};
		};
  //性别的验证
		 function changeuSex(){
		 		var sex = $("#uSex").val();
		 		if (sex==0) {
					$("#sexmsg").html("<img src='<%=basePath%>image/usererror.gif' />请选择性别").css("color","RED");
					return false;
				}else{
					$("#sexmsg").html("<img src='<%=basePath%>image/passok.gif' />");
					return true;
				}
		};
   //验证码的验证
		 function codesession(){
			var  code = $("#code").val().trim();
			$.ajax({
		 			"url":"<%=basePath%>asossh/userlogin!code.action",
		 			"type":"post" ,  
		 			"data":{"code":code},
		 			"success":function(data,type){
		 		 	if(data=="true"){
				 		$("#codemsg").html("<img src='<%=basePath%>image/passok.gif' />");
				 		return true;
 					 }else{
 					 	$("#codemsg").html("验证码错误").css("color","#F00");
 					 	return false;
 					 };
 					 },"error":function(){
 						$("#codemsg").html("无法验证").css("color","#F00");
 					 }
 				});
 				return true;
		};	
		$(function(){
		    //获取焦点文本框变化
			$(".f2_input").each(function(){
					$(this).bind("focus",function(){
					$(this).addClass("user_txtfocus");
				}).bind("blur",function(){
					$(this).removeClass("user_txtfocus");
				});
			});
			$("#username").keyup(function(){				//当用户按下弹起键时统计出输入的个数
				var str = $(this).val().trim();
				var reg = /[^\u4E00-\u9FA5\uf900-\ufa2d]/g;  //匹配非中文的正则表达式 
				var regzg = /[^\x00-\xff]/g ; 				//匹配中文的正则表达式
				var temp = str.replace(reg, '').length;		
				var tempzg = str.replace(regzg, '').length;	//统计出中文个数
				var  length = temp*2+tempzg;
				if(length<5){
					$("#msgusername").html("还需输入"+(5-length)+"个字符").css("color","#888");
				}else if(length<26){
	 				//使用ajax验证用户是否存在
	 				 ajaxusername();
				}else{
					$("#msgusername").html("输入超出"+(length-25)+"个字符").css("color","#F00");
				}
			});
	//密码验证	
		$("#password").keyup(function(){
			//验证密码的强度
			var user_password  = $(this).val();
			var pattern_d  =/^\d+$/;				//全部为数字
			var pattern_s  =/^[A-Za-z]+$/;				//全为字符
			var pattern_w  =/^\w+$/;					//数字或者字符
			var pattern_W  =/^\W+$/;					//全为数字也非字符
			var pattern_r  =/^\w+\W+[\w\W]*\w+$/;		//以字母或数字开头结尾的字符串
			var x=0;									//用于判断强度			
			var y=0;     
			var imgsize   = "60px";
			if(pattern_W.exec(user_password)){x=0;y=0; }
			if(pattern_w.exec(user_password)){x=0;y=1; }
			if(pattern_d.exec(user_password)){x=1;y=0; }
			if(pattern_s.exec(user_password)){x=2;y=0; }
			if(pattern_r.exec(user_password)){x=3;y=2; }
			if( x == 0 && y == 0) {  
                    imgsize = '-26px';  //安全级别《高》带特殊符号
              }  
             if( x > 0 && y == 0) {  
                 imgsize = '0';  	//安全级别《低》
             }  
             if( x == 0 && y == 1) {  
                 imgsize = '-13px';  //安全级别《中》
             }  
             if( y == 2) {  
                 imgsize = '-26px';  //安全级别《高》
             }  	
			if ($(this).val().trim()==""||$(this).val().trim().length<6||$(this).val().trim().length>16) {
				 $(".user_passcode").css("background-position","");
				$("#msgpassword").html("<img src='<%=basePath%>image/usererror.gif'/>密码错误格式").css("color","#F00");
			}else{
				$("#msgpassword").html("");
	            $(".user_passcode").css("background-position","left " +imgsize);
	            var   repassword = $("#repassword").val().trim();
	            if (repassword.length!=0) {
		            reuserpassword();
				}
			}
		});
		
		//其他表单验证
		$("#username").change(function(){ajaxusername();});
		$("#password").change(function(){userpassword();});
		$("#repassword").change(function(){reuserpassword();});
		$("#uSex").change(function(){changeuSex();});
		$("#uEmail").change(function(){userEmail();});
		$("#code").change(function(){codesession();});
		//提交需要验证的
		$("#useregisterform").submit(function(){   
			 $(this).ajaxSubmit({
			 	url:"<%=basePath%>asossh/userRegister!save.action",
			 	type:"post",
			 	beforeSubmit:validFunName,
			 	success:function(data,type){
			 		if (data!=0) {
						messagerShow("注册成功");	
						window.location.href = "<%=basePath%>asossh/userlogin!getemail.action?userPojo.userId="+data;
						messagerShow("发送激活用户邮件中……");	
					}else{
						messagerShow("注册失败");	
					}
			 	},error:function(XmlHttpRequest, textStatus, errorThrown){
		 				messagerShow("与服务器连接出错了");
		 			}
			 });
			 return false;
		});
	});
	function  validFunName(){ 
		if (ajaxusername()&&userpassword()&&reuserpassword()&&changeuSex()&&codesession()&&userEmail()) {
			messagerShow("正在提交数据");
			return true;
		}else{
			return false;
		}
		
	}
	 
</script>
  </head>
  <body  background="<%=basePath %>image/bg.jpg">
<!--头  -->
 	<jsp:include page="../headfoot/head.jsp"></jsp:include>
    <form  method="post"  id="useregisterform" name="myform" >
    <s:token></s:token>
 	<div class="userreg">
 	<br><br><br>
 	<div style="clear:both"></div>
 	  <div class="user_item">
         <div class="user_input">
       	 <label>用户名:<font color="RED">*</font></label>
         	<input type = "text" placeholder="请输入用户名" id = "username" class=f2_input name = "userPojo.username" title="建议使用中文用户名" >
		</div>
			 <p class="user_passmessage" id="msgusername"></p>
		</div>
	 <div style="clear:both"></div>
	 
	 <div class="user_item">
        <div class="user_input">
        <label> 密码:<font color="RED">*</font></label>
        <input type ="password" id = "password" placeholder="password" class=f2_input name = "userPojo.password" title="注意密码格式，长度为6－16位" >
        </div>
        <p class="user_passmessage" id="msgpassword"></p><b class="user_passcode"></b>
       </div>
         <div style="clear:both"></div>
      <div class="user_item">  
        <div class="user_input">
        <label>确认密码:<font color="RED">*</font></label>
         <input type ="password" id = "repassword" placeholder="确认输入密码"  class=f2_input name = "repassword" title="确认密码与密码相同">
      	</div>
         <p class="user_passmessage" id="msgrepassword"></p>
      </div>
      
       <div class="user_item">  
        <div class="user_input">
       		 <label>性别:<font color="RED">*</font></label>
		       <select id="uSex" name="userPojo.sex" class=f2_input placeholder="11">
		       <option value="0">请选择性别</option>
		       <option value="1">男</option>
		       <option value="2">女</option>
		       </select>
			</div>
		 <p class="user_passmessage" id="sexmsg"></p>
      </div>
      <div class="user_item">  
         <div class="user_input">
	     	 <label>QQ:</label> 
       		<input type="text" name = "userPojo.qq" placeholder="腾讯给你的ID"  class=f2_input  title="QQ号全为数字 并且不能超过12位"   >
			</div>
		<p class="user_passmessage"></p>
      </div>
 	<div class="user_item">  
         <div class="user_input">
    	<label>邮箱<font color="RED">*</font></label>
    	<input type="text" id="uEmail" class=f2_input  name="userPojo.email"  
    		placeholder="邮箱非常重要"
    		title="此邮箱是用来接受注册时激活使用,请务必填写正确的邮箱否则收不到激活邮件">
			</div>
		<p class="user_passmessage" id="email"></p>
      </div>
 	<div class="user_item">  
         <div class="user_input">
	    	<label>验证码:<font color="RED">*</font></label>
		        <input id="code" type = "text" placeholder="验证码不填你提交试试看" style="float: right;"   class=f2_input name = "code">
		</div>
	    	<div style="float: left;">
	    	<img alt="验证码" title="看不清点击换一个试试"  style="float: left;"  src="<%=basePath%>image.jsp"  onclick="document.getElementById('recode').src='<%=basePath%>image.jsp?'+Math.random()" id="recode" >
	 		<p class="user_passmessage" id="codemsg"  ></p>
	 		</div>
	</div>
	
	<div style="clear:both"></div>
    <div class="user_attention"><font size="2">注意：只有填写完整才能注册(</font><font color="RED">*</font><font size="2">为必填项)</font></div>
    <div class="user_item">
		    <div class="user_btton"   align="left">
		     <input type = "reset" value = "重置"  class="btn" >
		 	<input type ="submit" value="注册" id="submit" class="btn" >
		 	<a href="<%=basePath %>index.jsp"  ><input type ="button" value="返回首页"  class="btn" ></a>
		    </div>
    </div>
    <br><br>
	</div>
    </form>
    <jsp:include page="../headfoot/footer.jsp"></jsp:include>
  </body>
</html>
