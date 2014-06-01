<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head> -->
    <base href="<%=basePath%>">
    
    <title>导航头</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/headupstyles.css">
	<script type="text/javascript" src="<%=basePath%>js/headup.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/asosshgetpost.js"></script>
	<style type="text/css">
		body {
		margin: 0;
		padding: 0;
		font-family:  'georgia' '仿宋';
		font-size: 12px;
	}
	.headupid {
		margin: 0;
		padding: 0;
		font-size: 12px; 
		font-family:  'georgia' '仿宋';
	}
	a{
		text-decoration: none;
	}
	</style>
  <script type="text/javascript">
	function admininfo(){
		var password=window.prompt('请输入网站管理密码？',"");
		if (password=="1234") {
			window.location.href="<%=basePath %>admin/adminlogin.jsp";
		}else{
			alert("普通游客别闹了");
		}
	}
	function isgotocart(){
		if (userislogin()) {
			window.location.href="<%=basePath %>asossh/cart!mycart.action";
		}else{
		 	homemessagerShowtime("请登录",1500);
			userloginjs();    //显示用户登录
		}
	}
	function isgotoasess(){
		if (userislogin()) {
			window.location.href='<%=basePath %>asossh/userinfo!userHome.action';
		}else{
			homemessagerShowtime("请登录",1500);
			userloginjs();    //显示用户登录
		}
	}
	function isgotohome(){
		if (userislogin()) {
			window.location.href='<%=basePath %>asossh/userinfo!userHome.action';
		}else{
			homemessagerShowtime("请登录",1500);
			userloginjs();    //显示用户登录
		}
	}
	function userislogin(){
		var hiddenusername =$("#hiddenusername").val();
		if (hiddenusername!='') {
			return true;
		}else{
		  return false;
		}
	}
	/*网站提交方式由get方式全部转换成post*/
	</script>

  <div id="asosshgetpost" style="display:none;">
  	
  </div>
<div id=page class="headupid">
	<div class="chl-poster simple" id="headupheader">
		<div id="site-nav">
			<ul class="quick-menu">
			  <li class="home"><a href="<%=basePath%>index.jsp">闻道美食网</a> </li>
			  <li class="mytaobao menu-item">
				  <div class="menu">
					  <a class="menu-hd" href="javascript:void(0);" onclick="isgotohome();">
					  		个人中心</a> 
					  <div class="menu-bd">
						  <div class="menu-bd-panel">
							  <div>
								  <a href="javascrpit:void(0)" onclick="isgotohome();">已买到的宝贝</a>
								  <a href="javascrpit:void(0)" onclick="isgotohome();">已卖出的宝贝</a> 
							  </div>
						  </div>
					  </div>
				  </div>
			  </li>
			  <li class=cart>
			  <a href="javascript:void(0);"  onclick=" isgotocart(); ">
			  		<s></s>购物车 <input type="hidden" id="hiddenusername" value="${user.username}"> </a></li>
			  <li class=favorite>
			  <a href="javascript:void(0);"onclick=" isgotoasess(); ">
			  		收藏夹</a></li>
			  <li class="search menu-item">
				  <div class="menu"><span class="menu-hd"><s></s>搜索<b></b></span> 
					  <div class="menu-bd">
						  <div class="menu-bd-panel">
							   <form  name="formsearch" action="<%=basePath%>asossh/seekinput!seekGoodorHotel.action" method="post">
							  	<input name="hotelPojo.hotelName" type="text" autocomplete="off" 
                       				 	value="输入关键词，回车搜索美食或饭店" onfocus="if(this.value=='输入关键词，回车搜索美食或饭店'){this.value=''; inputonfocus() ;}"  
                        				onblur="if(this.value==''){this.value='输入关键词，回车搜索美食或饭店';}"    />
							  		<button type=submit>搜 索</button> 
							 	<input type=hidden  value=newsearch name=shopf> 
							  </form>
						  </div>
					  <s class=r></s><s class=rt></s><s class=lt></s><s class=b></s><s class="b b2"></s><s class=rb></s><s class=lb></s>
					  </div>
				  </div>
			  </li>
			  <li class="services menu-item">
				  <div class="menu">
					  <a class="menu-hd" href="#" target=_top>网站导航<b></b></a> 
					  <div class="menu-bd" style="WIDTH: 210px; HEIGHT: 262px; _width: 202px">
						  <div class="menu-bd-panel">
							  <dl>
								<dt><a href="#">购物</a>
								<dd>
									<a href="#">美食</a> 
									<a href="#">分类</a> 
								</dd>
							</dl>
							  <dl>
								<dt><a href="#">管理</a> 
								<dd>
								  <a href="javascript:void(0) " style="padding: 3px 3px ;border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;"  onclick=" admininfo();">网站管理</a>
								</dd>
							</dl>
							 <dl>
							 	<dt><a href="#">网站统计</a>
									<dd >本站共有<s:property value='@com.secret.action.StaticAction@getcount()'/>次访问</dd>							 	
							 </dl>
						  </div>
						  <s class=r></s>
						  <s class=rt></s>
						  <s class=lt></s>
						  <s class=b style="WIDTH: 169px"></s>
						  <s class="b b2" style="WIDTH:169px"></s>
						  <s class=rb></s><s class=lb></s>
					  </div>
				  </div>
			  </li>
			  <li class="services menu-item last">
			  <div class="menu">
				  <a class="menu-hd" href="#" target=_top>网站分享<b></b></a> 
				  <div class="menu-bd" style="WIDTH: 210px; HEIGHT: 100px; _width: 202px">
				<div class="menu-bd-panel">
						  <dl>
							<dt><a href="#">分享方式</a>
							<dd>
						 	<a style="border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 3px 3px ; "
						 			href="javascript:void((function(s,d,e,r,l,p,t,z,c){x=document;y=window;if(x.selection){Q=x.selection.createRange().text;}else%20if(y.getSelection){Q=y.getSelection();}else%20if(x.getSelection){Q=x.getSelection();};var%20f='http://v.t.sina.com.cn/share/share.php?',u=z||d.location,p=['url=',e(u)+e('\n')+e(Q),
										'&title=',e(t||d.title),'&source=',e(r),'&sourceUrl=',e(l),'&content=',c||'gb2312','&pic=',e(p||'')].join('');function%20a(){if(!window.open([f,p].join(''),'mb',['toolbar=0,status=0,resizable=1,width=440,height=430,left=',(s.width-440)/2,',top=',(s.height-430)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent,'','','','','','utf-8'));">
										新浪微博</a>
						  <a  href="https://chart.googleapis.com/chart?cht=qr&chs=220x220&choe=UTF-8&chld=L|2&chl=<%=basePath%>index.jsp" 
			    				target="_blank" style="border: 1px solid #ffaa00;border-radius:10px 10px 10px 10px;padding: 3px 3px ; "
			    			>二维码</a>
					</dd>
				</dl>
			</div>
			</div>
			</div>
			  </li>
		    </ul>
		</div>
	</div>
</div>

 