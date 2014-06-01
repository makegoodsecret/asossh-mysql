<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" >
<html>
<head> -->
  <base href="<%=basePath%>">
	<link rel='stylesheet' type='text/css' href='<%=basePath%>css/styles_head.css' />
   <link rel='stylesheet' type='text/css' href='<%=basePath%>css/styles_home_head.css' />
<%--    <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>  --%>  
 <!-- 获取用户的经纬度 -->
  <script type="text/javascript" src="http://j.maxmind.com/app/geoip.js"></script>   
<script type=text/javascript>
$(function(){
	$('#webmenu li').hover(function(){
		$(this).children('ul').stop(true,true).show('slow');
	},function(){
		$(this).children('ul').stop(true,true).hide('slow');
	});
	
	$('#webmenu li').hover(function(){
		$(this).children('div').stop(true,true).show('slow');
	},function(){
		$(this).children('div').stop(true,true).hide('slow');
	});
});
</script>
<style type="text/css">
a { color:#000; text-decoration:none;}
ul {list-style:none;}
#divshow { width: 115px; height: 115px;
	position: absolute; left: 70px; top: 5px;
	background-image: url("image/logo.jpg " ) ; 
	border:2px solid #c6cdd0;
	border-radius:15px 15px 15px 15px ;
	background-position:60% 0%;
}
.fontclasshead{color: #000000; font-size:25px; font-family: 楷体;}
.fontclasshead:LINK {color: #000000;}
.fontclasshead:VISITED {color: #000000;}
.fontclasshead:HOVER {color: #ff0000;}
.fontclasshead:ACTIVE {color: #0000ff;}
.hean_span{font-size: 15px;font-weight:bolder;}
</style>
 <script type="text/javascript">
	    
      	var userwelcome=<%=session.getAttribute("userwelcome")%>;
       	if (userwelcome==null) {
       		var  useripadress="<s:property value='@com.secret.action.StaticAction@useripaddress'/>";
       		<% session.setAttribute("userwelcome", "true");%>
      	 	var  userressmessager="来自"+useripadress+"的朋友，欢迎你来访闻到食府网,本网站还在建设中。";
       		homemessagerShow(userressmessager);
		}
        /*操作提示信息框*/
       function  homemessagerShow(messager){ 
      	homemessagerShowtime(messager,4000);
       }
       function  homemessagerShowtime(messager,time){ 
      	 if ($('.msgbox_layer_wrap')) {
				$('.msgbox_layer_wrap').remove();
			}
		$("body").prepend("<div class='msgbox_layer_wrap'  >"+
							"<span  style='z-index: 10000; border-radius:5px 5px  ;' class='msgbox_layer'>"+
							""+messager+"</span></div>");
			$(".msgbox_layer_wrap").show();
       var st = setTimeout(function (){
				$(".msgbox_layer_wrap").hide();
				clearTimeout(st);
			},time);
       }
       /*前往首页*/
       function gotohome(){
			var userlat = geoip_latitude();  
			var userlon = geoip_longitude();  
			var href="<%=basePath %>asossh/index!showIndex.action?userlat="+userlat+"&userlon="+userlon;
			formsubmit(href);//提交为post 
		}
		/*登录成功，刷新导航头*/
		function flashheaduser(username,email,emailstatu,power){
		  $("#uservisitorstatuid").attr("style","display:none");
		 if (power==1) {/* 管理员 */
		 	  $("#a_head_admin_id").attr("onclick","return confirm('"+username+"要离开吗')");
			  $("#head_admin_span").html(username);			  
			  $("#adminstatuid").show();
		}else if(power==0&&emailstatu>1){/*饭店管理员*/
			  $("#a_head_hoteladmin_id").attr("onclick","return confirm('"+username+"要离开吗')");
		  	  $("#head_hoteladmin_span").html(username);	
			  $("#userhoteladminstatuid").show();
		}else if(power==0&&emailstatu==1){/*普通用户*/
			 $("#a_head_user_id").attr("onclick","return confirm('"+username+"要离开吗')");
		     $("#head_user_span").html(username);
		     $("#userstatuid").show();
		     if (emailstatu==0) {		/*邮件未激活*/
		      $("#a_head_user_eamil_id").attr("onclick","alert('快去你的邮箱激活 "+email+"');");
		      $("#liemailstatu0").show();
			}
		}
		 
		}
    </script>

<!-- </head> -->
<jsp:include page="headup.jsp"></jsp:include>
	<jsp:include page="../webmessage.jsp"></jsp:include>
	<table  align="center" width="90%"    background="<%=basePath %>image/bg.jpg" border="0" >
		<tr>
		<td colspan="6"   height="110px" >
		<div id="divshow" onclick="gotohome();"  ></div>
		<jsp:include page="../digital-clock/digital-clock.jsp"></jsp:include>
		</td>
		<td valign="bottom" align="right">
<!-- 管理员 -->
		<s:set name="adminstatu">${user.power==1 }</s:set>
<!-- 普通用户 -->
		<s:set name="userstatu">${user.power==0 }</s:set>
<!-- 饭店管理员 -->
		<s:set name="userhoteladminstatu">${user.power==0&&user.emailstatu>1 }</s:set>
<!-- 游客 -->
		<s:set name="uservisitorstatu">${user==null }</s:set>
		<s:set name="notuservisitorstatu">${user!=null }</s:set>
<!-- 管理员 -->
			<s:if test="#adminstatu">
			    <jsp:include page="head_admin.jsp"></jsp:include>
			</s:if>
<!-- 饭店管理员 -->
			<s:elseif test="#userhoteladminstatu">
			   <jsp:include page="head_hoteladmin.jsp"></jsp:include>
			</s:elseif>
<!-- 普通用户 -->
			<s:elseif test="#userstatu">
				 <jsp:include page="head_user.jsp"></jsp:include>
			</s:elseif>
<!-- 游客 -->
			 <s:elseif test="#uservisitorstatu">
			 	<div id="uservisitorstatuid">
			  	  <jsp:include page="head_visitor.jsp"></jsp:include>
			 	</div>
			  	<div style="display: none;" id="adminstatuid"><!-- 管理员 -->
			  	  	 <jsp:include page="head_admin.jsp"></jsp:include>
			  	</div>
			  	<div style="display: none;" id="userhoteladminstatuid"><!-- 饭店管理员 -->
			  	  	 <jsp:include page="head_hoteladmin.jsp"></jsp:include>
			  	</div>
			  	<div style="display: none;" id="userstatuid"><!-- 普通用户 -->
			  	  	 <jsp:include page="head_user.jsp"></jsp:include>
			  	</div>
			</s:elseif>
			
		</td>	
	</tr>
	</table>
	<table  align="center" width="100%">
		<tr>
	<td colspan="2" >
 <div id='cssmenu_head'>
<ul>
   <li class='active'><a href='javascript:void(0);' onclick="gotohome()" ><span>首页</span></a></li>
   <li><a href='javascript:void(0);'><span>我的位置</span></a></li>
    <li><a href='<%=basePath %>asossh/chat!gotoCallMeHome.action'><span>在线聊天</span></a></li>
   <li class='has-sub'><a href='javascript:void(0);'><span>特色推荐</span></a>
      <ul>
         <li class='has-sub'><a href='javascript:void(0);' target='_blank'><span>Host饭店</span></a>
            <ul>
               <li><a href='javascript:void(0);' target='_blank'><span>Sub Item</span></a></li>
               <li class='last'><a href='javascript:void(0);' target='_blank'><span>Sub Item</span></a></li>
            </ul>
         </li>
         <li class='has-sub'><a href='javascript:void(0);' target='_blank'><span>Host美食</span></a>
            <ul>
               <li><a href='javascript:void(0);' target='_blank'><span>Sub Item</span></a></li>
               <li class='last'><a href='javascript:void(0);' target='_blank'><span>Sub Item</span></a></li>
            </ul>
         </li>
      </ul>
   </li>
   <li><a href='<%=basePath %>asossh/userinfo!userHome.action' target='_blank'><span>个人中心</span></a></li>
    <li  class='has-sub'><a href='javascript:void(0);' ><span>视频</span></a>
	    <ul>
	         <li class='has-sub'><a href='javascript:void(0);' target='_blank'><span>Host视频</span></a>
	            <ul>
	               <li><a href='<%=basePath %>webVideo.jsp' target='_blank'><span>查看</span></a></li>
	            </ul>
	         </li>
	      </ul>
    </li>
    <li><a href='javascript:void(0);'  title="刷新" onclick="history.go(0)"><span>刷新</span></a></li>
    <li><a href='javascript:void(0);' title="返回" onclick="javascript:history.go(-1)"><span>返回</span></a></li>
   <li><a href='javascript:void(0);' onclick="alert('网站还在开发中');"><span>关于</span></a></li>
   <li class='last'><a href='javascript:void(0);' target='_blank' onclick="alert('E-mail:makegoodsecret@sina.com')"><span>联系</span></a></li>
</ul>
</div>
 </td>		
</tr>
</table>