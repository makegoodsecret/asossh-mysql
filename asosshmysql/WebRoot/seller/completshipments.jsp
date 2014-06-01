<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.secret.alipay.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>复杂确认发货接口</title>
	</head>
	<%
		//支付宝交易号
		String trade_no = new String(request.getParameter("WIDtrade_no").getBytes("ISO-8859-1"),"UTF-8");
		//必填
		//物流公司名称
		String logistics_name = new String(request.getParameter("WIDlogistics_name").getBytes("ISO-8859-1"),"UTF-8");
		//必填
		//物流发货单号
		String invoice_no = new String(request.getParameter("WIDinvoice_no").getBytes("ISO-8859-1"),"UTF-8");
		//物流运输类型
		String transport_type = new String(request.getParameter("WIDtransport_type").getBytes("ISO-8859-1"),"UTF-8");
		//三个值可选：POST（平邮）、EXPRESS（快递）、EMS（EMS）
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "send_goods_confirm_by_platform");
        sParaTemp.put("partner", new AlipayConfig().partner);
        sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("trade_no", trade_no);
		sParaTemp.put("logistics_name", logistics_name);
		sParaTemp.put("invoice_no", invoice_no);
		sParaTemp.put("transport_type", transport_type);
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest("", "", sParaTemp);
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
