<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
 	<base href="<%=basePath%>">
<style>
a img { border:0;}
.maptabs_wrap { width:270px; background:url(image/tab_bg.png); height:445px;  position:relative;   border-radius:5px 5px;  font-size:12px; }
#homemaptabcity{width:270px;position: absolute; float: left;}
.maptabs_list { float:right; top:50px; right: 0px; list-style:none; height:30px; position:relative; z-index:1; }
.maptabs_list li { clear: left; border: 1px solid #6DBE0A; border-radius:10px 10px ; margin-top:4px;  height:28px;  width:90px; 
				line-height:25px; text-align:center; color:#000; font-size:14px; cursor:pointer;
				overflow:hidden;text-overflow:ellipsis;white-space:nowrap; -o-text-overflow: ellipsis}
.maptabs_list li.curr {   border: 1px solid #8DBE0A; border-radius:10px 10px ; font-size:14px; color:#397ab2; font-weight:bold; }
.maptabs_con { border:1px solid #c8cdd0;  height: 360px; border-radius:5px 5px;  padding-bottom:30px;  width:270px; position:relative; z-index:0;  overflow:hidden; background:url(image/tab_bg.png) repeat;}
.maptabs_con_wrap {    position:relative;   }
.maptabs_move { position:absolute; left:0;  }
.maptabs_move>div {  height: 330px;  width: 170px; padding:20px 0px 20px 0px;font-size:15px;  margin-top:5px; margin-bottom:45px; border: 1px solid #c8cdd0;  border-radius:10px 10px ;  }
#maptabsPrev {    width:90px; line-height:25px;  background:#7DBE0A ; border-radius:10px 10px ;  padding:2px 2px;  }
#maptabsNext {    width:90px; line-height:25px;background:#FDBE0A;   border-radius:10px 10px ;  padding:2px 2px; }
.class_hotelName{font-size: 18px;border: 1px solid #c9cdd0; margin-top:-20px; text-align:center;white-space:nowrap;woverflow:hidden;text-overflow:ellipsis; -o-text-overflow: ellipsis;border-radius:10px 10px ;}      
</style>
<!-- <script src="js/jquery-1.7.1.js" language="javascript" type="text/javascript"></script> -->
<script>
//初始化aui(与jQuery类似)
$(function(){
     aui();//绑定按钮事件
})
 
//添加
function addbtm(){
    $(".maptabs_list").append("<li>tabs5</li>");
    $(".maptabs_move").append("<div> tabs5 </div>");
    aui();
}
//绑定按钮事件
function aui(){
     var oWrap = $("#lidivid"),
    oTabs = oWrap.find("li"),
    oTabsLen = oTabs.length,
    oMove = $("#maptabsMove"),
    nWidth = oMove.children().eq(0).width(),
    iTimer = null,
    oPrev = $("#maptabsPrev"),
    oNext = $("#maptabsNext"),
    IDX = 0;
    oTabs.unbind( "click" );  //取消绑定
    oPrev.unbind( "click" );  //取消绑定
    oNext.unbind( "click" );  //取消绑定
    //重现绑定点击tab
    oTabs.bind("click",
    function() {
        var _this = $(this);
        IDX = _this.index();
        _this.addClass("curr").siblings().removeClass("curr");
        var nw="top:"+(-417*IDX)+"px;";
         oMove.stop().attr("style", nw);
    });
	//重新绑定向上按钮tab
    oPrev.bind("click",
    function() {
        if (IDX > 0) {
            IDX -= 1;
        } else {
            IDX = oTabsLen - 1;
        };
        var nw="top:"+(-417*IDX)+"px;";
         oMove.stop().attr("style", nw);
        oTabs.eq(IDX).addClass("curr").siblings().removeClass("curr");
        return false;
    });
    //重新绑定向下按钮tab
    oNext.bind("click",
    function() {
        if (IDX < oTabsLen - 1) {
            IDX += 1;
        } else {
            IDX = 0;
        };
         var nw="top:"+(-417*IDX)+"px;";
         oMove.stop().attr("style", nw);
        oTabs.eq(IDX).addClass("curr").siblings().removeClass("curr");
        return false;
    });
}
</script>
<script type="text/javascript">
	function removeli(){
		var userlat=30.1;
		var userlon=127.1;
	  	addressComponents(userlat, userlon);
	
	}
</script>
</head>
<body>
<div id="maptabdiv" class="maptabs_wrap">
<div id="homemaptabcity"  >
	   <jsp:include page="json_address/homecity.jsp"></jsp:include>
</div>
 <!-- <button type="button" onclick="removeli()" >remove</button> -->
  <ul class="maptabs_list">
  	  <button type="button" id="maptabsPrev">上一家</button>  
  	<div id="lidivid">
    <s:iterator value="distancemap">
    	<s:iterator value="key" status="status">
    			<s:if test="#status.first">
    				<li class="curr">${hotelName}</li>
    			</s:if>
    			<s:else>
	    			<li>${hotelName}</li>
    			</s:else>
    	</s:iterator>
    </s:iterator>
    </div>
     <button type="button" id="maptabsNext">下一家</button>  
  </ul>
  <div class="maptabs_con">
    <div class="maptabs_con_wrap">
      <div id="maptabsMove" class="maptabs_move">
        <s:iterator value="distancemap">
	    	<s:iterator value="key"  status="status">
	    	<div>  
	    		<div class="class_hotelName">
	    		  <a title="点击进入${hotelName}" href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }">
	    			${hotelName}
	    		  </a>
	    		</div>
	    		<div style="margin-top: 3px;">
		    		<a title="点击进入${hotelName}" href="<%=basePath %>asossh/hotel!mainhotel.action?hotelPojo.hotelId=${hotelId }">
		    			<img src="<%=basePath %>photo/${hotelLogo}" alt="${hotelName}" width="170px;"  height="130px;"/>
		    		</a>
	    		</div>
	    		<div style="margin-top: 3px;">简介:${hotelAds }</div>
	    		<div style="margin-top: 3px;">
 						 饭店等级:
 						<s:if test="hotelPojo.hotelLevel<0.2">
 								一星级
 						</s:if>
 						<s:if test="hotelPojo.hotelLevel<0.3">
 								二星级
 						</s:if>
 						<s:elseif test="hotelPojo.hotelLevel<0.6">
 								三星级
 						</s:elseif>
 						<s:elseif test="hotelPojo.hotelLevel<0.8">
 								四星级
 						</s:elseif>
 						<s:else>
 								五星级
 						</s:else>
		  	 	</div>
	    		<div style="margin-top: 3px;"> 营业时间: <br/>
	    		<font style="font-size: 13px;">
		    		上午:${hotelShopAmStart }-${hotelShopAmEnd }<br/>
					 下午:${hotelShopPmStart }-${hotelShopPmEnd }
	    		</font>
	    		</div>
	    		<div style="margin-top: 3px;">
	    			联系方式:
	    			<font style="font-size: 12px;">
	    			 ${hotelCellphone }<br/>
	    			<s:if test="hotelPhonecode!=null">
		    			${hotelPhonesection }-${hotelPhonecode }-${hotelOtherphone }
	    			</s:if>
	    			</font>
	    		</div>
	    		<div style="margin-top: 3px;">
	    			地址:${hotelProvince}${hotelCity}${hotelCounty}${hotelOtherAddress}
	    		</div>
	    		<div style="margin-top: 3px;">
	    		  	 距离:
	    		  	 <s:set name="distencename">${value[(status.count-1)]<1 }</s:set>
	    		  	 <s:if test="#distencename">
	    		  		 ${value[(status.count-1)]*1000 }m
	    		  	 </s:if>
	    		  	 <s:else>
	    		  	 	 ${value[(status.count-1)] }km
	    		  	 </s:else>
	    		</div>
	    	 </div>
	    	</s:iterator>
    	</s:iterator>
      </div>
    </div>
  	
  </div>
  </div>

</body>
</html>
 
