<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    <base href="<%=basePath%>">
    <script type="text/javascript">
    /**与餐厅管理员聊天*/	
	function isCallHotelAdmin(){
		if ("${hotelPojo.userPojo.userId}" != "") {
			 callMeInfo("${userFriendPojo.userFriendId }","${userFriendPojo.friendPojo.userId }","${userFriendPojo.friendPojo.username }");
		}
		var str  = "正在与<span style='font-size: 18px; font-family:仿宋 ;'>${hotelPojo.hotelName}</span>管理员<span style='font-size: 20px; font-family:楷体;'>${hotelPojo.userPojo.username}</span>聊天";
		$("#licallfriendTitel").html(str);
	}; 
    </script>
 <!-- 左侧导航 -->
 <div style="background-color: white;margin-top: 40px;">
		<!-- 黑名单 -->
		<s:set name="isuserfriendstatusblack">
				<s:property value="@com.secret.util.StatusChat@USERFRIENDSTATUSBLACK"/>
		 </s:set>
		 <!-- 临时聊天 -->
		 <s:set name="isuserfriendstatustemporary">
				<s:property value="@com.secret.util.StatusChat@USERFRIENDSTATUSTEMPORARY"/>
		 </s:set>
		<!-- 未处理请求 -->
		<s:set name="isuserfriendstatusnot">
				<s:property value="@com.secret.util.StatusChat@USERFRIENDSTATUSNOT"/>
		 </s:set>
	<ul id="sidebar" class="nav nav-pills nav-stacked"  style="margin-top: -70px;"   >
				<li class=" " style="background-color: #EFEFEF;" >
					<a href='<%=basePath %>asossh/userinfo!userHome.action' style="background-color: #EFEFEF;">
						<img  src="<%=basePath%>photo/${user.userHeadPojo.headImage }" style="width: 75px; height: 55px;" />
						<span>${user.username }</span>
					</a>
				</li>
				<s:iterator value="friendGroupPojoList" status="status">
				<li class="dropdown" id="friendGroupIdli${friendGroupId }" title="${friendGroupName }组"  style="background-color: #EFEFEF;">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"  title="${friendGroupName }组" style="background-color: #EFEFEF;">
						<i style="width: 75px; height: 45px;"  title="${friendGroupName }组">
							<img style="width: 75px; height: 55px;" alt="" src="<%=basePath%>callme/library/images/icons/collab.png">
						 </i>
						<span class="hidden-phone">${friendGroupName }</span>
					</a>
					<ul class="dropdown-menu" style="background-color: white;" id="friendGroup${friendGroupId }ul">
						<s:set name="isuserFriendPojosListemapyt">${userFriendPojosList=='[]'||userFriendPojosList=='{}' }</s:set>
						<s:set name="groupsize">0</s:set>
						<s:iterator value="userFriendPojosList" >
						<s:set name="isfriendGroupId">
								${friendGroupPojo.friendGroupId==friendGroupId
									&&userFriendStatus!=isuserfriendstatusblack
									&&userFriendStatus!=isuserfriendstatusnot
									&&userFriendStatus!=isuserfriendstatustemporary
								}
						</s:set>
				<!-- 一般的组 -->
 						<s:if test="#isfriendGroupId">
 							<s:set name="groupsize">${groupsize+1 }</s:set>
							<li style="width: 200px;padding-top:5px;  background-color: white;" id="friendGroup${friendPojo.userId }li">
								<i class="icon-large" >
								<a href="javascript:void(0)">
									<img class="thumb account-img" src="<%=basePath%>photo/${friendPojo.userHeadPojo.headImage }" />
								</a>
								</i>
								 <span style="width: 80px;" title="与${friendPojo.username }聊天">
									 ${friendPojo.username }
								 </span>
								 <img alt="离线"  title="离线" style="width:30px; height: 30px;" src="<%=basePath%>image/frienddrow.gif" id="userfriendisline${friendPojo.userId }">
								 <button type="button" style=" float:right; " onclick="callMeInfo('${userFriendId }','${friendPojo.userId }','${friendPojo.username }')" >
								 	聊天
								 </button>
								 <input type="hidden" value="friendGroup${friendGroupId }" data-groupid="${friendGroupId }" id="friendGroupId${friendPojo.userId }">
							</li>
						 </s:if> 
						</s:iterator>
						 <s:if test="#groupsize == 0">
							 <li style="width: 200px;background-color: white;" id = "isemaptyfriendGroup${friendGroupId }li">
						 		 <span style="width: 200px;" >该组没有任何好友</span>
						 	</li>
						 </s:if>
						 <s:else>
							 <li style="width: 200px; display:none;   background-color: white;" id = "isemaptyfriendGroup${friendGroupId }li">
							 		 <span style="width: 200px;" >该组没有任何好友</span>
							 </li>
						 </s:else>
					</ul>
						<input type="hidden" value="${groupsize }" id="groupsize${friendGroupId }">
				</li>
				</s:iterator>
			
			    <!-- 临时聊天 -->
			<li class="dropdown"  title="临时聊天"  style="background-color: #EFEFEF;">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-color: #EFEFEF;" >
						<i style="width: 75px; height: 45px;" title="临时聊天">
							<img style="width: 75px; height: 55px;" alt="" src="<%=basePath%>callme/library/images/imagescallme/groupemporary.png">
						 </i>
						<span class="hidden-phone" title="临时聊天">临时聊天</span>
					</a>
					<ul class="dropdown-menu" style="background-color: white;" id="friendemporaryul">
						 <s:set name="groupsize">0</s:set>
						<s:iterator value="userFriendPojosList" status="status" >
 						<s:if test="#isuserfriendstatustemporary==userFriendStatus" >
 							<s:set name="groupsize">${groupsize+1 }</s:set>
							<li style="width: 200px;padding-top:5px;  background-color: white;" id="friendGroup${friendPojo.userId }li">
								<i class="icon-large">
								<a href="">
								<img class="thumb account-img" src="<%=basePath%>photo/${friendPojo.userHeadPojo.headImage }" />
								</a>
								</i>
								 <span style="width: 80px;" title="与${friendPojo.username }聊天">
									 ${friendPojo.username }
								 </span>
								 <img alt="离线"  title="离线" style="width:30px; height: 30px;" src="<%=basePath%>image/frienddrow.gif" id="userfriendisline${friendPojo.userId }">
								 <button type="button" style=" float:right; " onclick="callMeInfo('${userFriendId }','${friendPojo.userId }','${friendPojo.username }')" >
								 	聊天
								 </button>
								 <input type="hidden" value="friendemporary" data-groupid="emporary" id="friendGroupId${friendPojo.userId }">
							</li>
						 </s:if> 
						</s:iterator>
					 	<s:if test="#groupsize == 0">
							 <li style="width: 200px; background-color: white;" id = "isemaptyemporaryli">
						 		 <span style="width: 200px;" >该组没有任何好友</span>
						 	</li>
						 </s:if>
						 <s:else>
							  <li style="width: 200px;display:none;background-color: white;" id = "isemaptyemporaryli">
							 		 <span style="width: 200px;" >该组没有任何好友</span>
							 </li>
						 </s:else>
					</ul>
						<input type="hidden" value="${groupsize }" id="groupsizeemporary">
					 
				</li>
				
				<!-- 黑名单 -->
					<li class="dropdown" title="我怎么可以在你的黑名单里？" id="userfriendblackli">
					<a  href="#" class="dropdown-toggle" data-toggle="dropdown" >
						<i style="width: 75px; height: 45px;" title="黑名单，想黑谁就黑谁">
							<img style="width: 75px; height: 55px;" alt="" src="<%=basePath%>callme/library/images/imagescallme/jianren19.gif">
						 </i>
						<span class="hidden-phone" title="黑名单就是黑">黑名单</span>
					</a>
					<ul class="dropdown-menu" style="background-color: white;" id="friendblackul">
						 <s:set name="groupsize">0</s:set>
						<s:iterator value="userFriendPojosList" status="status" >
 						<s:if test="#isuserfriendstatusblack==userFriendStatus" >
 							<s:set name="groupsize">${groupsize+1 }</s:set>
							<li style="width: 200px;padding-top:5px;  background-color: white;" id="friendGroup${friendPojo.userId }li">
								<i class="icon-large">
								<a href="">
								<img class="thumb account-img" src="<%=basePath%>photo/${friendPojo.userHeadPojo.headImage }" />
								</a>
								</i>
								 <label class="icon-large" style="color: white; margin-left: 2px;" title="我在你的黑名单里怎么跟你聊天">
									 ${friendPojo.username }
								 </label>
								 	 <img alt="离线"  title="离线" style="width:30px; height: 30px;" src="<%=basePath%>image/frienddrow.gif" id="userfriendisline${friendPojo.userId }">
								 <button type="button" style=" float:right; " >
								 	编辑
								 </button>
								  <input type="hidden" value="friendblack" data-groupid="black" id="friendGroupId${friendPojo.userId }">
							</li>
						 </s:if> 
						</s:iterator>
					 	<s:if test="#groupsize == 0">
							<li style="width: 200px;background-color: white;" id = "isemaptyfriendblackli">
						 		 <span style="width: 200px;" >该组没有任何好友</span>
						 	</li>
						 </s:if>
						 <s:else>
						     <li style="width: 200px; display:none; background-color: white;" id = "isemaptyfriendblackli">
						 		 <span style="width: 200px;" >该组没有任何好友</span>
						 	</li>
						 </s:else>
					</ul>
					<input type="hidden" value="${groupsize }" id="groupsizeblack">
				</li>
			</ul>
			 </div>