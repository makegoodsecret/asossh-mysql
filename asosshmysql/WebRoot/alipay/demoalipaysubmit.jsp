<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>'alipaysubmit.jsp'</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>

	<style type="text/css">
	.content{ margin-top:5px; }
	.content dt{ width:160px; display:inline-block;text-align:right; float:left;}
	.content dd{margin-left:100px; margin-bottom:5px;}
	.red-star{ color:#f00; width:10px; display:inline-block;}
	.null-star{color:#fff;}
	.new-btn-login-sp{border:1px solid #D74C00;padding:1px;display:inline-block;}
	.new-btn-login{ background-color: transparent;background-image: url("<%=basePath%>image/new-btn-fixed.png");
   					border: medium none;}
	.new-btn-login{
		    background-position: 0 -198px; width: 82px; color: #FFFFFF;
		    font-weight: bold; height: 28px; line-height: 28px; padding: 0 10px 3px;
		}
	.new-btn-login:hover{
			background-position: 0 -167px; width: 82px; color: #FFFFFF; font-weight: bold;
		    height: 28px; line-height: 28px;  padding: 0 10px 3px;}
	</style>
	<script type="text/javascript">
		  $(function(){
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
		}) 
	</script>
  </head>
  
  <body>
    <form id="alipaysubmit" name="alipaysubmit" action="https://mapi.alipay.com/gateway.do?_input_charset=utf-8" method="post">
	<div id="body" style="clear:left">
       <dl class="content">
		<dt>卖家支付宝帐户：</dt>
		<dd> <span class="null-star">*</span>
			<input size="40"   type="text" name="seller_email" value="makegoodsecret@sina.com" />
			 <span>必填</span>
		</dd>
		 <dt>商户订单号：</dt>
		<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="out_trade_no" value="2"/> 
		 	<span>商户网站订单系统中唯一订单号， </span>
		</dd>
		<dt>订单名称：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="subject" value="新订单名称" />
			<span>必填</span>
		</dd>
		<dt>付款金额：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="price" value="0.1"/>
			<span>必填</span>
		</dd>
		<dt>订单描述：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="body" value="订单描述"/>
		<span></span>
		</dd>
		<dt>商品展示地址：</dt>
		<dd>
			<span class="null-star">*</span>
			<input size="40"  name="show_url" value="<%=basePath %>alipay/userorder.jsp"/>
			<span>需以http://开头的完整路径，如：http://www.xxx.com/myorder.html</span>
		</dd>
		<dt>收货人姓名：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="receive_name" value="徐凯" />
			<span>如：张三</span>
		</dd>
		<dt>收货人地址：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="receive_address" value="浙江省杭州市淳安县威坪镇凤坡村"/>
			<span>如：XX省XXX市XXX区XXX路XXX小区XXX栋XXX单元XXX号</span>
		</dd>
		<dt>收货人邮编：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="receive_zip" value="311715"/>
		<span>如：311715</span>
		</dd>
		<dt>收货人电话号码：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="receive_phone" value="0571-65081498"/>
		<span>如：0571-65081498</span>
		</dd>
		<dt>收货人手机号码：</dt>
		<dd><span class="null-star">*</span>
			<input size="40"  name="receive_mobile" value="18768011400"/>
		<span>如：18768011400</span>
		</dd>
        
         <!-- 其他必填参数 -->
         <dt>其他必填参数 </dt>
         <dd>
         	<span class="null-star">*</span>
         	<hr>
         </dd>
         <dt>物流类型</dt>
         	<dd><span class="null-star">*</span>
         	<input size="40" type="text" name="logistics_type" value="EXPRESS"/><span>必填，三个值可选：EXPRESS（快递）、POST（平邮）、EMS（EMS）</span>
	 	</dd>
	 	<dt>物流费用</dt>
	 		<dd><span class="null-star">*</span>
	 		<input size="40" type="text" name="logistics_fee" value="0.00"/>
		 </dd>
		 <dt>签名方式</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="sign_type" value="MD5"/>
		 </dd>
		 <dt>异步通知路径</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="notify_url" value="<%=basePath %>asossh/alipay/notify_url _alipay.jsp"/>
		 </dd>
		 <dt>同步通知路径</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="return_url" value="<%=basePath %>asossh/alipay!returnUrl.action"/>
		 </dd>
		 <dt>字符编码格式</dt>
			 <dd><span class="null-star">*</span>
			 <input size="40" type="text" name="_input_charset" value="utf-8"/>
			 <span>(仅支持UTF-8和GBK)</span>
		 </dd>
		 <dt>标准双接口服务名称</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="service" value="trade_create_by_buyer"/>
		 </dd>
		 <dt>商品数量</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="quantity" value="1"/>
		 	<span>(建议默认为1，不改变值，把一次交易看成是一次下订单而非购买一件商品)</span>
		 </dd>
		 <dt>合作身份者ID</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="partner" value="2088502711093570"/>
		 </dd>
		 <dt>物流支付方式</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="logistics_payment" value="SELLER_PAY"/>
		 	<span>必填，两个值可选：SELLER_PAY（卖家承担运费）、BUYER_PAY（买家承担运费）</span>
		 </dd>
		 <dt>支付类型(不要修改)</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="payment_type" value="1"/>
		 </dd>
	 	 
		 <dt>签名结果</dt>
		 	<dd><span class="null-star">*</span>
		 	<input size="40" type="text" name="sign" value="不是手填的" id="signdata" />
		 	<span>(将提交的参数进行加密操作)</span>
           </dd>
          <dt></dt>
        	<dd><span class="null-star">*</span><span class="new-btn-login-sp">
            	<button id="subalipaybutton" class="new-btn-login" type="submit" 
            	style="text-align:center;">确 认</button>
             </span>
         </dd>
         </dl>
          </div>
		</form>
</body>
</html>
