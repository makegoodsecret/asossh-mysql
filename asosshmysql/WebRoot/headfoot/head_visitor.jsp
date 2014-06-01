<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <base href="<%=basePath%>">
<div id='cssmenu_home_head'>
<ul>
 <li class='has-sub'><a title="登录" href="<%=basePath %>user/userlogin.jsp"><span>登录</span></a></li>
 <li class='last'><a href='<%=basePath %>asossh/userlogin!gettreaty.action' target='_blank'><span> 注册</span></a></li>
 </ul>
</div>
