<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <base href="<%=basePath%>">
<div id='cssmenu_home_head'>
<ul>
   <li class='has-sub'>
	   <a href='<%=basePath %>asossh/userinfo!userHome.action' target='_blank'>
	   	<span id="head_user_span" class="hean_span"> ${user.username} </span>
		</a>
 	</li>
  <li>
  	<a class="fontclasshead"  href="<%=basePath %>asossh/userlogin!outlogin.action " id="a_head_user_id" 
  	target="_top" onclick="return confirm('${user.username}要离开吗')">注销</a></li>
  <s:if test="#session.user.emailstatu==0">
	<li><a href='javascript:void(0)' style="color:#ff0000; font-family: 宋体; font-size: 3; "  onclick="alert('快去你的邮箱激活  ${user.email}');"><span>你的账号未激活</span></a></li>
  </s:if>
  	<li id="liemailstatu0" style="display: none;">
  	<a href='javascript:void(0)' style="color:#ff0000; font-family: 宋体; font-size: 3; "
  	 id="a_head_user_eamil_id" onclick="alert('快去你的邮箱激活  ${user.email}');"><span>你的账号未激活</span></a></li>
  </ul>
</div>