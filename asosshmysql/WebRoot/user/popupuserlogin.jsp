<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>弹出登录</title>

    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport"  content="with=device-width,initial-scale=1">
	<link rel="stylesheet" type="text/css" media="all" href="<%=basePath%>css/popupuserloginstyle.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
 <script type="text/javascript">
function userloginjs(){
    	var o = {
				top : 100,
				overlay : 0.45,
				closeButton : ".hidemodal"
			};
    	var overlay = $("<div id='lean_overlay'></div>");
		$("body").append(overlay);
    	var modal_id ="#loginmodal";
    	$("#lean_overlay").click(function() {
			close_modal(modal_id)
		});
		$(o.closeButton).click(function() {
			close_modal(modal_id)
		});
    	var modal_height = $(modal_id).outerHeight();
		var modal_width = $(modal_id).outerWidth();
    	$("#lean_overlay").css({
		"display" : "block",
		opacity : 0
		});
		$("#lean_overlay").fadeTo(200, o.overlay);
		$(modal_id).css({
			"display" : "block",
			"position" : "fixed",
			"opacity" : 0,
			"z-index" : 11000,
			"left" : 50 + "%",
			"margin-left" : -(modal_width / 2) + "px",
			"top" : o.top + "px"
		});
		$(modal_id).fadeTo(200, 1);
    }
    function close_modal(modal_id) {
		$("#lean_overlay").fadeOut(200);
		$(modal_id).css({
			"display" : "none"
		})
	}
			
$(function(){
  /* $('#modaltrigger').click(function(){  
  	userloginjs();
  }); */
  //用户登录
  $("#loginbtn").click(function(){
  		var username = $("#username").val();
   		var password = $("#password").val();
   		if (username.length==0) {
   			homemessagerShowtime("用户名不能为空",1500);
			return false;
		}else if(password.length==0){
			homemessagerShowtime("密码不能为空",1500);
   			return false;
		}else{
			var url="<%=basePath%>asossh/userlogin!userAjaxlogin.action"
			$.getJSON(url,{"userPojo.username":username, "userPojo.password":password},function(data){
  				if (data.isloginstatu=="true") {
				homemessagerShowtime("登录成功",1500);
				close_modal("#loginmodal"); //关闭用户登录
				$(".mycarthidden").show();  //显示购物车
				showdatamycart();           //更新购物车
				$("#hiddenusername").val(username);//导航栏用户注入
			    flashheaduser(data.username,data.email,data.emailstatu,data.power);			//刷新导航头
			}else{
				homemessagerShowtime("用户名或密码出错",1500);
			}
  	 	}) 
		}
});
});
</script>
 
  </head>
  
 <body >
      <!-- <button type="button" id="modaltrigger"  >add</button>  -->
  <div id="loginmodal" style="display:none;">
    <h1>闻到食府网</h1>
    <form id="popupserloginform" name="popupserloginform" method="post" action="index.html">
    <fieldset style="text-align: left;">
     <legend style="font-size: 20px;font-family: 微软雅黑;">用户登录</legend>
      <label for="username" style="  font-family: 仿宋;font-size: 18px;">用户名:</label>
      <input type="text" name="userPojo.username" id="username" class="txtfield" tabindex="1" placeholder="UserName">
      
      <label for="password" style="font-family: 仿宋;font-size: 18px;">密码:</label>
      <input type="password" name="userPojo.password" id="password" class="txtfield" tabindex="2" placeholder="PassWord">
      
      <div class="center">
      	<input type="button" name="loginbtn" id="loginbtn" class="flatbtn-blu" value="登录" tabindex="3">
       	<input type="button" class="flatbtnre-blu hidemodal" value="取消" tabindex="3">
      </div>
    </fieldset>
    </form>
  </div>
</body>
</html>