<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>网站视频展示区</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

 <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script> 
	<style type="text/css">
	.headdiv{ text-align: center; width:100%; border: 1px solid #FFE5D8;border-radius:10px 10px 10px 10px; }
	</style>

  </head>
  
  <body background="<%=basePath %>image/bg.jpg">
    <jsp:include page="headfoot/head.jsp"></jsp:include>
		<div style="width: 90%; margin-left: 5%; margin-right: 5%;">
			<div style="text-align: center; font-family: 仿宋; font-size: 30px;">
					<strong>
						 视频展示区 
					</strong>
			</div>
		 	<div  class="headdiv" >
		 		<div style="text-align:left; font-family: 仿宋; font-size: 20px;">
			 		网站演示教程视频区
		 		</div>
		 		<div  style="border: 1px solid #eee;border-radius:10px 10px 10px 10px;">
		 		 	<div id="flvcontainer"><a href="http://www.macromedia.com/go/getflashplayer">请下载Flash播放器</a>播放该视频!</div>
				<script type="text/javascript" src="<%=basePath%>video/swfobject.js"></script>
				<script type="text/javascript">
					var so = new SWFObject('<%=basePath%>video/mediaplayer.swf','mpl','440','310','7');
					so.addParam('allowfullscreen','true');
					so.addParam('allowscriptaccess','sameDomain');
					so.addVariable('width','440');
					so.addVariable('height','310');
					so.addVariable('file','<%=basePath%>video/test.flv');
					so.addVariable("image","<%=basePath%>video/cover.jpg");
					so.write("flvcontainer");
					//播放指定的flv文件
					function playFlv(pic,flv){
						so.addVariable('file',flv);
						so.addVariable("image",pic);
						so.addVariable('autostart','true');
						so.write("flvcontainer");					
					}					
				</script>		
		 		</div>
		 	</div>
		</div>
	<jsp:include page="headfoot/footer.jsp"></jsp:include> 
  </body>
</html>
