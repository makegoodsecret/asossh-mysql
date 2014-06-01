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
	   	<span id="head_admin_span" class="hean_span"> ${user.username} </span>
		</a>
 	</li>
  <li>
  	<a class="fontclasshead"  href="<%=basePath %>asossh/userlogin!outlogin.action " id="a_head_admin_id"  
  	target="_top"onclick="return confirm('${user.username}要离开吗')">注销</a>
  </li>
   <li class='has-sub'><a href='javascript:void(0)' target='_blank'><span>管理网站</span></a>
    <ul>
       <li><a href='<%=basePath %>asossh/admSort!findAllSort.action' target='_blank'><span>种类管理</span></a></li>
       <li><a href='<%=basePath %>asossh/goods!showGoods.action' target='_blank'><span>美食管理</span></a></li>
       <li><a href='<%=basePath %>asossh/hotelmanage!showhotel.action' target='_blank'><span>饭店管理</span></a></li>
       <li><a href='<%=basePath %>asossh/ads!show.action' target='_blank'><span>广告管理</span></a></li>
       <li class='last'><a href='<%=basePath %>asossh/applySeller!showapply.action' target='_blank'><span>申请管理</span></a></li>
    </ul>
 </li>
 </ul>
</div>