<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String websocketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>web聊天系统</title>
	<meta charset="UTF-8">
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
   
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/messageShow.css">
    <link href="<%=basePath%>callme/library/assets/css/bootstrap.css" rel="stylesheet" />
	<link href="<%=basePath%>callme/library/assets/css/bootstrap-responsive.css" rel="stylesheet" />
	<link href="<%=basePath%>callme/library/css/styles.css" rel="stylesheet" />
	
	<!-- 用户自定义的方法  -->
	<script src="<%=basePath%>callme/library/assets/js/jquery.js"></script>
	
	<script src="<%=basePath%>callme/library/assets/js/bootstrap.min.js"></script>
	<script src="<%=basePath%>callme/library/plugins/jquery-ui-slider.js"></script>
	<script src="<%=basePath%>callme/library/plugins/redactor/redactor.min.js"></script>
	<script src="<%=basePath%>callme/library/plugins/jquery.uniform.js"></script>
	<script src="<%=basePath%>callme/library/plugins/bootstrap-datepicker.js"></script>
	<script src="<%=basePath%>callme/library/js/loader.js"></script>
	<script src="<%=basePath%>callme/js/callmeWebSocket.js" type="text/javascript"></script>
	<style type="text/css">
		body {font-family: georgia;}
	</style>
	<script type="text/javascript">
    	var notread  = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSNOTREAD'/>"; 	//获取用户好友信息
		var notread  = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSNOTREAD'/>"; 	//获取用户好友信息
		var friendup = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSFRIENDUP'/>"; 	//推送出好友上线
		var frienddrop = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSFRIENDDROP'/>"; //推送出好友下线
		var agreefriend	= "<s:property value='@com.secret.util.StatusChat@HEADERSTATUAGREEFRIEND'/>";//同意加友后获取好友是否在线以及信息
		var addfriend     = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSADDFRIEND'/>";//推送加友请求消息
		var chat     = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSCHAT'/>"; 		//推送私人聊天消息
		var allchat  = "<s:property value='@com.secret.util.StatusChat@HEADERSTATUSALLCHAT'/>"; 	//推送群聊
		var  black= "<s:property value='@com.secret.util.StatusChat@USERFRIENDSTATUSBLACK'/>"; 	//黑名单
	    var emporary = "<s:property value='@com.secret.util.StatusChat@USERFRIENDSTATUSTEMPORARY'/>"; //临时聊天
    	var chatsplit= "<s:property value='@com.secret.util.StatusChat@getChatSplit()'/>";	   		//分割符
		var userId = "${user.userId }";
		var username = "${user.username }";
		var url = "ws://<%=websocketPath%>websocket.websocketcellme"; //必须以ws://来头使用ws或wss协议
		var basePath = "<%=websocketPath%>";
		var homePath = "<%=basePath%>";
	</script>
  </head>
 <body style="background-color: white;">
		 
<!-- 主聊天面板 -->		
		<div id="left_layout" style="  background-color: #EFEFEF;">
			
			<div id="main_content" class="container-fluid">
			
				<!-- page heading -->
				<div class="page-heading">
				<div class="page-title muted">
					<ul class="nav pull-right">
						<li class="dropdown">
						<a href='<%=basePath %>asossh/userinfo!userHome.action' target='_blank'class="dropdown-toggle" data-toggle="dropdown">
							<i class="icon-large icon-user"></i>
							${user.username }
						</a>
						<ul class="dropdown-menu dropdown-user-account">
							<li class="account-img-container">
								<a href='<%=basePath %>asossh/userinfo!userHome.action' target='_blank'>
								<img class="thumb account-img" src="<%=basePath%>photo/${user.userHeadPojo.headImage }" />
								</a>
							</li>
							<li class="account-info">
								<h3>${user.username }</h3>
								<p>个人信息</p>
								<p>
									<a href="#">修改</a> | <a href="#">设置</a>
								</p>
							</li>
							<li class="account-footer">
								<div class="row-fluid">
									<div class="span8">
										<a class="btn btn-small btn-primary btn-flat" href="#">换个账户</a>
									</div>
									<div class="span4 align-right">
										<a class="btn btn-small btn-danger btn-flat"  href="<%=basePath %>asossh/userlogin!outlogin.action " 
										  onclick="return confirm('${user.username}要离开吗')">下线</a> 
									</div>
								</div>									
							</li>
						</ul>
					</li>
				</ul>
					</div>
					<div class="page-info hidden-phone" style="">
						<ul class="stats">
							<li>
								<span class="large text-warning">0</span>
								<span class="mini muted">好友脚印</span>
							</li>
							<li>
								<span class="large text-info" >0</span>
								<span class="mini muted">未读信息</span>
							</li>
							<li>
								<span class="large text-success">0</span>
								<span class="mini muted">购物车</span>
							</li>
							<li style="">
								<span class="large text-error">0</span>
								<span class="mini muted">最近</span>
							</li>
						</ul>
					</div>
					<span class="navbar-search pull-right hidden-phone">
				<form class="form-search" />
					<div class="input-append" style="font-size: 10px;padding:5px 5px;" >
						<input type="text" id="userFriendeMail" class="search-query span3" placeholder="通过用户的邮箱添加好友"  />
						<select id="friendGroupId" style="width: 100px; ">
						<s:iterator value="friendGroupPojoList" >
							<option value="${friendGroupId }">${friendGroupName }</option>
						</s:iterator>
						</select>
						<button type="button" class="btn btn-primary"  onclick="addUserFriend();">加为好友</button>
					</div>
				</form>
				</span>
				</div>
				
				<ul class="breadcrumb breadcrumb-main">
					<li><a href="<%=basePath %>">首页</a> <span class="divider"><i class="icon-caret-right"></i></span></li>
					<li><a href="#">聊天大厅</a> <span class="divider"><i class="icon-caret-right"></i></span></li>
					<li class="text-info">聊天主页</li>
				</ul>
				
				<!-- post wrapper -->				
				<div class="row-fluid">
				
					<div class="span4">
					
						<!-- widget -->
						<div class="well widget">
							<!-- widget header -->
							<div class="widget-header">
								<h3 class="title">最新评价</h3>
							</div>
							<!-- ./ widget header -->
							
							<!-- media object -->
							<div class="media media-feed">
								<a class="pull-left" href="#">
									<img class="media-object" src="<%=basePath%>callme/library/images/100/07.png" />
								</a>
								<div class="media-body">
									<a href="#"><h4 class="media-heading">Ressa</h4></a>
									<p class="meta">
										<span class="tags"><a href="#" class="text-warning">The</a></span>
									</p>
									<p class="excerpt">Cras</p>
								</div>
							</div>
							<!-- ./ media object -->
							
							<!-- media object -->
							<div class="media media-feed">
								<a class="pull-left" href="#">
									<img class="media-object" src="<%=basePath%>callme/library/images/100/07.png" />
								</a>
								<div class="media-body">
									<a href="#"><h4 class="media-heading">Ola</h4></a>
									<p class="meta">
										<span class="tags"><a href="#" class="text-warning">The</a></span>
									</p>
									<p class="excerpt">Nice</p>
								</div>
							</div>
							<!-- ./ media object -->
							
						</div>
						<!-- ./ widget -->
						
					
					
						
						
						<!-- custom alert -->
						<div class="c-alert" style="margin-bottom:20px;">
							<div class="alert-message error">
								<a class="close" href="#">
									<i class="icon-large icon-remove-circle"></i>
								</a>
								<strong>警告</strong>!交易有风险，交易须谨慎
							</div>
						</div>
						<!-- ./ custom alert -->
						
					</div>
	<!-- 右侧组主聊天面板 -->				
					<div class="span8">
					
						<!-- widget -->
						<div class="well bg-d widget" style="height: 80px;">
							<div class="widget-content">
								 <div class="btn-circle-panel small" style="margin-top: -10px;">
									<ul class="btn-circle"  style="">
										<li>
											<a href="#" class="bottom_tooltip" title="群消息">
												<img src="<%=basePath%>callme/library/images/icons/collab.png" />
											</a>
											<span class="badge badge-important" >0</span>
										</li>
										 
										<li class="important">
												<a href="#" class="bottom_tooltip" title="好友消息">
													<img src="<%=basePath%>callme/library/images/icons/add-user.png" />
												</a>
											<span class="badge badge-important" >0</span>
										</li>
										<li class="success">
												<a href="#messagesModal" data-toggle="modal" class="bottom_tooltip" title="信息" >
													<img src="<%=basePath%>callme/library/images/icons/personal-messages.png" />
												</a>
											<span class="badge badge-important" id="notInfoSpanId" >0</span>
										</li>
										<li class="warning">
												<a href="#friendApplyModal" data-toggle="modal" class="bottom_tooltip" title="待办事宜">
													<img src="<%=basePath%>callme/library/images/icons/clock.png" />
												</a>
											<span class="badge badge-important" id="delayEventId" >
												<s:property value="userFriendApplyList.size()"/>
											</span>
									   </li>
										<li class="inverse">
											<a href="#" class="bottom_tooltip" title="传输文件">
												<img src="<%=basePath%>callme/library/images/icons/file-sharing.png" />
											</a>
											<span class="badge badge-important" >0</span>
										</li>
										<li class="danger">
											<a href="#" class="bottom_tooltip" title="设置">
												<img src="<%=basePath%>callme/library/images/icons/projects.png" />
											</a>
											<span class="badge badge-important" >0</span>
										</li>
									</ul>
								</div>
							</div>
						</div>
<!-- 未读信息弹出层 -->
					<div id="messagesModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="tabbable tabs-custom">
						<ul class="nav nav-tabs" id="messagesModalul">
							 
						</ul>
						<div class="tab-content" id="messagesModaldiv">
							<div class='tab-pane fade in active' id="isnoteampty">
								暂未信息
							</div>
						</div>
						</div>
						<div class="modal-footer">
							<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
						</div>
					</div>
<!-- 加友信息弹出层-->						
					<div id="friendApplyModal" class="modal hide fade"  style="text-align: center;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<s:set name="userFriendApplyListisemapty">${userFriendApplyList == '[]'||userFriendApplyList == '{}' }</s:set>
						<div class="tabbable tabs-custom">
								<s:if test="#userFriendApplyListisemapty">
									<input type="hidden" id="userFriendApplyListisemapty"  data-isexits="false">
								</s:if>
							<ul class="nav nav-tabs" id="messagesModalul">
								 <s:iterator value="userFriendApplyList" status="status">
								 		<s:if test="#status.first" >
											 <li class="active">
											 	<a href="#${friendPojo.username }" data-toggle="tab">${friendPojo.username }发来了加友请求</a>
											 </li>
									 	</s:if>
									 	<s:else>
									 	 	<li >
											 	<a href="#${friendPojo.username }" data-toggle="tab">${friendPojo.username }发来了加友请求</a>
											 </li>
									 	</s:else>
								 </s:iterator>
								 <s:if test="#userFriendApplyListisemapty">
								 	 <li class="active" id="noteventli">
								 	 	待办事宜
								 	 </li>
								 </s:if>
							</ul>
						</div>
						<div class="tab-content" id="friendApplyModaldiv">
								 <s:iterator value="userFriendApplyList" status="status">
								 	<s:if test="#status.first">
										 <div class="tab-pane fade in active" id="${friendPojo.username} " style="text-align: center;">
												<p id="isexistApplyFriend">   
													${friendPojo.username }于${userFriendTime }发来加友请求
													<hr>
													<a href="#friendGroupModal" data-toggle="modal" class="btn btn-success" 
														data-dismiss="modal" aria-hidden="true" onclick="agreeApplyFriend('${userFriendId }','${friendPojo.userId }','${friendPojo.username }')"
													>同意</a>
													<a href="#friendApplyModal" data-toggle="modal" class="btn btn-warning" 
														   onclick="refuseAddUserFriend('${userFriendId }')"
													>拒绝</a>
													<hr>
												</p>
										 </div>
								 	</s:if>
								 	<s:else>
								 	 	<div class="tab-pane fade " id="${friendPojo.username} " style="text-align: center;">
												<p>   
													${friendPojo.username }于${userFriendTime }发来加友请求
													<hr>
													<a href="#friendGroupModal" data-toggle="modal" class="btn btn-success"
													 	data-dismiss="modal" aria-hidden="true" onclick="agreeApplyFriend('${userFriendId }','${friendPojo.userId }','${friendPojo.username }')"
													 >同意</a>
													<a href="#friendApplyModal" data-toggle="modal" class="btn btn-warning" 
														   onclick="refuseAddUserFriend('${userFriendId }')"
													>拒绝</a>
													<hr>
												</p>
										 </div>
								 	</s:else>
								 </s:iterator>	
								 <s:if test="#userFriendApplyListisemapty">
								 	 <div class="tab-pane fade in active" id="noteventdiv">
										<p>没有待办事宜</p>
									</div>
								 </s:if>							 
							</div>
						<div class="modal-footer">
							<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
						</div>
					</div>
<!-- 加友分组导航 -->
		<div id="friendGroupModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		 	<div class="tabbable tabs-custom"  >
		 		<ul class="nav nav-tabs" >
		 			<li class="active">加友同意申请分组</li>
		 		</ul>
		 		<hr>
		 	</div>
		 	<div class="tab-content" id="friendGroupModaldiv" style="text-align: center;" >
		 		 <p> 
		 		 	<span id="addFriendfriendGroup"></span>添加进
			 		<select  id="selectFriendGroup" style="font-size: 18px;width: 150px;">
							<s:iterator value="friendGroupPojoList" status="status">
								<option value="${friendGroupId }" >${friendGroupName }</option> 
							</s:iterator>
					</select> 
					组
					<hr>
					<input type="text" class="input-large" placeholder="添加分组" id="addFriendGroup">
					<input type="hidden" id="agreeuserFriendGroupId">
					<input type="hidden" id="agreeuserFriendId">
					<a type="javascript:void(0)" class="btn btn-danger"   onclick="addApplayGroupFriend()">添加分组</a>
		 		 </p>
		 		 <a type="javascript:void(0)" class="btn btn-cm"  data-dismiss="modal" aria-hidden="true" onclick="addApplayFriend()">&nbsp;确定&nbsp;</a>
		 	</div>
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
			</div>
		</div>
<!-- tab导航 -->					 
				<div class="tabbable tabs-custom tabs-right" id="callMeInfoPana" style="display: none;">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#rA" data-toggle="tab" id="licallfriend">与XX聊天</a></li>
						<li><a href="#rB" data-toggle="tab" id="licallfriendInfo">XX的个人信息</a></li>
						<li><a href="#rC" data-toggle="tab" id="licallfriendMap">XX现在的位置</a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="rA">
							<!-- 聊天输入面板 -->
							<form method="post" action="" >
								<div>
									<div class="widget-header" >
										<span class="title" id="licallfriendTitel">正在与XX聊天</span>
									</div>
									<div style="border: 1ex solid #F2F2F2;height: 250px; overflow: auto;" id="callPane" >
										 
									</div>
								</div>
								<div class="well widget kuta-editor">
									<textarea id="redactor_content" class="fullRedactor" name="content" 
										   data-contentCallid="与谁聊天者的id" data-contentCallName="与谁聊天的名字"
									></textarea>
								</div>
								<div class="action-wrapper">
									<div class="pull-right">
										<button class="btn btn-flat btn-primary" type="button" onclick="callMeInfosend()">发送</button> 
										<button class="btn btn-flat btn-danger" type="button" onclick="onResetCall()">清空</button>
									</div>
								</div>
							</form>
						</div>
						<div class="tab-pane" id="rB">
							<p> 用户信息详情</p>
						</div>
						<div class="tab-pane" id="rC">
							<!-- 好友在线地图显示 -->		 
							<div class="well widget widget-map hidden-phone">							
								<div id="map1" class="map-wrapper bs-map" style="height:270px;"></div>
								<div id="map-side-bar" class="mapSidebar thumbs">
									<h3 class="title text-warning">好友在线</h3>
									
									<div class="map-location" data-jmapping="{id: 1, point: {lng: 106.697135581519, lat: 10.772981071794}, category: 'hotel'}">
										<a href="#" class="map-link"><img src="<%=basePath%>callme/library/images/100/06.png" /></a>
										<div class="info-box hide">
											<p class="map-info-content">
												<a href="#">
													<img class="pull-left img-circle avatar" src="<%=basePath%>callme/library/images/100/06.png" />
												</a>
												<span class="user-name">
													<a href="#">Paenah</a>
												</span>
												<span class="recent-status">
													Dived
												</span>
											</p>
										</div>
									</div>
									
									<div class="map-location" data-jmapping="{id: 2, point: {lng: 106.693530000000, lat: 10.771463000000}, category: 'hotel'}">
										<a href="#" class="map-link"><img src="<%=basePath%>callme/library/images/100/06.png" /></a>
										<div class="info-box hide">
											<p class="map-info-content">
												<a href="#">
													<img class="pull-left img-circle avatar" src="<%=basePath%>callme/library/images/100/06.png" />
												</a>
												<span class="user-name">
													<a href="#">Ponidjan</a>
												</span>
												<span class="recent-status">
													Dived
												</span>
											</p>
										</div>
									</div>								
								</div>
							</div>
						</div>
					</div>
				</div>

						 
						

						
						<!-- widget -->
						<div class="well widget">
							<!-- widget header -->
							<div class="widget-header">
								<h3 class="title">消息记录</h3>
								<div class="widget-nav">
									
								</div>
							</div>
							<!-- ./ widget header -->
							
							<div class="row-fluid">
								<div class="span6">
									<p class="meta uppercase large">
										<span class="tags">
											<a href="#" class="text-info"><i class="icon-comments"></i> 12</a>
										</span>
										<span class="date">2012</span>
									</p>
									<a href="#">
										<h3>The</h3>
									</a>
									<img class="img-featured" src="<%=basePath%>callme/library/images/100/06.png" />
									<p>Dived</p>
								</div>
								<div class="span6">
									<p class="meta uppercase large">
										<span class="tags"><a href="#" class="muted"><i class="icon-comments"></i></a></span>
										<span class="date">Dec2</span>
									</p>
									<a href="#">
										<h3>Begadan</h3>
									</a>
									<img class="img-featured" src="<%=basePath%>callme/library/images/100/06.png" />
									<p>sprang</p>
								</div>
							</div>
							
						</div>
						<!-- ./ widget -->
						
					</div>
				</div>
				<!-- ./ post wrapper -->
			</div>
<!-- end 聊天系统面板 -->
<!-- 左侧导航 -->
<jsp:include page="callhomeLeftPanel.jsp"></jsp:include>
		</div>
  </body>
</html>
