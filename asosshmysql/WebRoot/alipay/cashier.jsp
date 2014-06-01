<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>订单操作界面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
 <style type="text/css">
 	#bodydiv{
 		width: 90%;font-family: 仿宋; font-size: 20px;
 	}
 	#bodydiv>div{
 		width: 100%;
 		float: left;
 		margin-left: 5.5%;
 		margin-top:10px;
 		border-radius:10px 10px 10px 10px; 
 	}
 	#bodydiv>div>div{
 		float: left;
 		margin-left: 1%;
 		margin-top:10px; 
 		border-radius:10px 10px 10px 10px; 
 	}
 </style>
   <script type="text/javascript">
		 <%--  $(function(){
			$("#alipaysubmit").submit(function(){
				 $(this).ajaxSubmit({
				 	url:"<%=basePath %>asossh/alipay!alipaysavesign.action",
				 	type:"post",
				 	success:function(data,type){
				 		 $("#signdata").val(data);//获取加密数据
				 		 alipaysubmit.action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8";
				 		 alipaysubmit.submit();
				 	},error:function(XmlHttpRequest, textStatus, errorThrown){
				 		alert("出错了");
				 	}
				 })
				return false;
			})
		})  --%>
		function submitbutton(count){
			 $("#alipaysubmit"+count).ajaxSubmit({
				 	url:"<%=basePath %>asossh/alipay!alipaysavesign.action",
				 	type:"post",
				 	success:function(data,type){
				 		 $("#signdata"+count).val(data);//获取加密数据
				 		 $("#alipaysubmit"+count).action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8";
				 		 $("#alipaysubmit"+count).submit();  
				 	},error:function(XmlHttpRequest, textStatus, errorThrown){
				 		alert("出错了");
				 	}
				 })
			return false;
		}
	</script>
</head>
<body   background="<%=basePath %>image/bg.jpg" >
 <jsp:include page="../headfoot/head.jsp"></jsp:include>
	<div id="bodydiv"   align="center">
		<div style=" height: 30px; border: 1px solid #aa0000; text-align: left; ">
			<strong style="margin-left: 10px; "> 订单确认:</strong>
			<label>目前有<s:property value="goodsOrderPojomap.size()" />份订单
			</label>
		</div>
	 	<s:set name="goodsOrderPojomapisnull">${goodsOrderPojomap=='[]'||goodsOrderPojomap=='{}' }</s:set>
	 	<s:if test="#goodsOrderPojomapisnull">
	 		<div >
	 			订单为空
	 		</div>
	 	</s:if>
	 	<s:else>
	 	<div style="border: 1px solid #bb0000;">
	 		<s:iterator value="goodsOrderPojomap" status="status">
	 		<form id="alipaysubmit${status.count}" name="alipaysubmit" action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8" method="post">
	 		<div style="text-align: left;clear:left;  border: 1px solid #bb0000; padding-left: 5px; padding-right: 10px; padding-bottom: 5px;">
	 			<label style="font-family:黑体;">订单号:</label>
	 			${key }
	 			<s:set name="sumprice">0</s:set>
	 		<s:iterator value="value" status="valuestatus">
	 			<s:if test="#valuestatus.count==1">
			 		<div style="text-align: left; clear: left; ">
			 			<font style="font-size: 25px;font-family:黑体;">饭店:</font>
			 			${hotelPojo.hotelName } 
			 			<font style="font-size: 15px;">
				 			生成订单时间:${orderTime }
			 			</font>
			 		</div>
	 			</s:if>
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
	 		</s:iterator>
	 		<s:iterator value="value" status="valuestatus">
	 			<s:if test="#valuestatus.count==1">
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
	 			<!-- 卖家支付宝帐户 -->
	 			<input size="40"   type="hidden" name="seller_email" value="${hotelPojo.userPojo.payname } " />
	 			<!-- 商户订单号 -->
	 			<input size="40" type="hidden" name="out_trade_no" value="${key }"/> 
	 			<!-- 订单名称 -->
	 			<input size="40" type="hidden" name="subject" value="${hotelPojo.hotelName }的订单" />
	 			<!-- 付款金额 -->
	 			 <%-- <input size="40" type="hidden"  name="price" value="${sumprice }"/> --%>  
	 			<input size="40" type="hidden"  name="price" value="0.1"/>
	 			<!-- 订单描述 -->
	 			<input size="40" type="hidden" name="show_url" value="<%=basePath %>alipay/userorder.jsp"/>
	 			<!-- 收货人姓名 -->
	 			<input size="40" type="hidden" name="receive_name" value="${orderAddress.orderName }" />
	 			<!-- 收货人地址 -->
	 			<input size="40"  type="hidden" name="receive_address" value="${orderAddress.province }${orderAddress.city }${orderAddress.county }${orderAddress.otherAddress }"/>
	 			<!-- 收货人邮编 -->
	 			<input size="40" type="hidden" name="receive_zip" value="${orderAddress.postCode }"/>
	 			<!-- 收货人电话号码 -->
	 			<input size="40" type="hidden"  name="receive_phone" value="${orderAddress.phonesection }-${orderAddress.phonecode }-${orderAddress.otherphone }"/>
	 			<!-- 收货人手机号码 -->
	 			<input size="40"  type="hidden" name="receive_mobile" value="${orderAddress.cellphone }"/>
	 		<!-- 其他必填参数 -->
	 			<!-- 物流类型 -->
	 			<input size="40" type="hidden" name="logistics_type" value="EXPRESS"/>
	 			<!-- 物流费用 -->
	 			<input size="40" type="hidden" name="logistics_fee" value="0.00"/>
	 			<!-- 签名方式 -->
	 			<input size="40" type="hidden" name="sign_type" value="MD5"/>
	 			<!-- 异步通知路径 -->
	 			<input size="40" type="hidden" name="notify_url" value="<%=basePath %>asossh/alipay!notifyUrl.action"/>
	 			<!-- 同步通知路径 -->
	 			<input size="40" type="hidden" name="return_url" value="<%=basePath %>asossh/alipay!returnUrl.action"/>
	 			<!-- 字符编码格式 -->
	 			 <input size="40" type="hidden" name="_input_charset" value="utf-8"/>
	 			<!-- 标准双接口服务名称 -->
	 			<input size="40" type="hidden" name="service" value="trade_create_by_buyer"/>
	 			<!-- 商品数量 -->
	 			<input size="40" type="hidden" name="quantity" value="1"/>
	 			<!-- 合作身份者ID -->
	 			<input size="40" type="hidden" name="partner" value="2088502711093570"/>
	 			<!-- 物流支付方式 -->
	 			<input size="40" type="hidden" name="logistics_payment" value="SELLER_PAY"/>
	 			<!--支付类型(不要修改)  -->
	 			<input size="40" type="hidden" name="payment_type" id="paymenttype${status.count}" value="1"/>
	 			<!-- 签名结果 -->
	 			<div style="display: none;">
	 			  <input size="40"  type="text" name="sign" value="" id="signdata${status.count}" />  
	 			</div>
	 				<div  style="text-align:left; clear: left;  ">
	 					<label  >
	 					<font style="font-family: 黑体; font-size:25px; ">订单状况:</font> 
	 					 (${tradeStatus })
	 					 </label>
	 					 <s:if test="tradeStatus=='none'">
		 					<font style="font-size: 20px; color: #ff0000;">未生成支付订单</font>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick="submitbutton(${status.count})"
	 							style="padding: 10px 10px ; font-family: 楷体; font-size: 20px; ">生成支付宝订单，去支付宝付款</button>(目前仅支持支付宝付款)
	 						</div>
		 				</s:if>
		 				<s:elseif test="tradeStatus=='WAIT_BUYER_PAY'">
		 					<font style="font-size: 20px; color: #ffff00;">交易创建,没有付款</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick=" window.location.href='https://lab.alipay.com/consume/record/buyerConfirmTrade.htm?tradeNo=${alipayTradeNo }&window=new'"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">去支付宝付款</button>(目前仅支持支付宝付款)
	 						</div>
		 				</s:elseif>
		 				<s:elseif test="tradeStatus=='WAIT_SELLER_SEND_GOODS'">
		 					<font style="font-size: 20px; color: #ff0000;">付款成功，但卖家没有发货</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick="alert('该功能还在开发中');"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">提醒发货</button>
	 						</div>
		 				</s:elseif>
		 				<s:elseif test="tradeStatus=='WAIT_BUYER_CONFIRM_GOODS'">
		 					<font style="font-size: 20px; color: #ff0000;">卖家已经发了货，但买家还没有做确认收货</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  
	 						onclick="  window.location.href='https://lab.alipay.com/consume/queryTradeDetail.htm?actionName=CONFIRM_GOODS&tradeNo=${alipayTradeNo }'"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">确认收货</button>(需前往支付宝完成确认付款)
	 						</div>
		 				</s:elseif>
		 				<s:elseif test="tradeStatus=='TRADE_FINISHED'">
		 					<font style="font-size: 20px; color: #ff0000;">交易成功</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>		 					
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick="window.location.href='<%=basePath %>asossh/goodsAssess!userasess.action?goodsOrderPojo.alipayTradeNo=${alipayTradeNo }'"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">交易成功,评价</button>
	 						</div>
		 				</s:elseif>
		 				<s:elseif test="tradeStatus=='TRADE_CLOSED'">
		 					<font style="font-size: 20px; color: #ff0000;">交易关闭</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick="alert('该功能还在开发中');"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">交易关闭</button>
	 						</div>
		 				</s:elseif>
		 				<s:elseif test="tradeStatus=='USER_ASSESS_SUCCESS'">
		 					<font style="font-size: 20px; color: #ff0000;">评价成功</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  disabled="disabled"  
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">评价成功</button>
	 						</div>
		 				</s:elseif>
		 				<s:else>
		 					<font style="font-size: 20px; color: #ff0000;">未知的成功的操作</font>
		 					<div style="text-align:left; clear: left;  " >
		 						<label>支付宝交易号:</label>${alipayTradeNo }
		 					</div>
		 					<div style="text-align:center; clear: left;  " >
	 						<button type="button"  onclick="alert('该功能还在开发中');"
	 							style="padding: 10px 10px ; font-family: 仿宋; font-size: 20px;">未知的成功的操作</button>
	 						</div>
		 				</s:else>
		 				
		 				
		 				
	 				</div>
	 		
	 			</s:if>
	 		</s:iterator>
	 		</div>
	 		</form>
	 		</s:iterator>
	 	</div>
	 	
	 	</s:else>
	</div>
<jsp:include page="../headfoot/footer.jsp"></jsp:include> 
</body>
</html>
