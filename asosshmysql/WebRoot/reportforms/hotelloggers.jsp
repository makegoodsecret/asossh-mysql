<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head >
    <base href="<%=basePath%>">
    
    <title>${hotelPojo.hotelName }报表管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
     <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
     <link rel="stylesheet" type="text/css"  href="<%=basePath %>css/styles_menu_reportforms.css" >
	<script type="text/javascript" src="<%=basePath%>js/menu_jquery_home.js"></script>  
  	<script type="text/javascript">
  	function reportFormClick(ts,actionmethod){
  			$("#divreporthome").hide();
  			$("#divreportchart").show();
  		 	 var imghref =  $(ts).data("href")+"&mathround="+new Date();
  		 	 var herf = imghref.split(".action")[0].split("!")[0];
  		 	 var data = imghref.split(".action")[1];
  		 	 homemessagerShowtime("正在生成报表……",1000);
  		 	 $("#reposrtFormsImage").attr("src",imghref);
  		 	 $("#chartbuttonPie").data("href",herf+"!"+actionmethod+"Pie.action"+data);
  		 	 $("#chartbuttonHistogram").data("href",herf+"!"+actionmethod+"Histogram.action"+data);
  		 	 $("#chartbuttonLineGraph").data("href",herf+"!"+actionmethod+"LineGraph.action"+data);
  		 	 $("#chartbuttonexcel").data("href","<%=basePath%>report/reportForms!exportweekExcel.action"+data);
  		 }
  	  function chartclick(ts){
  	    homemessagerShowtime("正在为你切换报表……",1000);
  	  	var imghref = $(ts).data("href");
  	  	$("#reposrtFormsImage").attr("src",imghref);
  	  }
  	  /*导出Exacle*/
  	  function excelloadclick(ts){
  	  	homemessagerShowtime("正在导出数据……",2000);
  	  	window.location.href  =  $(ts).data("href");
  	  }
  	</script>
  </head>
   <body background="<%=basePath %>image/bg.jpg" >
   <jsp:include page="../headfoot/head.jsp"></jsp:include>
	    <div  style="margin-top: 1px; margin-left:5%; ">
     	<div style="float: left; border: 1px solid #D9D9D9; width: 200px;">
   		<div style="font-family: 宋体;font-size: 20px; text-align: center;">
   			<strong> ${hotelPojo.hotelName }</strong>
   			<hr/>
   			<span style="font-size: 18px;"><strong>${user.username }</strong>你好</span>
   		</div>
 		<div id='cssmenu_home' style="width: 100%;">
			<ul>
				<li class='has-sub'><a href='javascript:void(0)' >
					<span style="font-size: 20px; font-family: 楷体; color: #ffff00;">系列</span>
					</a>
				      <ul>
						 <s:iterator value="sortList">
						   	<li> 
						   	<a href="javascript:void(0);"  onclick="reportFormClick(this,'sort')"
						   		 data-href='<%=basePath%>jfreechartdefaultpack/exampleAction!sortHistogram.action?sortPojo.sortId=${sortId}&sortPojo.sortName=${sortName}&hotelPojo.hotelName=${hotelPojo.hotelName}'>
						   		<span>${sortName }</span>
						   	</a>
						   </li>
		   				</s:iterator>
				      </ul>
				</li>
	   		   <s:iterator value="sortList">
				   <li class='has-sub' >
				   	  <a href='javascript:void(0)'><span>${sortName }</span></a>
				      <ul>
					      <s:iterator value="goodsInfoPojos">
					         <li>
					         	<a href="javascript:void(0);" onclick="reportFormClick(this,'goods')"
					         	   data-href='<%=basePath%>jfreechartdefaultpack/exampleAction!goodsHistogram.action?goodsInfoPojo.goodsId=${goodsId}&goodsInfoPojo.goodsName=${goodsName}&hotelPojo.hotelName=${hotelPojo.hotelName}' title="" >
					         		<span>${goodsName }</span>
					         	</a>
					         </li>
					      </s:iterator>
				      </ul>
				    </li>
	   			</s:iterator>
	   		 	<li class='has-sub'> <a href='javascript:void(0)'>
	   		 			<span style="font-size: 20px; font-family: 楷体; color: #ffff00;">套餐</span>
	   		 		  </a>
	   		 		  <ul>
			   			 <s:iterator value="hotelPojo.mealPojo">
						   <li >
						   	  <a href="javascript:void(0);" onclick="reportFormClick(this,'meal')"
						   	  	 data-href='<%=basePath%>jfreechartdefaultpack/exampleAction!mealHistogram.action?mealPojo.mealId=${mealId}&mealPojo.mealName=${mealName}&hotelPojo.hotelName=${hotelPojo.hotelName}'>
						   	  	<span>${mealName }</span>
						   	  </a>
						   </li>
			   			</s:iterator>
	   		 		  </ul>
	   		 	</li>
		   </ul>
	   </div>
	   </div>
	   <div style="margin-top: 1px; border: 1px solid #D9D9D9; height:600px; width:78.6%; overflow: auto;float: left;">
   			<div style="overflow: auto;height: 100%;width: 100%; " id="divreporthome">
   				<div style="text-align: center; font-family: 楷体;font-size: 25px;">报表管理系统</div>
   			 	<div style="text-align: center; width: 400px; margin-left: 30%; margin-top: 10px;">
   			 		<button type="button" onclick="" style="width: 200px; height: 50px; float: left;">每日报表</button>
   			 		<button type="button" onclick="" style="width: 200px; height: 50px; float: left;">每月报表</button>
   			 		<button type="button" onclick="" style="width: 200px; height: 50px; float: left;">每季报表</button>
   			 		<button type="button" onclick="" style="width: 200px; height: 50px; float: left;">每年报表</button>
   			 	</div>
   			</div>
   			<div style="overflow: auto;height: 100%;width: 100%;display: none; " id="divreportchart">
   			 	<div style="text-align: center; font-family: 楷体;font-size: 25px; margin-top: 5px; ">
   			 		销量分析图
   			 		<div style="text-align: center; width: 600px; margin-left:20%;  margin-top: 5px;">
   			 			<button type="button"  onclick="chartclick(this)"  
   			 				id="chartbuttonPie"	style="width: 150px; height: 30px; float: left;">饼状图</button>
	   			 		<button type="button"  onclick="chartclick(this)"     
	   			 			id="chartbuttonHistogram"	 style="width: 150px; height: 30px; float: left;">柱形图</button>
	   			 		<button type="button"  onclick="chartclick(this)"    
	   			 			id="chartbuttonLineGraph"	 style="width: 150px; height: 30px; float: left;">折线图</button>
   			 			<button type="button"  onclick="excelloadclick(this)" 
   			 				id="chartbuttonexcel"	style="width: 150px; height: 30px; float: left; ">导出Excel报表</button>
   			 		</div>
   			 	</div>
   			 	<div style="margin-top: 10px; text-align:center;">
   			 		<img alt="" src="" id="reposrtFormsImage"width= 100%; height="500px">
   			 	</div>
   			</div>
       </div>
    </div>
   <jsp:include page="../headfoot/footer.jsp"></jsp:include>
  </body>
</html>
