<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加我的收货地址</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	 
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/myaddressstyles.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/tc.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/areacode.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/showhiddentop.js"></script>
 	<script type="text/javascript" src="<%=basePath %>js/myaddressinit.js"></script>
 	
<script type="text/javascript">
<!-- 鼠标移过形式图片 -->
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
var basePath = "<%=basePath %>";
</script>
 
</head>
  
  <body background="<%=basePath %>image/bg.jpg" >
    <center >
  <jsp:include page="../headfoot/head.jsp"></jsp:include>   
    <div id="addressfirst"  class="addressfirst" style="margin-top: 20px;" >
    		<div style="float: left; ">
    			<h3>确认收货地址</h3>
    		</div> 
    		<div style="float: right;" >
    				<a href=""  target="_blank" title="管理我的收货地址">管理我的收货地址</a>
    		</div>
    </div>
    <hr width="90%" align="center">
    <div align="left" style="margin-left: 5%">
    <ul id="address-list" class="address-list "style="">
    <s:iterator value="orderAddressList" status="status">
    <s:if test="#status.first">
    	<li style="left: 10px"  class="selected_order_address" id="li<s:property value='#status.count'/>" >
				<div class="address-info">
					<input name="address" class="  " type="radio" value=" " id="radio<s:property value='#status.count'/>"  
					checked="checked" onclick="radioclick(<s:property value='#status.count'/>);" > 
				   	<label  class="user-address" id="user_address<s:property value='#status.count'/>"> 
				   		${province }&nbsp;
				   		${city }&nbsp;
				   		${county }&nbsp;
				   		${otherAddress }&nbsp;
				   		(${orderName} 收)
				   		<em>
				   		<s:if test="cellphone!=''">
				   			${cellphone }
				   		</s:if>
				   		<s:else>
					   		${phonesection}-${phonecode }-${otherphone }
				   		</s:else>
				   		</em>
					</label> 
					<em class="tip<s:property value='#status.count'/>" >默认地址</em> 
					<a   href="javascript:void(0)" style="display:none " id="setaddress<s:property value='#status.count'/>" 
					onclick="setaddress(<s:property value='#status.count'/>)" >设置为默认收货地址</a>
					<a href="javascript:void(0)" class=""  style="position: absolute;right: 9%;" id="updateaddress<s:property value='#status.count'/>" 
					onclick="updateaddress(<s:property value='#status.count'/>)">修改本地址</a>  
				</div>
			</li>
		</s:if>
		<s:else>
		<li style="left: 10px" id="li<s:property value='#status.count'/>" class="order_address" >
				<div class="address-info">
					<input name="address" class="  " type="radio" value=" " id="radio<s:property value='#status.count'/>" 
					onclick="radioclick(<s:property value='#status.count'/>);"  > 
				   	<label id="user_address<s:property value='#status.count'/>" class="user-address"> 
				   		${province }&nbsp;
				   		${city }&nbsp;
				   		${county }&nbsp;
				   		${otherAddress }&nbsp;
				   		(${orderName } 收)
				   		<em>
				   		<s:if test="cellphone!=''">
				   			${cellphone }
				   		</s:if>
				   		<s:else>
					   		${phonesection}-${phonecode }-${otherphone }
				   		</s:else>
				   		</em>
					</label> 
					<em class="tip<s:property value='#status.count'/>" style="display: none">默认地址</em> 
					<a class="" href="javascript:void(0)" style="display: " id="setaddress<s:property value='#status.count'/>" 
					onclick="setaddress(<s:property value='#status.count'/>)"  >设置为默认收货地址</a>
					<a href="javascript:void(0)" class=""  style="position: absolute;right: 9%;" id="updateaddress<s:property value='#status.count'/>" 
					onclick="updateaddress(<s:property value='#status.count'/>)">修改本地址</a> 
				</div>
			</li>
		</s:else>
	<!-- 注入隐藏的地址信息值 -->
	<input type="hidden" id="orderAddressId<s:property value='#status.count'/>" value="${orderAddressId }">
	<input type="hidden" id="orderName<s:property value='#status.count'/>" value="${orderName }">
	<input type="hidden" id="province<s:property value='#status.count'/>" value="${province }">
	<input type="hidden" id="city<s:property value='#status.count'/>" value="${city }">
	<input type="hidden" id="county<s:property value='#status.count'/>" value="${county }">
	<input type="hidden" id="otherAddress<s:property value='#status.count'/>" value="${otherAddress }">
	<input type="hidden" id="postCode<s:property value='#status.count'/>" value="${postCode }">
	<input type="hidden" id="cellphone<s:property value='#status.count'/>" value="${cellphone }">
	<input type="hidden" id="phonesection<s:property value='#status.count'/>" value="${phonesection}">
	<input type="hidden" id="phonecode<s:property value='#status.count'/>" value="${phonecode }">
	<input type="hidden" id="otherphone<s:property value='#status.count'/>" value="${otherphone }">
	<input type="hidden" id="orderAddressStatus<s:property value='#status.count'/>" value="${orderAddressStatus }">
	
	<input type="hidden" id="Id${orderAddressId }" value="<s:property value='#status.count'/>">
	 <s:set name="listcount"><s:property value='#status.count'/></s:set>
    </s:iterator>
   	<li id="li_button">
   		<button type="button" id="newAddAddressButton"   style="padding: 10px 10px" 
   		>使用新的收获地址</button>
   	</li>
    </ul>
      <input type="hidden" id="listcount" value="${listcount }">  
    </div>
  <!-- 弹出层 -->
    <!-- 添加收货地址 -->
  <form   id="saveaddressform" method="post">
    <div align="left"  class="show_add_address" id="show_add_address"  style="margin-left:  50px ; margin-top: 100px;">
   	 		 <a class="close" > </a> 
         	 <h3 style="margin-left: 40%; font-family: 宋体 ; font-size: 20px;">收货地址 </h3> 
			<h4>
				<span style="margin-left: 10%; font-family: 宋体 ; font-size: 15px;"> 
					新增收货地址:电话号码、手机号选填一项,其余均为必填项
				</span>
			</h4>
			<ol id=addressform class="addresseditor">
				<li>
					<label   class=label-like>收货人:&nbsp;&nbsp;</label>
					<span class="spark_span_show_main" >
						&nbsp;&nbsp;&nbsp;
						<span class=spark-indeed>*</span>
						<input id=orderName  type="text" style="padding: 5px 5px ;" name=orderAddressPojo.orderName>
					</span>
				</li>
				<li>
					<span class=label-like>所在地区: </span>
					<span class="spark_span_show_main" > 
						&nbsp;
						<span class=spark-indeed>*</span>
						 <jsp:include page="../json_address/myaddress.jsp"></jsp:include>  
					</span>
				</li>
				<li>
					  <label class=label-like>街道地址:</label>
						<span class="spark_span_show_main"> 
						&nbsp;
						<span class=spark-indeed>*</span>
							<textarea id=otherAddress rows=1 cols=40 name=orderAddressPojo.otherAddress></textarea>
							<span class=spark-attention><em>注：不需要重复填写省/市/区</em></span> 
						</span>
				</li>
				<li>
				<label  class=label-like>邮政编码:</label> 
					<span class="spark_span_show_main"> 
						&nbsp;
						<span class=spark-indeed>*</span>
						<input id=postCode type="text" style="padding: 5px 5px"   name=orderAddressPojo.postCode> 
						<span class="spark-attention">注：大陆以外地区可不填写</span>
					</span>
				</li>
				
				  <li>
					<label  class=label-like>手机号码:</label>
					<span class="spark_span_show_main">&nbsp; &nbsp;
						<span class=spark-indeed> </span>
						 <input id="cellphone"  type="text" name="orderAddressPojo.cellphone "  style="padding: 5px 5px ; ">  
						<span class="spark-attention">注：电话号码、手机号码必填一项</span>
					</span>
				</li>  
				<li>
				<label class=label-like>电话号码:</label> 
				<span class="spark_span_show_main">&nbsp; &nbsp;
					 <span class=spark-indeed> </span>
					 <input id=phonesection type="text" onfocus="getphonesection()" style="padding: 5px 5px ; " size="6"  title=区号 name=orderAddressPojo.phonesection   > 
					 <input id=phonecode  type="text" style="padding: 5px 5px ; " size="15"  title=电话号码 name=orderAddressPojo.phonecode > -
					 <input id=otherphone type="text" style="padding: 5px 5px ;" size="15" title=分机 name= orderAddressPojo.otherphone> 
				 <span  class="spark-attention">注：区号-电话号码-分机</span> 
				 </span>
				</li>
				<li>
					<label class=label-like for=statusaddr>设为默认:</label> 
					<span class="spark_span_show_main">&nbsp; &nbsp;
						<span class=spark-indeed> </span>
						<input id=order_address_status type=checkbox onclick="orderstatuscheckbox()">
						<input id=orderAddressStatus type="hidden" name=orderAddressPojo.orderAddressStatus value="0">
					</span>
				</li>
				<li style="list-style-type: none;">
					<div  style="float: left;margin-left: 150px" >
						<button  type="submit" class="short-btn" id="submit-btn" 
						style="padding: 5px 10px ; background-color: #0066FF; color: FFF; "
						>保存</button>
						<button  type="button" class="short-btn" onclick="cancel() " id="cancel-btn"
						style="padding: 5px 5px ; background-color: #F0F0F0 "
						>取消</button>
					</div>
					<input type="hidden" id="orderAddressId" name="orderAddressPojo.orderAddressId ">
					<input type="hidden" id="submit_update" value="submit">
		            <a class="btn" href="javascript:void(0);" onclick="notice_hidden();">我知道了</a>
				</li>
				</ol>
				</div> 
				</form>
	<!-- 购物车 -->
		<form action="<%=basePath %>asossh/order!saveorder.action" id="form2"  method="post">
					<div style="padding-top: 30px ;">
						<table border="0" background="<%=basePath %>image/bg.jpg"
							width="90%">
							<thead>
								<tr bgcolor="#E2F2FF">
									<th width="5%" nowrap="nowrap"><input type="checkbox"
										name="checkboxhead" id="hotelheadcheckboxall"
										checked="checked">全选
										<hr></th>
									<th width="35%">店铺宝贝
										<hr>
									</th>
									<th width="10%">单价(元)
										<hr>
									</th>
									<th width="10%">数量
										<hr>
									</th>
									<th width="10%">小计(元)
										<hr>
									</th>
									<th width="30%">备注(留言)
										<hr>
									</th>
								</tr>
							</thead>
							<s:set name="sum">0</s:set>
							<s:iterator value="goodsCartPojosMap" status="status" id="column">
								<tr bgcolor="#EBFFE1">
									<td><input type="checkbox" checked="checked"
										value="${key.hotelId }" name="checkboxhotel"
										id="hotel${key.hotelId }"
										onclick="hotelcheck('${key.hotelId }')"> <input
										type="hidden" id="checkboxhotel${key.hotelId }"
										value="${key.hotelId }"> <s:property
											value='#status.count' /></td>
									<td>饭店:<a
										href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${key.hotelId }"><font
											color="#000000">${key.hotelName }</font></a>
									</td>
									<td colspan="5"><nobr> 正常：市区(10:00-21:30)
											阴雨天：市区5公里(10:00-21:00) 冻雪天：市区3公里(10:00-20:30) </nobr></td>
								</tr>
								<s:iterator value="value" status="hotelstatus">
									<tr>
										<td> 
											<input type="hidden" id="cartIdishotelid${cartId }"value="${key.hotelId }"> 
											<input type="checkbox" name="checkboxcartId" checked="checked"
											onclick="goodsormealcheck('${cartId }','${key.hotelId }')"
											value="${cartId }" id="hotel${key.hotelId }checkbox${cartId }">
											 <input type="hidden" id="cartId<s:property value='cartId'/>"value="${cartId }">
											 <input type="hidden" name="submitcartId"  value="${cartId}">
											 </td>
										<s:if test="goodsInfoPojo!=null">
											<td>
												<table>
													<tr>
														<td><a href=""> <img alt="图片已经损坏"
																src="<%=basePath %>photo/${goodsInfoPojo.goodsImagePojo.gimageImage }"
																width="60px;" height="40px;"><br>
														</a></td>
														<td><font color="#8000ff">
																${goodsInfoPojo.goodsName }&nbsp;
																${goodsInfoPojo.goodsDis }&nbsp;
																${goodsInfoPojo.sortPojo.sortName } </font></td>
													</tr>
													<tr>
														<td><a href=""><font face="新宋体" size="2"
																color="#000000"><u>查看大图</u></font></a></td>
														<td></td>
													</tr>
												</table>
											</td>
											<!-- 单价 -->
											<td>&yen;<fmt:formatNumber
													value="${goodsInfoPojo.goodsPrice }" pattern="#0.00"></fmt:formatNumber>
												<input type="hidden" id="price${cartId}"
												value="${goodsInfoPojo.goodsPrice }">
											</td>
											<!-- 数量 -->
											<td>${goodsNumber}</td>
											<!-- 小计 -->
											<td><s:set name="sum">${sum+goodsInfoPojo.goodsPrice*goodsNumber }</s:set>
												<span id="tinymsg${cartId}"> &yen;<fmt:formatNumber
														value="${goodsInfoPojo.goodsPrice*goodsNumber }"
														pattern="#0.00"></fmt:formatNumber>
											</span></td>
										</s:if>
										<s:else>
											<!-- 套餐 -->
											<td>
												<table>
													<tr align="center">
														<td>${mealPojo.mealName}</td>
													</tr>
													<tr align="center">
														<s:iterator value="mealPojo.goodsInfoPojo">
															<td><font color="#8000ff"> <a
																	href="<%=basePath %>" class="screenshot"
																	rel="<%=basePath %>photo/<s:property value="goodsImagePojo.gimageImage"/>">
																		<font style="font-family: 宋体;color:#22F;">${goodsName
																			} </font>
																</a> &nbsp;
															</font></td>
														</s:iterator>
													</tr>
												</table>
											</td>
											<td>
												<!-- 单价 --> &yen;<fmt:formatNumber
													value="${mealPojo.mealPrice }" pattern="#0.00"></fmt:formatNumber>
											</td>
											<td>
												<!-- 数量 --> ${goodsNumber}
											</td>
											<td>
												<!-- 小计 --> <span id="tinymsg${cartId}"> &yen;<fmt:formatNumber
														value="${mealPojo.mealPrice*goodsNumber }" pattern="#0.00"></fmt:formatNumber>
											</span> <s:set name="sum">${sum+mealPojo.mealPrice*goodsNumber}</s:set>
											</td>
										</s:else>
										<td><b id="orderads${cartId}">${orderAds}</b></td>
									</tr>
									<tr>
										<td colspan="6"><label class="label" style="font-size: 12px;" >给卖家留言：</label> 
										<textarea title="选填：对本次交易的补充说明（建议填写已经和卖家达成一致的说明）" name="orderAds" 
											cols="85"  rows="1"   onfocus="textfocus('${cartId}')"
											id="textarea_ads${cartId}"   style="font-size: 13px;">选填：对本次交易的补充说明(建议填写已经和卖家达成一致的说明)
		   	 							</textarea> <b id="ads_textarea${cartId}" style="font-size: 11px;">还可输入400字符(一个汉字等于两个字符)</b></td>
									</tr>
								</s:iterator>
							</s:iterator>
								<tr bgcolor="#F3F3F3">
									<td nowrap="nowrap" colspan="5">
										<b id="summsg"> 商品总价(不含运费) 
											<font size='4'> &yen; 
												<fmt:formatNumber value="${sum }" pattern="#0.00"></fmt:formatNumber>
											</font>
										</b>
									</td>
									<td>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
						<s:set name="orderAddressListname">${orderAddressList=='[]'||orderAddressList=='{}' }</s:set>
						<s:if test="#orderAddressListname">
							<input  type="hidden" id="userAddressId" name="userAddressId" value="">
						</s:if>
						<s:else>
							<s:iterator value="orderAddressList" status="status">
	   						 <s:if test="#status.first">
									<input  type="hidden" id="userAddressId" name="userAddressId" value="${orderAddressId }">
							 </s:if>
							</s:iterator>
						</s:else>
						<button type="submit" style="padding-left: 15px;padding-right: 15px;padding-top: 10px;padding-bottom: 10px;"
						onclick="submitformads();"
						>提交订单</button>
					</form>
					 <jsp:include page="../headfoot/footer.jsp"></jsp:include> 
				</center>
  </body>
</html>
