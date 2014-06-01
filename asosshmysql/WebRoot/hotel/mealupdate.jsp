<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@  taglib  prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>套餐修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>
	<s:head/>
	<sx:head parseContent="true"/>
	 <style>
    body,div,p,ul,li,input{margin:0;padding:0;}
    ul{list-style-type:none;}
    a{color:#fff;outline:none;text-decoration:none;}
    body{font:700 24px/1.5 Arial;}
    #calc{position:relative;width:300px;background:#000; height:400px}
    #calc p{color:#fff;text-align:left;font:12px/20px Arial; padding-left: 10px;}
    #calc .f-text{border:0;width:290px;height:84px;text-align:right;font:700 50px/84px Arial;background:url(<%=basePath%>image/computer/inputBg.jpg) repeat-x;}
    #calc ul{position:relative;overflow:hidden;zoom:1;background:url(<%=basePath%>image/computer/bg.jpg);}
    #calc ul li{float:left;width:63px;height:41px;margin:17px 10px 0 0;}
    #calc ul li a{display:block;width:63px;height:41px;line-height:41px;text-align:center;background:url(<%=basePath%>image/computer/btn.png) no-repeat;}
    #calc ul li a:hover{background-position:-63px 0;}
    #calc ul li.btn-1 a{background-position:0 -41px;}
    #calc ul li.btn-1 a:hover{background-position:-63px -41px;}
    #calc ul li.btn-2{position:absolute;top:174px;right:0;height:99px;}
    #calc ul li.btn-2 a{height:99px;line-height:99px;background-position:0 -164px;}
    #calc ul li.btn-2 a:hover{background-position:-63px -164px;}
    #calc ul li.btn-3{width:136px;}
    #calc ul li.btn-3 a{width:136px;background-position:0 -82px;}
    #calc ul li.btn-3 a:hover{background-position:0 -123px;}
    #formula{position:absolute;top:20px;background:none;border:0;font:700 12px/1.5 Arial;width:280px;padding:3px 15px 0 5px;text-align:right;}
    </style>
    <script>
    window.onload = function ()
    {
    var oCalc = document.getElementById("calc");
    var aA = oCalc.getElementsByTagName("a");
    var aInput = oCalc.getElementsByTagName("input")[0];
    var oFormula = document.getElementById("formula");
    var s = false;
    var i = 0;
    for (i = 0; i < aA.length; i++){ 
    aA[i].onfocus = function ()
    {
    this.blur();
    };
    aA[i].onclick = function ()
    {
    switch(this.innerHTML)
    {
    case "清除":
    aInput.value =  0;
    oFormula.value = "";
    break;
    case "%":
    count("%");
    break;
    case "/":
    count("/");
    break;
    case "×":
    count("*");
    break;
    case "-":
    count("-");
    break;
    case "+":
    count("+");
    break;
    case "=":
    s || (oFormula.value += aInput.value);
    aInput.value = eval(oFormula.value.replace(/\%\/\*\-\+/,''));
    aInput.value = aInput.value.substr(0,10).replace("NaN",0);
    s = true;
    break;
    case ".":
    if(aInput.value.search(/[\.\%\/\*\-\+]/) != -1)
    break;
    default:
    s && (aInput.value = 0, oFormula.value = "", s = false);
    aInput.value.length < 10 && (aInput.value = (aInput.value + this.innerHTML).replace(/^[0\%\/\*\-\+](\d)/,"$1"));
    }
    };
    }
    function count(a)
    {
    if(s)
    {
    oFormula.value = aInput.value + a;
    aInput.value = a;
    s = false;
    }
    else
    {
    /[\%\/\*\-\+]$/.test(aInput.value) || (oFormula.value += aInput.value);
    aInput.value = a;
    /[\%\/\*\-\+]$/.test(oFormula.value) || (oFormula.value += aInput.value);
    oFormula.value = oFormula.value.slice(-1) != a ? oFormula.value.replace(/.$/,a) : oFormula.value;
    }
    }
    //点击计算结果将值
	$("#jisuan").click(function(){
		var price =aInput.value*1;
		$("#price").val(price.toFixed(2));
	});
 $("#submit").click(function(){
   		if($("#mealName").val()==""){
   			alert("请填写套餐名字");
   			return false;
   		}
   		//选中右边的下拉列表后提交
    	var   right =document.myform.rightRoles;
   	for(var i=1;i<right.length;i++){
   		right[i].selected=true;
   		}; 
  	  }); 
    };
    </script>
  </head>
  
  <body  background="<%=basePath %>image/bg.jpg">
   <jsp:include page="../headfoot/head.jsp"></jsp:include>
   <form action="<%=basePath %>asossh/hotelmanage!mealSave.action" method="post" name="myform">
   <input type="hidden" value="<s:property value='hotelPojo.hotelId'/>" name="hotelPojo.hotelId">
   
   			<table width="50%" border="0" align="left" style="padding-left: 5%">
   				<tr>
   					<td  align="center" colspan="2">
   					<font style="font-family: 宋体;" size="5">智能套餐生成系统</font>
   					</td>
   				</tr>
   				<tr>
   					<td  align="center" colspan="2" style="padding-top: 20px;padding-bottom: 20px">
   					<font style="font-family: 宋体;" size="3">套餐的名字：</font>
   					<input type="text" name="mealPojo.mealName"  id="mealName"
   					style="padding-left: 5px ;padding-top: 5px; padding-bottom: 5px;padding-right: 5px;"
   					>
   					</td>
   				</tr>
   				<tr >
   					<td >
   						<s:optiontransferselect 
   						list="goodsInfolist" name="leftRoles"
   						listKey="goodsId"   listValue="goodsName"
   						headerKey="-1"  headerValue="这里是你未选择的"  
   						doubleList="goodsInforight" doubleName="rightRoles"
   						doubleListKey="goodsId" doubleListValue="goodsName"
   						doubleHeaderKey="-1"  doubleHeaderValue="这里是你已经选择的"
   						addAllToLeftLabel="全部左移"  allowAddAllToLeft="true"
   						addAllToRightLabel="全部右移" allowAddAllToRight="true"
   						addToLeftLabel="左移"  	allowAddToLeft="true"
   						addToRightLabel="右移"	allowAddToRight="true"
   						 leftUpLabel="左边↑"     leftTitle="你看看我是什么"
   						 rightUpLabel="右边↑"  allowUpDownOnLeft="true"
   						leftDownLabel="左边↓"		rightTitle="看看你是什么"
   						rightDownLabel="右边↓"  allowUpDownOnRight="true"
   						 allowSelectAll="true"   selectAllLabel="全选"
   						 multiple="true"
   						></s:optiontransferselect>
   					</td>
		   	</tr>
		   	<tr>
		   		<td colspan="2" style="padding-left: 30% ;padding-top: 3%;">
		   		<font style="font-family: 宋体;" size="3">套餐是否发布：</font>
		   		<select name="mealPojo.mealStatu" 
		   			style="padding-left: 5px ;padding-top: 5px; padding-bottom: 5px;padding-right: 5px;"
		   		>
		   			<option value="1">发布</option>
		   			<option value="0">未发布</option>
		   		</select>
		   		</td>
		   	</tr>
		   	<tr>
		   		 <td colspan="2">
   					 <div style="padding-left: 30% ;padding-top: 3%;">
	   					套餐优惠价：
	   					<input type="text" id="price" name="mealPojo.mealPrice" value="0.00"
	   					style="padding-left: 5px ;padding-top: 5px; padding-bottom: 5px;padding-right: 5px;"
	   					>
	   					<input  type="button" id="jisuan" value="添加计算器的结果"
	   					style="padding-left: 5px ;padding-top: 5px; padding-bottom: 5px;padding-right: 5px;"
	   					>
   					</div>
   						<div style="padding-left: 30% ;padding-top: 3%;">
	   					<input type="submit" id="submit" value="提交" 
	   					style="padding-left: 3% ;padding-top: 3%; padding-bottom: 3%;padding-right: 3%;">
   						</div>
		   			</td> 
		   	</tr>
   		</table>
   		<table width="50%" align="center" style="padding-right: 5% ;padding-left: 5%; padding-top: 4%" >
			<tr>
				<td>
				<!-- 计算机 -->
   			<div id="calc" >
		   	 <p>算算优惠价钱是多少</p>
		 	   <input class="f-text" type="text" readonly="readonly" maxlength="9" value="0" id="computerrice"/>
		    <ul>
			    <li class="btn-1"><a href="javascript:void(0)">清除</a></li>
			    <li class="btn-1"><a href="javascript:void(0)">%</a></li>
			    <li class="btn-1"><a href="javascript:void(0)">/</a></li>
			    <li class="btn-1"><a href="javascript:void(0)">×</a></li>
			    <li><a href="javascript:void(0)">7</a></li>
			    <li><a href="javascript:void(0)">8</a></li>
			    <li><a href="javascript:void(0)">9</a></li>
			    <li class="btn-1"><a href="javascript:void(0)">-</a></li>
			    <li><a href="javascript:void(0)">4</a></li>
			    <li><a href="javascript:void(0)">5</a></li>
			    <li><a href="javascript:void(0)">6</a></li>
			    <li class="btn-1"><a href="javascript:void(0)">+</a></li>
			    <li><a href="javascript:void(0)">1</a></li>
			    <li><a href="javascript:void(0)">2</a></li>
			    <li><a href="javascript:void(0)">3</a></li>
			    <li class="btn-2"><a href="javascript:void(0)" >=</a></li>
			    <li class="btn-3"><a href="javascript:void(0)">0</a></li>
			    <li><a href="javascript:void(0)">.</a></li>
		    </ul>
		   	 <input id="formula" type="text" readonly="readonly" value="" />
		    </div>
				</td>
			</tr>
		</table>
   </form>
   <jsp:include page="../headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
