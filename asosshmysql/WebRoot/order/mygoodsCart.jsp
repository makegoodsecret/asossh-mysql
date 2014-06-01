<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>  
    <base href="<%=basePath%>">
    
    <title>我的购物车</title>
    
 
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/downrun.css"> 
 	 <link rel="stylesheet" type="text/css" href="<%=basePath%>css/messageShow.css"> 
	  <script type="text/javascript" src="<%=basePath%>js/messageShow.js"></script>  
<%-- 	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> --%>
<style type="text/css">
body{font-family: georgia;}
#common_box {
	width: 350px; position: fixed;
	_position: absolute; right: 0;
	top: 27%; border: 5px solid #ff0000;
	border-radius:20px 20px; background: #fff;z-index: 88;}
.imgllr{border: 1px solid #eee;border-radius:20px 20px;}
#cli_on {width: 25px;height: 400px;float: left;cursor: pointer;
	background: #ac8932;border: 1px solid #eee;
	border-radius:20px 20px;text-align: center;line-height: 350px}
.text-overflow{	/*限制字符显示的长度*/
	display:block;width:50em;word-break:keep-all;
	white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
.input-overflow{	/*禁止换行*/
	white-space:nowrap;overflow:hidden;text-overflow:ellipsis;
}
.mycatbutton {  text-align: center;background: #82ce18;font-size: 8px;font-weight:normal; cursor: pointer;color: #000 ;}
.mycatbuttontwo {  text-align: center;background: #ECBB00;font-size: 8px;font-weight:normal; cursor: pointer;color: #000 ;}

</style>

<script type="text/javascript">
     function  mygoodsCartLoad() { 
    var combox = document.getElementById("common_box");
    var cli_on = document.getElementById("cli_on");
    var flag = true, timer = null, initime = null, r_len = 0;
   
    cli_on.onclick = function () {
     //如果不需要动态效果，这两句足矣
   /*  combox.style.right = flag?'-270px':0;
    flag = !flag; */
    
    clearTimeout(initime);
    //根据状态flag执开展开收缩
    if (flag) {
	    r_len = 0;
	    timer = setInterval(slideright,0);
	 } else {
	    r_len = -325;
	    timer = setInterval(slideleft, 0);
	    }
    };
     //展开
    function slideright() {
	    if (r_len <= -325) {
		    clearInterval(timer);
		    flag = !flag;
		    $(".imgllr").attr("src","<%=basePath %>image/imagesshow/orderleft.png");
		    return false;
	    } else {
		    r_len -= 5;
		    combox.style.right = r_len + 'px';
	    }
    }
    //收缩
    function slideleft() {
	    if (r_len >= 0) {
		    clearInterval(timer);
		    flag = !flag;
		    $(".imgllr").attr("src","<%=basePath %>image/imagesshow/orderreght.png");
		    return false;
	    } else {
		    r_len += 5;
		    combox.style.right = r_len + 'px';
	    }
    }
    //加载后1秒页面自动收缩
    initime = setTimeout("cli_on.click()", 0);
    };
    
    </script>
    
  <!-- 向下滚动 -->
  <script type="text/javascript">
    $(function(){
	    var _BuyList=$("#buyList");
        var Trundle = function () {
            _BuyList.prepend(_BuyList.find("li:last")).css('marginTop', '-120px');
            _BuyList.animate({ 'marginTop': '0px' }, 800);
        };
        var setTrundle = setInterval(Trundle, 3000);
        _BuyList.hover(function () {
            clearInterval(setTrundle);
            setTrundle = null;
        },function () {
            setTrundle = setInterval(Trundle, 3000);
        });
    });
    /*手动调节下滑*/
    function handertrundledown(){
     	var _BuyList=$("#buyList");
     	  _BuyList.prepend(_BuyList.find("li:last")).css('marginTop', '-120px');
            _BuyList.animate({ 'marginTop': '0px' }, 800);
     	
    }
       /*计算*/
       function  stickCut( cartid,count){	//减数量
       		messagerShow("正在为你改变数量");
        	var number=+$("#number"+count).val().trim();
        	var mealPrice=+$("#mealPrice"+count).val();
        	number=number-1;
        	if (number>0) {
        		$("#number"+count).val(number);
        		
			}else if(number==0){
				if(window.confirm("是否删除")){
					 daleteCart(cartid,count);//减为0时提示是否删除
					stickajax(0,cartid,number,-1,1,-mealPrice  ,"cart!stickCRUD.action");	//ajax操作 -1指不用判断是否是套餐还是普通的美食
					$("#tinysun"+count).val(mealPrice*number);							//更改小计
				}else{
					return false;
				}
				return false;
			}
			stickajax(0,cartid,number,-1,1,-mealPrice  ,"cart!stickCRUD.action");	//ajax操作 -1指不用判断是否是套餐还是普通的美食
			$("#tinysun"+count).val(mealPrice*number);	
       }
       function  stickAdd( cartid,addcount){	//增加数量  
       	messagerShow("正在为你改变数量");
       	//alert($("#tinysun"+addcount).val());
       	 var number=+$("#number"+addcount).val().trim();
       	 var mealPrice=+$("#mealPrice"+addcount).val();
       	 number=number+1;
       	 $("#number"+addcount).val(number);
       	 stickajax(0,cartid,number,-1,1,mealPrice  ,"cart!stickCRUD.action");	//ajax操作  -1指不用判断是否是套餐还是普通的美食
       	 $("#tinysun"+addcount).val(mealPrice*number);							//更改小计
       }
       /*输数量*/
       function stickupdate(cartid,count){
       	 var number=+$("#number"+count).val().trim();
       	 var mealPrice=+$("#mealPrice"+count).val().trim();
       	 if (isNaN(number)) {
			messagerShow("输入的数量无效");
			 $("#number"+count).val(1);
			return false;
		}else if(number<1){
		 	$("#number"+count).val(1);
			messagerShow("输入的数量不能小于1");
			return false;
		}
		var tiny  = +$("#tinysun"+count).val().trim();		//获得小计
		var updatetiny =mealPrice*number-tiny;
		stickajax(0,cartid,number,-1,1,updatetiny  ,"cart!stickCRUD.action" );	//ajax操作 -1指不用判断是否是套餐还是普通的美食
		$("#tinysun"+count).val(mealPrice*number);							//更改小计
       }
       /*删除*/
       function  daleteCart(cartid,count){ 
		       if (window.confirm("是否删除")) {
			       messagerShow("正在删除");
			       var updatetiny  = +$("#tinysun"+count).val().trim();		//获得小计
			        var  addcountid= +$("#addcountid").val();		//在购物车的序号
			       	var hiddencutcountid =+$("#hiddencutcountid").val();   //假删除了几条 
			      	 hiddencutcountid++;
			      	 $("#hiddencutcountid").val(hiddencutcountid);
			      	 var  showcount =addcountid-hiddencutcountid;
			       	 $("#suncount").html(showcount);//显示总份数减一，其实没有变
			      	var zerosuncount =	+$("#suncount").html();
			      	 if (zerosuncount==0) {    //如果显示为0条就提示为空
							var isempty="<li><div id='isemptyldiv' style='width: 200px; height: 30px; font-family: 宋体; font-size: 20px;'>你的菜单空空如也……</div></li>";
							 $("#buyList").append(isempty);
							 $("#mycartaddfoot").hide();	
					}
			       	$("#mycartli"+count).attr("style","display: none");
			        stickajax(0,cartid,0,-1,2,-updatetiny ,"cart!stickCRUD.action");	//ajax操作   -1指不用判断是否是套餐还是普通的美食
			}
       }
       /*添加留言*/
       function orderAds(cartid,count){ 
       	messagerShow("留言操作中请稍候");
       	var orderAds=$("#orderAds"+count).val().trim();
       	$("#orderAds"+count).attr("style","display: none");
       		  	$.ajax({
       		"url":"<%=basePath%>asossh/cart!stickCRUD.action",
       		"type":"post",
       		"data":{"goodormealId":0,"goodsCartPojo.cartId":cartid,"goodsCartPojo.orderAds":orderAds,"goodormeal":-1,"status":3},
       		"success":function(data,type){
       			var messager ;
       			if (data) {
					  messager="留言成功"; 
       				$("#orderAdsbutton"+count).attr("style","display:none");
			       	$("#orderAdsmgs"+count).html("留言:"+orderAds);
				}else{
					  messager="留言失败";  
				}
				messagerShow(messager);
       		},
       		"error":function(){
       			messagerShow("操作失败!");
       		}
       	});
       }
       /*总计*/
       function setsumprice(sumprice){
       	var price=$("#prices").val().trim()*1;		//获取总价
       	var sum =price+sumprice*1;
       	$("#sum").html(sum.toFixed(2));			//更改总价
       	$("#prices").val(sum);						//将总价重新注入到隐藏域中
       }
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
       /*AJax处理*/
        function stickajax(goodormealId,cartid,number,goodormeal,status ,updatetiny,CRUD){
        //updatetiny 修改总价
       	$.ajax({
       		"url":"<%=basePath%>asossh/"+CRUD,
       		"type":"post",
       		"data":{"goodormealId":goodormealId,"goodsCartPojo.cartId":cartid,"number":number,"goodormeal":goodormeal,"status":status},
       		"success":function(data,type){
       			var messager="" ;
       			if (data) {
					switch (status) { case 1: messager="修改成功";  break; case 2: messager="删除成功";  break; }
					setsumprice(updatetiny);//修改总价	
				}else{
					switch (status) { case 1: messager="修改失败"; break; case 2: messager="删除失败"; break; }
				}
				messagerShow(messager);
       		},
       		"error":function(){
       			messagerShow("操作失败!");
       		}
       	});
       };
    /*动态追加我的购物车 */
    function addCart(goodormealId,goodormeal){ 
    if (!userislogin()) { //用户没有登录
		 userloginjs();    //显示用户登录
	}else{
    messagerShow("正在添加购物车……");
    var zerosuncount =	+$("#suncount").html();
    /* goodormealId  :  为美食或者是套餐 的id
    	goodormeal    : 美食还是套餐  */
    var  addcountid= +$("#addcountid").val().trim();		//在购物车的序号
    var  addcountnowid=addcountid+1;						//追加后的序号
     var url  ="<%=basePath%>asossh/cart!addcart.action";
    	$.getJSON(url,{"goodormealId":goodormealId,"goodormeal":goodormeal,"addcountnowid":addcountnowid}, function(data){
	 	 if (data.bool) {
			 if (zerosuncount==0) {    //如果显示为0条就提示为空
   			 $("#isemptyldiv").attr("style","display:none");
   			 $("#mycartaddfoot").show();
    	}
			 $("#buyList").append(data.str);				 //动态追加
			 $("#addcountid").val(addcountnowid);			//更改购物车的长度
			$("#suncount").html(addcountnowid);				//总份数加一
		 	var mealPrice=+$("#mealPrice"+addcountnowid).val().trim();		//获取单价
			setsumprice(mealPrice);							//更改总价
			messagerShow("添加成功");							//成功提示信息
		}else{
			//已经存在在原来的基础上加1 
			 var cartId =data.cartId;
			 var count  =$("#cartId"+cartId).val().trim();
			 var number=+$("#number"+count).val().trim();
       		 var mealPrice=+$("#mealPrice"+count).val().trim();
       		 number=number+1;
	       	 $("#number"+count).val(number);
	       	 $("#tinysun"+count).val(mealPrice*number);	
	       	 setsumprice(mealPrice);						//更改总价	
	       	 messagerShow("添加了一份");							//成功提示信息
		}
		});  
		}
    }
     //保留小数点后两位
	function gettoFixed(number,afternumber){
		return    number.toFixed(afternumber);
	}
    /*收藏 */
    function userCol(goodormealIdorhotel,goodormealorhotel){
    
    if (!userislogin()) { //用户没有登录
		 userloginjs();    //显示用户登录
	}else{
    /* goodormealIdorhotel  :  为美食或者是套餐 的id
    	goodormealorhotel    : 美食还是套餐*/
     	$.ajax({
       		"url":"<%=basePath%>asossh/userCol!userColaddordel.action",
       		"type":"post",
       		"data":{"goodormealId":goodormealIdorhotel,"goodormeal":goodormealorhotel},
       		"success":function(data,type){
       			if (data==1) {
       				messagerShow("已经收藏");
				}else if (data==2) {
       				messagerShow("收藏成功");
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
    /*更新显示购物车*/
    function showdatamycart(){
    	var url ="<%=basePath %>asossh/cart!ajaxaddcart.action"; 
    	$.getJSON(url,function(data){
    		$("#isemptylistli").empty(); //删除购物车为空提示
    		$("#buyList").append(data.buyListli); // 更新购物车
    		$("#ismycartfoot").empty();
    		$("#ismycartfoot").append(data.ismycartfoot);//显示总价栏
    	});
    }
    </script>
   </head>
  <body  background="<%=basePath %>image/bg.jpg" >  
    <div id="common_box" class="common_box">
    <div id="cli_on">
    <img alt="+" class="imgllr" src="<%=basePath %>image/imagesshow/orderreght.png" width="25px"  height="400px" ></div>
    <div>
<!--     这里放置菜单内容 -->
    <div class="share"  >
    	<div style="border: 1px solid #aa7654; border-radius:10px 10px 10px 10px; text-align: center;">
    		<a href="<%=basePath %>asossh/cart!mycart.action" style="font-size:20px; color: black; font-family: 宋体;">我的菜单</a>
    	</div>
  <div class="buyList" >
	<ul id="buyList" >
		<s:set name="sumprice">0</s:set><!-- 统计总额 -->
		<s:set name="addcount">0</s:set><!-- 统计一共有多少,方便直接添加 -->
		<s:set name="isemptylist">${ goodsCartPojosList == '[]' || goodsCartPojosList == '{}' || user == null || user == '' }</s:set>
		<s:if test="#isemptylist">
			<li id="isemptylistli">
					<div id="isemptyldiv" style="width: 200px; height: 30px; font-family: 宋体; font-size: 20px;">你的菜单空空如也……</div>
			</li>
		</s:if>
		<s:else>
		<s:iterator value="goodsCartPojosList" status="status"  >
		<li id="mycartli${status.count}">
			<!-- 套餐 -->
		<s:if test="mealPojo.mealId!=null">
			<div style="font-size: 15px; ">
			 <input type="hidden" id="mealcartid${status.count}" value="${cartId }">
			 套餐名：  ${mealPojo.mealName}  
			<button type="button" class="mycatbuttontwo" onclick='daleteCart("${cartId}","${status.count}");' >删除</button>
			<div>
				<s:iterator value="mealPojo.goodsInfoPojo">
					<a style="color: #000000; font-size: 15px;"  href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsId}" title="${goodsDis}" target="_blank" > 
						${goodsName }
					</a>
				</s:iterator>
			</div>
			<div  >
			单价:&yen;&nbsp;${mealPojo.mealPrice}
			<input type="hidden" id="cartId${cartId}" value="${status.count}">
			<input type="hidden" value="${mealPojo.mealPrice}" id="mealPrice${status.count}">
			<!-- 小计 -->
			<input type="hidden" value="${mealPojo.mealPrice*goodsNumber}" id="tinysun${status.count}">
			<s:set name="sumprice">${sumprice+mealPojo.mealPrice*goodsNumber}</s:set>
			</div>
			<div >
			 <button type="button" class="mycatbutton" onclick='stickCut("${cartId}","${status.count}")' >-</button>
			 <input type="text" size="5" id="number${status.count}" value="${goodsNumber }" onkeyup='stickupdate("${cartId}","${status.count}")'>
			 <button type="button" class="mycatbutton" onclick='stickAdd("${cartId}","${status.count}")'>+</button>份
			</div>
				<s:if test="orderAds!=null">
						备注：<b>${orderAds}</b>
				</s:if>
				<s:else>
							<button type="button" class="mycatbutton" id="orderAdsbutton${status.count}" onclick='orderAds(${cartId},${status.count})'>添加留言</button>
							<input type="text" size="15" id="orderAds${status.count}">
							<b id="orderAdsmgs${status.count}" ></b>
				</s:else>
				</div>
		</s:if>
		<s:else>
			<div style=" height: 100%;">
				<div style="float: left;">
					<a href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" title="${goodsInfoPojo.goodsDis}" target="_blank" class="pic"> 
						<img src="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }" alt="${goodsInfoPojo.goodsDis}" width="80px" height="60px" />
					</a>
				</div>
				<div style="float: left; ">
					<div>
						<label style="margin-left: 10px;  font-size: 15px;">菜名:</label>
						<a style="color: #000000; font-size: 15px;"  href="<%=basePath %>asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId=${goodsInfoPojo.goodsId}" title="${goodsInfoPojo.goodsDis}" target="_blank" > 
							${goodsInfoPojo.goodsName }
						</a>
						<button type="button"  class="mycatbuttontwo" onclick='daleteCart(${cartId},${status.count});'>删除</button>
					</div>
					<div>
							<label style="margin-left: 10px;  font-size: 15px;">单价:</label>
							<font style="font-size: 14px; color: #222222">&yen;</font> ${goodsInfoPojo.goodsPrice }
					</div>
					<div> 
						 <button type="button" class="mycatbutton"  onclick='stickCut(${cartId},${status.count})'>-</button>
			 			 <input type="text" size="5" id="number${status.count}" value="${goodsNumber }" onkeyup='stickupdate(${cartId},${status.count})'>
			 			 <button type="button"  class="mycatbutton"  onclick='stickAdd(${cartId},${status.count})'>+</button>份
					</div>
				</div>
				<div style="clear: both; ">
					<s:if test="orderAds!=null">
							留言：<b>${orderAds}</b>
					</s:if>
					<s:else>
						<button type="button" class="mycatbutton" id="orderAdsbutton${status.count}" onclick='orderAds(${cartId},${status.count});'>添加留言</button>
						<input type="text" size="15" id="orderAds${status.count}">
						<b id="orderAdsmgs${status.count}" ></b>
					</s:else> 
				</div>
				<!-- 隐藏值 -->
				<input type="hidden" id="mealcartid${status.count}" value="${cartId }">
				<input type="hidden" id="cartId${cartId}" value="${status.count}">
				<input type="hidden" value="${goodsInfoPojo.goodsPrice}" id="mealPrice${status.count}">
				<input type="hidden" value="${goodsInfoPojo.goodsPrice*goodsNumber}" id="tinysun${status.count}">
				<!-- 计算 -->
				<s:set name="sumprice">${sumprice+goodsInfoPojo.goodsPrice*goodsNumber}</s:set>
			</div>
			</s:else>
			<s:set name="addcount">${addcount+1}</s:set>
		</li>
		</s:iterator>
		</s:else>
	</ul>
   <!-- 其他的操作 -->
  </div>
</div>
	 	<div  id="ismycartfoot">
	 	<s:if test="#isemptylist">
			<script type="text/javascript">
				$(function(){
					$("#mycartaddfoot").attr("style","display:none");				
				});
			</script>
		</s:if>
		<div id="mycartaddfoot">
		    <input type="hidden" value="${addcount }" id="addcountid">
		 	<input type="hidden" id="prices" value="${sumprice}" >
		 	<input type="hidden" value="0" id="hiddencutcountid">
	 		<label style="font-size: 18px; ">
	 		需支付:<font style="font-size: 20px; ">&yen;</font> 
	 		<font id="sum">
		 		<fmt:formatNumber  pattern="#0.00">${sumprice }</fmt:formatNumber>
	 		</font>
	 		(总计:<font id="suncount">${addcount }</font>份)
	 		</label>
		 	<div align="center">
		 		<button type="button" id="subbutton"  onclick="javascript:window.location.href='<%=basePath %>asossh/cart!mycart.action'"
		 		style=" width: 120px; height: 30px; border: 1px solid #aa7654; border-radius:10px 10px 10px 10px; text-align: center; font-family:仿宋; background: #82ce18; font-size: 20px; font-weight: bold;  " 
		 		 >我的订单</button>
		 		 <button type="button" class="mycatbutton" onclick="handertrundledown();"
		 		 style=" width: 80px; height: 30px; margin-left:20px;border: 1px solid #aa7654; border-radius:10px 10px 10px 10px; text-align: center; font-family:仿宋; background: #82ce18; font-size: 20px; font-weight: bold;  "
		 		 >其他 </button>
			</div>
		 </div>
	 	</div>
</div>
</div>
   
   </body>
    </html>
    
