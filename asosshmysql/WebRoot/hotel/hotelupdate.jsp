<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    
    <title>修改饭店</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>css/mstx.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/areacode.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.settime.js"></script>
	<script type="text/javascript" src="<%=basePath%>json_address/jquery.cityselect.js"></script>
	<s:head/>
	<sx:head parseContent="true" extraLocales="zh-tw"/> 
	 
<!-- 添加百度地图的支持 -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=6a5c5a8dcaeb5b014a2c293d48a8bc34"></script>
<style type="text/css">
	#l-map{
		width:100% ;	height: 500px; float: left; border-right: 2px solid #bcbcbc;
	}
	.btnhotel {
	PADDING-RIGHT: 10px;
	PADDING-LEFT: 10px;
  	BACKGROUND: #CCA202; 
    PADDING-BOTTOM: 1px;
  	MARGIN: 0px; OVERFLOW: visible;
	COLOR: #fff; BORDER-TOP-STYLE: none; 
	PADDING-TOP: 4px; BORDER-RIGHT-STYLE: none; 
	BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none;
	-moz-border-radius: 5px; -webkit-border-radius: 5px
}
	input{
		padding: 5px 5px;
	}
	/*会员名片提示层样式开始*/
.tl{width:14px;height:13px;position:absolute;top:-6px;left:20px;z-index:999;background:url(<%=basePath%>image/widget_tip_t.gif) no-repeat;}
.tr{width:14px;height:13px;position:absolute;top:-6px;right:20px;background:url(<%=basePath%>image/widget_tip_t.gif) no-repeat;}
.bl{width:14px;height:13px;position:absolute;top:177px;left:20px;z-index:999;background:url(<%=basePath%>image/widget_tip_b.gif) no-repeat;}
.br{width:14px;height:13px;position:absolute;top:177px;right:20px;z-index:999;background:url(<%=basePath%>image/widget_tip_b.gif) no-repeat;}
.lt{width:14px;height:13px;position:absolute;top:20px;left:-6px;z-index:999;background:url(<%=basePath%>image/widget_tip_l.gif) no-repeat;}
.lb{width:14px;height:13px;position:absolute;bottom:20px;left:-7px;z-index:999;background:url(<%=basePath%>image/widget_tip_l.gif) no-repeat;}
.rt{width:14px;height:13px;position:absolute;top:20px;right:-7px;z-index:999;background:url(<%=basePath%>image/widget_tip_r.gif) no-repeat;}
.rb{width:14px;height:13px;position:absolute;bottom:20px;right:-7px;z-index:999;background:url(<%=basePath%>image/widget_tip_r.gif) no-repeat;}
.userInfoDialog{width:290px;height:184px;border:0;margin:0;padding:0;font-size:12px;font-weight:normal;text-align:left;color:#000;position:absolute;left:0;top:0; background:#fff; display:none;}
.out{margin:0;padding:0;border:0;background:#DADADA;filter:alpha(opacity=80);opacity:0.8;height:100%;-moz-border-radius:3px;-webkit-border-radius:3px;border-radius:3px;}
.in{border:1px solid #CCC;background:#FFF;width:248px;height:142px;margin:0;padding:15px;position:absolute;top:5px;left:5px;overflow:hidden;}
.inload{border:1px solid #CCC;background:#FFF;width:248px;height:142px;margin:0;padding:15px;position:absolute;top:5px;left:5px;overflow:hidden;}
.userInfo{cursor:pointer;width:50px;height:50px;}
.in img{float:left;margin-right:15px;width:65px;height:75px;}
.in div{float:left;height:110px;width:160px; line-height:23px;}
.gzjy{ float:right; text-align:right;}
.gzjy a{ margin-left:10px; width:55px;}
/*会员名片提示层样式结束*/
select{
	position:relative;
	font-size:14px;
	font-family:黑体;
	width:80px;
	line-height:14px;
	border:1px;
	color:#000;
}
</style>
<script type="text/javascript">
//名片夹代码
	$.fn.manhuaCardTip = function(option) {
		var defaults = {	
			Event : "click", 						//触发响应事件
			position : "bl",							//箭头指向上(t)、箭头指向下(b)、箭头指向左(l)、箭头指向右(r)
			photo : "<%=basePath%>image/head.gif",	//头像路径
			name : "闻到食府网CEO、CTO徐凯",						//名称
			sex : "男",								//性别
			power : "爱好女",							//爱好
			detail : "游弋在代码中的猿猴。"				//介绍
			
		};	 
		var options = $.extend(defaults,option);	
		var bid = parseInt(Math.random()*100000);		
		$("body").prepend("<div id='userInfoDialog"+bid+"' class='userInfoDialog'>"
							+"<span></span><div class='out'><div class='in'>"
							+"<a href='javascript:void(0)' title='查看资料'>"
							+"<img src='"+options.photo+"' alt='用户头像' /></a>"
							+"<div>名称："+options.name+"<br />性别："+options.sex+"<br />权限："+options.power
							+"<br />介绍(组别)："+options.detail+"<br />"
							+"<a href='javascript:void(0)' class='btn btn-success btn-small' title='加关注'>"
							+"+加关注</a>&nbsp;&nbsp;<a href='javascript:void(0)' class='btn btn-success btn-small' title='加好友'>"
							+"+加好友</a></div></div></div></div>");
		var $this = $(this);
		var $btip = $("#userInfoDialog"+bid);			
		$this.die().live(options.Event, function(){			
			var h = $(this).height();
			var offset = $(this).offset();		
			$btip.find("span").addClass("bl"); 
			$btip.css({
				"left":offset.left-70,
				"top":offset.top-h-170
			}).show();	
		});		
		$btip.die().live(options.Event, function(){
			$(this).show();									 
		}).live("mouseleave", function(){				
			$(this).hide();																
		});
	}
	 //上传图片的验证方法
	function validFunNameLogo(hotelimageid){   
			var imge=$("#"+hotelimageid).val().trim(); 
			var strlist=imge.split(".");
	 		var imgesuffix="BMP、JPG、JPEG、PNG、GIF";
	 		if(imgesuffix.indexOf(strlist[1].toUpperCase())==-1){
	 		 	alert("上传的图片格式为BMP、JPG、JPEG、PNG、GIF");
	 		 	return false;
	 		};
	 		return true;
		}
	//提交饭店logo图片
	function  onformhotelLogo(){ajaxsubmitimage("formhotelLogo","hotelLogonameid","hotelLogo","hotellogoimg","idhotelLogo");}
	function onformhotelCertificate(){ajaxsubmitimage("formhotelCertificate","hotelCertificatenameid","hotelCertificate","hotelCertificateimg","idhotelCertificate");};
	function  ajaxsubmitimage(formName,hotelimageidvalue,hotelimageid,hotelimgshow,hotelimgsubmitid){
		var src  ="<%=basePath%>asossh/hotelmanage!";
			if ($("#"+hotelimageidvalue).val().trim().length==0) {  //上传图片
				src+="savehotelimage.action";
			}else{ //修改图片
				src+="updatahotelimage.action";
			}
		if(validFunNameLogo(hotelimageid)){ 
			$("#"+formName).ajaxSubmit({
				url:src,
				type:"post",
				success:function(data ,type){
				if (data!="false") {
					var src ="<%=basePath%>photo/"+data+"?time="+new Date().getTime();
					$("#"+hotelimgshow).attr("src",src);
					$("#"+hotelimageidvalue).val(data);
					$("#"+hotelimgsubmitid).val(data);
				}else{
					alert("操作失败");
				}
				},error:function(XmlHttpRequest, textStatus, errorThrown){
					alert("出错了");
				}
			});
		};
	}
		function resultName(){
			var hotelName =$("#hotelName").val().trim();
			if(hotelName==""){
				$("#msghotelName").html("<font color='RED' size='2'>饭店名称不能为空</font>");
				return false;
			}else{
				$("#msghotelName").html("<font color='#4F81BD' size='2'>OK</font>");
				return true;
			}
		};
		function resultAds(){
			var hotelAds =$("#hotelAds").val().trim();
			if(hotelAds==""){
				$("#msghotelAds").html("<font color='RED' size='2'>饭店描述不能为空</font>");
				return false;
			}else{
				$("#msghotelAds").html("<font color='#4F81BD' size='2'>OK</font>");
				return true;
			}
		};
		function resultuserinputaddress(){
			//注入地址
			var province ,city,county;
			  province = $("#province").val().trim();
			  $("#hotelProvince").val(province);
		 	if (province!="国外") {
		 		if ($("#county").val().trim()=="请选择" ||$("#city").val().trim()=="请选择" ) {
					  messagerShow("收件人地址不完整");
					   return false;
				}
			 	if ($("#county").val()==null ) {
					  messagerShow("收件人地址不完整");
					  county =null;
					   return false;
				}else{
					  city = $("#city").val().trim();
			 		  county = $("#county").val().trim();
			 		  $("#hotelCity").val(city);
					 $("#hotelCounty").val(county);
				}
			}  
			var otherAddress = $("#userinputaddress").val().trim();
		 	if (otherAddress.length<=0) {
				 $("#msghotelAddress").html("<font color='RED' size='2'>收件人地址(不包含省市区)不完整</font>");
				 return false;
			}else if (isNaN(otherAddress)&&otherAddress.indexOf(".")<-1) {
				 $("#msghotelAddress").html("<font color='RED' size='2'>收件人地址(不包含省市区)不能为纯数字</font>");
				 return false;
			}
				 $("#msghotelAddress").html("<font color='#4F81BD' size='2'>OK</font>");
		 return true;
		}
		function resultPhone(){
			var hotelPhone =$("#hotelPhone").val().trim();
			if(hotelPhone==""){
				$("#msghotelPhone").html("<font color='RED' size='2'>饭店联系手机不能为空</font>");
				return false;
			}else{
				$("#msghotelPhone").html("<font color='#4F81BD' size='2'>OK</font>");
				 return true;
			}
		};
		
		function resultShopHours(){
		 
		var hotelShopPMStart=$('#hotelShopPMStart').val().trim();
		var hotelShopPMEnd=$('#hotelShopPMEnd').val().trim();
		if(hotelShopPMStart.length==0||hotelShopPMEnd.length==0){
				$("#msghotelShopHours").html("<font color='RED' size='2'>饭店营业时间晚餐不能为空</font>");
				return false;
		}else{ 
				$("#msghotelShopHours").html("<font color='#4F81BD' size='2'>OK</font>");
				 return true;
			}
		}
		function  resultHotelImge(){
			var idhotelLogo =$("#idhotelLogo").val();
			var idhotelCertificate =$("#idhotelCertificate").val();
			if (idhotelLogo.length==0) {
				$("#msghotelImage").html("<font color='RED' size='2'>请上传饭店logo</font>");
				return false;		
			}else if (idhotelCertificate.length==0) {
				$("#msghotelImage").html("<font color='RED' size='2'>请上传饭店许可证图片</font>");
				return false;
			}else{
				$("#msghotelImage").html("<font color='#4F81BD' size='2'>OK</font>");
				 return true;
			}
		}
	//把验证饭店地理位置的方法提成全局方法，就可以让地图访问
	function resultGpspoint(){
			if($("#info_lng").val()==""||$("#info_lng").val()==""){
				$("#msghotelGpspoint").html("<font color='RED' size='2'>饭店地理位置不能为空</font>");
				return false;
			}else{
				$("#msghotelGpspoint").html("<font color='#4F81BD' size='2'>OK</font>");
				return true;				  
			}
		}
		function payname(){
			var payname= $("#paynameid").val().trim();
			if (payname.length==0) {
				messagerShow("<font color='RED' size='2'>支付宝账号不能为空</font>");
				$("#msgpayname").html("<font color='RED' size='2'>支付宝账号不能为空</font>");
				return false;	
			}else{
		   return  true;
		}
		}
	
	$(function(){
	$("#show").click(function(){
		if($("#info_lng").val()==""||$("#info_lng").val()==""){
			alert("请点击地图获取饭店的位置");
			return false;
		}
		$("#info_lng").attr("style","display: ");
		$("#info_lat").attr("style","display: ");
		$("#hiddren").show();
		$("#show").hide();
	});
		$("#hiddren").click(function(){
			$("#info_lng").attr("style","display:none ");
			$("#info_lat").attr("style","display:none ");
			$("#hiddren").hide();
			$("#show").show();
		});
		
		//注入区号
	$("#areacode").focus(function(){
		// reacodedata 为城市的数据源封装areacode.js中  i为areacodedata的下标  n为匹配到的值
		var	province = $("#province").val().trim();
		if($("#city").val()!=""){
			var   city = $("#city").val().trim();
			$.each( areacodedata, function(i, n){
		  	 if((i.indexOf(city)!=-1)||(i.indexOf(province)!=-1)){ //只要包含省份或市就填充
		  		$("#areacode").val(n);
		  	}  
			}); 
		}
	});
	 function  hoteluseremailstatu(){
	 	var hotelusermailsatu=+$("#hotelusermailsatu").val();
	 	if (hotelusermailsatu!=2) {
	 		alert("此人员权限不足，无法管理饭店，请重新分配人员");
			return  false;
		}else{
		   return  true;
		}
	 }
		//提交
	$("#updatehotelsubmit").click(function(){ 
		 var userpower=+"${user.power}";
		if (userpower==1) {  //管理员
		 	$("#hoteluserPojouserId").val(dojo.widget.byId("auto").getText()); //注入username
		} 
		if (
			resultName()&&resultAds()
			&&resultShopHours()&&resultuserinputaddress()
			&&resultPhone()&&resultGpspoint()
			&&resultHotelImge()&&hoteluseremailstatu()&&payname()
			){
		 	formhotelupdate.action="<%=basePath%>asossh/hotelmanage!updatehotel.action";
		 	formhotelupdate.submit();
		}else{
			messagerShow("检查必填项是否填写完成");
		}
	});
	$("#userinfobutton").click( function(){ 
		var  username=dojo.widget.byId("auto").getText();
		if (username=="") {
			messagerShow("请先选择载参看");
		}else{
			$.getJSON(
			"<%=basePath%>asossh/userinfo!getjsonuserinfo.action",
			{"userPojo.username":username},
			function(data){
				var userheadimage=data.userheadimage;
				var src="<%=basePath%>";
				var time=new Date().getTime();
				if(userheadimage.indexOf("tiger")!=-1){
		 			src +="image/tiger/"+userheadimage+"?time="+time;
		 		}else{
		 			src +="photo/"+userheadimage+"?time="+time;
		 		} 
		 		var useremailsatu = data.useremailsatu;
		 		$("#hotelusermailsatu").val(useremailsatu);   //将是否是饭店的原理员注入隐藏域
		 		var  detail ;
		 		if (useremailsatu==0) {
					detail="普通邮箱未验证用户不能管理饭店";
				}else if(useremailsatu==1&&power==0){
					detail="普通用户不能管理饭店";
				}else{
					detail="饭店管理员";
				}
		 		var power ;
		 		var userpower=data.userpower;
		 		if (userpower==0) {
					power="普通用户";
				}else{
					power="网站管理员";
					detail="网站管理员权利巨大";
				}
				var usersex;
				if ( data.usersex=='1') {
					 usersex="男";
				}else{
					 usersex="女";
				}
				$("#paynameid").val(data.payname);
			 var    option ={
					Event : "click", 						//触发响应事件
					position : "bl",							//箭头指向上(t)、箭头指向下(b)、箭头指向左(l)、箭头指向右(r)
					photo : src,	    //头像路径
					name : data.username,						//名称
					sex : usersex,							//性别
					power: power, 								//用户的权限
					detail : detail
					};
					$("#userinfobutton").manhuaCardTip(option);
			}); 
		}
	
	});
	});
	/* 注入饭店的 地址 */
	function hoteladdress(){
		var hotelProvince="${hotelPojo.hotelProvince}";
		var hotelCity="${hotelPojo.hotelCity}";
		var hotelCounty="${hotelPojo.hotelCounty}";
		 $("#my_address").citySelect({
			prov:hotelProvince,city:hotelCity,dist:hotelCounty,nodata:"none",required:false
		});
	}
</script>
  </head>
  
  <body  background="<%=basePath %>image/bg.jpg" onload="hoteladdress()" >
      <jsp:include page="../headfoot/head.jsp"></jsp:include>  
	<table background="<%=basePath %>image/bg.jpg" align="center" width="90%">
		<tr>
			<td align="center" colspan="2">
				<font style="font-family: 宋体; font-size: 30px;">创建饭店界面</font>
			</td>
		</tr>
		<tr>
		<!-- 修改饭店  -->
			<td width="50%">
				<form id="formhotelupdate"  method="post" >
				<table width="100%" border="0" style="border:1px solid #abcdef;">
					<tr>
						<td width="30%" align="left" nowrap="nowrap">
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">饭店名称;</font></td>
						<td width="70%">
							<input type="text" value="${hotelPojo.hotelName }" id="hotelName" name="hotelPojo.hotelName" style="font-size: 1pc;"> 
						</td>
					</tr>
					<tr><td></td><td height="15"><div id="msghotelName"></div></td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">饭店的描述</font></td>
						<td width="70%">
						<textarea rows="2" cols="30"  id="hotelAds" name="hotelPojo.hotelAds">${hotelPojo.hotelAds }</textarea>
						</td>
					</tr>
					<tr>
					<td></td>
					<td height="15">
					<div id="msghotelAds"></div>
					</td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">饭店的营业时间</font></td>
						<td width="70%">
						中餐：<input type="text" id="hotelShopAMStart" value="${hotelPojo.hotelShopAmStart }" name="hotelPojo.hotelShopAmStart" size="8px;" style="font-size: 1pc;">
						至<input type="text" id="hotelShopAMEnd" value="${hotelPojo.hotelShopAmEnd }" name="hotelPojo.hotelShopAmEnd" size="8px;" style="font-size: 1pc;"><br>
						<br>
					  	晚餐：<input type="text" id="hotelShopPMStart" value="${hotelPojo.hotelShopPmStart }" name="hotelPojo.hotelShopPmStart" size="8px;" style="font-size: 1pc;">
					  	至<input type="text" id="hotelShopPMEnd" value="${hotelPojo.hotelShopPmEnd }" name="hotelPojo.hotelShopPmEnd" size="8px;" style="font-size: 1pc;">
					    <script>
					    $('#hotelShopAMStart').setTime();
					    $('#hotelShopAMEnd').setTime();
					    $('#hotelShopPMStart').setTime();
					    $('#hotelShopPMEnd').setTime();
					    </script>
						</td>
					</tr>
					<tr><td><br></td><td height="15">&nbsp;<div id="msghotelShopHours"></div></td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">饭店的地址</font></td>
						<td width="70%">
						 <span id="my_address">
					  		<select class="prov" style="width: 80px ;padding: 5px 5px;border: 1px solid #afcecc;  " name="orderAddressPojo.province" id="province" ></select> 
					    	<select class="city"  style="width: 100px ;padding: 5px 5px;border: 1px solid #afcecc;"   name="orderAddressPojo.city" id="city"></select>
					        <select class="dist"  style="width: 150px;padding: 5px 5px;border: 1px solid #afcecc;" name="orderAddressPojo.county" id="county"></select>
   				 		</span> 
						<textarea rows="2" cols="20" id="userinputaddress" name="hotelPojo.hotelOtherAddress">${hotelPojo.hotelOtherAddress }</textarea>
						 <input type="hidden" id="hotelProvince" name="hotelPojo.hotelProvince" value="${hotelPojo.hotelProvince}">
						 <input type="hidden" id="hotelCity" name="hotelPojo.hotelCity" value="${hotelPojo.hotelCity}">
						 <input type="hidden" id="hotelCounty" name="hotelPojo.hotelCounty" value="${hotelPojo.hotelCounty}">
						 </td>
					</tr>
					<tr><td></td><td height="15"><div id="msghotelAddress"></div></td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
							<font color="RED"  >&nbsp;*</font>(必填)手机号:<br>
						 	<font style="font-family: 微软雅黑">饭店的联系号码(选填)<br>&nbsp;区号-电话号码<br>分机号</font>
						 </td>
						<td width="70%">
							<input type="text" id="hotelPhone" value="${hotelPojo.hotelCellphone }" name="hotelPojo.hotelCellphone" style="margin-top: 5px; margin-bottom: 10px;"> <br>
							<input type="text" id="areacode" value="${hotelPojo.hotelPhonesection }" name="hotelPojo.hotelPhonesection" size="3" style="font-size: 1pc;" >
							<input type="text" id="telephone" value="${hotelPojo.hotelPhonecode }" name="hotelPojo.hotelPhonecode"size="10" style="font-size: 1pc;" >
							<input type="text" id="mobilephone" value="${hotelPojo.hotelOtherphone }" name="hotelPojo.hotelOtherphone" size="10"style="font-size: 1pc;"><br>
						</td>
					</tr>
					<tr><td></td><td height="15"><div id="msghotelPhone"></div></td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">添加饭店的位置:</font></td>
						<td width="70%"><b>使用说明：</b>
						<p><font style="font-family: 黑体" size="2">
						&nbsp;&nbsp;1.请点击地图上的相应位置，红色跳动的标记点就是你选择的饭店位置。<br>
						&nbsp;&nbsp;2.通过点击左上角的查看坐标按钮查看你选择的坐标。<br>
						&nbsp;&nbsp;3.点击红色的标记点可以弹出对话框，点击对话框中的取消按钮就可以重新标注饭店的位置。<br>
						&nbsp;&nbsp;4.通过拖拽地图上的红色标记点，就可以改变饭店的位置。<br>
						&nbsp;&nbsp;5.地图上每次只能标记一个。</font></p>
						 </td>
					</tr>
					<tr><td></td><td height="15"><div id="msghotelGpspoint"></div></td></tr>
					<tr>
						<td width="30%" align="left" nowrap="nowrap"> 
						<font color="RED"  >*</font><font style="font-family: 微软雅黑">饭店是否营业</font></td>
						<td width="70%">
							<select id="hotelStatus" name="hotelPojo.hotelStatus" 
							style="width: 80px ;padding: 5px 5px;border: 1px solid #afcecc;">
								<option value="1" ${hotelPojo.hotelStatus=="1"?"selected=selected":"" } >营业</option>
								<option value="0" ${hotelPojo.hotelStatus=="0"?"selected=selected":"" }>歇业</option>
							</select>
						 </td>
					</tr>
						<s:if test="#session.user.power==1"> <!-- 管理员 -->
					<tr>
					<td width="30%" align="left"> 
						<label><font color="RED"  >*</font>饭店管理人员：</label>
					</td>
					<td>
							<s:set name="url">
								<%=basePath %>asossh/autocompleter!hoteluser.action
							</s:set>
							<s:set name="username">${hotelPojo.userPojo.username }</s:set>
							<sx:autocompleter    value="%{username}"
							 name="userName"  href="%{url}" loadOnTextChange="true"  loadMinimumCount="1" 
							  autoComplete="true" showDownArrow="true" forceValidOption="true"
							  id="auto"   
							  cssStyle="padding: 5px 5px ;margin-top: 10px; margin-bottom: 15px;"
							></sx:autocompleter>
							<button type="button" style="padding: 5px 5px" id="userinfobutton">参看饭店管理员</button>
							<input type="hidden"   id="hoteluserPojouserId" value="${hotelPojo.userPojo.username }" name="userPojo.username">
							<input type="hidden"   id="hotelusermailsatu" value="2" >
					</td>
					</tr>
					<tr>
						<td>
							<label><font color="RED"  >*</font>饭店的支付宝账号：</label>
						</td>
						<td>
							<input type="text"  id="paynameid" value="${hotelPojo.userPojo.payname }" name="userPojo.payname">
							<br>注意:<br>
							<em style="font-family: 楷体;font-size: 15px;">
							1.如果查看了该饭店管理员，将会自动填充.<br>
							2.如果填写了错误的支付宝号，导致顾客的投诉，将对你的饭店做停业处理.
							</em>
							<div id="msgpayname"></div>
						</td>
					</tr>
						</s:if>
						<s:else>
						<tr>
							<td>
								<label><font color="RED"  >*</font>饭店的支付宝账号：</label>
							</td>
							<td>
								<input type="text" id="paynameid"  value="${user.payname }" name="userPojo.payname">
								<br>注意:<br>
								<em style="font-family: 楷体;font-size: 15px;">
								如果填写了错误的支付宝号，导致顾客的投诉，将对你的饭店做停业处理.
								</em>
								<input type="hidden"  value="${user.username }" name="userPojo.username">
								<input type="hidden"   id="hotelusermailsatu" value="${user.emailstatu }" >
								<div id="msgpayname"></div>
							</td>
						</tr>
						</s:else>
					<tr>
						<td colspan="2" align="center">
							<button  type="button" style="padding: 10px 10px ; margin-right: 10px; "  id="updatehotelsubmit">修改饭店</button>
							<button type="button" style="padding: 10px 10px ; margin-left: 10px;"  
							onclick="window.location.href='<%=basePath %>asossh/hotelmanage!showhotel.action'"
							id="index">返回</button>
			<!-- 隐藏提交经纬度 -->
						<input type="hidden"    name="hotelPojo.hotelLng"  id="info_lngs"  value="${hotelPojo.hotelLng }"  >
						<input type="hidden"    name="hotelPojo.hotelLat"  id="info_lats"  value="${hotelPojo.hotelLat }"  >
			<!-- 隐藏提交图片 -->
						<input type="hidden"    name="hotelPojo.hotelLogo"  id="idhotelLogo"  value="${hotelPojo.hotelLogo }"  >
						<input type="hidden"    name="hotelPojo.hotelCertificate"  id="idhotelCertificate" value="${hotelPojo.hotelCertificate }"   >
			<!-- 隐藏饭店的id  -->
						<input type="hidden" name="hotelPojo.hotelId" value="${hotelPojo.hotelId }">			
					</td>
					</tr>
				</table>
				</form>
				</td>
		<!-- 百度地图位置定位 -->
			<td width="50%">
				<div style="width: 100% ; height: 160px;" >
					<div style="float:left; border:1px solid #abcdef; display: inline;width: 30%  ; height: 160px;">
						<form id="formhotelLogo" method="post" enctype="multipart/form-data">
							<span>
							<font color="RED"  >*</font>
							<font style="font-family: 微软雅黑 ;font-size: 15px;">饭店的商标(图片)</font><br>
							<input type="file" id="hotelLogo" name="images" style="height: 40px;width: 250px"  onchange="onformhotelLogo()" > 
							<input type="hidden" id="hotelLogonameid" name="imagesname" value="${hotelPojo.hotelLogo }" >
							</span>
						</form>
						<hr>
						<form id="formhotelCertificate" method="post" enctype="multipart/form-data">
						<span>
							<font color="RED"  >*</font>
							<font style="font-family: 微软雅黑;font-size: 15px;">饭店的证书(图片)</font><br>
							<input type="file" id="hotelCertificate" name="images" style="height: 40px;width:250px" onchange="onformhotelCertificate()" > 
							<input type="hidden" id="hotelCertificatenameid" name="imagesname" value="${hotelPojo.hotelCertificate }">
						</span>
						</form>
					</div>
					<div style="float:left; border:1px solid #abcdef; display: inline; width: 34% ; height: 160px;">
						<img alt="选择上传饭店的logo" src="<%=basePath %>photo/${hotelPojo.hotelLogo }"  width="100%" height="160px;" id="hotellogoimg">
					</div>
					<div style="float:left; border:1px solid #abcdef; display: inline; width: 34% ; height: 160px;">
						<img alt="选择上传饭店的许可证" src="<%=basePath %>photo/${hotelPojo.hotelCertificate }"  width="100%" height="160px;" id="hotelCertificateimg">
					</div>
				</div>
					<div style=" clear: both;border:1px solid #abcdef; width: 100% ; margin-top:10px;  height: 30px;">
						 <div id="msghotelImage" style="width: 100%;height: 100px;">饭店logo与许可证为必填项</div>
					</div>
				<div style="clear: both; border:1px solid #abcdef; ">
				<input type="button" value="查看坐标" id="show" style="padding: 10px 10px">
				<input type="button" value="隐藏坐标" id="hiddren" style="display: none ;padding: 10px 10px;">
				<input type="text"  value="${hotelPojo.hotelLng }"    id="info_lng" style="display: none" disabled="disabled"  >
				<input type="text"  value="${hotelPojo.hotelLat }"     id="info_lat" style="display: none" disabled="disabled"  >
				</div>
				<div id="l-map"></div>
			</td>
		</tr>		
	</table>
<jsp:include page="../headfoot/footer.jsp"></jsp:include>
<!-- 创建百度地图的 -->
<script type="text/javascript">
   var  map  = new BMap.Map("l-map");
   var point  = new BMap.Point("${hotelPojo.hotelLng }","${hotelPojo.hotelLat }");   		//默认为饭店的经纬度所在地
   map.centerAndZoom(point,13) ;   						 	//15为级别
   map.enableScrollWheelZoom();    							//开启滚轮放大缩小
   map.enableContinuousZoom();  							//启动地图惯性拖拽，默认禁止
   map.addControl(new BMap.OverviewMapControl({isOpen:true, anchor: BMAP_ANCHOR_TOP_RIGHT})); //右上角，打开
   map.addControl(new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]}));     //2D图，卫星图
   map.addControl(new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_LEFT}));    //左上角，默认地图控件
   showhotelinmarker(point);                    //创建饭店标记
	function showhotelinmarker(point){
		inmarker(point);							//创建标记
		resultGpspoint();							 //提示已经选择了
		map.removeEventListener("click",showPoin);    //移除标记,及点击别处不会生成新的标记
	}
   function showPoin(e){
   		//alert("你家的 经纬度"+e.point.lng+e.point.lat);
	   	var hotelpoint= new BMap.Point(e.point.lng,e.point.lat);
	   	inmarker(hotelpoint);
   		$("#info_lng").val(e.point.lng);//查看坐标
   		$("#info_lat").val(e.point.lat);
   		$("#info_lngs").val(e.point.lng);//将值注入到隐藏域中
   		$("#info_lats").val(e.point.lat);
   		resultGpspoint();							 //提示已经选择了
	   	map.removeEventListener("click",showPoin);    //移除标记,及点击别处不会生成新的标记
   }
   var marker ;
   function  inmarker(hotelpoint){
	   	 marker  = new BMap.Marker(hotelpoint);
	   	map.addOverlay(marker);							//将标注添加到地图中
	   	marker.setAnimation(BMAP_ANIMATION_BOUNCE);		//添加跳动的动画
	    marker.enableDragging();            //可拖拽
	    /*
	    	在标注开启拖拽功能后，您可以监听标注的dragend事件来捕获拖拽后标注的最新位置。
	    */
	   //marker.disableDragging();            //不可拖拽，默认为不可拖拽
	   	marker.addEventListener("dragend",function(e){
	   		//alert("移动后的经纬度"+e.point.lng+","+e.point.lat);
	   		$("#info_lng").val(e.point.lng);
	   		$("#info_lat").val(e.point.lat);
	   		$("#info_lngs").val(e.point.lng);//将值注入到隐藏域中
   			$("#info_lats").val(e.point.lat);
	   		resultGpspoint();							//提示已经选择了
	   	});
	   	
	   	//点击跳动的动画让动画显示文字
	   	var infoWindow   = new BMap.InfoWindow(
	   	"<p style='font-size:14px;'>这就是要添加的饭店吗？"+
	   	"<input type='button' value='确定' onclick='map.closeInfoWindow()' title='关闭这个窗口'>"+
	   	"<input type='button' value='取消' onclick='removemarker()' title='移除marker标记'></p>"
	   	);
   	 	marker.addEventListener("click",function(){
			this.openInfoWindow(infoWindow);  	 	
   	 	});
	   	}
	   	//移除marker标记
   	 	function  removemarker(){
   	 		map.removeOverlay(marker); //移除marker标记
   	 		map.addEventListener("click",showPoin);  //重新获取鼠标点击
   	 		//清空定位位置信息,并将显示框隐藏
   	 		$("#info_lng").val("");
   	 		$("#info_lat").val("");
   	 		$("#info_lngs").val("");//将值注入到隐藏域中
   			$("#info_lats").val("");
   	 		resultGpspoint();							//提示已经选择了
	   	 	$("#info_lng").attr("style","display:none ");
			$("#info_lat").attr("style","display:none ");
			$("#hiddren").attr("style","display:none");
			$("#show").show();
   	 	}
   //添加鼠标点击事件
 //  map.addEventListener("click",showPoin);
   
   //添加鼠标右击事件
   var contextMenu  = new BMap.ContextMenu();
   var txtMenuItem = [
   {
   text:'放大',
   	callback:function(){ map.zoomIn(); }
   },
    {
   text:'缩小',
   callback:function(){map.zoomOut();}
  },
  {
   text:'放置到最大级',
   callback:function(){map.setZoom(18);}
  },
  {
   text:'查看全国',
   callback:function(){map.setZoom(4);}
  },
  {
  text:'在此添加标注',
  callback:function(p){
  	inmarker(p);
  	map.removeEventListener("click",showPoin);    //移除标记,及点击别处不会生成新的
  }
  }
   ];
   for(var i=0; i < txtMenuItem.length; i++){
	  contextMenu.addItem(
	  		new BMap.MenuItem(txtMenuItem[i].text,txtMenuItem[i].callback,100)
	  		);
		  if(i==1 || i==3) {
		   contextMenu.addSeparator();
		  }
 }
 map.addContextMenu(contextMenu);
   
</script>

</body>
</html>
