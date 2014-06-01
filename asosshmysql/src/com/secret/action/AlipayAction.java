package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import org.apache.struts2.ServletActionContext;
import org.apache.taglibs.standard.lang.jstl.test.PageContextImpl;

import com.opensymphony.xwork2.ActionSupport;
import com.secret.alipay.AlipayConfig;
import com.secret.alipay.AlipayCore;
import com.secret.alipay.AlipayNotify;
import com.secret.alipay.AlipaySubmit;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.service.GoodsOrderService;
import com.secret.util.FinalStatus;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class AlipayAction extends ActionSupport{
	private String body  ;
	private String logistics_type ;
	private String logistics_fee ;
	private String subject ;
	private String sign_type ;
	private String receive_address ;
	private String receive_phone ;
	private String receive_name ;
	private String notify_url ;
	private String out_trade_no ;
	private String return_url ;
	//private String sign ;   //签名加密后的结果
	private String _input_charset ;
	private String price ;
	private String service ;
	private String receive_mobile ;
	private String quantity ;
	private String partner ;
	private String seller_email ;
	private String receive_zip ;
	private String logistics_payment ;
	private String payment_type ;
	private String show_url ;
	private HttpServletResponse response =  ResponseSetCharacterEncoding.getInstance();
	
	private String returnurlmsg;     //同步处理
	
	private GoodsOrderService goodsOrderService;
		//签名加密
		public void alipaysavesign(){
			try {
				Map<String, String> sParaTemp = new HashMap<String, String>();
				sParaTemp.put("body", body );
				sParaTemp.put("logistics_type", logistics_type);
				sParaTemp.put("logistics_fee",logistics_fee);
				sParaTemp.put("subject",subject);
				//sParaTemp.put("sign_type", sign_type );			  //只需与AlipayConfig.sign_type.equals=MD5
				sParaTemp.put("receive_address",receive_address);
				sParaTemp.put("receive_phone",receive_phone);
				sParaTemp.put("receive_name",receive_name);
				sParaTemp.put("notify_url",notify_url);
				sParaTemp.put("out_trade_no",out_trade_no);
				sParaTemp.put("return_url",return_url);
				sParaTemp.put("_input_charset",_input_charset);
				sParaTemp.put("price",price);
				sParaTemp.put("service",service);
				sParaTemp.put("receive_mobile",receive_mobile);
				sParaTemp.put("quantity",quantity);
				sParaTemp.put("partner",partner);
				sParaTemp.put("seller_email",seller_email);
				sParaTemp.put("receive_zip",receive_zip);
				sParaTemp.put("logistics_payment",logistics_payment);
				sParaTemp.put("payment_type",payment_type);
				sParaTemp.put("show_url",show_url);
				 //除去数组中的空值和签名参数
		        Map<String, String> sPara = AlipayCore.paraFilter(sParaTemp);
		        //生成签名结果
		        String mysign =  AlipaySubmit.buildRequestMysign(sPara);
				PrintWriter out = response.getWriter();
				out.println(mysign);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//支付宝同步通知界面
		public String returnUrl(){
			try {
			//获取支付宝GET过来反馈信息
			HttpServletRequest request = ServletActionContext.getRequest();
			Map<String,String> params = new HashMap<String,String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
				params.put(name, valueStr);
			}
			//商户订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//支付宝交易号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//交易状态
			String tradeStatus = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
			//计算得出通知验证结果
			boolean verify_result = AlipayNotify.verify(params);
			if(verify_result){//验证成功
				List<GoodsOrderPojo> goodsOrderlist = goodsOrderService.findProperty("orderNumber", out_trade_no);
				 for (GoodsOrderPojo goodsOrderPojo : goodsOrderlist) {
					 goodsOrderPojo.setAlipayTradeNo(trade_no);
					 goodsOrderPojo.setTradeStatus(tradeStatus);
					 goodsOrderService.merge(goodsOrderPojo);
				}
				if(tradeStatus.equals("WAIT_SELLER_SEND_GOODS")){
					System.out.println("支付宝同步通知界面WAIT_SELLER_SEND_GOODS===付款成功，但卖家没有发货");
					returnurlmsg="付款成功……等待卖家发货";
				}
			
				if(tradeStatus.equals("TRADE_FINISHED")){
					System.out.println("支付宝同步通知界面TRADE_FINISHED===交易成功");
					returnurlmsg="交易成功";
				}
				System.out.println("商户订单号out_trade_no=="+out_trade_no);
				System.out.println("支付宝交易号trade_no=" + trade_no);
				//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			}else{
				System.out.println("验证失败");
				returnurlmsg="同步验证失败";
			}
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			return "return_url";
		}
		//支付宝返回异步通知
		public void notifyUrl(){
			System.out.println("支付宝返回异步通知");
			HttpServletRequest request = ServletActionContext.getRequest();
			HttpServletResponse response = ServletActionContext.getResponse();
			PrintWriter out;
			try {
				out = response.getWriter();
			//获取支付宝POST过来反馈信息
			Map<String,String> params = new HashMap<String,String>();
			Map requestParams = request.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]
							: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
				//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
				params.put(name, valueStr);
			}
			
			//商户订单号
			String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//支付宝交易号
			String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
			//交易状态
			String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
			//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
			if(AlipayNotify.verify(params)){//验证成功
					List<GoodsOrderPojo> goodsOrderlist = goodsOrderService.findProperty("orderNumber", out_trade_no);
					 for (GoodsOrderPojo goodsOrderPojo : goodsOrderlist) {
						 goodsOrderPojo.setAlipayTradeNo(trade_no);
						 goodsOrderPojo.setTradeStatus(trade_status);
						 goodsOrderService.merge(goodsOrderPojo);
					}
					if(trade_status.equals("WAIT_BUYER_PAY")){
					//该判断表示买家已在支付宝交易管理中产生了交易记录，但没有付款
						System.out.println("异步通知==交易创建,没有付款");
						out.println("success");	//请不要修改或删除
					} else if(trade_status.equals("WAIT_SELLER_SEND_GOODS")){
					//该判断表示买家已在支付宝交易管理中产生了交易记录且付款成功，但卖家没有发货
						out.println("success");	//请不要修改或删除
						System.out.println("异步通知==付款成功，但卖家没有发货");
					} else if(trade_status.equals("WAIT_BUYER_CONFIRM_GOODS")){
					//该判断表示卖家已经发了货，但买家还没有做确认收货的操作
						out.println("success");	//请不要修改或删除
						System.out.println("异步通知==卖家已经发了货，但买家还没有做确认收货");
					} else if(trade_status.equals("TRADE_FINISHED")){
					//该判断表示买家已经确认收货，这笔交易完成
						out.println("success");	//请不要修改或删除
						System.out.println("异步通知==交易成功");
					}else if(trade_status.equals("TRADE_CLOSED")){
						System.out.println("异步通知==交易关闭");
					}else {
						out.println("success");	//请不要修改或删除
						System.out.println("异步通知==成功");
					}
			}else{//验证失败
						out.println("fail");
			}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		public String getBody() {
			return body;
		}
		public void setBody(String body) {
			this.body = body;
		}
		public String getLogistics_type() {
			return logistics_type;
		}
		public void setLogistics_type(String logistics_type) {
			this.logistics_type = logistics_type;
		}
		public String getLogistics_fee() {
			return logistics_fee;
		}
		public void setLogistics_fee(String logistics_fee) {
			this.logistics_fee = logistics_fee;
		}
		public String getSubject() {
			return subject;
		}
		public void setSubject(String subject) {
			this.subject = subject;
		}
		public String getSign_type() {
			return sign_type;
		}
		public void setSign_type(String sign_type) {
			this.sign_type = sign_type;
		}
		public String getReceive_address() {
			return receive_address;
		}
		public void setReceive_address(String receive_address) {
			this.receive_address = receive_address;
		}
		public String getReceive_phone() {
			return receive_phone;
		}
		public void setReceive_phone(String receive_phone) {
			this.receive_phone = receive_phone;
		}
		public String getReceive_name() {
			return receive_name;
		}
		public void setReceive_name(String receive_name) {
			this.receive_name = receive_name;
		}
		public String getNotify_url() {
			return notify_url;
		}
		public void setNotify_url(String notify_url) {
			this.notify_url = notify_url;
		}
		public String getOut_trade_no() {
			return out_trade_no;
		}
		public void setOut_trade_no(String out_trade_no) {
			this.out_trade_no = out_trade_no;
		}
		public String getReturn_url() {
			return return_url;
		}
		public void setReturn_url(String return_url) {
			this.return_url = return_url;
		}
		 
		public String get_input_charset() {
			return _input_charset;
		}
		public void set_input_charset(String _input_charset) {
			this._input_charset = _input_charset;
		}
		public String getPrice() {
			return price;
		}
		public void setPrice(String price) {
			this.price = price;
		}
		public String getService() {
			return service;
		}
		public void setService(String service) {
			this.service = service;
		}
		public String getReceive_mobile() {
			return receive_mobile;
		}
		public void setReceive_mobile(String receive_mobile) {
			this.receive_mobile = receive_mobile;
		}
		public String getQuantity() {
			return quantity;
		}
		public void setQuantity(String quantity) {
			this.quantity = quantity;
		}
		public String getPartner() {
			return partner;
		}
		public void setPartner(String partner) {
			this.partner = partner;
		}
		public String getSeller_email() {
			return seller_email;
		}
		public void setSeller_email(String seller_email) {
			this.seller_email = seller_email;
		}
		public String getReceive_zip() {
			return receive_zip;
		}
		public void setReceive_zip(String receive_zip) {
			this.receive_zip = receive_zip;
		}
		public String getLogistics_payment() {
			return logistics_payment;
		}
		public void setLogistics_payment(String logistics_payment) {
			this.logistics_payment = logistics_payment;
		}
		public String getPayment_type() {
			return payment_type;
		}
		public void setPayment_type(String payment_type) {
			this.payment_type = payment_type;
		}
		public String getShow_url() {
			return show_url;
		}
		public void setShow_url(String show_url) {
			this.show_url = show_url;
		}
		public String getReturnurlmsg() {
			return returnurlmsg;
		}
		public void setReturnurlmsg(String returnurlmsg) {
			this.returnurlmsg = returnurlmsg;
		}
		public GoodsOrderService getGoodsOrderService() {
			return goodsOrderService;
		}
		public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
			this.goodsOrderService = goodsOrderService;
		}
		 
		 
}
