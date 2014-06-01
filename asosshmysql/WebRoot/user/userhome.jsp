<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户的个人主页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Expires" content="-1" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css"  href="<%=basePath %>css/modernizr-1.5.css" >
	<link rel="stylesheet" type="text/css"  href="<%=basePath %>css/styles_menu_home.css" >
	
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/modernizr-1.5.min.js"></script>
	 <script type="text/javascript" src="<%=basePath%>js/menu_jquery_home.js"></script>
	<!-- 拖拽布局 -->
	<link href="<%=basePath%>css/jquery-fallr-main.css" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>css/jquery-fallr-1.3.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath%>js/ui/ui.core.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/ui/ui.sortable.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/ui/jquery-fallr-1.3.pack.js"></script>
	<%-- <script type="text/javascript" src="<%=basePath%>js/jquery.easing.1.3.js"></script> --%>
	<script type="text/javascript" src="<%=basePath%>js/ui/Jh.js"></script>
 <style type="text/css">
	.go {width: 47px;height: 150px;position: fixed;_position: absolute;
	_top: expression(eval(document.documentElement.scrollTop + 
			 document.documentElement.clientHeight-this.offsetHeight- (  
		parseInt(this.currentStyle.marginTop, 10)||200 )-(parseInt(this.currentStyle.marginBottom, 10)||0
		) ) );left: 12px;bottom: 10%;
	background-image: url("/imagesforcode/201208/tobg.png");background-repeat: no-repeat;}
	.go a {background: url(<%=basePath%>image/topbottom.png) no-repeat;
		display: block;text-indent: 999em;width: 37px;margin: 5px;
		border: 0;overflow: hidden;float: left;cursor: pointer;}
	.go .top {background-position: 0 0px;height: 22px}
	.go .feedback {background-position: 0 -22px;height: 32px}
	.go .bottom {background-position: 0 -55px;height: 22px}
	.go .top:hover {background-position: -38px -0px}
	.go .feedback:hover {background-position: -38px -22px}
	.go .bottom:hover {background-position: -38px -55px}
</style>
	<style type="text/css">
	.shutterfont{float:left;  margin-top:  30px;margin-left: 140px ;font-family: 宋体; font-size: 25px; }
	.buttonshutter{float:left; margin-top:  -42px;margin-left: 45px ;padding-left:13px;padding-top:8px;padding-right:13px;padding-bottom:8px;font-family: 宋体;font-size: 20px; } 
	</style>
	<style type="text/css">
	body{ margin:0px; font-family: 仿宋; padding: 0px;font-size: 12px;}
	#container { width: 100%; text-align: left;}
	#container>div {border: 1px solid #aaf;background-image:url("<%=basePath %>image/bg.jpg");}
	#main{width:100%;text-align: left;margin-top: 10px;border:1px solid #eee;border-radius:15px 15px ;}
	.containerul{margin-left: -30%;}
	.agreen{border: 2px solid #eee;background-color:#eee;border-radius:15px 15px ;color:black;font-size: 25px;padding: 6px 6px;}
	.agreen:ACTIVE {background-color:red;}
	.agreen:HOVER{background-color:#aa0000;}
	.dropdownli{border: 1px solid #aaa;border-radius:10px 10px ;font-size: 18px;padding: 5px 5px;}
	.dropdownli:ACTIVE {background-color:#ff0000;}
	.dropdownli:HOVER {background-color:#aa0000}
	.dropdownli>a{color: black;font-size: 15px;}
	</style>
    <script type="text/javascript">
    $(function () {
    $(".top").click(//定义返回顶部点击向上滚动的动画
    function () {
    $('html,body').animate({ scrollTop: 0 }, 700);
    });
    $(".bottom").click(//定义返回顶部点击向上滚动的动画
    function () {
    $('html,body').animate({ scrollTop: document.body.clientHeight }, 700);
    });
    });
    </script>
 	<script type="text/javascript">
 	$(function(){
 		$.easing.def = "easeOutBounce";
		$('li.button a').click(function(e){
		var dropDown = $(this).parent().next();
		$('.dropdown').not(dropDown).slideUp('slow');
		dropDown.slideToggle('slow');
		e.preventDefault();
	});
 	});
 	</script>
 	<script>
		var jQueryScriptOutputted = false;
		function initJQuery() {
		    if (typeof(jQuery) == 'undefined') {
		        if (!jQueryScriptOutputted) {
		            jQueryScriptOutputted = true;
		            document.write("<scr" + "ipt src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js\"></scr" + "ipt>");
		        }
		        setTimeout("initJQuery()", 50);
		    } else {
		    	$.getScript('js/jquery.backgroundPosition.js', function() {
		    		$("h2").text('This Browser is using a jQuery fallback for this effect.');
					$('#shutter1').css({backgroundPosition: '0px 0px'});
					$('#shutter2').css({backgroundPosition: '0px 0px'});
					$('#shutter3').css({backgroundPosition: '0px 0px'});
					$('#shutter4').css({backgroundPosition: '0px 0px'});
					$("#garagedoor a").hover(function() {	
					      $(this).parent().stop().animate({backgroundPosition: '(0px -100px)'}, 500);
					    }, function() {
					      $(this).parent().stop().animate({backgroundPosition: '(0px 0px)'}, 500);
					});
		    	});
		    }
		}
		
		if (!Modernizr.csstransitions) {
			initJQuery();
		}
	</script>
	<script>
	$(document).ready(function () {	
		var DATA = {
			'appL' : {
				'avatar':'头像信息',
				'comment':'留言簿',
				'doing':'最新动态',
			},
			'appM' :{
				'profile':'个人资料',
				'spaceinfo':'最近购物',
				'friends':'我的好友',
				'blog':'blog'
			},
			'appR' : {
				'gallery':'我的相册',
				'visitors':'最近访客',
				'thread':'我的话题'
			}
		};	
		Jh.fn.init(DATA);
		Jh.Portal.init(DATA);
		
		initmsg();//初始化显示
		
	});
	function userheadmsg(){
		var src  ="<%=basePath%>";
		var img  ="${user.userHeadPojo.headImage }";
		if(img.indexOf("tiger")!=-1){ src +="image/tiger/"+img; }
		else{ src +="photo/"+img;} 
		var imageheadmsg  ="<form method='post' enctype='multipart/form-data' id='submitheadImage'>"
							+"<img alt='&nbsp;&nbsp;&nbsp;&nbsp;用户头像'  id='liavatarheadimage' src='"+src+"' width='160px'  height='100px' style='border:1px solid #eee; border-radius:35px 35px ;'>"
							+"<br/><input type='file' id='images'  style='width: 150px;'   name='images'><br/>"
							+"<button type='submit'  style='padding: 3px 3px;' title='修改头像'>修改</button>"
							+"<input type='hidden' id='imagesname'   value='${user.userHeadPojo.headImage }'  name='imagesname'>"
							+"</form>";
		return imageheadmsg;
	}
	function userinfo(){
		var usermsg="<span><lable>用户名:</lable>${user.username } </sapn><br>"
					+"<span><lable>email:</lable>${user.email } </sapn><br>"
					+"<span><lable>描述:</lable>${user.dis } </sapn><br>"
					+"<span><lable>爱好:</lable>${user.hobby } </sapn><br>"
					+"<span><lable>注册时间:</lable>${user.time } </sapn><br>"
						;
		return usermsg;
	}
	function initmsg(){ 
		 $("#liavatar").html(userheadmsg() );        //初始化显示用户的头像
		 $("#liprofile").html(userinfo()) ;		  	//初始化显示用户信息
	
	
	}

	 function  inithead(){
	 	 var userheadimage =$("#userheadimage").attr("src");
	 	 var src  ="<%=basePath%>";
 		if(userheadimage.indexOf("tiger")!=-1){
 			src +="image/tiger/"+userheadimage;
 		}else{
 			src +="photo/"+userheadimage;
 		}
 		$("#userheadimage").attr("src",src);
	 }
	 function validFunName(){ 
	 		var imge=$("#images").val().trim();
		 if(imge.length==0){
			 messagerShow("请先选择图片后提交");
			 return false;
		 } 
 		var strlist=imge.split(".");
 		var imgesuffix="BMP、JPG、JPEG、PNG、GIF";
 		if(imgesuffix.indexOf(strlist[1].toUpperCase())==-1){
 		 	messagerShow("上传的图片格式为BMP、JPG、JPEG、PNG、GIF");
 		};
	 }
	 $(function(){
	 //鼠标移动到a标签上触发事件 
	 	$("#submitheadImage").submit(function(){ 
	 		$(this).ajaxSubmit({
	 			url:"<%=basePath%>asossh/userinfo!updateuserimage.action",
	 			type:"post",
	 			beforeSubmit:validFunName ,
	 			success:function(data,type){
	 				if (data=="false") {
						 messagerShow("图片修改失败");
					}else{
						 messagerShow("图片修改成功");
						 var src="<%=basePath%>photo/"+data+"?r="+Math.random()*100;
						 $("#userheadimage").attr("src",src);
						 $("#liavatarheadimage").attr("src",src);
						 $("#imagesname").val(data);
					}
	 			},error:function(XmlHttpRequest, textStatus, errorThrown){
	 				 messagerShow("与服务器链接出错了");
	 			}
	 		});
	 		return false;
	 	});
	 })
	 
</script>
	
  </head>
 <body  background="<%=basePath %>image/bg.jpg" onload="inithead()">
  <!-- 返回顶 -->
    <div class="go">
    <a title="返回顶部" class="top"></a>
    <a title="如果您有意见，请反馈给我们！" class="feedback" href="javascript:void(0)" target="_blank"></a>
    <a title="返回底部" class="bottom" ></a>
    </div>
  <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div style="margin:auto;text-align:center; font-family:楷体; font-size:20px; margin-left: 5%;margin-top:  5px; margin-right: 5%;">
		<div id="container">
			<div style="width:20% ;   float:left; " >
			<div style="width:100% ; height: 120px; text-align: center;"  >
				<img alt="&nbsp;&nbsp;&nbsp;&nbsp;用户头像"  id="userheadimage" src="${user.userHeadPojo.headImage }" width="150px"  height="100px" 
					style="border:1px solid #eee; border-radius:35px 35px ;"
				><br>
				<div  style="width:250px ; height: 20px;">
					<span>
						<a href="<%=basePath %>" target="_blank">编辑资料</a>
					</span>
					<span>
						<a href="<%=basePath %>" target="_blank">隐私设置</a>
					</span>
				</div>
			</div>
			<div id="main">
			<div style="border:1px solid #aaa; border-radius:10px 10px ;">我的交易</div>
 			<div id='cssmenu_home'>
				<ul>
				   <li><a href='<%=basePath %>asossh/cart!mycart.action'><span>购物车(<s:property value="goodsCartList.size()"/>) </span></a></li>
				   <li class='has-sub'><a href='javascript:void(0)'><span>卖家管理</span></a>
				      <ul>
				      	<s:set name="useremailstatu">${user.power==0&&user.emailstatu==2 }</s:set>
					   	<s:if test="#useremailstatu"><!-- 饭店管理员 -->
					         <li><a href='<%=basePath %>asossh/seller!sellermain.action' title="点击查看，饭店管理" target='_blank'><span>饭店管理</span></a></li>
					         <li><a href='<%=basePath %>user/applyseller.jsp' title="点击查看，申请一家饭店" target='_blank'><span>申请一家饭店</span></a></li>
				         </s:if>
				         <s:elseif test="#user.power==1"><!-- 管理员 -->
				        	 <li><a href='javascript:void(0)'><span>你好管理员</span></a></li>
				         </s:elseif>
				          <s:else>
				         	<li class='last'><a href='<%=basePath %>user/applyseller.jsp'  title="点击查看，申请成为卖家" target='_blank'><span>申请成为卖家</span></a></li>
				     	 </s:else>
				      </ul>
				   </li>
				   <li class='has-sub'><a href='javascript:void(0)'><span>已买到的宝贝 </span></a>
				      <ul>
				        <s:set name="goodsOrderMapname">${goodsOrderMap=='[]'||goodsOrderMap=='{}' }</s:set>
		                 <s:if test="#goodsOrderMap">
				         <li><a href='javascript:void(0)' title="没有一次购买"><span>没有一次购买</span></a></li>
				         </s:if>
				          <s:else>
			              <s:iterator value="goodsOrderMap">
			              <s:if test="key=='TRADE_FINISHED'">
			              <s:set name="trade_finishedname">${value=='[]'||value=='{}' }</s:set>
			               <s:if test="#trade_finishedname">
				         <li class='last'><a href='javascript:void(0)' title="没有一次成功购买的记录"><span>没有一次成功购买的记录</span></a></li>
				         </s:if>
			              <s:else>
			              <s:iterator value="value" >
			              <li class="dropdownli">
				              <a href="<%=basePath %>asossh/goodsOrder!" title='<s:property value="value.{hotelPojo.hotelName}[0]"/>的订单' target='_blank'>
				               <s:property value="value.{hotelPojo.hotelName}[0]"/>的订单<br>
				                (<s:date name="value.{orderTime}[0]" format="MM月dd天"/>)
				                </a>
				           </li>
			             </s:iterator>
			              </s:else>
			             </s:if>
			               </s:iterator>
		                 </s:else>
				      </ul>
				   </li>
				   
				     <li class='has-sub'><a href='javascript:void(0)'><span>购买过的店铺 </span></a>
				      <ul>
				         <li>
				           <s:set name="hotelMapname">${hotelMap=='[]'||hotelMap=='{}' }</s:set>
		                    <s:if test="#hotelMapname">
				         	<a href='javascript:void(0)' title="没有一次购买"><span>没有一次购买</span></a></li>
				         	</s:if>
		                    <s:else>
				              <s:iterator value="hotelMap">
					        	 <li class='last'>
					           		<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${value}"  title="${key }"  target='_blank'>
			                  			 <span>${key }</span>
			                  		 </a>
			                  	  </li>
			                    </s:iterator>
		                    </s:else> 
				      </ul>
				   </li>
				    <li class='last'><a href='javascript:void(0)'><span>我的收藏  </span></a>
				      <ul>
				       <s:set name="userColListname">${userColList=='[]'||userColList=='{}' }</s:set>
		                <s:if test="#userColListname">
				         <li><a href='javascript:void(0)' title="没有收藏"><span>没有收藏</span></a></li>
				         </s:if>
				        <s:else>
			               <s:iterator value="userColList.{hotelPojo}" status="status">
			              <s:if test="hotelName!=null">
				         <li class='last'>  <a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }"  title="${hotelName }"  target='_blank'>
		                    <span> ${hotelName }</span>
		                   </a></li>
		                      </s:if>
			                    </s:iterator>
			                    <s:iterator value="userColList.{mealPojo}" status="status">
			                    <s:if test="mealName!=null">
		                    		<li class="dropdownli">
		                    		   <a href="<%=basePath %>asossh/hotel!useroptionhotel.action?mealorgoodsname=inhotelmeal&&hotelPojo.hotelId=${hotelPojo.hotelId  }">
		                    		  	 <span>${mealName }</span>
		                    		    </a>
		                    		</li>
		                    	</s:if>
			                    </s:iterator>
			                    <s:iterator value="userColList.{goodsInfoPojo}" status="status">
			                    <s:if test="goodsName!=null">
		                    		<li  >
		                    		   <a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId  }">
		                    		  	 <span>${goodsName }</span>
		                    		    </a>
		                    		</li>
			                    </s:if>
			                    </s:iterator>
		                    </s:else> 
				      </ul>
				   </li>
				          		 
				</ul>
				</div>
		  </div>
		</div>
<!-- 中间最大处的内容 -->
		<s:set name="setwait_buyer_pay">true</s:set>
		<s:set name="setwait_buyer_confirm_goods">true</s:set>
		<s:set name="settrade_finished">true</s:set>
		<s:iterator value="goodsOrderMap">
			<s:if test="key=='WAIT_BUYER_PAY'">
				<s:set name="setwait_buyer_pay">false</s:set>
			</s:if>
			<s:if test="key=='WAIT_BUYER_CONFIRM_GOODS'">
				<s:set name="setwait_buyer_confirm_goods">false</s:set>
			</s:if>
			<s:if test="key=='TRADE_FINISHED'">
				<s:set name="settrade_finished">false</s:set>
			</s:if>
		</s:iterator>
    		<div style="width:79%;float:left;">
				<div style="width:100% ;height: 170px; text-align: center;" >
					<h2 style="margin: 0px;">个人中心</h2>
				    <h3 align="left" style="margin: 0px;">交易提醒</h3>
							<s:set name="goodsOrderMapName">${goodsOrderMap=='[]'||goodsOrderMap=='{}' }</s:set>
					<ul id="garagedoor">
						<li id="shutter1"  >
							<s:if test="#setwait_buyer_pay">
								<font class="shutterfont"  >(0) </font>
							 <button type="button" id="buttonshutter1"  class="buttonshutter"
							 onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
							 >待付款</button>  
							</s:if>
							<s:else>
							<s:iterator value="goodsOrderMap">
								<s:if test="key=='WAIT_BUYER_PAY'">
									<s:if test="value.size()>0">
										<font class="shutterfont"  >(<s:property value="value.size()"/>) </font>
										<button type="button" id="buttonshutter1"  class="buttonshutter"
								 				onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
								 		>待付款</button> 
									</s:if>
								</s:if>
							</s:iterator>
							</s:else>
							<a href="javascript:void(0)"  id="shutter"  data-aid="1"  > </a>
						</li>
						<li id="shutter2">
						<s:if test="#setwait_buyer_confirm_goods">
							<font class="shutterfont">(0)</font>
							<button type="button" id="buttonshutter2"  class="buttonshutter" 
							 onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
							>待收货</button>  
						</s:if>
						<s:else>
							<s:iterator value="goodsOrderMap">
								<s:if test="key=='WAIT_BUYER_CONFIRM_GOODS'">
									<font class="shutterfont"  >(<s:property value="value.size()"/>) </font>
									<button type="button" id="buttonshutter1"  class="buttonshutter"
							 				onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
							 		>待收货</button> 
								</s:if>
							</s:iterator>
							</s:else>
							<a href="javascript:void(0)" id="shutter" data-aid="2"  ></a>
						</li>
						<li id="shutter3">
						<s:if test="#settrade_finished">
							<font class="shutterfont">(0)</font>
							<button type="button" id="buttonshutter3"  class="buttonshutter"
							 onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
							>待评价</button>  
						</s:if>
						<s:else>
							<s:iterator value="goodsOrderMap">
								<s:if test="key=='TRADE_FINISHED'">
									<font class="shutterfont"  >(<s:property value="value.size()"/>) </font>
									<button type="button" id="buttonshutter1"  class="buttonshutter"
							 				onclick="window.location.href='<%=basePath %>asossh/order!showorder.action'"
							 		>待评价</button> 
								</s:if>
							</s:iterator>
						</s:else>
							<a href="<%=basePath %>asossh/goodsAssess!userasess.action" id="shutter" data-aid="3"   ></a>
						</li>
						<li id="shutter4">
							<font class="shutterfont">(0)</font>
							<button type="button" id="buttonshutter4"  class="buttonshutter" 
 								onclick="alert('功能开发中')"							
							>其他</button>  
							<a href="javascript:void(0)" id="shutter" data-aid="4"   ></a>
						</li>
					</ul>
				</div>
				<!-- 拖拽布局 -->
				<div style="width:100% ; clear:both; ">
					  <div id="meun" class="fallr_windows" >
					    
					  </div>
				</div>
			  <div class="fallr_windowsfoot" style="margin: 0px; clear: left;">
			  
			  </div>
			</div>
			
 		</div>
	</div> 
  <jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
