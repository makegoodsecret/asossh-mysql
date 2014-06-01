var orderName="" , province="" , city="" , county="" ,otherAddress="" ,postCode ,cellphone,phonecode,otherphone;
	//其他
		var  adsmsg="选填：对本次交易的补充说明(建议填写已经和卖家达成一致的说明)";
		function textfocus(cartid){ 
		 	var ads  = $("#textarea_ads"+cartid).val().trim();
			if(ads==adsmsg){
				$("#textarea_ads"+cartid).val("");
			}else if(ads==""){
				$("#textarea_ads"+cartid).val(adsmsg);
			}
			 $("#textarea_ads"+cartid).blur(function(){   
				 if($("#textarea_ads"+cartid).val().trim()==adsmsg){
					$("#textarea_ads"+cartid).val("");
				}else if($("#textarea_ads"+cartid).val().trim()==""){
					$("#textarea_ads"+cartid).val(adsmsg);
				}
			 });
		 $("#textarea_ads"+cartid).keydown(function(){
		 		var str  = $("#textarea_ads"+cartid).val().trim();
				var reg = /[^\u4E00-\u9FA5\uf900-\ufa2d]/g;  //匹配中文的正则表达式 
				var regzg = /[^\x00-\xff]/g ; 				//匹配非中文的正则表达式
				var temp = str.replace(reg, '').length;		
				var tempzg = str.replace(regzg, '').length;	//统计出中文个数
				var  length = temp*2+tempzg;
		 		if (length<=400) {
					$("#ads_textarea"+cartid).html("还可输入"+(400-length)+"字符(一个汉字等于两个字符)").css("color","#888");
				}else{
					$("#ads_textarea"+cartid).html("已经超出"+(length-400)+"字符(一个汉字等于两个字符)").css("color","red");;
				}
		 });
		}; 
		 
		 //验证表单值
		 function validFunName(){
		 	  orderName = $("#orderName").val().trim();
		 	  var regzg = /[^\u4E00-\u9FA5\uf900-\ufa2d]/g ; 				//匹配中文的正则表达式
			if (orderName.length<=0) { 
					messagerShow("用户名不能为空"); return false;
			}else if(!isNaN(orderName)&&orderName.indexOf(".")<-1){
				messagerShow("用户名不能为纯数字"); return false;
			}else if(!(/^[a-z0-9_-]{2,16}$/.test(orderName))&&(orderName.replace(regzg,'').length<=1)){
				messagerShow("用户名为2-16位的字母、数字、_或中文组成"); return false;
			};
		 	province = $("#province").val().trim();
		 	if (province!="国外") {
		 		if ($("#county").val().trim()=="请选择" ||$("#city").val().trim()=="请选择" ) {
					  messagerShow("收件人地址不完整");
					   return false;
				}
			 	if ($("#county").val()==null ) {
					  messagerShow("收件人地址不完整");
					  county =null;
					   return false;
				}else{
					  city = $("#city").val().trim();
			 		  county = $("#county").val().trim();
				}
			}
		 	 	 otherAddress = $("#otherAddress").val().trim();
		 	if (otherAddress.length<=0) {
				 messagerShow("收件人地址(不包含省市区)不完整");
				 return false;
			}else if (isNaN(otherAddress)&&otherAddress.indexOf(".")<-1) {
				 messagerShow("收件人地址(不包含省市区)不能为纯数字");
				 return false;
			}
		 	 	 postCode = $("#postCode").val().trim();
		 	if (postCode.length<=0) {
				 messagerShow("收件人邮政编码不能为空");
				 return false;
			}else if (isNaN(postCode)||postCode.indexOf(".")>-1) {
				 messagerShow("收件人邮政编码只能是数字");
				 return false;
			}
		 	  cellphone = $("#cellphone").val().trim();
		 	  phonecode = $("#phonecode").val().trim();
		 	  otherphone = $("#otherphone").val().trim();
		 	if (phonecode.length<=0&&cellphone.length<=0) {
				messagerShow("手机号码和联系电话至少填一个");
				 return false;
			}
			if (cellphone.length>0) {
			 	if (isNaN(cellphone)||!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(cellphone))) {
					 messagerShow("手机号输入有误");
					 return false;
				}
			}else{
			 	if (phonecode.length<=0) {
					 messagerShow("区号不能为空");
					 return false;
				}
			 	if (phonecode.length<=0) {
					 messagerShow("电话号码不能为空");
					 return false;
				}
			 
			}
		 }
		 function addShowaddress(orderAddressId){		//添加地址
		 //	orderName , province , city , county ,otherAddress ,postCode ,cellphone,phonecode,otherphone
		 	var  count =$("#listcount").val().trim()*1+1;
		 	
		 	$("#listcount").val(count);
		 	var  phonesection  		 =$("#phonesection").val().trim();
		 	var  orderAddressStatus  =$("#orderAddressStatus").val().trim();
		 	var   dataName =["orderAddressId","orderName","province "," city "," county ","otherAddress ","postCode ","cellphone","phonesection","phonecode","otherphone","orderAddressStatus"];
		 	var   dataValue=[orderAddressId,orderName , province , city , county ,otherAddress ,postCode ,cellphone,phonesection,phonecode,otherphone,orderAddressStatus];
		 	var   hiddenmsg  ="";
			var limsg  ="<li style='left: 10px' id='li"+count+"' class='order_address' ><div class='address-info'>"
		 		 		+"<input name='address'  type='radio'  id='radio"+count+"' onclick='radioclick("+count+");'>" 
				 		+"<label  class='user-address'  id='user_address"+count+"'>"+province+"&nbsp;"+city+"&nbsp;"+county+"&nbsp;"+otherAddress+"&nbsp;("+orderName+"&nbsp;"+"收)"
				 		+"<em>"+ cellphone + phonesection+"-"+phonecode+"-"+otherphone+"</em>"
				 		+"</label><em class='tip"+count+"' style='display: none'>默认地址</em><a class='' href='javascript:void(0)' style='display: ' id='setaddress"+count+"'" 
						+"onclick='setaddress("+count+")'  >设置为默认收货地址</a><a href='javascript:void(0)'  style='position: absolute;right: 9%;' id='updateaddress"+count+"'"
				 		+"onclick='updateaddress("+count+")'>修改本地址</a></div></li>";
		 	$("#li_button").before(limsg);
		 	var userAddressId=$("#userAddressId").val().trim();
		 	if (userAddressId.length==0) {
				$("#radio"+count).attr("checked",true);
				$("#userAddressId").val(orderAddressId)
			}
		 	for ( var i = 0; i < dataName.length; i++) {
		 		hiddenmsg+="<input type='hidden' id='"+dataName[i]+count+"' value='"+dataValue[i]+"'>";
			}
			hiddenmsg+="<input type='hidden' id='Id"+orderAddressId+"' value='"+count+"'>";
		 	$("#li_button").before(hiddenmsg);
		 	if ($("#order_address_status").attr("checked")=="checked") {
		 		updateorderaddress(count) ;//改变默认地址
			}
		 }
		//显示修改地址
		 function updateShowaddress(orderAddressId){
			 
			 orderName = $("#orderName").val().trim();
			 province = $("#province").val().trim();
			 city = $("#city").val().trim();
			 otherAddress = $("#otherAddress").val().trim();
		 	var msg=""+province+"&nbsp;"+city+"&nbsp;"+county +"&nbsp;"
		 			+otherAddress+"&nbsp;(&nbsp;"+orderName+"&nbsp;"+ "收)";
		 	var count=$("#Id"+orderAddressId).val();
		 	$("#user_address"+count).html(msg);
		 	if($("#order_address_status").prop("checked")){	//修改为默认
		 		updateorderaddress(count);
		 	}
		 };		
		 $(function(){
		 //添加收件人地址
		    $("#saveaddressform").submit(function(){
		    var  url=basePath+"asossh/order!" ;
		    if ($("#submit_update").val().indexOf("submit")!=-1) {
		  		 url+="saveaddress.action";
			}else{
				url+="updateaddress.action";
			}
		 	$("#saveaddressform").ajaxSubmit({
		 		url:url,
		 		type:"post",
		 	 	beforeSubmit:validFunName ,	//提交前验证，如果返回false则不能提交 
		 		success:function(data,status){
		 			  if(data=="true"){
		 				messagerShow("修改成功");
						notice_hidden();		//隐藏弹出层
						updateShowaddress($("#orderAddressId").val().trim());		//显示修改地址
		 			}else if (data>0) {
						messagerShow("添加成功");
						addShowaddress(data);		//添加地址
						notice_hidden();		//隐藏弹出层
					}else{
						messagerShow("失败");
					}  
		 		},error:function(XmlHttpRequest, textStatus, errorThrown){
		 			messagerShow("出错了");
				}
		 	}); 
		 	return false;
		 });  
		 });
		 
		//得到区号
			function getphonesection(){
			// reacodedata 为城市的数据源封装areacode.js中  i为areacodedata的下标  n为匹配到的值
				var	province = $("#province").val().trim();
				if($("#city").val()!=""){
				var   city = $("#city").val().trim();
				$.each( areacodedata, function(i, n){
			  	 if((i.indexOf(city)!=-1)||(i.indexOf(province)!=-1)){ //只要包含省份或市就填充
			  		$("#phonesection").val(n);
			  	}  
				}); 
				}
		}
				
			//单击选择
			function  radioclick(id){
				$("#address-list>li").each(function(i){
						$("#address-list>li").removeAttr("class","");
						$("#address-list>li").each(function(j){
							if (i==j) {
								$("#li"+id).attr("class","selected_order_address");
							}else{
						 		$("#li"+j).attr("class","order_address");
							}
							
						});
				}); 
			};
			//设为默认收货地址
			function setaddress(id){
				var orderAddressId  =$("#orderAddressId"+id).val();
					$("#userAddressId").val(orderAddressId);
				$.ajax({
					url:basePath+"asossh/order!setaddress.action",
					type:"post",
					data:{"orderAddressPojo.orderAddressId":orderAddressId },
					success:function(data,status){
					if (data) {
						messagerShow("设置成功");
						updateorderaddress(id) ;//改变默认地址
					}else{
						messagerShow("设置失败");
					}
					},error:function(){
						messagerShow("修改失败");
					}
				});
				
			}
			//改变默认地址
			function  updateorderaddress(id){
				$("#address-list>li").each(function(i){
					if (i==0) { i+1; }
					if (id==i) {
						$("#setaddress"+id).attr("style","display:none");
						$(".tip"+id).attr("style","display:");
					}else{
						$("#setaddress"+i).attr("style","display:");
						$(".tip"+i).attr("style","display:none");
					}
					$("#address-list>li").removeAttr("class","");
					$("#address-list>li").each(function(j){
							if (i==j) {
								$("#li"+id).attr("class","selected_order_address");
							}else{
						 		$("#li"+j).attr("class","order_address");
							}
						});
			});
			};
			function initfiledValue(id){	//填充输入框里的值
				$("#orderAddressId").val($("#orderAddressId"+id).val().trim());
				$("#orderName").val($("#orderName"+id).val().trim());
				
				
				$("#postCode").val($("#postCode"+id).val().trim());
				$("#cellphone").val($("#cellphone"+id).val().trim());
				$("#phonesection").val($("#phonesection"+id).val().trim());
				$("#phonecode").val($("#phonecode"+id).val().trim());
				$("#otherphone").val($("#otherphone"+id).val().trim());
				if ($("#orderAddressStatus"+id).val().trim()*1==1) {
					$("#order_address_status").attr("checked",true);
				}else{
					$("#order_address_status").prop("checked",false);
				}
				//注入下拉地址
				$("#otherAddress").val($("#otherAddress"+id).val().trim());
				  provmsg  = $("#province"+id).val().trim();
				  citymsg  = $("#city"+id).val().trim();
				  dist     = $("#county"+id).val().trim();
				 $("#my_address").citySelect({
					prov:provmsg,city:citymsg,dist:dist,nodata:"none",required:false
				});
			};
			//修改地址
			function  updateaddress(id){
				//弹出显示层
					if (show_hidden) {
						$("#submit_update").val("update");	//修改为提交方式为修改
						notice_show();//单击按钮触发显示
						initfiledValue(id);	//填充输入框里的值
					}else{
						notice_hidden();//单击按钮触发隐藏
					}
			};
			 //选为默认
			 function  orderstatuscheckbox(){
			 	if ($("#order_address_status").is(":checked")) {
					$("#orderAddressStatus").val("1");
				}else{
					$("#orderAddressStatus").val("0");
				}
			 }
			 function  submitformads(){
				 $("textarea[id^='textarea_ads']").map(function(){
				 	if ($(this).val().trim()==adsmsg) {
						$(this).val("");
					}
				 });
				 
			 }