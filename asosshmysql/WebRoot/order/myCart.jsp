<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的购物车</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	
<style type="text/css">
#screenshot{
	position:absolute;
	border:1px solid #ccc;
	background:#333;
	padding:5px;
	display:none;
	color:#fff;
	}

a:link {color: #FF0000}     /* 未访问的链接 */
a:visited {color: #00FF00}  /* 已访问的链接 */
a:hover {color: #FF00FF}    /* 当有鼠标悬停在链接上 */
a:active {color: #0000FF}   /* 被选择的链接 */
</style>
<script type="text/javascript">
//鼠标移过形式图片
this.screenshotPreview = function(){	
		xOffset = 250;
		yOffset = 30;
	$("a.screenshot").hover(function(e){
		this.t = this.title;
		this.title = "";	
		var c = (this.t != "") ? "<br/>" + this.t : "";
		$("body").append("<p id='screenshot'><img src='"+ this.rel 
		+"' alt='url preview' width='300px' height='200px' />"+ c
		 +"</p>");								 
		$("#screenshot")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px")
			.fadeIn("fast");						
    },
	function(){
		this.title = this.t;	
		$("#screenshot").remove();
    });	
	$("a.screenshot").mousemove(function(e){
		$("#screenshot")
			.css("top",(e.pageY - xOffset) + "px")
			.css("left",(e.pageX + yOffset) + "px");
	});			
};
$(document).ready(function(){
	screenshotPreview();
});

</script>
<script type="text/javascript">
	//减
	function  cutbutton(id){
		var  cartid  =$("#cartId"+id).val()*1;
		var number  =$("#number"+id).val().trim()*1;
		var price   =$("#price"+id).val().trim()*1;		//单价
		var  tiny  =$("#tiny"+id).val().trim()*1;   //小计
		if (number<=1) {
			$("#cutbutton"+id).attr("disabled",true);
			number=1;
		}else{
			number--;
			if (number==1) {
				$("#cutbutton"+id).attr("disabled",true);
			}
		}
			$("#number"+id).val(number);
		var updatetiny =price*number-tiny ;
		statuajax(-1,cartid,number,-1,1 ,updatetiny,"cart!stickCRUD.action");
		$("#tiny"+id).val(gettoFixed(price*number,2));
		$("#tinymsg"+id).html("&yen;"+gettoFixed(price*number,2));
	}
	//加
	function  addbutton(id){
		var  cartid  =$("#cartId"+id).val()*1;
		var number  =$("#number"+id).val().trim()*1;
		var price   =$("#price"+id).val().trim()*1;		//单价
		var  tiny  =$("#tiny"+id).val().trim()*1;   //小计
		if ($("#cutbutton"+id).attr("disabled")=="disabled") {
			$("#cutbutton"+id).attr("disabled",false);
		}
		number ++;
		$("#number"+id).val(number);
		var updatetiny =price*number-tiny ;
		statuajax(-1,cartid,number,-1,1 ,updatetiny,"cart!stickCRUD.action");
		$("#tinymsg"+id).html("&yen;"+gettoFixed(price*number,2));
		$("#tiny"+id).val(gettoFixed(price*number,2));
	}
	function updatenumbers(id){
		var number  =$("#number"+id).val().trim();
		if (number==""||isNaN(number)||number<=0) {
		  $("#number"+id).val(1);
		  $("#cutbutton"+id).attr("disabled","disabled");
		}
		updatenumber(id);
	}
	//更改数量
	function updatenumber(id){
	
	var  cartid  =$("#cartId"+id).val()*1;
	var number  =$("#number"+id).val().trim();
	var  tiny  =$("#tiny"+id).val().trim()*1;   //小计
	if (number=="") {
		setTimeout("updatenumbers("+id+")",600);
	}else{
			number=number*1;
		var price   =$("#price"+id).val().trim()*1;		//单价
		if (number<=0) {
			number=1;
			$("#cutbutton"+id).attr("disabled","disabled");
			$("#number"+id).val(number);
		}else if(number==1){
			$("#cutbutton"+id).attr("disabled","disabled");
		}else{
			$("#cutbutton"+id).attr("disabled",false);
		}
		var updatetiny =price*number-tiny ;
		statuajax(-1,cartid,number,-1,1 ,updatetiny,"cart!stickCRUD.action");
		$("#tiny"+id).val(gettoFixed(price*number,2));
		$("#tinymsg"+id).html("&yen;"+gettoFixed(price*number,2));
	}
	}
	//保留小数点后两位
	function gettoFixed(number,afternumber){
		return    number.toFixed(afternumber);
	}
	//更改总价
	function updatesum(updatetiny){
		var  sum = $("#sum").val().trim()*1;
		sum= sum+updatetiny*1;
		$("#sum").val(gettoFixed(sum,2));
		$("#checkboxsum").val(gettoFixed(sum,2));			//按钮次总价
		$("#summsg").html("商品总价(不含运费) <font size='4' >&yen;"+gettoFixed(sum,2)+"</font>");
	}
	function  statuajax(goodormealId,cartId,number,goodormeal,status ,updatetiny,CRUD){
		$.ajax({
			"url":"<%=basePath%>asossh/"+CRUD,
			"type":"post",
			"data":{"goodormealId":goodormealId,"goodsCartPojo.cartId":cartId,"number":number,"goodormeal":goodormeal,"status":status},
			"success":function(data,statu){
			var hotelId = $("#cartIdishotelid"+cartId).val();
			if ($("#hotel"+hotelId+"checkbox"+cartId).attr("checked")=="checked") {	//判断按钮是否选中
				updatesum(updatetiny);
			}else{
				var  sum = $("#sum").val().trim()*1;
				sum= sum+updatetiny*1;
				$("#sum").val(gettoFixed(sum,2));
			}
			},
			"error":function(){
			alert("出错了");
			}
		});
	}
	//单选按钮更改总价啊
	 function checkboxsum(updatetiny){
	 	var checkboxsum  =$("#checkboxsum").val().trim()*1;
	 	checkboxsum= checkboxsum+updatetiny*1;
		$("#checkboxsum").val(gettoFixed(checkboxsum,2));
		 $("#summsg").html("商品总价(不含运费) <font size='4' >&yen;"+gettoFixed(checkboxsum,2)+"</font>");
	 }
	$(function(){
	 $("#hotelheadcheckboxall").click(function(){
	 	if($("[name='checkboxhead']:checkbox").attr("checked")=="checked"){//全选
	 		//input[name^='checkbox'] 匹配出所有name是以checkbox开头的
		 	$("input[name^='checkbox']:checkbox").attr("checked",true);
		 	var updatetiny =$("#sum").val().trim()*1;
	 		checkboxsum(updatetiny);			//更改显示总价
	 		$("#subbutton").attr("disabled",false);
	 	}else{//取消全选
	 		$("input[name^='checkbox']:checkbox").attr("checked",false);
	 		var updatetiny =$("#sum").val().trim()*(-1);
	 		checkboxsum(updatetiny);		//更改显示总价
	 		$("#subbutton").attr("disabled",true);
	 	}
	 });
	 $("#footcheckboxall").click(function(){
	 	if($("[name='checkboxfoot']:checkbox").attr("checked")=="checked"){//全部选中
		 	$("input[name^='checkbox']:checkbox").attr("checked",true);
		 	var updatetiny =$("#sum").val().trim()*1;
	 		checkboxsum(updatetiny);      //更改显示总价
	 		$("#subbutton").attr("disabled",false);
	 	}else{//取消
	 		$("input[name^='checkbox']:checkbox").attr("checked",false);
	 		var updatetiny =$("#sum").val().trim()*(-1);
	 		checkboxsum(updatetiny);     //更改显示总价
	 		$("#subbutton").attr("disabled",true);
	 	}
	 });
	});
		//处理层级按钮
	function hotelcheck(hotelId){
		if($("#hotel"+hotelId).attr("checked")=="checked"){ //选中
			//得到该饭店下的套餐或美食的购物车的id,及单选按钮下的value
			$("input[id^='hotel"+hotelId+"checkbox']:checkbox").map(function(){
			 	//return $(this).val();
			 	if (!($("#hotel"+hotelId+"checkbox"+$(this).val()).attr("checked")=="checked")) {   //没有选中的重新计算
					hotelmealorcart($(this).val(),1);	
				}
			 });
			 //input[id^='hotel"+hotelId+"'] 匹配出所有id是以'hotel"+hotelId+"'开头的
			$("input[id^='hotel"+hotelId+"']:checkbox").attr("checked",true);
			 $("#subbutton").attr("disabled",false);
			 //判断是否全部选中
			var status  =0;
			 $("input[id^='checkboxhotel']:hidden").map(function(){
			 	//判断其他是否都处于选中状态
			 	if(!($("#hotel"+$(this).val()).attr("checked")=="checked")&&($(this).val()!=hotelId)){  
			 	//如果有为没有选中的就不处理
			 		status++;
			 	}
			 });
			 //处理全选状态
			 if(status==0){
			 	$("[name='checkboxhead']:checkbox").attr("checked",true);
			 	$("[name='checkboxfoot']:checkbox").attr("checked",true);
			 	$("#subbutton").attr("disabled",false);		//能提交
			 }else{
			 	$("[name='checkboxhead']:checkbox").attr("checked",false);
			 	$("[name='checkboxfoot']:checkbox").attr("checked",false);
			 }
		}else{ //取消选中
			$("input[id^='hotel"+hotelId+"']:checkbox").attr("checked",false);
			//得到该饭店下的套餐或美食的购物车的id,及单选按钮下的value
			$("input[id^='hotel"+hotelId+"checkbox']:checkbox").map(function(){
			 //return $(this).val();
			 //alert($(this).val());
			 hotelmealorcart($(this).val(),-1);			
			 });
			var status  =0;
			//判断是否全部取消选中
			$("input[id^=checkboxhotel]:hidden").map(function(){
				var hotelIdvar=$(this).val();
				$("input[name^=checkboxcartId]:checkbox").map(function(){
					if(($("#hotel"+hotelIdvar+"checkbox"+$(this).val()).attr("checked")=="checked")&&(hotelIdvar!=hotelId)){  
					 		status++;
					 }
				 });
			 });
			 if(!status==0){
			 	$("[name='checkboxhead']:checkbox").attr("checked",false);
			 	$("[name='checkboxfoot']:checkbox").attr("checked",false);
			 }else{//全部取消
			 	$("#hotelheadcheckboxall").attr("checked",false);
			 	$("#footcheckboxall").attr("checked",false);
		 		$("#subbutton").attr("disabled",true);
			 }
		}
	}
	//饭店下的套餐或美食的购物车
	 function hotelmealorcart(cartId,mark){
		 var  tiny  =$("#tiny"+cartId).val().trim()*1;   //小计
		 //alert("tiny*mark=="+tiny*mark);
		 checkboxsum(tiny*mark);     //更改显示总价
	 }
	 //处理具体的套餐后美食的单选
	 function goodsormealcheck(cartId ,hotelId){
	 if ($("#hotel"+hotelId+"checkbox"+cartId).attr("checked")=="checked") {
		hotelmealorcart(cartId,1);
		$("#subbutton").attr("disabled",false);		//能提交
		//更改全选状态
		//先判断同级是否选中
		var  status  =0;
		$("input[id^=hotel"+hotelId+"checkbox]:checkbox").map(function(){
			if(!($("#hotel"+hotelId+"checkbox"+$(this).val()).attr("checked")=="checked")&&($(this).val()!=cartId)){  
			 	//如果没有选中的就处理，饭店选中
			 		status++;
			 	}
		});
		//alert(status);
		if(status==0){
			//更该店铺是否选中
			$("#hotel"+hotelId).attr("checked",true);
			//判断其他饭店是否都选中
			status=0;
			$("input[id^=checkboxhotel]:hidden").map(function(){
				 	//判断其他饭店是否都处于选中状态
			var hotelIdvar=$(this).val();
			$("input[name^=checkboxcartId]:checkbox").map(function(){
				if(!($("#hotel"+hotelIdvar+"checkbox"+$(this).val()).attr("checked")=="checked")){  
				 		status++;
				 	}
			 });
			 });
			 if (status==0) {
				$("[name='checkboxhead']:checkbox").attr("checked",true);
				$("[name='checkboxfoot']:checkbox").attr("checked",true);
			}
		}
	}else{//取消选中
		hotelmealorcart(cartId,-1);
		//更该店铺是否选中
		$("#hotel"+hotelId).attr("checked",false);
		//更改全选状态
		$("[name='checkboxhead']:checkbox").attr("checked",false);
		$("[name='checkboxfoot']:checkbox").attr("checked",false);
		var  status  =0;
		$("input[id^=checkboxhotel]:hidden").map(function(){
			var hotelIdvar=$(this).val();
			$("input[name^=checkboxcartId]:checkbox").map(function(){
				if($("#hotel"+hotelIdvar+"checkbox"+$(this).val()).attr("checked")=="checked"){  
				 	//如果没有选中的就处理，饭店选中
				 		status++;
				 	}
			 });
	   });
		if (status==0) {
			$("#subbutton").attr("disabled",true);				//全部没有选中，不能提交
		}
	}
	 }
	 //修改留言
	 function updateadsclick(cartId){ 
	 	var orderAds =$("#adstext"+cartId).val();
		getajax(-1,cartId,orderAds,-1,3);	 
		$("#adstext"+cartId).attr("style","display:none");	
		$("#adsclickbutton"+cartId).attr("style","display:none");
		$("#updateadsclickbutton"+cartId).attr("style","display:");		
		$("#orderads"+cartId).html(orderAds);
	 }
	 //添加留言
	 function  adsclick(cartId){
	 	$("#addadsclickbutton"+cartId).attr("style","display:none");
		$("#adstext"+cartId).attr("style","display:");
		$("#adsclickbutton"+cartId).attr("style","display:");
	 }
	 //修改显示
	 function updateadsshow(cartId){
	 	$("#cartadsmsg"+cartId).html("");
	 	$("#orderads"+cartId).html("");
	 	$("#orderads"+cartId).attr("style","dispaly:none");
		$("#adstext"+cartId).attr("style","display:");	
		$("#adsclickbutton"+cartId).attr("style","display:");
		$("#updateadsclickbutton"+cartId).attr("style","display:none");		 
	 }
	 function  getajax(goodormealId,cartId,orderAds,goodormeal,status){
	 	$.ajax({
       		"url":"<%=basePath%>asossh/cart!stickCRUD.action",
       		"type":"post",
       		"data":{"goodormealId":goodormealId,"goodsCartPojo.cartId":cartId,"goodsCartPojo.orderAds":orderAds,"goodormeal":goodormeal,"status":status},
       		"success":function(data,type){
       		if(data){
       			$("#adstext"+cartId).attr("style","display:none");
       			$("#updateadsclickbutton"+cartId).attr("style","display:");
       			$("#adsclickbutton"+cartId).attr("style","display:none");
       		}else{
       			$("#cartadsmsg"+cartId).html("有误");
       		}
       		},
       		"error":function(){
       		}
       	});
	 }
	    /*收藏 */
    function romevecartincol(cartId){ 
        if (window.confirm("确定要移入收藏夹，并从购物车中删除商品")) {
     	$.ajax({
       		"url":"<%=basePath%>asossh/userCol!userremovecart.action",
       		"type":"post",
       		"data":{"goodsCartPojo.cartId":cartId},
       		"success":function(data,type){
       			if (data==1) {
       				messagerShow("已经收藏");
       				removecartinCol(cartId);  //页面上删除
				}else if (data==2) {
       				messagerShow("收藏成功");
       				removecartinCol(cartId); //页面上删除
				}else{
					messagerShow("收藏失败"); 
					}
       		},
       		"error":function(){
       			messagerShow("操作失败!");
       		}
       	});
		}   
    } 
    function   removecartinCol(cartId){
    		var hotelId = $("#cartIdishotelid"+cartId).val();
    		//(0.是否该只有一家饭店)
    		var hotelnumber=0;
    		$("input[id^=checkboxhotel]:hidden").map(function(){hotelnumber++});
     	 	//(1.是否该饭店只有一种美食)
     	 	var hotelgoodesmealnumber=0;
     	 	$("input[name^=checkboxcartId]:checkbox").map(function(){ hotelgoodesmealnumber++;});
			 if (hotelnumber==1) {
			 	if (hotelgoodesmealnumber==1) {//一家饭店一种美食
					//删除全部
					$("#tbodyid").remove();
					$("#tfootid").remove();
					$("#theadid").remove();
					var  bodytext="<tbody><tr><th colspan='7'  ><div style='font-family: 宋体;font-size: 20px;text-align: center;' > 你的菜单还是空的，赶紧行动吧……<br>你可以：<br>马上去<a href='javascipt:void(0)'>大家都点了些啥</a><br>"
	  	  					+"看看<a href='javascipt:void(0)'>已经成功买到的宝贝</a></div></th></tr></tbody>"
					$("#tablemycat").append(bodytext);
				}else{ //一家饭店多种美食
					//(2.判断该美食是否选中)
					 if ($("#hotel"+hotelId+"checkbox"+cartId).attr("checked")=="checked") {
					 	//删除2隐总1显中
					 	var  sum = +$("#sum").val().trim();
					 	var tiny =+$("#tiny"+cartId).val();
						sum= sum-tiny;
						$("#sum").val(gettoFixed(sum,2));
						$("#summsg").html("商品总价(不含运费) <font size='4' >&yen;"+gettoFixed(sum,2)+"</font>");
					 	var checkboxsumvar=+$("#checkboxsum").val();
					 	$("#checkboxsum").val(checkboxsumvar-tiny);
						 $("#tridgoodsormeal"+cartId).remove(); 
					 }else{
					 	//(3.判断该饭店其他美食的状态)
						var goodsormealcheckednumber=0;
						$("input[name^=checkboxcartId]:checkbox").map(function(){
							 if(($("#hotel"+hotelId+"checkbox"+$(this).val()).attr("checked")=="checked")&&($(this).val()!=cartId)){  
						 	     goodsormealcheckednumber++;
						 	}
						});
					 	if (goodsormealcheckednumber==hotelgoodesmealnumber) { //全部选中
							var  sum = +$("#sum").val().trim();
						 	var tiny =+$("#tiny"+cartId).val();
							sum= sum-tiny;
							$("#sum").val(gettoFixed(sum,2));
							//修改饭店的状态为选中
						 	$("#hotel"+hotelId).attr("checked",true);
							 $("[name='checkboxhead']:checkbox").attr("checked",true);
							 $("[name='checkboxfoot']:checkbox").attr("checked",true);
							 $("#tridgoodsormeal"+cartId).remove();  
						}else{
							var  sum = +$("#sum").val().trim();
						 	var tiny =+$("#tiny"+cartId).val();
							sum= sum-tiny;
							$("#sum").val(gettoFixed(sum,2));
						 	$("#tridgoodsormeal"+cartId).remove(); 
						}
					 
					 }
				}
			}else{
					//(2.判断该美食是否选中)
					 if ($("#hotel"+hotelId+"checkbox"+cartId).attr("checked")=="checked") {
					 	//删除2隐总1显中
					 	var  sum = +$("#sum").val().trim();
					 	var tiny =+$("#tiny"+cartId).val();
						sum= sum-tiny;
						$("#sum").val(gettoFixed(sum,2));
						$("#summsg").html("商品总价(不含运费) <font size='4' >&yen;"+gettoFixed(sum,2)+"</font>");
					 	var checkboxsumvar=+$("#checkboxsum").val();
					 	$("#checkboxsum").val(checkboxsumvar-tiny);
						 $("#tridgoodsormeal"+cartId).remove(); 
					 }else{
						//(3.判断该饭店其他美食的状态)
						var goodsormealcheckednumber=0;
						$("input[name^=checkboxcartId]:checkbox").map(function(){
							 if(($("#hotel"+hotelId+"checkbox"+$(this).val()).attr("checked")=="checked")&&($(this).val()!=cartId)){  
						 	     goodsormealcheckednumber++;
						 	}
						});
						if (goodsormealcheckednumber==hotelgoodesmealnumber) { //全部选中
						 
							  var  sum = +$("#sum").val().trim();
						 	var tiny =+$("#tiny"+cartId).val();
							sum= sum-tiny;
							$("#sum").val(gettoFixed(sum,2));
							//修改饭店的状态为选中
						 	$("#hotel"+hotelId).attr("checked",true);
							  var status  =0;
							 $("input[id^='checkboxhotel']:hidden").map(function(){
							 	//判断其他饭店是否都处于选中状态
							 	if(!($("#hotel"+$(this).val()).attr("checked")=="checked")&&($(this).val()!=hotelId)){  
							 	//如果有为没有选中的就不处理
							 		status++;
							 	}
							 });
							 //处理全选状态
							 if(status==0){
							 	$("[name='checkboxhead']:checkbox").attr("checked",true);
							 	$("[name='checkboxfoot']:checkbox").attr("checked",true);
							 }  
							 $("#tridgoodsormeal"+cartId).remove();  
						}else{
							var  sum = +$("#sum").val().trim();
						 	var tiny =+$("#tiny"+cartId).val();
							sum= sum-tiny;
							$("#sum").val(gettoFixed(sum,2));
						 	$("#tridgoodsormeal"+cartId).remove(); 
						}
					 }
				}
		var hotelsize = $("tr[name='hotelName"+hotelId+"']").length;  //判断饭店是否有美食或套餐
		if ( hotelsize == 0 ) {
		 	$("#trhotelid"+hotelId).remove(); //删除饭店
		}
    }
    function  deletecart(cartId){
        if (window.confirm("确定要移入收藏夹，并从购物车中删除商品")) {
     	$.ajax({
       		"url":"<%=basePath%>asossh/userCol!userdeletecart.action",
       		"type":"post",
       		"data":{"goodsCartPojo.cartId":cartId},
       		"success":function(data,type){
       			if (data==1) {
       				messagerShow("删除成功");
       				removecartinCol(cartId);  //页面上删除
				}else {
       				messagerShow("删除失败");
       				removecartinCol(cartId); //页面上删除
				} 
       		},
       		"error":function(){
       			messagerShow("操作失败!");
       		}
       	});
		}   
    
    }
</script>
  </head>
  <body  background="<%=basePath %>image/bg.jpg" >
  	  <center>
  	  <jsp:include page="../headfoot/head.jsp"></jsp:include> 
  	  <form action="<%=basePath %>asossh/cart!postMyCart.action" method="post"  name="myform">
  	  		<table border="0" background="<%=basePath %>image/bg.jpg" width="90%" id="tablemycat" >
  	  		<s:set name="isemptygoodsCartPojosMap">${goodsCartPojosMap=='[]'||goodsCartPojosMap=='{}' }</s:set>
			<s:if test="#isemptygoodsCartPojosMap">
  	  		<tr>
  	  			<th >
  	  				<div style="font-family: 宋体;font-size: 20px;text-align: center;">
  	  					你的菜单还是空的，赶紧行动吧……<br>
  	  					你可以：<br>
  	  					马上去<a href="javascipt:void(0)">大家都点了些啥</a><br>
  	  					看看<a href="javascipt:void(0)">已经成功买到的宝贝</a>
  	  				</div>
  	  			</th>
  	  			</tr>
	  		 </s:if>
	  		 <s:else>
			<thead  id="theadid" >
			<tr bgcolor="#E2F2FF">
				<th  width="5%" nowrap="nowrap">
					<input type="checkbox" name="checkboxhead" id="hotelheadcheckboxall"  checked="checked">全选<hr></th>
				<th  width="30%">店铺宝贝<hr></th>
				<th  width="15%">单价(元)<hr></th>
				<th  width="20%">数量<hr></th>
				<th  width="10%">小计(元)<hr></th>
				<th  width="10%">备注(留言)<hr></th>
				<th  width="10%">操作<hr></th>
			</tr>
			</thead>
			<tbody id="tbodyid">
				<s:set name="sum">0</s:set>
				<s:iterator value="goodsCartPojosMap" status="status" id="column">
				<tr bgcolor="#EBFFE1" id="trhotelid${key.hotelId }" >
					<td>
						<input type="checkbox" checked="checked" value="${key.hotelId }" name="checkboxhotel" id="hotel${key.hotelId }" onclick="hotelcheck('${key.hotelId }')">
						<input type="hidden" id="checkboxhotel${key.hotelId }" value="${key.hotelId }" >
					</td>	
					<td>
						饭店:<a href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${key.hotelId }"><font color="#000000">${key.hotelName }</font></a>
					</td>	
					<td colspan="5">
					<nobr>
					正常：市区(10:00-21:30)
					阴雨天：市区5公里(10:00-21:00)
					冻雪天：市区3公里(10:00-20:30)
					</nobr>
					</td>
				</tr>
				<s:iterator value="value"  status="hotelstatus">
				<tr name="hotelName${key.hotelId }" id="tridgoodsormeal${cartId }">
					<td>
						<input type="checkbox" name="checkboxcartId"  checked="checked" onclick="goodsormealcheck('${cartId }','${key.hotelId }')"  
						value="${cartId }" id="hotel${key.hotelId }checkbox${cartId }">
						<input type="hidden" id="cartIdishotelid${cartId }" value="${key.hotelId }" >
						<input type="hidden"  id="cartId<s:property value='cartId'/>" value="${cartId }">
					</td>
					<s:if test="goodsInfoPojo!=null">
					<td>
						<table>
							<tr>
								<td>
								<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}">
								<img alt="图片已经损坏" src="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }"  width="60px;" height="40px;"><br>			
								</a>								
								</td>
								<td>
								<font color="#8000ff">
								${goodsInfoPojo.goodsName }&nbsp;
								${goodsInfoPojo.goodsDis }&nbsp;
								${goodsInfoPojo.sortPojo.sortName }
								</font>	
								</td>
							</tr>
							<tr>
								<td>
								 <a class="screenshot" rel="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" 
									href=" <%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" >
								<font face="新宋体" size="2" color="#000000"><u>查看大图</u></font></a>
								</td>
								<td>
								</td>
							</tr>
						</table>
					</td>
<!-- 单价 -->			<td>
						&yen;<fmt:formatNumber value="${goodsInfoPojo.goodsPrice }" pattern="#0.00"></fmt:formatNumber>
						<input type="hidden" id="price${cartId}" value="${goodsInfoPojo.goodsPrice }">
					</td>
<!-- 数量 -->			<td>
						<button type="button" onclick='cutbutton("${cartId}");' id="cutbutton${cartId}" ${goodsNumber==1?"disabled='disabled'":"" } >-</button>
						<input type="text" size="5" id="number${cartId}" onkeyup='updatenumber("${cartId}")' value="${goodsNumber}">
						<button type="button" onclick='addbutton("${cartId}")' id="addbutton${cartId}">+</button>
					</td>
<!-- 小计 -->			<td>
						<s:set name="sum">${sum+goodsInfoPojo.goodsPrice*goodsNumber }</s:set>
						<span id="tinymsg${cartId}">
						&yen;<fmt:formatNumber value="${goodsInfoPojo.goodsPrice*goodsNumber }" pattern="#0.00"></fmt:formatNumber>
						</span>
						<input type="hidden" id="tiny${cartId}" value="${goodsInfoPojo.goodsPrice*goodsNumber }">
						
					</td>
					</s:if>
					<s:else>
					<!-- 套餐 -->
					<td>
						<table>
							<tr align="center">
								<td>
									${mealPojo.mealName}
								</td>							
							</tr>
							<tr align="center">
								<s:iterator value="mealPojo.goodsInfoPojo">
								<td>
								<font color="#8000ff">
								<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" 
								class="screenshot" rel="<%=basePath %>photo/<s:property value="goodsImagePojo.gimageImage"/>">
										<font style="font-family: 宋体;color:#22F;">${goodsName }
										</font>
								</a>		
								&nbsp;
								</font>	
								</td>
								</s:iterator>
							</tr>
						</table>
					</td>
					<td>
<!-- 单价 -->						&yen;<fmt:formatNumber value="${mealPojo.mealPrice }" pattern="#0.00"></fmt:formatNumber>
						<input type="hidden" id="price${cartId}" value="${mealPojo.mealPrice}">
					</td>
					<td>
<!-- 数量 -->			<button type="button" onclick='cutbutton("${cartId}");'  id="cutbutton${cartId}" ${goodsNumber==1?"disabled='disabled'":"" } >-</button>
						<input type="text" size="5" id="number${cartId}" onkeyup='updatenumber("${cartId}")' value="${goodsNumber}">
						<button type="button" onclick='addbutton("${cartId}")' id="addbutton${cartId}">+</button>
					</td>
					<td>
<!-- 小计 -->			<span id="tinymsg${cartId}">
						&yen;<fmt:formatNumber value="${mealPojo.mealPrice*goodsNumber }" pattern="#0.00"></fmt:formatNumber>
					</span>
					<s:set name="sum">${sum+mealPojo.mealPrice*goodsNumber}</s:set>
					<input type="hidden" id="tiny${cartId}" value="${mealPojo.mealPrice*goodsNumber}">
					</td>
					</s:else>
					<td >
						<s:if test="orderAds!=null">
						<b id="orderads${cartId}">${orderAds}</b>
						<button type="button" onclick='updateadsshow("${cartId}")' id="updateadsclickbutton${cartId}">修改</button>
						<input type="text" id="adstext${cartId}" size="10"  style=" display:none;" >
						<button type="button" onclick='updateadsclick("${cartId}")' id="adsclickbutton${cartId}" style="display: none;">确定</button>
						<b id="cartadsmsg${cartId }"><font color="red"></font> </b>
						</s:if>
						
						<s:else>
						<button type="button" onclick='adsclick("${cartId}")'  id="addadsclickbutton${cartId }"
							style=" padding-top: 3px;padding-left: 5px;padding-right: 5px;padding-bottom: 3px;"
						>添加留言</button>
						<input type="text" id="adstext${cartId}" size="10"  style=" display:none;"  >
						<button type="button" onclick='updateadsclick("${cartId}")' 
							id="adsclickbutton${cartId}" style=" display:none; "
						>确定</button>
						<b id="orderads${cartId}"></b>
						<button type="button" onclick='updateadsshow("${cartId}")' 
							id="updateadsclickbutton${cartId}" style=" display:none; "
						>修改</button>
						<b id="cartadsmsg${cartId }"><font color="red"></font> </b>
						</s:else>
					</td>
					<td>
					<a href="javascript:void(0)"  onmousedown='romevecartincol(${cartId });' >
					<font color="#8000aa" size="2">移入收藏夹</font></a><br>
					<a href="javascript:void(0)" onmousedown='deletecart(${cartId });' >
					<font color="#8000ff" size="2">删除</font></a>
					</td>
				</tr>
				</s:iterator>
				</s:iterator>					
			</tbody>
		<tfoot id="tfootid">
		<tr  bgcolor="#F3F3F3">
			<td nowrap="nowrap">
			<input type="checkbox" name="checkboxfoot" id="footcheckboxall" checked="checked">
			全选
			</td>
			<td>
				<a href="javascript:void(0)"  ><font color="#000000">批量删除</font></a>
				<a href="javascript:void(0)" ><font color="#000000">批量移入收藏夹</font></a>
			</td>
			<td colspan="3">
			</td>
			<td nowrap="nowrap" >
				<b id="summsg">
					商品总价(不含运费)
					<font size='4' > &yen;
					<fmt:formatNumber value="${sum }" pattern="#0.00"></fmt:formatNumber>
					</font>
				</b>
				<input type="hidden"  id="sum" 
					value="<fmt:formatNumber value='${sum }' pattern='#0.00'></fmt:formatNumber>">
				<input type="hidden"  id="checkboxsum" value="${sum }">
			</td>
			<td>
				<button type="submit"   id="subbutton"   
				style="   order-bottom-color:fuchsia ; padding-left: 15px;padding-right: 15px;padding-top: 10px;padding-bottom: 10px;"
				>结算</button>
			</td>
		</tr>
		</tfoot>
		</s:else>
		</table>
		</form>
  	  <jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </center>
   </body>
    </html>
    
