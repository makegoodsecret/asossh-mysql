/*************
		Author:轻轻的烟雾 QQ:281099678
		charset:ANSI
		Based on: jquery-1.7.1.min.js
		______________________________________________
		Example:

		$('#time').setTime({
			drag:true,  //是否可以拖动
			h:[5,20],   //小时限制范围
			i:[5,50],   //分
			s:[5,45],   //秒
			a:0.05,     //拖动的加速度
			constraint:'',   //拖动的横竖限制 : '';'l';'v'
			'starteffect': function(d){    //开始时的特效
				$('#msg').html(d[0]);
			},
			'onmove':function(e){          //移动过程中的特效
				$('#msg').html(e[0] + '/' + e[1])
			},
			zindex:'-100',
			'cursor':'move',   //鼠标样式
			'area':[[50,600],[10 ,500]],    //限制拖动范围
			'callback':function(){          //回调函数
				alert(1)
			}
		});
*************/


(function($){
	// class ID,避免与原html的class name 冲突
	var class_num = id_num = (Math.random()*1000000 + 1000000).toString().substr(0,6);
	//settimeout
	var set_time_out = 0;

	document.writeln('<style>'+
						'.set-time-'+class_num+'{border:5px solid #aaa;background:#ddd;z-index:2000;overflow:hidden;max-width:520px;_width:530px;border-radius:5px;}' +
						'.set-time-'+class_num+' div,dl,dt,dd,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td{margin:0;padding:0;}' +
						'.set-time-'+class_num+' a{text-decoration:none;color:blue;}' +
						'.set-time-'+class_num+' table{border-collapse:collapse;border-spacing:0;vertical-align:top;width:100%;background:#fff;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-title{padding:5px;background:#aaa;overflow:hidden;*zoom:1;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-title div{float:left;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-title .set-time-'+class_num+'-close{text-align:right;float:right;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-title .set-time-'+class_num+'-close span a{color:#111;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-title .set-time-'+class_num+'-close span a:hover{background:#555;color:#fff;text-align:right;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-content div{float:left;margin:5px;display:inline;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-content .set-time-'+class_num+'-content-h{width:510px;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-content .set-time-'+class_num+'-content-i{width:250px;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-content .set-time-'+class_num+'-content-s{width:250px;}' +
						'.set-time-'+class_num+' td{border:1px solid #ccc;padding:2px;text-align:center;cursor:pointer;font:12px "宋体"} ' +
						'.set-time-'+class_num+' td.unuse{color:#ccc;cursor:wait;} ' +
						'.set-time-'+class_num+' td.use:hover{color:#eee;background:#999;} ' +
						'.set-time-'+class_num+' th{padding:2px;background:#ccc;border:1px solid #ccc;}' +
						'.set-time-'+class_num+' .now{background:#eee;color:red;}' +
						'.set-time-'+class_num+' .default{background:#bbb;color:#555;}' +
						'.set-time-'+class_num+' .selected{background:#555;color:#eee;}' +
						'.set-time-'+class_num+' .set-time-'+class_num+'-now{border:0px solid #111;text-align:left;padding:5px;clear:both;width:400px;font:12px "宋体"}' +
					'</style>');

	$.fn.extend({
		setTime : function(options){
			var self = $(this);
			options = options ? options : {};
			var h_min = options.h ? options.h[0] : 0;
			var h_max = options.h ? options.h[1] : 23;
			var i_min = options.i ? options.i[0] : 0;
			var i_max = options.i ? options.i[1] : 59;
			var s_min = options.s ? options.s[0] : 0;
			var s_max = options.s ? options.s[1] : 59;

			self.attr('readonly','true').bind('click', function(e){
				var id_num = (Math.random()*1000000 + 1000000 + (new Date).getMilliseconds()).toString().substr(0,7);
				var now_h = (new Date).getHours();
				var default_time = ( default_time = self.val() ) ? default_time.split(':') : [-1,-1,-1];
				var default_h = default_time[0];
				var default_i = default_time[1];
				var default_s = default_time[2];

				//小时选择框
				var td_class, now_class, default_class;
				var html_h = '<table id="set-time-'+id_num+'-h"><tr><th colspan="12">时</th>';
				for(var n = 0, num = 0, num_s = 0; n < 2; n ++){
					html_h += '<tr>';
					for(var n2 = 0; n2 < 12; n2 ++, num ++){
						td_class = ( h_min <= num && num <= h_max ) ? 'use' : 'unuse';
						default_class = (default_h == num) ? 'default':'';
						now_class = (now_h == num) ? 'now':'';
						num_s = num < 10 ? 0 + num.toString(): num;
						html_h += '<td class="'+td_class+' '+default_class+' '+now_class +'">'+num_s+'</td>';
					}
					html_h += '</tr>';
				}
				html_h += '</table>';

				//分钟选择框
				var html_i = '<table id="set-time-'+id_num+'-i"><tr><th colspan="10">分</th>';
				for(var n = 0, num = 0, num_s = 0; n < 6; n ++){
					html_i += '<tr>';
					for(var n2 = 0; n2 < 10; n2 ++, num ++){
						td_class = ( i_min <= num && num <= i_max ) ? 'use' : 'unuse';
						default_class = (default_i == num) ? 'default':'';
						num_s = num < 10 ? 0 + num.toString(): num;
						html_i += '<td class="'+td_class+' '+default_class+'">'+num_s+'</td>';
					}
					html_i += '</tr>';
				}
				html_i += '</table>';

				//秒钟选择框
				var html_s = '<table id="set-time-'+id_num+'-s"><tr><th colspan="10">秒</th>';
				for(var n = 0, num = 0, num_s = 0; n < 6; n ++){
					html_s += '<tr>';
					for(var n2 = 0; n2 < 10; n2 ++, num ++){
						td_class = ( s_min <= num && num <= s_max ) ? 'use' : 'unuse';
						default_class = (default_s == num) ? 'default':'';
						num_s = num < 10 ? 0 + num.toString(): num;
						html_s += '<td class="'+td_class+' '+default_class+'">'+num_s+'</td>';
					}
					html_s += '</tr>';
				}
				html_s += '</table>';

				var html = '<div id="set-time-'+id_num+'" class="set-time-'+class_num+'" style="position:absolute;display:none;">' +
				'<div class="set-time-'+class_num+'-title" id="set-time-title-'+id_num+'"><div><b>选择时间</b></div><div class="set-time-'+class_num+'-close"><span><a href="javascript:" title="关闭" id="set-time-'+id_num+'-close">&nbsp;×&nbsp;</a></span></div></div>' +
				'<div class="set-time-'+class_num+'-content"><div class="set-time-'+class_num+'-content-h">'+html_h+'</div><div class="set-time-'+class_num+'-content-i">'+html_i+'</div><div class="set-time-'+class_num+'-content-s">'+html_s+'</div></div>' +
				'<div class="set-time-'+class_num+'-now" id="set-time-'+id_num+'-now">now</div>'
				'</div>';

				$('.set-time-'+class_num).remove();
				$('body').append( html );
				//alert( html )

				var thisHtmlObj = $('#set-time-'+id_num);
				thisHtmlObj.css({display:'block', left:e.pageX-20, top:e.pageY+10});
				showTimeNow($('#set-time-'+id_num+'-now'));

				//关闭
				$('#set-time-'+id_num+'-close').live('click', function(){
					clearData(thisHtmlObj,self)
				});
				$('.set-time-'+class_num+'').live('mouseenter', function(){
					$(this).live('mouseleave', function(){
						clearData(thisHtmlObj,self)
					});
				});

				//默认选择当前小时
				thisHtmlObj.data('set-time-h', default_h != '-1' ? default_h : now_h );

				//选择时间
				$('#set-time-'+id_num+'-h td.use').live('click', function(){
					thisHtmlObj.data('set-time-h', $(this).html() );
					$('#set-time-'+id_num+'-h td').removeClass('selected');
					$(this).addClass('selected');
					self.focus();
					checkTime(thisHtmlObj,self);
				})
				$('#set-time-'+id_num+'-i td.use').live('click', function(){
					thisHtmlObj.data('set-time-i', $(this).html() );
					$('#set-time-'+id_num+'-i td').removeClass('selected');
					$(this).addClass('selected');
					self.focus();
					checkTime(thisHtmlObj,self);
				})
				$('#set-time-'+id_num+'-s td.use').live('click', function(){
					thisHtmlObj.data('set-time-s', $(this).html() );
					$('#set-time-'+id_num+'-s td').removeClass('selected');
					$(this).addClass('selected');
					self.focus();
					checkTime(thisHtmlObj,self);
				})

				//拖动
				options = defaultSet(options);
				options.clickid = 'set-time-title-'+id_num;
				if( options && options.drag === true ){
					drag($('#set-time-'+id_num),options);
				}
			});


		}
	});

	function checkTime(thisHtmlObj, obj){
		if( thisHtmlObj.data('set-time-h') && thisHtmlObj.data('set-time-i') && thisHtmlObj.data('set-time-s') ){
			obj.val( thisHtmlObj.data('set-time-h') +':'+ thisHtmlObj.data('set-time-i') +':'+ thisHtmlObj.data('set-time-s') );
			clearData(thisHtmlObj, obj);
		}
	}

	function clearData(thisHtmlObj, obj){
		clearTimeout( set_time_out );
		obj.data('set-time-h',null);
		obj.data('set-time-i',null);
		obj.data('set-time-s',null);
		obj.blur();

		//$('.set-time-'+class_num+'').remove();
		thisHtmlObj.remove();
	}

	function showTimeNow(obj){
		var d = new Date();
		var h = d.getHours();
		var i = d.getMinutes();
		var s = d.getSeconds();
		obj.html( h + ':' + i +':'+ s )
		set_time_out = setTimeout(function(){
			showTimeNow(obj)
		}, 1000 );
	}

	function drag(obj, options){
		var $obj = obj;

		var i = 0;
		var x,y; //对象的坐标
		var left_value, top_value, x1, y1, v_x0, v_y0, area_check, onmove_check,callback_check,zIndexOld;
		var values_x = [], values_y = [], values_t = [];
		if($.isArray(options.area)) {
			area_check = 1;
		}
		if($.isFunction(options.onmove)) {
			onmove_check = 1;
		}
		if($.isFunction(options.callback)){
			callback_check = 1;
		}
		var $mousedownobj =  options.clickid  ? $('#'+options.clickid) : $obj;


		var style_position = $obj.css('position');
		if( style_position != 'absolute' && style_position != 'relative' && style_position != 'fixed'){
			$obj.css('position', 'absolute')
		}

		//鼠标样式
		if(options.cursor) $mousedownobj.css({'cursor':options.cursor});

		$mousedownobj.bind('mousedown', function(e){
			i = clearMove(i);

			// eval( options.starteffect )
			//$('#msg').html(  options.starteffect  );


			//如果有zindex, 则设置
			zIndexOld = $obj.css('z-index');
			zIndexOld = zIndexOld ? zIndexOld : 0;
			if(options.zindex){
				$obj.css({'z-index':options.zindex});
			}

			//判别移动方向，如无设置，则随意移动
			if( options.constraint == 'v' || options.constraint == 'vertical' ){
				top_value = $obj.css('top') == 'auto' ?  $(window).height() - parseInt($obj.css('bottom')) -  parseInt($obj.css('height')) : parseInt($obj.css('top'));
			}
			else if( options.constraint == 'l' || options.constraint == 'level' ){
				left_value = $obj.css('left') == 'auto' ?  $(window).width() - parseInt($obj.css('right')) -  parseInt($obj.css('width')) : parseInt($obj.css('left'));
			}else {
				left_value = $obj.css('left') == 'auto' ?  $(window).width() - parseInt($obj.css('right')) -  parseInt($obj.css('width')) : parseInt($obj.css('left'));
				top_value = $obj.css('top') == 'auto' ?  $(window).height() - parseInt($obj.css('bottom')) -  parseInt($obj.css('height')) : parseInt($obj.css('top'));

			}
			//$('#msg').html(left_value + '/' + top_value);
			left_value = left_value == 'auto' ? e.pageX : left_value;
			top_value = top_value == 'auto' ? e.pageY : top_value;

			x1 = e.pageX - left_value;
			y1 = e.pageY - top_value;

			//开始特效
			if( $.isFunction(options.starteffect) ){
				options.starteffect([x1,y1,left_value,top_value]);
			}
			else {
				eval( '$obj.css('+options.starteffect+')' );
			}
			//alert( left_value )
			values_x = [0,0,0], values_y = [0,0,0], values_t = [0,0,0];

			//移动
			$(document).bind('mousemove', function(e){
				var x2 = e.pageX;
				var y2 = e.pageY;

				x = x2 - x1;
				y = y2 - y1;
				if(onmove_check == 1){
					options.onmove([x,y,x2-x1,y2-y1]);
				}

				var d = new Date();
				var t = d.getTime();
				if( area_check == 1 ){
					if( options.area[0][1] > x && x > options.area[0][0] && options.area[1][1] > y && y > options.area[1][0] ){
						$obj.css({left:x, top:y});
					}
				}
				else {
						$obj.css({left:x, top:y});
				}

				values_x.push(x);
				values_y.push(y);
				values_t.push(t);
				//$('#msg').html( x + '-' + y )
			});
		});

		//结束移动
		$obj.bind('mouseup', function(e){
			$(document).unbind('mousemove');
			//结束特效
			if( $.isFunction(options.endeffect) ){
				options.endeffect();
			}
			else {
				eval( '$obj.css('+options.endeffect+')' );
			}
			$obj.css({'z-index':zIndexOld});

			//计算初速度
			if( !values_x || !values_y || !values_t ) return false;
			var value_array_len = values_x.length  - 1;
			var dif_num = 3; //判断速度最后的距离为5个数组
			dif_num = value_array_len > dif_num ? dif_num :value_array_len;

			var x_dif = values_x[value_array_len] - values_x[value_array_len-dif_num];
			var y_dif = values_y[value_array_len] - values_y[value_array_len-dif_num];
			var t_dif = values_t[value_array_len] - values_t[value_array_len-dif_num];
			var v_x = x_dif * 2 / t_dif;
			var v_y = y_dif * 2 / t_dif;
			v_x = ( -0.5 < v_x && v_x < 0.5 ) ? 0 : v_x;
			v_y = ( -0.5 < v_y && v_y < 0.5 ) ? 0 : v_y;  //在-0.5与0.5之间时，值为0
			v_x = ( -1 < v_x && v_x < -0.5 ) ? -1 : v_x;
			v_y = ( -1 < v_y && v_y < -0.5 ) ? -1 : v_y;  //
			v_x = ( 0.5 < v_x && v_x < 1 ) ? 1 : v_x;
			v_y = ( 0.5 < v_y && v_y < 1 ) ? 1 : v_y;  //

			//获取加速度
			var a_x,a_y;
			a_x = a_y = options.a;
			a_x = ( v_x > 0 && a_x > 0 ) || ( v_x < 0 && a_x < 0 ) ? 0 - a_x : a_x;
			a_y = ( v_y > 0 && a_y > 0 ) || ( v_y < 0 && a_y < 0 ) ? 0 - a_y : a_y; //初速度与加速度反向

			v_x = !v_x ? 0 : parseInt(v_x);
			v_y = !v_y ? 0 : parseInt(v_y);
			v_x0 = v_x;
			v_y0 = v_y;
			var time_value = 1;
			//$('#msg').html( a_x  + '/' + a_y + '</br>' + v_x0  + '/' + v_y0 + '</br>' + v_x  + '/' + v_y  + '</br>' + a_x * v_x  + '/' + a_y * v_y     );
			i = setInterval(function(){
				if(!options.acceleration){
					i = clearMove(i);
					if( callback_check == 1)options.callback();
				}
				else {

					x = x != NaN ? parseInt(x): x1;
					y = y != NaN ? parseInt(y) : y1;
					if( v_x != 0 ) v_x += a_x * time_value;
					if( v_y != 0 ) v_y += a_y * time_value;
					x += v_x * time_value;
					y += v_y * time_value;

					//$('#msg').html( x  + '/' + y + '|' + v_x  + '/' +v_y   );

					//$('#msg').html( a_x  + '/' + a_y + '</br>' + v_x0  + '/' + v_y0 + '</br>' + v_x  + '/' + v_y  + '</br>' + a_x * v_x  + '/' + a_y * v_y     );
					//加速度与初速度需反号，否则速度越来越快
					if( v_y0 == 0 && a_x * v_x < 0  && a_y * v_y >= 0 ){
						//如果限制了区域参数
						if( area_check == 1 ){
							if( options.area[0][1] > x && x > options.area[0][0] ){
								$obj.css({left:x});
							}
						}
						else {
							$obj.css({left:x});
						}
					}
					else if( v_x0 == 0  &&  a_x * v_x >= 0  && a_y * v_y < 0 ){
						//如果限制了区域参数
						if( area_check == 1 ){
							if( options.area[1][1] > y && y > options.area[1][0] ){
								$obj.css({top:y});
							}
						}
						else {
							$obj.css({top:y});
						}
					}
					else if( v_x0 * v_x > 0 && v_y0 * v_y > 0  &&  a_x * v_x < 0  &&  a_y * v_y < 0){
						//如果限制了区域参数
						if( area_check == 1 ){
							if( options.area[0][1] > x && x > options.area[0][0] && options.area[1][1] > y && y > options.area[1][0] ){
								$obj.css({left:x, top:y});
							}
						}
						else {
							$obj.css({left:x, top:y});
						}
					}
					else {
						i = clearMove(i);
						if( callback_check == 1)options.callback();
					}
				}

			},time_value );
		});
	}


	function defaultSet(options){
		//alert(options.starteffect);
		if(options == undefined ){
			var options = {};
		}
		if( options.starteffect === undefined || options.starteffect === '') options.starteffect = "{}";
		if( options.endeffect === undefined  || options.endeffect === '') options.endeffect = "{}";
		if( options.callback === undefined  || options.callback === '') options.callback = 0;
		if( options.acceleration === undefined ) options.acceleration = 1;
		if( options.a === undefined  || options.a === '') options.a = options.acceleration;

		//alert(options.callback);
		return options;
	}

	function clearMove(i){
		clearInterval( i );
		i = 0;

		return i;
	}
})(jQuery)