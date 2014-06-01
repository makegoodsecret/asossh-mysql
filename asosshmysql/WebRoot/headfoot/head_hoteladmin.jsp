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
	   	<span id="head_hoteladmin_span" class="hean_span"> ${user.username} </span>
		</a>
 	</li>
  <li><a class="fontclasshead"  href="<%=basePath %>asossh/userlogin!outlogin.action " id="a_head_hoteladmin_id"  
  target="_top" onclick="return confirm('${user.username}要离开吗')">注销</a></li>
 <li class='has-sub'><a href='<%=basePath %>asossh/seller!sellermain.action' target='_blank'><span>我是卖家</span></a>
     <ul>
        <li><a href='<%=basePath %>asossh/seller!sellermain.action'><span>卖家管理</span></a></li>
        <li class='last'><a href='<%=basePath %>user/applyseller.jsp' target='_blank'><span>申请一家饭店</span></a></li>
     </ul>
  </li>
  </ul>
</div>