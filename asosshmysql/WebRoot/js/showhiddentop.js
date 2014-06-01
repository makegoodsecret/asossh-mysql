var   show_hidden=true;
		function notice_show()//显示
		{
			var browser_visible_region_height=document.documentElement.clientHeight;//获取浏览器可见区域高度
			var element_height=$(".show_add_address").outerHeight();//获取元素高度:height+paelement_heighting+margin
			//计算元素显示时的top值
			var element_show_top=(browser_visible_region_height-element_height-200)/3;
			$(".show_add_address").stop(true).animate({top:element_show_top,left:"200px",opacity:1},1000);
			 show_hidden=false;
		}
		function notice_hidden()//隐藏
		{		 
			var element_height=$(".show_add_address").outerHeight();//获取元素高度:height+paelement_heighting+margin
			var ee=-element_height;//元素隐藏时的top值
			$(".show_add_address").stop(true).animate({top:ee,opacity:0},1000);
			show_hidden=true;
		}
	$(function(){
	/*弹出层地址*/
		if($.browser.msie && $.browser.version<=6)
		{
			$(".show_add_address").css("position","absolute");
		} 
		$(".show_add_address").css({"top":$(".show_add_address").outerHeight()*(1)+"px","opacity":0});//载入页面时将元素置于页面可见区域的顶部达到自上而下显示效果（PS：还有隐藏效果）
		
		$("a.close").click(function(){
			var element_height=$(".show_add_address").outerHeight();//获取元素高度:height+paelement_heighting+margin
			var ee=-element_height;//元素隐藏时的top值
			$(".show_add_address").animate({opacity:0},1000).animate({top:ee},0);
			show_hidden=true;
		});//点击关闭按钮隐藏
		$("#cancel-btn").click(function(){
			notice_hidden();//单击按钮触发隐藏
		});
		$("a.btn").click(function(){
			$(".show_add_address").animate({top:$(document).height(),opacity:0},1000);
			show_hidden=true;
		});
		$("#newAddAddressButton").click(function(){
			$("#submit_update").val("submit");	//修改为提交方式为保存
			if (show_hidden) {
				notice_show();//单击按钮触发显示
			}else{
				notice_hidden();//单击按钮触发隐藏
			}
		});
		
		function check()
		{
			var kk=$(".show_add_address").outerHeight()*-1;//获取元素高度:height+paelement_heighting+margin
			var ww=$(document).height();
			var qq=parseInt($(".show_add_address").css("top"));//获取元素当前的top值，String类型转换为number类型
			
			if(qq == kk || qq == ww)
			{
				return;
			}
			else//弹出层自适应浏览器窗口大小。
			{
				var browser_visible_region_height=document.documentElement.clientHeight;//获取浏览器可见区域高度
				var element_height=$(".show_add_address").outerHeight();//获取元素高度:height+paelement_heighting+margin
				//计算元素显示时的top值
				var element_show_top=(browser_visible_region_height-element_height-200)/3;
				$(".show_add_address").stop(true).animate({top:element_show_top,left:"200px"},1000);
			}
		}
		
		$(window).resize(function(){
			check();
		});//自适应浏览器窗口大小
	})
	
	