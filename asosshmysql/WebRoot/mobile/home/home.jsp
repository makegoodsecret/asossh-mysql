<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>闻到食府网(手机版)主页</title>

      <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport"  content="with=device-width,initial-scale=1">
   
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
 .navmenu-login{
	border: 0.1em solid #660000;
 	border-radius:0.5em 0.5em;
 	padding: 0.1em 0.1em;
 	text-decoration:none;
 }
  .navmenu-login:HOVER {
 	border: 0.1em solid #ff0000;
}
.header-navmenu-login{
	background: #fff;
	color: #777;
	text-shadow: 0 1px 0 #fff;
	-webkit-box-shadow: 0 0 5px rgba(0,0,0,.15);
	-moz-box-shadow: 0 0 5px rgba(0,0,0,.15);
	box-shadow: 0 0 5px rgba(0,0,0,.15);
}
	 </style>
  </head>
  
 <body>
<div data-role="page" class="jqm-demos"  data-quicklinks="true">
		<div data-role="header"  class="jqm-header" data-position="fixed">
			<div style="header-navmenu-login">
				<a href="#nav-panel" class="navmenu-login" data-icon="bars"   >网站导航</a>
				 	<abbr style="font-family: 楷体; font-size: 1.2em; ">闻到食府网(手机版)</abbr>
				 <a href="#add-form" class="navmenu-login" data-icon="gear" data-iconpos="notext">登录</a>
			</div>
			<div class="semented-control ui-bar-d">
				<div data-role="controlgroup" data-type="horizontal">
					<a href="#" data-role="button" class="ui-control-active">
						AAAA
					</a>
					<a href="#" data-role="button" class="ui-control-active">
						BBBB
					</a>
					<a href="#" data-role="button" class="ui-control-active">
						CCCC
					</a>
				</div>
			</div>
		</div>
		<div data-role="content" style="margin-top: 0em;">
		 	 	<div data-role="fieldcontain" style="margin-top: 0em;">  
			 	 <input name="" id="searchinput1" placeholder="搜索" value="" type="search">
			   </div>
	 
	  
	 	
	 
	 
	 
		</div>	
		<div data-role="footer" class="jqm-footer" data-position="fixed">
			 <p style="text-align: center;">
			 	Copyright 2013 The XUKAI Foundation<br>
			 	E-mail: makegoodsecret@sina.com
			 </p>
		</div>
<!-- 导航面板 -->			
		<div data-role="panel" data-position-fixed="true" data-theme="c" id="nav-panel" data-position="left">
        <ul data-role="listview" data-theme="d" data-divider-theme="d"  class="nav-search">
				<li data-role="list-divider">导航栏</li>
				<li  >
					<div data-role="collapsible" style="margin: -0.6em -0.6em -0.6em -0.8em ;"  data-collapsed="true" data-mini="true" data-collapsed-icon="arrow-d" data-expanded-icon="arrow-u" data-theme="b" data-content-theme="d">
						<h4>我的主页</h4>
						<ul data-role="listview">
							<li>
								<a href="">我的主页</a>
							</li>
						</ul>
					</div>
				</li>
				<li data-role="list-divider">host栏</li>
				<li><div data-role="collapsible" style="margin: -1.0em -0.4em -1.0em -0.7em ;" data-theme="b" data-content-theme="d" data-inset="false">
				    <h3>Pets</h3>
				    <ul data-role="listview">
				        <li><a href="#">Canary</a></li>
				        <li><a href="#">Mouse</a></li>
				    </ul>
				</div> 
				</li>
				<li data-icon="delete"><a href="#" data-rel="close">关闭导航</a></li>
			</ul>
		</div>
<!-- 登录面板 -->		
		<div data-role="panel" data-position="right" data-position-fixed="true" data-display="overlay" data-theme="b" id="add-form">
        <form class="userform">
        	<h2>登录</h2>
            <label for="name">用户名:</label>
            <input type="text" name="name" id="username" value="" data-clear-btn="true" data-mini="true" placeholder="username ~ email">
            <label for="password">密码:</label>
            <input type="password" name="password" id="password" value="" data-clear-btn="true" autocomplete="off" data-mini="true" placeholder="password">
            <div class="ui-grid-a">
                <div class="ui-block-a"><a href="#" data-rel="close" data-role="button" data-theme="c" data-mini="true">取消</a></div>
                <div class="ui-block-b"><a href="#" data-rel="close" id="userloginid"  data-role="button" data-theme="b" data-mini="true">登录</a></div>
			</div>
        </form>

	</div>
	</div>
  </body>
</html>
