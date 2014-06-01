<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <base href="<%=basePath%>">

    <title>首页城市级联</title>

    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport"  content="with=device-width,initial-scale=1">
   	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="x-ua-compatible" content="IE=7" />
	 
	<link href="<%=basePath%>css/home_city.css" rel="stylesheet" type="text/css" />
<%-- 	<script src="<%=basePath%>js/jquery-1.7.1.js" type="text/javascript"></script> --%>
	<script src="<%=basePath%>js/homecities.js"  type="text/javascript"></script>
	<script src="<%=basePath%>js/jquery.autocomplete.js" type="text/javascript"></script>
	<script type="text/javascript">
		function searchmapcity(){
			var city_name = $("#city_name").val().trim();
			 var url ="<%=basePath%>js/citygps.js";
		 	$.getJSON(url, function(json){
  				 $.each( json, function(i, n){
				  if (i==city_name) {
				     removemarker();
				     point  = new BMap.Point(n.lng,n.lat);
					map.setCenter(city_name); //平移到新设定的位置	
					addressComponents(point.lat, point.lng); 
				} 
				});
			});
		}	
	</script>
  </head>
  
 <body>
		  <div class="search-citys">
				<button type="button" onclick="searchmapcity()"  class="manhuaTip">切换</button>	
				<input class="text" id="city_name" type="text" value="城市"  style="border-width: 5px;"
				onFocus="if(value=='城市'){value='';style.color='#606060';}" 
				onKeyUp="input_keyup();" onClick="append_city();" onBlur="input_blur()"  size="25"/>
				<input class="text" id="hid_city_name" name="index_city" style="display:none">
				<input class="text" id="hid_real_city_name" name="real_index_city" style="display:none">			
				<!--热门城市下拉-->
				<div class="pop search-citys-pop click" style="display:none;z-index:9999" id="cityarea">
					<a href="javascript:void(0)" class="pop-close" >关闭</a>
					<div class="search-citys-tit click">热门城市(可直接输入中文名/拼音/三字码)</div>
					<div class="search-citys-tt click">
						<a class="current click" onClick="tabCutover(this,'s-citys1')" href="javascript:void(0)">热门<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys2')" href="javascript:void(0)">ABCDEFG<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys3')" href="javascript:void(0)">HIJKL<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys4')" href="javascript:void(0)">MNOPQRST<span></span></a>
						<a class="click" onClick="tabCutover(this,'s-citys5')" href="javascript:void(0)">UVWXYZ<span></span></a>
					</div>
					<div class="search-citys-list click" id="citylist"></div>
				</div>
			</div>
  </body>
</html>
