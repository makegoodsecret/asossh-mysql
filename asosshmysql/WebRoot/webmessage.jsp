<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>



    <base href="<%=basePath%>">

 	<%-- <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>  --%>
	<style type="text/css">

.msgbox_layer,.msgbox_layer .gtl_ico_succ,.msgbox_layer .gtl_ico_fail,.msgbox_layer .gtl_ico_hits,.msgbox_layer .gtl_ico_clear,.msgbox_layer .gtl_end
	{
	background-image: url("image/imagesshow/gb_tip_layer.png");
	background-repeat: no-repeat; color: #606060;
	display: inline-block; font-size: 14px; font-weight: bold; height: 54px; line-height: 54px;
}

.msgbox_layer_wrap {
	left: 0; position: fixed; _position: absolute; 
	_top: expression(documentElement.clientHeight/ 2 +   documentElement.scrollTop +   "px");
	text-align: center; top: 46%; width: 100%; z-index: 65533;
}

.msgbox_layer {
	background-position: 0 -161px; background-repeat: repeat-x; margin: 0 auto;
	padding: 0 18px 0 9px; position: relative;
}
	</style>
	
	<script type="text/javascript">
		 /*操作提示信息框*/
       function  messagerShow(messager){ 
      	 if ($('.msgbox_layer_wrap')) {
				$('.msgbox_layer_wrap').remove();
			}
		$("body").prepend("<div class='msgbox_layer_wrap'>"+
							"<span  style='z-index: 10000;' class='msgbox_layer'>"+
							""+messager+"</span></div>");
			$(".msgbox_layer_wrap").show();
       var st = setTimeout(function (){
				$(".msgbox_layer_wrap").hide();
				clearTimeout(st);
			},2000);
       }
		
	</script>

<!--   </head>
  
  <body   onload="messagerShows( );">
  </body>
</html>
 -->