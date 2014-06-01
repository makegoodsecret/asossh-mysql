<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib  prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>  
    <base href="<%=basePath%>">
    
<!--<title>百度导航</title> -->
    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=6a5c5a8dcaeb5b014a2c293d48a8bc34"></script>
  	<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>
  <%-- <script type="text/javascript" src="<%=basePath%>js/jquery-1.7.1.js"></script>    --%>
 <!-- 获取用户的经纬度  -->
	 <script type="text/javascript" src="http://j.maxmind.com/app/geoip.js"></script> 
	<!-- 百度地图使用链接-->
	<style type="text/css">
	#allmap,#l-map{
		height: 450px;width:680px  ; 
		border-radius:10px 10px 10px 10px;
		border: 1px solid #eee;
	}
	/* #r-result{
		 height: 50%;width: 20%;float: left;
	} */
	.titleclass{
		border-radius:10px 10px 10px 10px;
		border: 1px solid #aa0000;
		font-family:仿宋;
		font-size: 20px;
		color: black; }
	.titleclass:HOVER { background-color: #eee; }
	.titleclass:VISITED { color:black;}
	</style>
   <!-- 添加检索支持 -->
 
   </head> 
  <body >
  <div style="border: 1px solid #eee;border-radius:5px 5px 5px 5px;">
  	<div style="float: left; margin-bottom: -15px; padding-top: 5px;padding-bottom: 5px;border: 1px solid #eee;border-radius:5px 5px 5px 5px;">
 	
   </div>
    <!-- 根据IP解析当前的位置 -->
      <div id="allmap" style="clear: left;" ></div>  
    <div style="float: right; width: 270px; height:450px; margin-top:-449px; border: 1px solid #eee;border-radius:5px 5px;">
          <jsp:include page="homemaptab.jsp"></jsp:include>   
    </div>
    </div>
    <input type="hidden" id="info_lng">
  <script type="text/javascript">
  	var marker ;
     window.map  =new BMap.Map("allmap");   //allmap与div对应
	 //IP定位到当前的位置
	 var point  = new BMap.Point(122.122976 , 30.01966);    //默认定义到浙江海洋学院
	 map.centerAndZoom(point,13);							//14是级别，数值越大放大级别越高							//创建百度地图 
	 map.enableScrollWheelZoom();           				//启用滚轮放大缩小，默认禁用。
	 map.enableContinuousZoom();  							//启动地图惯性拖拽，默认禁止
	map.addControl(new BMap.OverviewMapControl({isOpen:true}));        //添加默认缩略地图控件
	map.addControl(new BMap.MapTypeControl({mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]}));     //2D图，卫星图
	map.enableScrollWheelZoom();    						//开启滚轮放大缩小
   	map.enableContinuousZoom();  							//启动地图惯性拖拽，默认禁止
	//map.addControl(new BMap.OverviewMapControl({isOpen:true, anchor: BMAP_ANCHOR_TOP_RIGHT})); //右上角，打开
	 var BASEDATA ;											//动态数据
	 var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
    if(this.getStatus() == BMAP_STATUS_SUCCESS){
      	var mk = new BMap.Marker(r.point);
        map.addOverlay(mk);
       // map.panTo(r.point);  
      	map.setCenter(r.point);
        point=r.point;
        //alert('您的位置：'+r.point.lng+','+r.point.lat);
        addressComponents(r.point.lat, r.point.lng);
    }else {//用户拒绝定位
        //alert('failed'+this.getStatus()); 
        homemessagerShowtime("以为你开启模糊定位",2000);
        //启动模糊定位
      	var lat = geoip_latitude(); //纬度
		var lng = geoip_longitude(); //经度
		  point  = new BMap.Point(lng , lat); 
		var mk = new BMap.Marker(point);
        map.addOverlay(mk);
        map.panTo(point);
         addressComponents(lat,lng);
    }        
	},{enableHighAccuracy: true})
	 //移动到的城市获取的饭店信息
	 map.addEventListener("dragend",function  showInfo(){
	 	var cp =map.getCenter();
	 	var gc  =new BMap.Geocoder();
	 	gc.getLocation(cp,function(rs){
	 		var addComp=rs.addressComponents;
	 		addressComponents(userlat, userlon); //重新获取当前定位区
	 	});
	 });
	 //获取用户所在的Gps，得到当前城市里面的全部饭店信息
	 function addressComponents(userlat, userlon){
	 	$(function(){
	 var url ="<%=basePath%>asossh/hotel!hotelhome.action";
	 $.getJSON(url,{"userlat":userlat, "userlon":userlon},function(data){
		 	$("#lidivid").empty();
			$("#maptabsMove").empty();
	 	$.each(data.baidumaptablist,function(j,valj){
		 	//alert("data"+valj.maptabdistance);
			$("#lidivid").append(valj.maptablib);
			$("#maptabsMove").append(valj.maptabdistance);
	 	});
 			 BASEDATA = data.baidumaplist;   //为百度地图动态注值；
 			 initMap(); //创建和初始化地图
	 		 aui();//重新绑定按钮事件
	 		 inmarker(point); //重新生成中心标注
	 }) 
 	});
	 }
	 
	 
	 
	 //创建和初始化地图函数
	 function initMap(){
	 	map.addControl(new BMap.NavigationControl()); 
	 	/*	addControl()       将控件添加到地图，一个控件实例只能向地图中添加一次。
	 		NavigationControl()此类表示地图的平移缩放控件，可以对地图进行上下左右四个方向的平移和缩放操作。
	 	*/
	 	window.searchClass = new SearchClass();
	 	searchClass.setData(BASEDATA);   //将静态的用户数据存入到
	 	var dd= searchClass.search({k:"title",d:"图书馆",t:"more",s:""});//t:{single|more},s{all|!all}
		addMarker(dd);     //向地图中添加marker标记
		//添加版权控件
		var cr =  new BMap.CopyrightControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
		map.addControl(cr);
		var bs  = map.getBounds();
		cr.addCopyright({id:1,content:"<font style='font-family: 楷体;font-size: 12px;'>百度地图开发：</font><button type='button' style='padding: 3px 3px;' onclick=alert('你是谁,别乱点') >徐凯</button>",bounds:bs});
		//添加默认缩略地图控件
	 }
	  function showPoin(e){
   		//alert("你家的 经纬度"+e.point.lng+e.point.lat);
	   	var usergpspoint= new BMap.Point(e.point.lng,e.point.lat);
	   	if (resultGpspoint()) {
		   	inmarker(usergpspoint);
		}
	   	map.removeEventListener("click",showPoin);    //移除标记,及点击别处不会生成新的标记
   }
   
   function  inmarker(usergpspoint){
  		 var myIcon = new BMap.Icon("image/tutu02.gif", new BMap.Size(40,50));
	   	 marker  = new BMap.Marker(usergpspoint,{icon:myIcon});
	   	 $("#info_lng").val(usergpspoint.lng);
	   	map.addOverlay(marker);							//将标注添加到地图中
	   	marker.setAnimation(BMAP_ANIMATION_BOUNCE);		//添加跳动的动画
	    marker.enableDragging();            //可拖拽
	    //在标注开启拖拽功能后，您可以监听标注的dragend事件来捕获拖拽后标注的最新位置。
	   //marker.disableDragging();            //不可拖拽，默认为不可拖拽
	   	marker.addEventListener("dragend",function(e){
	   		//alert("移动后的经纬度"+e.point.lng+","+e.point.lat);
	   		$("#info_lng").val(e.point.lng);
	   		point=e.point;       //中心坐标重新获得
	   		addressComponents(e.point.lat, e.point.lng);
	   	});
	   	
	   	//点击跳动的动画让动画显示文字
	   	var infoWindow   = new BMap.InfoWindow(
	   	"<p style='font-size:14px;'>这是我的位置吗？"+
	   	"<input type='button' value='是' onclick='map.closeInfoWindow()' title='关闭这个窗口'>"+
	   	"<input type='button' value='修改' onclick='removemarker()' title='重新点击获取你的当前位置'></p>"
	   	);
   	 	marker.addEventListener("click",function(){
			this.openInfoWindow(infoWindow);  	 	
   	 	});
	   	}
	   	//移除marker标记
   	 	function  removemarker(){
   	 		map.removeOverlay(marker); //移除marker标记
   	 		map.addEventListener("click",showPoin);  //重新获取鼠标点击
   	 		$("#info_lng").val("");
   	 	}
   	 	//检测是否已经添加了
   	 	function resultGpspoint(){
			if($("#info_lng").val()==""){
				return true;
			}else{
				return false;				  
			}
		}
   //添加鼠标点击事件
   map.addEventListener("click",showPoin);
	 window.search = function(name_t,name_s,id_d){
	 	var t_o  = document.getElementsByName(name_t);
	 	var s_o  =  document.getElementsByName(name_s);
	 	var s_v,t_v,d_v=  document.getElementById(id_d).value;
	 	for(var i=0;i<t_o.length;i++){
	 		if(t_o[i].checked){
	 			t_v = t_o[i].value;
	 		};
	 	};
	 	for(var i=0;i<s_o.length;i++){
	 		if(s_o[i].checked){
				s_v =s_o[i].value;	 		
	 		}
	 	};
	 searchClass.trim(t_v) ==""&&(t_v='single');
	 var dd  = searchClass.search({k:"title",d:d_v,t:t_v,s:s_v});
	 addMarker(dd);			//向地图中添加marker
	 };
	 //创建marlker
	 window.addMarker = function(data){
	  map.clearOverlays();
	// alert(data.length);
	 for(var i=0;i<data.length;i++){
        var json = data[i];
        var p0 = json.point.split("|")[0];
        var p1 = json.point.split("|")[1];
		var point = new BMap.Point(p0,p1);
 	//	infowindow( point );
        var iconImg = createIcon(json.icon);
        var marker = new BMap.Marker(point,{icon:iconImg});
        var iw = createInfoWindow(i);
		var label  = new BMap.Label(json.hotemName,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
			marker.setLabel(label);
			map.addOverlay(marker);
			marker.setAnimation(BMAP_ANIMATION_BOUNCE);  //跳动的动画
			label.setStyle({
				borderColor:"#eee",
				color:"#333",
				cursor:"pointer"
			});
			(function(){
			var _json  = json ;
			var _iw =  createInfoWindow(_json);
			var _marker = marker  ;
			_marker.addEventListener("click",function(){
				this.openInfoWindow(_iw);
			});     //addEventListener()添加事件监听函数,openInfoWindow()在地图上打开信息窗口。
			_iw.addEventListener("open",function(){
			_marker.getLabel().hide();
			});			
			_iw.addEventListener("close",function(){
			_marker.getLabel().show();	   //getLabel()返回标注的文本标注。		
			});
			label.addEventListener("click",function(){
			_marker.openInfoWindow(_iw);
			});
			if(!!json.isOpen){
			label.hide();
			_marker.openInfoWindow(_iw);
			}
			})();
		}
	 };
//创建InfoWindow
function createInfoWindow(json){
    var iw = new BMap.InfoWindow("<div style='paddring:10px 10px ;'><b class='iw_poi_title'  >" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div><div>");
    return iw;
}
	//创建一个Icon
function createIcon(json){
    var icon = new BMap.Icon("http://dev.baidu.com/wiki/static/map/API/img/ico-marker.gif", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowAnchor:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
    return icon;
}
	 function SearchClass(data){
	 	this.datas= data;
	 }
	 // rule = {k:"title",d:"酒店",s:"all",t:"single"}=>t{single:(key=?),more:(key like[%?%])}//t:{single|more},s{all|!all}
	 SearchClass.prototype.search= function(rule){
	 	if(this.datas== null){
	 		alert("数据不存在！");
	 		return  false;
	 	};
	 	if(this.trim(rule)==""||this.trim(rule.d)==""||this.trim(rule.k)==""||this.trim(rule.t)==""){
	 		alert("请指定要搜索内容！");
	 		return false;
	 	};
	 	var reval  =[];
	 	var datas  = this.datas;
	 	var len  = datas.length;
	 	var me  = this;
	 	var ruleReg  = new RegExp(this.trim(rule.d));
	 	var hasOpen  = false;
	 	var addData  = function(data,isOpen){
	 		//第一条数据打开信息窗口
	 		if(isOpen&&!hasOpen){
	 			hasOpen  = true;
	 			data.isOpen =1;
	 		}else{
	 			data.isOpen = 0;
	 		};
	 		reval.push(data);
	 	};
	 	var getData = function(data,key){
	 		var ks  = me.trim(key).split(/\./);
	 		var i  = null, s=  "data";
	 		if(ks.length ==0){
	 			return data;
	 		}else{
	 			for ( var i = 0; i < ks.length; i++) {
					s+='["'+ks[i]+'"]';
				}
				return  eval(s);
	 		}
	 	};
	 	for ( var cnt = 0; cnt < len; cnt++) {
			var data  = datas[cnt];
			var d  = getData(data,rule.k);
			if(rule.t=="single"&&rule.d==d){
				addData(data,true);
			}else if (rule.t!="single"&&ruleReg.test(d)){
				addData(data, true);
			}else if(rule.s ="all"){
				addData(data, false);
			}
		}
	 	return reval;
	 };
	 SearchClass.prototype.setData = function(data){
	 	this.datas = data;
	 };
	SearchClass.prototype.trim=function(str) {
		if(str == null){
			str ="";
		}else{
			str =str.toString();
		}
		return str.replace(/(^[\s\t\xa0\u3000]+)|([\u3000\xa0\s\t]+$)/g,"");
	};
	
//检索信息窗口类
	 function infowindow( poi ){
    var content = '<div style="margin:0;line-height:20px;padding:2px;">' +
                    '<img src="image/email.png" alt="" style="float:right;zoom:1;overflow:hidden;width:100px;height:100px;margin-left:3px;"/>' +
                    '地址：北京市海淀区上地十街10号<br/>电话：(010)59928888<br/>简介：百度大厦位于北京市海淀区西二旗地铁站附近，为百度公司综合研发及办公总部。' +
                  '</div>';
    //创建检索信息窗口对象
    var searchInfoWindow = null;
	searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
			title  : "闻路食府网百度搜索、短信分享控件",     		 //标题
			width  : 350,             //宽度
			height : 150,              //高度
			panel  : "panel",         //检索结果面板
			enableAutoPan : true,     //自动平移
			searchTypes   :[
				BMAPLIB_TAB_SEARCH,   //周边检索
				BMAPLIB_TAB_TO_HERE,  //到这里去
				BMAPLIB_TAB_FROM_HERE //从这里出发
			]
		});
	//创建标注对象
    var marker = new BMap.Marker(poi); //创建marker对象
    marker.enableDragging(); //marker可拖拽
    marker.addEventListener("click", function(e){
	    searchInfoWindow.open(marker);
    });
    map.addOverlay(marker); //在地图中添加marker
    searchInfoWindow.open(marker); //在marker上打开检索信息串口
    $("close").onclick = function(){
        searchInfoWindow.close();
    };
    $("open").onclick = function(){
		var enableSendToPhone = false;
        if ($("enableSendToPhone").checked) {
            enableSendToPhone = true;
        }
		searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
			title  : "闻路食府网百度搜索、短信分享控件",      //标题
			width  : 290,             //宽度
			height : 105,              //高度
			panel  : "panel",         //检索结果面板
			enableAutoPan : true,     //自动平移
			enableSendToPhone: enableSendToPhone, //是否启用发送到手机
			searchTypes   :[
				BMAPLIB_TAB_SEARCH,   //周边检索
				BMAPLIB_TAB_TO_HERE,  //到这里去
				BMAPLIB_TAB_FROM_HERE //从这里出发
			]
		});
        if ($("enableAutoPan").checked) {
            searchInfoWindow.enableAutoPan();
        } else {
            searchInfoWindow.disableAutoPan();
        };
        searchInfoWindow.open(marker);
    };
    

    var isPanelShow = false;
    //显示结果面板动作
    $("showPanelBtn").onclick = function(){
        if (isPanelShow == false) {
            isPanelShow = true;
            $("showPanelBtn").style.right = "300px";
            $("panelWrap").style.width = "300px";
            $("map").style.marginRight = "300px";
            $("showPanelBtn").innerHTML = "隐藏检索结果面板<br/>>";
        } else {
            isPanelShow = false;
            $("showPanelBtn").style.right = "0px";
            $("panelWrap").style.width = "0px";
            $("map").style.marginRight = "0px";
            $("showPanelBtn").innerHTML = "显示检索结果面板<br/><";
        }
    }
    }
    
	 </script>
	 </body>
</html>  
