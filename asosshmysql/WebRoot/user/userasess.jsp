<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s"  uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户评价页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/messageShow.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<style type="text/css">
		body{
			margin:0px;
			font-family: 仿宋;
		}
		div#container {
			display: box;
			display: -moz-box;
			display: -webkit-box;
			width: 960px;
			text-align: left;
		}
		#container>div {
			border: 1px solid #aaf;
			/* 设置HTML组件的width属性包括边框 */
			box-sizing: border-box;
			-moz-box-sizing: border-box;
			border-radius: 12px 12px 0px 0px;
			background-image:url("<%=basePath %>image/bg.jpg");
			padding:5px;
		}
	</style>
	<style>
    #star{position:relative;width:765px; }
    #star ul,#star span{float:left;display:inline;height:19px;line-height:19px;}
    #star ul{margin:0 10px;}
    #star li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(<%=basePath %>image/star.png) no-repeat;}
    #star strong{color:#f60;padding-left:10px;}
    #star li.on{background-position:0 -28px;}
    #star p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(<%=basePath %>image/icon.gif) no-repeat;padding:7px 10px 0;}
    #star p em{color:#f60;display:block;font-style:normal;}
    </style>
    <script type="text/javascript">
    window.onload = function (){
	    var oStar = document.getElementById("star");
	    var aLi = oStar.getElementsByTagName("li");
	    var oUl = oStar.getElementsByTagName("ul")[0];
	    var oSpan = oStar.getElementsByTagName("span")[1];
	    var oP = oStar.getElementsByTagName("p")[0];
	    var i = iScore = iStar = 0;
	    var aMsg = [
	    "很不满意|差得太离谱，与卖家描述的严重不符，非常不满",
	    "不满意|部分有破损，与卖家描述的不符，不满意",
	    "一般|质量一般，没有卖家描述的那么好",
	    "满意|质量不错，与卖家描述的基本一致，还是挺满意的",
	    "非常满意|质量非常好，与卖家描述的完全一致，非常满意"
	    ];
    for (i = 1; i <= aLi.length; i++){
	    aLi[i - 1].index = i;
	    //鼠标移过显示分数
	    aLi[i - 1].onmouseover = function (){
		    fnPoint(this.index);
		    //浮动层显示
		    oP.style.display = "block";
		    //计算浮动层位置
		    oP.style.left = oUl.offsetLeft + this.index * this.offsetWidth - 104 + "px";
		    //匹配浮动层文字内容
		    oP.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg[this.index - 1].match(/(.+)\|/)[1] + "</em>" + aMsg[this.index - 1].match(/\|(.+)/)[1];
    	};
    //鼠标离开后恢复上次评分
    aLi[i - 1].onmouseout = function (){
	    fnPoint();
	    //关闭浮动层
	    oP.style.display = "none";
    };
    //点击后进行评分处理
    aLi[i - 1].onclick = function (){
	    iStar = this.index;
    	 $("#assStars").val(iStar);
	    oP.style.display = "none";
	    oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")";
    	};
    }
    //评分处理
    function fnPoint(iArg) { 
	    //分数赋值
	    iScore = iArg || iStar;
	    for (i = 0; i < aLi.length; i++) {
	    	aLi[i].className = i < iScore ? "on" : "";
	    	}
	    }
    };
    
		 /*操作提示信息框*/
       function  messagerShow(messager){ 
      	 if ($('.msgbox_layer_wrap')) {
				$('.msgbox_layer_wrap').remove();
			}
		$("body").prepend("<div class='msgbox_layer_wrap'>"+
							"<span id='mode_tips_v2' style='z-index: 10000;' class='msgbox_layer'>"+
							"<span class='gtl_ico_clear'></span>"+messager+"<span class='gtl_end'></span></span></div>");
			$(".msgbox_layer_wrap").show();
       var st = setTimeout(function (){
				$(".msgbox_layer_wrap").hide();
				clearTimeout(st);
			},1000);
       }
    function validFunName (){
    		var editor  = CKEDITOR.instances.editor1.getData();
    		  if(editor==0){
    		  	alert("请对此次交易进行评价");
    		  	return false;
    		  }else{
    		  	$("#assDis").val(editor);
    		  }
    		 if($("#assStars").val().length==0){
    		 	alert("请对饭店等级进行评价");
    		 	return false;
    		 };
    }
    $(function(){ 
    	$("#userassess").submit(function(){ 
				 $(this).ajaxSubmit({
				 	url:"<%=basePath%>asossh/goodsAssess!savegoodsAssess.action",
		 			type:"post" , 
		 			beforeSubmit:validFunName,
		 			success:function(data,type){
		 			if (data == 1) {
		 				messagerShow("提交成功，正在跳转……");
		 				window.location.href="<%=basePath%>asossh/userinfo!userHome.action";
					}else{
						messagerShow("提交失败");
					}
		 			},error:function(XmlHttpRequest, textStatus, errorThrown){
		 				messagerShow("与服务器链接出现了异常");
		 			}
				 });
		 			return false;
			});
    })
    </script>
  </head>
  
 <body  background="<%=basePath %>image/bg.jpg">
  <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div style="margin:auto;text-align:center; margin-left: 5%;margin-top:  5px; margin-right: 5%;">
		<div id="container">
			<div style="width:200px">
				<h2>我的交易</h2>
				<ul>
					<li>2011年11月10日&nbsp;买了盘烤鸡</li>
					<li>2011年12月02日&nbsp;买了盘鱼头</li>
					<li>2012年02月08日&nbsp;功能还在开发中</li>
				</ul>
			</div>
			<div style="width:765px">
			<form action="" method="post" id="userassess">
				<h2>评价</h2>
				<div style="width: 765px; margin-top: 10px; font-size: 20px;">
					 <h2>店铺简介：</h2>  
					<label>店铺的名字:</label>
					<s:property value="goodsOrderlist.{hotelPojo.hotelName}[0]"/><br>
					<label>店铺的描述</label>
					<s:property value="goodsOrderlist.{hotelPojo.hotelAds}[0]"/>
				</div>
				<hr>
				<div style="width: 765px; margin-top: 5px; font-size: 23px;">
					<h3>交易成功的订单：</h3>
					<p>
					<s:iterator value="goodsOrderlist" status="valuestatus">
						<div  style="border: 1px solid #eee; border-radius:10px 10px 10px 10px;"> 
		 			<s:if test="mealPojo!=null">
		 				<label style="font-family:黑体;">套餐:</label>${mealPojo.mealName }
		 				<s:set name="sumprice">${sumprice+goodsNumber*mealPojo.mealPrice }</s:set>
		 			</s:if>
		 			<s:if test="goodsInfoPojo!=null">
		 				 <label style="font-family:黑体;">美食:</label>${goodsInfoPojo.goodsName }
		 				 <s:set name="sumprice">${sumprice+goodsNumber*goodsInfoPojo.goodsPrice }</s:set>
		 			</s:if>
	 				</div>
	 				<s:if test="#valuestatus.last">
	 				<div style="text-align: left; clear: left; ">
	 					<label style="font-family:黑体;">收件人:</label>
	 					${orderAddress.orderName }<br>
	 					<label style="font-family:黑体;">收件人手机:</label>
	 					${orderAddress.cellphone }<br>
	 					<label style="font-family:黑体;">收件人电话:</label>
	 					${orderAddress.phonesection }-${orderAddress.phonecode }-${orderAddress.otherphone }<br>
	 					<label style="font-family:黑体;">收货地址:</label>
	 					${orderAddress.province }${orderAddress.city }${orderAddress.county }${orderAddress.otherAddress }
	 					<br>
	 				</div>
	 				</s:if>
					</s:iterator>
					 <input type="hidden" name="goodsOrderPojo.alipayTradeNo" value="<s:property value="goodsOrderlist.{alipayTradeNo}[0]"/>" >
					</p>
				</div>
				<div style="width: 765px; margin-top: 5px; font-size: 20px;">
					   <h3>对该商品整体评价</h3>
					  <div id="star">
					    <span>打分(滑动星星打分)</span>
					    <ul>
					    <li><a href="javascript:;">1</a></li>
					    <li><a href="javascript:;">2</a></li>
					    <li><a href="javascript:;">3</a></li>
					    <li><a href="javascript:;">4</a></li>
					    <li><a href="javascript:;">5</a></li>
					    </ul>
					    <span></span>
					    <p></p>
					    <input type="hidden" name="goodsAssessPojo.assStars" id="assStars" >
					   </div>
				</div>
				<br>
			   <div style="width: 765px; margin-top: 60px;">
			   		<jsp:include page="../ckeditor/samples/editor.jsp"></jsp:include>
			   		<input type="hidden" name="goodsAssessPojo.assDis" id="assDis" >
			   </div>
			   <div style="width: 765px; margin-top: 30px;">
			   		<button type="submit" style="padding: 10px 10px">提交评价</button>
			   </div>
			   </form>
			</div>
			<div style="width:250px">
				<h2>对该物品的最新评价</h2>
				<marquee  height="400px" width="250px" 
					behavior="alternate" scrollamount="10" scrolldelay="500"  
					direction="up"  loop="-1" onmouseover="this.stop()" onmouseout="this.start()" >
				<s:iterator value="usercollist" status="status">
					<div style="width: 250 ;height:60px ; margin-top: 5px;">
 						<p>功能还在完善中……</p>
					</div>
				</s:iterator>
				<div style="width: 250 ;height:60px ; margin-top: 5px;">
 						<p>功能还在完善中……</p>
					</div>
					<div style="width: 250 ;height:60px ; margin-top: 5px;">
 						<p>功能还在完善中……</p>
					</div>
					<div style="width: 250 ;height:60px ; margin-top: 5px;">
 						<p>功能还在完善中……</p>
					</div>
				</marquee>
			</div>
		</div>
	</div> 
  <jsp:include page="../headfoot/footer.jsp"></jsp:include>
</body>
</html>
