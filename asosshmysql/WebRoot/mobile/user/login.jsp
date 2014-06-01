<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>手机版登录页面</title>
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <!-- name="viewport" 说明:强制让文档的宽度与设备的宽度保持1:1，并且文档最大的宽度比例是1.0，并且不允许用户点击屏幕放大浏览 -->
    <meta name="viewport"  content="with=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0;">
    <!-- name="apple-moblie-web-app-capable"代表的是iPhone(iPhone私有属性)设备中的safari私有meta标签 -->
   	<meta name="apple-moblie-web-app-capable" content="yes">
   	<!-- name="apple-mobile-web-app-status-bar-style"iPhone私有便签，它指定iPhone中safari顶端的状态条 -->
   	<meta name="apple-mobile-web-app-status-bar-style"  content="black">
   	<!-- name="format-decation" 告诉设备忽略将页面中的数字识别为电话号码 -->
   	<meta name="format-detection" content="telephone=no">

   <link rel="stylesheet" type="text/css" href="<%=basePath%>mobile/css/jquery.mobile-1.3.2.min.css"> 
   <link rel="stylesheet" type="text/css" href="<%=basePath%>mobile/_assets/css/jqm-demos.css"> 
   <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
   <script type="text/javascript" src="<%=basePath%>mobile/js/jquery-1.9.1.js"></script> 
   <script type="text/javascript" src="<%=basePath%>mobile/js/mymobile.js"></script>
   <script type="text/javascript" src="<%=basePath%>mobile/_assets/js/index.js"></script>
   <script type="text/javascript" src="<%=basePath%>mobile/js/jquery.mobile-1.3.2.min.js"></script>	
	<style type="text/css">
	body,a,div,span,img {
		margin: 0em 0em;
		font-family: 仿宋;
	}
	</style>
	<script type="text/javascript">
	/* $( document ).on( "click", "#sub", function() {
			$.mobile.loadingMessage="My custom message!";
			 var $this = $("#sub"),
			theme = $this.jqmData( "theme" ) || $.mobile.loader.prototype.options.theme,
			msgText = $this.jqmData( "msgtext" ) || $.mobile.loader.prototype.options.text,
			textVisible = $this.jqmData( "textvisible" ) || $.mobile.loader.prototype.options.textVisible,
			textonly = !!$this.jqmData( "textonly" );
			html = $this.jqmData( "html" ) || "";
			var un =$("#username").val().trim();
			var pw= $("#password").val().trim();
			if (un.length==0) {
			   messageshowfunction(400,theme,"请输入用户名",textVisible,textonly,html);
			}else if(pw.length==0){
				messageshowfunction(400,theme,"请输入密码",textVisible,textonly,html);
			}else{
			}   
		}); */
			  <%-- $.post("<%=basePath%>mobile/userMobile!userlogin.action", {"userPojo.username":un,"userPojo.password":pw},
				   function(data){
						if (data==1) {
						    msgText="登录成功";
						}else{
							 msgText="用户名或密码错误";
						}
				messageshowfunction(400,theme,msgText,textVisible,textonly,html);
			 });   --%>
			 $(document).bind("mobileinit",function(){
			 	 $("#registrationPage").live("pageinit",function(){
			 	 $("form").submit(function(){
					$.mobile.showPageLoadingMsg();
					$.ajax({
						url:"<%=basePath%>mobile/userMobile!userlogin.action",
						typr:"POST",
						dataType:"jsonp",
						jsonp:"jsoncallback",
						data:$("form#register").serialize(),
						success:function(response){
							alert("aa");
						},
						error: function( jqXHR, textStatus, errorThrown ) {
							$.mobile.hidePageLoadingMsg();
							console.log('Status: ' + textStatus + "\nError: " + errorThrown);
						}
					})
						return false;
			 	 })
			 	 })
			 });
			 function jsoncallback(){
			 alert("jsoncall");
			 	return true;
			 }
			 
			 
	</script>
  </head>
  
 <body>
   <div data-role="page"  id="registrationPage"  class="jqm-demos" data-quicklinks="true">
		<div data-role="header"  class="jqm-header" data-position="fixed">
			 <h1 style="text-align:center; font-size: 1.3em;margin: 0em 0em; font-family: 楷体;" class="jqm-logo">
			 	<a href="">
			 		<img  src="<%=basePath %>mobile/images/logo_mobile.jpg" 
			 		style=" max-height: 2.5em;max-width: 2.5em; min-height:2em;min-width:2.3em; margin-top:0.1em;border:0.1em solid #ff0000;border-radius:0.5em 0.5em ;" >
			 	</a>
			 		闻到食府网
			 </h1>
		</div>
		<div data-role="content"  class="jqm-content">
			    <form id="register" method="post">
			        <div style="padding:3.5em 2em; font-size: 1.1em; font-family: 仿宋;"   >
			            <h3 style="text-align: center; font-size: 1.5em; margin-top: -2em;">用户登录</h3>
			            <label for="un"  >用户名:</label>
			            <input type="text" name="user" id="username" maxlength="16" min="6" value=""  placeholder="username or email" data-theme="d"  required="required">
			            <label for="pw"  >密码:</label>
			            <input type="password" name="pass" id="password" value="" maxlength="20" placeholder="password" data-theme="d" required="required">
			            <fieldset class="ui-grid-a">
			           		<div class="ui-block-a" >
					             <input type="submit" value="登录 " data-theme="b"  id="sub"  >
			            	</div>  
			            	 <div class="ui-block-b">
								<button type="reset"  value="重置"  data-theme="c" ></button>
			            	</div>
			            </fieldset>
			            <div  class="ui-grid-solo">
			            	 <div class="ui-block-a">
			            		<a href="<%=basePath %>mobile/user/usergister.jsp"  data-role="button" data-theme="e"   data-ajax="false" rel="external">注册</a>
			            	</div>   
			            </div>
			            <div class="ui-grid-solo">
			            		<div class="ui-block-a">
			            			<a href="<%=basePath %>mobile/homeMobile!gotohome.action" data-role="button" data-theme="d" data-ajax="false" rel="external" >
			            				返回首页
			            			</a>
			            		</div>
			            </div>
					</div>
			    </form>
		</div>	
		<div data-role="footer"  class="jqm-footer">
			 <p style="text-align: center; ">
			 	Copyright 2013 The XUKAI Foundation<br>
			 	E-mail: makegoodsecret@sina.com
			 </p>
		</div>
	</div>
  </body>
</html>
