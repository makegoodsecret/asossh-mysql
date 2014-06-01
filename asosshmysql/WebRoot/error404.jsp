<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>404页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 
	<link rel="stylesheet" type="text/css" href="<%=basePath%>page404error/page404.css">
	 
	 <script type="text/javascript" src="<%=basePath%>page404error/jquery-1.7.1.js"> </script>

   
  </head>
  <body>
	<a href="<%=basePath%>">
	
    <div id="parallax_wrapper">
      <div id="parallax_field">
        <img alt="building" class="js-plaxify" data-invert="true" data-xrange="0" data-yrange="20" height="415" id="parallax_bg" width="940"
        src="<%=basePath%>page404error/building.jpg" />
      </div>
      <div id="parallax_illustration">
        <div id="auth"></div>

        <img alt="404 | &ldquo;This is not the web page you are looking for&rdquo;" class="js-plaxify" data-xrange="20" data-yrange="10" height="249" id="parallax_error_text" width="271"
        src="<%=basePath%>page404error/404.jpg" />

        <img alt="Octobi Wan Catnobi" class="js-plaxify" data-xrange="10" data-yrange="10" height="230" id="parallax_octocat" width="188"
        src="<%=basePath%>page404error/Catnobi.jpg" />

        <img alt="land speeder" class="js-plaxify" data-xrange="10" data-yrange="10" height="156" id="parallax_speeder" width="440"
        src="<%=basePath%>page404error/speeder.jpg" />

        <img alt="Octobi Wan Catnobi's shadow" class="js-plaxify" data-xrange="10" data-yrange="10" height="49" id="parallax_octocatshadow" width="166"
        src="<%=basePath%>page404error/shadow.jpg" />

        <img alt="land_speeder's shadow" class="js-plaxify" data-xrange="10" data-yrange="10" height="75" id="parallax_speedershadow" width="430"
        src="<%=basePath%>page404error/land_speeder.jpg" />

        <img alt="building" class="js-plaxify" data-invert="true" data-xrange="50" data-yrange="20" height="123" id="parallax_building_1" width="304"
        src="<%=basePath%>page404error/building_plaxify.jpg" />

        <img alt="building_" class="js-plaxify" data-invert="true" data-xrange="75" data-yrange="30" height="50" id="parallax_building_2" width="116"
        src="<%=basePath%>page404error/parallax_building_2.jpg" />
      </div>

    </div>
</a>
    <script type="text/javascript">
    (function(e){function l(){return f==true?false:window.DeviceOrientationEvent!=undefined}function c(e){x=e.gamma;y=e.beta;if(Math.abs(window.orientation)===90){var t=x;x=y;y=t}if(window.orientation<0){x=-x;y=-y}u=u==null?x:u;a=a==null?y:a;return{x:x-u,y:y-a}}function h(e){if((new Date).getTime()<r+n)return;r=(new Date).getTime();var t=s.offset()!=null?s.offset().left:0,u=s.offset()!=null?s.offset().top:0,a=e.pageX-t,h=e.pageY-u;if(a<0||a>s.width()||h<0||h>s.height())return;if(l()){if(e.gamma==undefined){f=true;return}values=c(e);a=values.x/30;h=values.y/30}var p=a/(l()==true?o:s.width()),d=h/(l()==true?o:s.height()),v,m;for(m=i.length;m--;){v=i[m];newX=v.startX+v.inversionFactor*v.xRange*p;newY=v.startY+v.inversionFactor*v.yRange*d;if(v.background){v.obj.css("background-position",newX+"px "+newY+"px")}else{v.obj.css("left",newX).css("top",newY)}}}var t=25,n=1/t*1e3,r=(new Date).getTime(),i=[],s=e(window),o=1,u=null,a=null,f=false;e.fn.plaxify=function(t){return this.each(function(){var n=-1;var r={xRange:e(this).data("xrange")||0,yRange:e(this).data("yrange")||0,invert:e(this).data("invert")||false,background:e(this).data("background")||false};for(var s=0;s<i.length;s++){if(this===i[s].obj.get(0)){n=s}}for(var o in t){if(r[o]==0){r[o]=t[o]}}r.inversionFactor=r.invert?-1:1;r.obj=e(this);if(r.background){pos=(r.obj.css("background-position")||"0px 0px").split(/ /);if(pos.length!=2){return}x=pos[0].match(/^((-?\d+)\s*px|0+\s*%|left)$/);y=pos[1].match(/^((-?\d+)\s*px|0+\s*%|top)$/);if(!x||!y){return}r.startX=x[2]||0;r.startY=y[2]||0}else{var u=r.obj.position();r.obj.css({top:u.top,left:u.left,right:"",bottom:""});r.startX=this.offsetLeft;r.startY=this.offsetTop}r.startX-=r.inversionFactor*Math.floor(r.xRange/2);r.startY-=r.inversionFactor*Math.floor(r.yRange/2);if(n>=0){i.splice(n,1,r)}else{i.push(r)}})};e.plax={enable:function(t){e(document).bind("mousemove.plax",function(n){if(t){s=t.activityTarget||e(window)}h(n)});if(l()){window.ondeviceorientation=function(e){h(e)}}},disable:function(t){e(document).unbind("mousemove.plax");window.ondeviceorientation=undefined;if(t&&typeof t.clearLayers==="boolean"&&t.clearLayers)i=[]}};if(typeof ender!=="undefined"){e.ender(e.fn,true)}})(function(){return typeof jQuery!=="undefined"?jQuery:ender}())
    </script>

    <script type="text/javascript">
      // Plaxify all `js-plaxify` element layers
      var layers = $('.js-plaxify')

      $.each(layers, function(index, layer){
        $(layer).plaxify({
          xRange: $(layer).data('xrange') || 0,
          yRange: $(layer).data('yrange') || 0,
          invert: $(layer).data('invert') || false
        })
      })

      $.plax.enable()

      $.ajax({
        url: '/sessions/login_404?return_to='+window.location.pathname,
        success: function(data) {
          if (data != ' ') {
            $('#auth').html(data).slideDown(100)
            $('#login_field').attr("placeholder", "Username or Email")
            $('#password').attr("placeholder", "Password")
          }
        }
      });

      $(document).on('keydown', function(event) {
        if (event.target === document.body && event.keyCode === 192) {
          $('#parallax_wrapper').css('-webkit-filter','grayscale(25%)')
          document.cookie = 'stats=yes; path=/';
          setTimeout(function() {
            location.reload();
          }, 250)
          return false;
        }
      })
    </script>
  </body>
</html>
