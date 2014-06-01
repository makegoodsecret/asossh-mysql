<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>

<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head> -->
    <base href="<%=basePath%>">
    
   <!--  <title>下拉输入框</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page"> -->
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/pull_drow_input.css">
	<%-- <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> --%>
	<script type="text/javascript">
	 var dataprovicecity=["全国","浙江省","北京市","天津市","上海市","重庆市  ","河北省 ","山西省 ",
	 					  "辽宁省","吉林省","黑龙江省","江苏省","安徽省",
	 					  "福建省","江西省","山东省","河南省","湖北省","湖南省",
	 					  "广东省","海南省","四川省","贵州省","云南省","陕西省",
	 					  "甘肃省","青海省 ","广西","西藏","宁夏",
	 					  "新疆维吾尔","内蒙古","香港","澳门",
	 					  "台湾省","钓鱼岛"];
	
	function inputonfocus(){
		var provice =$("#province").val();
		var city  =$("#city").val();
		getajax(provice,city);
	
	}
	function getajax(provice,city){
	$.ajax({
 			"url":"<%=basePath%>asossh/seekinput!pullDrowInput.action",
 			"type":"post" ,  
 			dataType: "json",
 			"data":{"province": provice ,"city":city},
 			"success":function(data,desc1){
 				$("#hotwords").html("");
 		 	 	$("#hotwords").append(data.hotelTopInfo);
				 },
				 	"error":function(){
				 }
				});
	}
	function getprovince_city(id){
		getajax(dataprovicecity[id],"");
	}
	</script>
  </head>
<!--   
<body  > -->
	<input type="hidden" id="province" value="浙江省"  >
	<input type="hidden" id="city" value="舟山市">
	<div class="searchbox mt1" >
            <div class="search w960 center" >
          <form  name="formsearch" action="<%=basePath%>asossh/seekinput!seekGoodorHotel.action" method="post">
            <div class="form" >
            	<div class="form_left" > 
                    <div class="form_right" >
                    <div id="searchtype" >
                    	<div id="searchvalue" >其他省份</div>
                        <div id="boult" >▼</div>
                        <ul id="valuelist" style="display:none">
	                        <li title="全国省份" id="province_city0s"><a onclick="getprovince_city(0)">&nbsp;&nbsp;全国 </a></li>
	                        <li title="浙江省" id="province_city1"><a onclick="getprovince_city(1)">&nbsp;&nbsp;浙江省 &nbsp;</a></li>
	                        <li title="北京市" id="province_city2"><a onclick="getprovince_city(2)">&nbsp;&nbsp;北京市 &nbsp;</a></li>
	                        <li title="天津市" id="province_city3"><a onclick="getprovince_city(3)">&nbsp;&nbsp;天津市 &nbsp;</a></li>
	                        <li title="上海市" id="province_city4"><a onclick="getprovince_city(4)">&nbsp;&nbsp;上海市 &nbsp;</a></li>
	                        <li title="重庆市" id="province_city5"><a onclick="getprovince_city(5)">&nbsp;&nbsp;重庆市 &nbsp;</a></li>
	                        <li title="河北省" id="province_city6"><a onclick="getprovince_city(6)">&nbsp;&nbsp;河北省 &nbsp;</a></li>
	                        <li title="山西省" id="province_city7"><a onclick="getprovince_city(7)">&nbsp;&nbsp;山西省 &nbsp;</a></li>
	                        <li title="辽宁省" id="province_city8"><a onclick="getprovince_city(8)">&nbsp;&nbsp;辽宁省 &nbsp;</a></li>
	                        <li title="吉林省" id="province_city9"><a onclick="getprovince_city(9)">&nbsp;&nbsp;吉林省 &nbsp;</a></li>
	                        <li title="黑龙江省" id="province_city10"><a onclick="getprovince_city(10)">&nbsp;&nbsp;黑龙江省 &nbsp;</a></li>
	                        <li title="江苏省" id="province_city11"><a onclick="getprovince_city(11)">&nbsp;&nbsp;江苏省 &nbsp;</a></li>
	                        <li title="安徽省" id="province_city12"><a onclick="getprovince_city(12)">&nbsp;&nbsp;安徽省 &nbsp;</a></li>
	                        <li title="福建省" id="province_city13"><a onclick="getprovince_city(13)">&nbsp;&nbsp;福建省 &nbsp;</a></li>
	                        <li title="江西省" id="province_city14"><a onclick="getprovince_city(14)">&nbsp;&nbsp;江西省 &nbsp;</a></li>
	                        <li title="山东省" id="province_city15"><a onclick="getprovince_city(15)">&nbsp;&nbsp;山东省 &nbsp;</a></li>
	                        <li title="河南省" id="province_city16"><a onclick="getprovince_city(16)">&nbsp;&nbsp;河南省 &nbsp;</a></li>
	                        <li title="湖北省" id="province_city17"><a onclick="getprovince_city(17)">&nbsp;&nbsp;湖北省 &nbsp;</a></li>
	                        <li title="湖南省" id="province_city18"><a onclick="getprovince_city(19)">&nbsp;&nbsp;湖南省 &nbsp;</a></li>
	                        <li title="广东省" id="province_city19"><a onclick="getprovince_city(18)">&nbsp;&nbsp;广东省 &nbsp;</a></li>
	                        <li title="海南省" id="province_city20"><a onclick="getprovince_city(20)">&nbsp;&nbsp;海南省 &nbsp;</a></li>
	                        <li title="四川省" id="province_city21"><a onclick="getprovince_city(21)">&nbsp;&nbsp;四川省 &nbsp;</a></li>
	                        <li title="贵州省" id="province_city22"><a onclick="getprovince_city(22)">&nbsp;&nbsp;贵州省 &nbsp;</a></li>
	                        <li title="云南省" id="province_city23"><a onclick="getprovince_city(23)">&nbsp;&nbsp;云南省 &nbsp;</a></li>
	                        <li title="陕西省" id="province_city24"><a onclick="getprovince_city(24)">&nbsp;&nbsp;陕西省 &nbsp;</a></li>
	                        <li title="甘肃省" id="province_city25"><a onclick="getprovince_city(25)">&nbsp;&nbsp;甘肃省 &nbsp;</a></li>
	                        <li title="青海省" id="province_city26"><a onclick="getprovince_city(26)">&nbsp;&nbsp;青海省 &nbsp;</a></li>
	                        <li title="广西壮族自治区" id="province_city27"><a onclick="getprovince_city(27)">&nbsp;&nbsp;广&nbsp;西 &nbsp;&nbsp;</a> </li>
	                        <li title="西藏自治区"    id="province_city28"><a onclick="getprovince_city(28)">&nbsp;&nbsp;西&nbsp;藏  &nbsp;&nbsp;</a></li>
	                        <li title="宁夏回族自治区"  id="province_city29"><a onclick="getprovince_city(29)">&nbsp;&nbsp;宁&nbsp;夏  &nbsp;&nbsp;</a></li>
	                        <li title="新疆维吾尔自治区" id="province_city30"><a onclick="getprovince_city(30)">&nbsp;&nbsp;新&nbsp;疆  &nbsp;&nbsp;</a></li>	
	                        <li title="内蒙古自治区"    id="province_city31"><a onclick="getprovince_city(31)">&nbsp;&nbsp;内蒙古  &nbsp;&nbsp;</a></li>
	                        <li title="香港特别行政区"  id="province_city32"><a onclick="getprovince_city(32)">&nbsp;&nbsp;香&nbsp;港 &nbsp;</a> </li>
	                        <li title="澳门特别行政区"  id="province_city33"><a onclick="getprovince_city(33)">&nbsp;&nbsp;澳&nbsp;门 &nbsp;</a> </li>
	                        <li title="台湾省"       id="province_city34"><a onclick="getprovince_city(34)">&nbsp;&nbsp;台湾省 &nbsp;</a></li>
	                        <li title="钓鱼岛"       id="province_city35"><a onclick="getprovince_city(35)">&nbsp;&nbsp;钓鱼岛 &nbsp;</a></li>
                        </ul>
                    </div>
                      <h4>搜索</h4>
                       <input name="hotelPojo.hotelName" type="text" autocomplete="off" class="search-keyword" id="search-keyword"
                        value="输入关键词，回车搜索美食或饭店" onfocus="if(this.value=='输入关键词，回车搜索美食或饭店'){this.value=''; inputonfocus() ;}"  
                        onblur="if(this.value==''){this.value='输入关键词，回车搜索美食或饭店';}"    />
                      <button type="submit" class="search-submit" onclick="return checkinput()">
						搜索</button>
                    </div>
                </div>
					<ul id="hotwords" class="hotwords" style="display:none"  >
						<li class="hwtitle" >每日最火饭店TOP10：范围 :<b id="province_city">浙江省</b></li>
					</ul>
					<script type="text/javascript" src="<%=basePath%>js/pull_drow_input.js"></script>
            </div>
            </form>
   		 </div>
	</div>
<!-- </body>
</html> -->
