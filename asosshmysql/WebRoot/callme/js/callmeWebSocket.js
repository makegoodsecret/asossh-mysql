/**聊天提示*/ 
function  homemessagerShowtime(messager,time){ 
  	 if ($('.msgbox_layer_wrap')) {
			$('.msgbox_layer_wrap').remove();
		}
	$("body").prepend("<div class='msgbox_layer_wrap'  >"+
						"<span  style='z-index: 10000; border-radius:5px 5px  ;' class='msgbox_layer'>"+
						""+messager+"</span></div>");
		$(".msgbox_layer_wrap").show();
   var st = setTimeout(function (){
			$(".msgbox_layer_wrap").hide();
			clearTimeout(st);
		},time);
   }
/**添加好友*/
function addUserFriend(){
	var userFriendeMail = $("#userFriendeMail").val();
	var friendGroupId   = $("#friendGroupId").val();
	$.ajax({
		url:"asossh/chat!addUserFriend.action",
		type:"post",
		data:{"friendPojo.email":userFriendeMail,"friendGroupPojo.friendGroupId":friendGroupId},
		success:function(data,type){
			if (data==-2) {
				homemessagerShowtime("你怎么可以输入自己的邮箱加好友，你真幽默……",3500);
			}else if (data==-1) {
				homemessagerShowtime("真可惜没有该好友，你邮箱输的对吗？",3500);
			}else if (data==0) {
				homemessagerShowtime("添加好友失败，请稍候再试",3500);
			}else if (data > 0) { //返回成功的好友id
				homemessagerShowtime("成功发送加友请求",3500);
				/**重新推送加友请求*/
				sendAddFriend(data);
			}else if (data== -3) {
				homemessagerShowtime("你真幽默，这位好友早就再你的好友名单中了，呵呵",3500);
			}
		},error:function (XMLHttpRequest, textStatus, errorThrown) {
			homemessagerShowtime("与服务器连接失败",2000);
		}
	
	})
}
	/**HTML5 websocket function*/
	var ws = null;
	var isfrist = true;
    function startServer() {
       // var url = "ws://localhost:8099/asosshoracle/websocket.websocketcellme"; //必须以ws://来头
        if ('WebSocket' in window) {
            ws = new WebSocket(url);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(url);
        } else {
             homemessagerShowtime("对不起你的浏览器暂不支持聊天系统,推荐使用最新Chrome或Firefox浏览器",5000);
            return;
        }
       /**建立与服务器握手成功*/
        ws.onopen = function() {
         	   homemessagerShowtime("欢迎回来",1500);
         	   headerGetUseInfo();  /**获取用户发起在线请求后获取的数据*/
        };
        /**服务器发回客户端的信息*/
        ws.onmessage = function(event) {
             dataReturned(event.data);
        };
        ws.onclose = function() {
            homemessagerShowtime("服务器已经关闭，请重新刷新页面",5000);
        };
        /**用户强制关闭websocket*/
        function closewebsocket(){
        	ws.terminate();   
        }
    }
	/**获取用户好友信息*/
	function headerGetUseInfo(){
    	if (ws!=null&&userId!='') {
			ws.send(notread+chatsplit+userId);
		}
    }
/**获取用户发起在线请求后获取的数据*/
    function dataReturned(datas){
		var datajson=JSON.parse(datas,dateRevicer);
		if (datajson.headerstatus==notread) {
			/**获取用户好友信息*/
			homemessagerShowtime("获取在线好友成功",1000);
		}else if(datajson.headerstatus==chat){
			/**单聊*/
			if (username==(datajson.nikeName)) {/**显示自己*/
			  var callmeinfo= "<div class='alert alert-block alert-info' style='margin:5px 5px;'>"
				+"<a class='close' data-dismiss='alert' href='#'><i class='icon-large icon-remove-circle'></i></a>"
				+"<h5 class='alert-heading' style='margin-top:-10px;'>"+username+"&nbsp;&nbsp; "+datajson.endtime
				+"</h5><p style='font-family: 仿宋; font-size: 18px;color: black;'>"+datajson.textMsg+"</P></div>";
				$("#callPane").append(callmeinfo);
			
			}else{/**显示好友*/
			 
				var friendId = $("#redactor_content").attr("data-contentCallid");
				if(datajson.nikeNameid == friendId){ //好友正好只跟自己聊天
					var callmeinfo= "<div class='alert alert-block' style='margin:5px 5px;'>"
						+"<a class='close' data-dismiss='alert' href='#'><i class='icon-large icon-remove-circle'></i></a>"
						+"<h5 class='alert-heading' style='margin-top:-10px;'>"+datajson.nikeName+"&nbsp;&nbsp;"
						+datajson.endtime+"</h5><p style='font-family: 仿宋; font-size: 18px;'>"+datajson.textMsg+"</p></div>";
					$("#callPane").append(callmeinfo);
					updateChat(datajson.addChatId);   //修改为已读
				}else{/**好友没有与自己聊天*/
						var notsize= +$("#notInfoSpanId").html();
						$("#notInfoSpanId").html(notsize+1);
					  if ($("#span"+datajson.nikeNameid).length > 0) { //检查是否存在
						  var spanuserfriendid = +$("#span"+datajson.nikeNameid).html();
						  $("#span"+datajson.nikeNameid).html(spanuserfriendid+1);
						}else{
							appendMessagesModalul(datajson.userFriendId,datajson.nikeNameid,datajson.nikeName,1,datajson.textMsg,datajson.endtime);
						}
				}
				
			}
				
		}else if(datajson.headerstatus == allchat){
			/**群聊*/
			if (username == (datajson.nikeName)) {/**群聊显示自己*/
				document.getElementById("content").innerHTML+="我说:"+datajson.textMsg+"  <br>";
				document.getElementById("content").innerHTML+="时间:"+datajson.endtime+"  <br>";
			}else{/**群聊显示其他*/
			 	document.getElementById("content").innerHTML+=datajson.nikeName+"(群聊)说:"+datajson.textMsg+"  <br>";
			 	document.getElementById("content").innerHTML+="时间:"+datajson.endtime+"  <br>";
			}
		}else if(datajson.headerstatus == friendup){
			/**推送好友上线*/
			 var src  =homePath+"image/friendup.gif?r="+Math.random()*100;
				$("#userfriendisline"+datajson.friendup).attr("src",src);
				$("#userfriendisline"+datajson.friendup).attr("title","上线");
				$("#userfriendisline"+datajson.friendup).attr("alt","上线");
		}else if(datajson.headerstatus == frienddrop){
			/**推送好友下线*/
			var src= homePath+"image/frienddrow.gif?r="+Math.random()*100;
			$("#userfriendisline"+datajson.userFriendId).attr("src",src);
			$("#userfriendisline"+datajson.userFriendId).attr("title","离线");
			$("#userfriendisline"+datajson.userFriendId).attr("alt","离线");
		}else if(datajson.headerstatus == addfriend){
			/**在线推送加友请求*/
			onlineAddFriendApply(datajson.userFriendId,datajson.friendId,datajson.friendUserName,datajson.userFriendTime);
		}else if(datajson.headerstatus  == agreefriend){
			/**同意加友后在线推送好友信息*/
			agreeOnlineFriend(datajson.friendUserName,datajson.friendUserImage,
							datajson.friendUserId,datajson.userFriendId,
							datajson.friendup,datajson.friendGroupId,
							datajson.friendGroupName,datajson.userFriendStatus);
		}else{
			homemessagerShowtime("服务器发出了未知应答",2000);
		}
	}
	/**Json处理数据*/	
	function dateRevicer(key,value){
		 if (typeof value=='string') {
			if (key=="notreaduserIdandsize") {      //未读信息的
				var notreadArry = value.split("&"+chatsplit+"&");
				var notsize =0;
				for ( var i = 0; i < notreadArry.length-1; i++) {
					    $("#isnoteampty").hide();
						var userIdandsize = notreadArry[i].split(chatsplit);
						var userfriendid = userIdandsize[0];    //未读好友关系的id
						var userfriendgroup = userIdandsize[1]; //该好友的组别
						var notreadsize = +userIdandsize[2];   // 未读消息共有几条
						var userFriendName = userIdandsize[3];   // 未读好友的名字
						var userFriendlastinfo = userIdandsize[4];  //最好一条
						var userFriendlastinfoTime = userIdandsize[5]; //最后一条时间
						var friendId = userIdandsize[6]; // 好友的id
						notsize+=notreadsize;
						/**追加*/
						appendMessagesModalul(userfriendid,friendId,userFriendName,notreadsize,userFriendlastinfo,userFriendlastinfoTime);
						
				}
				$("#notInfoSpanId").html(notsize);
			}
			 if (key=="userfriendidup") {      		//好友的上线信息
				 userIdandsize = value.split(chatsplit);
				 userfriendid = userIdandsize[0]; 	 //上线好友的id
				 userfriendgroup = userIdandsize[1]; //该好友的组别
				 friendGroupName = userIdandsize[2]; //好友组名
				 var src  =homePath+"image/friendup.gif?r="+Math.random()*100;
				$("#userfriendisline"+userfriendid).attr("src",src);
				$("#userfriendisline"+userfriendid).attr("title","上线");
				$("#userfriendisline"+userfriendid).attr("alt","上线");
				 
			}
		}  
		return value;
	}
	/**重新推送加友请求*/
  function sendAddFriend(addUserFriendId){
	  if (ws!=null&&userId!='') {
			ws.send(addfriend+chatsplit+userId+chatsplit+addUserFriendId);
		}
  }
  /**在线推送加友请求*/
	function onlineAddFriendApply(userFriendId,friendId,friendUserName,userFriendTime){
			var delayEventId = +$("#delayEventId").html();
			delayEventId++;
			$("#delayEventId").html(delayEventId);
			var adddiv =  "<div class=";
			
			if ($("#userFriendApplyListisemapty").data("isexits")) {  
				adddiv +="'tab-pane fade'"
				var addli  = "<li ><a href='#$"+friendUserName+"' data-toggle='tab'>"+friendUserName+"发来了加友请求</a></li>";
				$("#messagesModalul").append(addli);
				$("#userFriendApplyListisemapty").attr("data-isexits","true");
			}else{
				 adddiv += "'tab-pane fade in active'";
				 var addli  = "<li class='active'><a href='#$"+friendUserName+"' data-toggle='tab'>"+friendUserName+"发来了加友请求</a></li>";
				$("#messagesModalul").remove();
				$("#noteventli").remove();
				$("#messagesModalul").append(addli);
				$("#friendApplyModaldiv").empty();
			}
		  adddiv +="id="+friendUserName+" style='text-align: center;'><p>"
			  	  +friendUserName+"于"+userFriendTime+"发来加友请求 <hr>"
			  	  +"<a href='#friendGroupModal' data-toggle='modal' class='btn btn-success' data-dismiss='modal' aria-hidden='true' "
			  	  +"onclick=agreeApplyFriend('"+userFriendId+"','"+friendId+"','"+friendUserName+"') >同意</a>"
			  	  +"<a href='#friendApplyModal' data-toggle='modal' class='btn btn-warning'" 
				  +"onclick=refuseAddUserFriend('"+userFriendId+"') >拒绝</a><hr></p></div>";
			$("#friendApplyModaldiv").append(adddiv);
	};
	/**同意加友后在线推送好友信息*/
	function agreeOnlineFriend(friendUserName,friendUserImage,friendUserId,userFriendId,
								friendup,friendGroupId,friendGroupName ,userFriendStatus){
		var groupsize;
		if ($("#friendGroupId"+friendUserId).length != 0) { 
			var friendoriginal = $("#friendGroupId"+friendUserId).val(); //得到之前的组的
			var  friendoriginalid =$("#friendGroupId"+friendUserId).data("groupid");
			$("#friendGroup"+friendUserId+"li").remove();  //删除之前的组
			groupsize = +$("#groupsize"+friendoriginalid).val();
			groupsize--;
			$("#groupsize"+friendoriginalid).val(groupsize);
			if (groupsize  == 0) {
				$("#isemapty"+friendoriginalid+"li").show();
			}
		}
		if($("#friendGroup"+friendGroupId+"ul").length == 0){ // 该组不存在
	    	 var groupInfo= 
	    		"<li class='dropdown' friendGroup"+friendGroupId+"ul title='"+friendGroupName+"组'>"
				+"<a href='#' class='dropdown-toggle' data-toggle='dropdown'  title='"+friendGroupName+"组'>"
				+"<i style='width: 75px; height: 45px;'  title='"+friendGroupName+"组'>"
				+"<img style='width: 75px; height: 55px;' alt='' src='"+homePath+"callme/library/images/icons/collab.png?r="+Math.random()*100+"'>"
				+"</i><span class='hidden-phone'>"+friendGroupName+"</span></a>"
				+"<ul class='dropdown-menu' style='background-color: white;' id='friendGroupIdul"+friendGroupId+"'>"
				+"<li style='width: 200px;background-color: white;padding-top:5px;' id='friendGroup"+friendUserId+"li'><i class='icon-large' ><a href='javascript:void(0)'>"
				+"<img class='thumb account-img' src='"+homePath+"photo/"+friendUserImage+"?r="+Math.random()*100+"' /></a></i>"
				+"<span style='width: 80px;' title='与"+friendUserName+"聊天'>"+friendUserName+"</span>"
			    +" <img alt='离线'  title='离线' style='width:30px; height: 30px;' src='"+homePath+"image/frienddrow.gif?r="+Math.random()*100+"' id='userfriendisline"+friendUserId+"'/><button type='button' style=' float:right; '"
			    +" onclick=callMeInfo('"+userFriendId+"','"+friendUserId+"','"+friendUserName+"') >聊天</button>"
			    +" <input type='hidden' value='friendGroup"+friendGroupId+"'  data-groupid='"+friendGroupId+"' id='friendGroupId"+friendUserId+"'></li></ul>"
			    +"<input type='hidden' value='0' id='groupsize"+friendGroupId+"'></li>";
	    	   $("#userfriendblackli").before(groupInfo);
	    }else{
	    	var  groupInfo="<li style='width: 200px;background-color: white;padding-top:5px;' id='friendGroup"+friendUserId+"li'><i class='icon-large' ><a href='javascript:void(0)'>"
	    	+"<img class='thumb account-img' src='"+homePath+"photo/"+friendUserImage+"?r="+Math.random()*100+"' /></a></i>"
	    	+"<span style='width: 80px;' title='与"+friendUserName+"聊天'>"+friendUserName+"</span>"
	    	+"<img alt='离线'  title='离线' style='width:30px; height: 30px;' src='"+homePath+"image/frienddrow.gif?r="+Math.random()*100+"' id='userfriendisline"+friendUserId+"'/><button type='button' style=' float:right; '"
	    	+" onclick=callMeInfo('"+userFriendId+"','"+friendUserId+"','"+friendUserName+"') >聊天</button>";
	    	if (userFriendStatus  == emporary) { //临时聊天
	    		groupInfo += "<input type='hidden' value='friendemporary' data-groupid='emporary' id='friendGroupId"+friendUserId+"'></li>";
	    		$("#friendemporaryul").append(groupInfo);
	    		groupsize = +$("#groupsizeemporary").val();
				groupsize++;
				$("#groupsizeemporary").val(groupsize);
				$("#isemaptyemporaryli").hide();
	    	}else if( userFriendStatus  == black){ //黑名单
				groupInfo += "<input type='hidden' value='friendblack' data-groupid='black' id='friendGroupId"+friendUserId+"'></li>";
				$("#friendblackul").append(groupInfo);
	    		groupsize = +$("#groupsizeblack").val();
				groupsize++;
				$("#groupsizeblack").val(groupsize);
				$("#isemaptyfriendblackli").hide();
	    	}else{ //其他
				groupInfo +="<input type='hidden' value='friendGroup"+friendGroupId+"'data-groupid='"+friendGroupId+"' id='friendGroupId"+friendUserId+"'></li>";
				$("#friendGroup"+friendGroupId+"ul").append(groupInfo);
				groupsize = +$("#groupsize"+friendGroupId).val();
				groupsize++;
				$("#isemaptyfriendGroup"+friendGroupId+"li").hide();
				$("#groupsize"+friendGroupId).val(groupsize);
			}
	    }
	    //更改上线
		if(friendup != 0){
			var src  =homePath+"image/friendup.gif?r="+Math.random()*100;
			$("#userfriendisline"+friendUserId).attr("src",src);
			$("#userfriendisline"+friendUserId).attr("title","上线");
			$("#userfriendisline"+friendUserId).attr("alt","上线");
		}
	}
	/**追加未读信息*/
	function appendMessagesModalul(userfriendid,friendId,userFriendName,notreadsize,userFriendlastinfo,userFriendlastinfoTime){
		if (isfrist){
			$("#messagesModalul").append("<li class='active'><a href='#"
					+userFriendName+userfriendid+"' data-toggle='tab' id='messagesModalulid"+userfriendid+"' >"
					+userFriendName+"(<span id='span"+friendId+"'>"+notreadsize+"</span>条未读)"+"</a></li>");
			$("#messagesModaldiv").
			append("<div class='tab-pane fade in active' id='"+userFriendName+userfriendid+"'><p><a type='#' data-dismiss='modal' aria-hidden='true'"
					+ "onclick=callMeInfo('"+userfriendid+"','"+friendId+"','"+userFriendName+"')>"+userFriendlastinfo+"</a><hr><br/>时间"
					+userFriendlastinfoTime+"</p> </div>");
		}else{
			$("#messagesModalul").append("<li><a href='#" +userFriendName+userfriendid+"' id='messagesModalulid"+userfriendid+"' data-toggle='tab'  >"
					+userFriendName+"(<span id='span"+friendId+"'>"+notreadsize+"</span>条未读)"+"</a></li>");
			$("#messagesModaldiv").
			append("<div class='tab-pane fade' id='"+userFriendName+userfriendid+"'><p><a type='#' data-dismiss='modal' aria-hidden='true'"
					+ "onclick=callMeInfo('"+userfriendid+"','"+friendId+"','"+userFriendName+"')>"+userFriendlastinfo+"</a><hr><br/>时间"
					+userFriendlastinfoTime+"</p> </div>");
		}
		isfrist =  false;
	}
	/**开启聊天*/
	function callMeInfo(userFriendId,friendId,userFriendName){
		$("#callMeInfoPana").show();
		$("#callPane").empty();   //清空聊天框
		$("#licallfriend").html("与"+userFriendName+"聊天");
		$("#licallfriendInfo").html(userFriendName+"的个人信息");
		$("#licallfriendMap").html(userFriendName+"现在的位置");
		$("#licallfriendTitel").html("正在与"+userFriendName+"聊天");
		$("#redactor_content").attr("data-contentCallid",friendId);
		$("#redactor_content").attr("data-contentCallName",userFriendName);
		$("#redactor_content").attr("data-userFriendId",userFriendId);
		
		getAjaxFriendInfo(userFriendId,friendId,userFriendName); //获取用户的聊天记录
	}
	/**修改好友正在与自己聊天标记为修改为已读*/
	function updateChat(chatId){
		$.ajax({
			url:"asossh/chat!updateChatReaderStatus.action",
			type:"post",
			data:{"chatPojo.chatId":chatId},
			success:function(data,type){
				if (data ==0 ) {
					homemessagerShowtime("已读修改失败，请待会再试",1000);
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
		})
	}
	/**获取用户的聊天记录*/
	function getAjaxFriendInfo(userFriendId,friendId,userFriendName){
		$.ajax({
			url:"asossh/chat!readerChatGetJson.action",
			type:"post",
			data:{"userPojo.userId":userId},
			success:function(data,type){
				   $("#callPane").append(data);
				   var	notsize = +$("#notInfoSpanId").html();
				   var spanuserfriendid = +$("#span"+friendId).html();
				   notsize-=spanuserfriendid
				   $("#notInfoSpanId").html(notsize); //显示未读条数减减
				   //删掉未读条数
				   $("#messagesModalulid"+userFriendId).hide();
				   $("#"+userFriendName+userFriendId).hide();
				   if (notsize == 0) {
					   $("#isnoteampty").show(); //显示未读提示
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
			}
		);
		
	}
	 
	/**聊天*/
	function callMeInfosend(){
			var redactor_content = $("#redactor_content").val();
			var friendnameid = $("#redactor_content").attr("data-contentCallid");
			var userFriendId = $("#redactor_content").attr("data-userFriendId");
			var friendname   =  $("#redactor_content").attr("data-contentCallName");
			if(redactor_content== ''){
				homemessagerShowtime("你是不是该输点啥",2000);
			}else if (ws != null) {
				var sendstr=chat
							+chatsplit+userId
							+chatsplit+username
							+chatsplit+friendnameid
							+chatsplit+friendname 
							+chatsplit+redactor_content
							+chatsplit+userFriendId;
	           	ws.send(sendstr); 
	           	onResetCall(); //清空
	        }
		}
	
/**清空聊天系统*/
	function onResetCall(){
		$(".redactor_box > div").empty().append("<p><br></br></p>");
		$("#redactor_content").val(""); 
	}
/**拒绝加友*/
	function refuseAddUserFriend(userFriendId ){
		$.ajax({
			url:"asossh/chat!doubleFriend.action",
			type:"post",
			data:{"userFriendPojo.userFriendId":userFriendId,"userFriendPojo.userFriendStatus":2},
			success:function(data,type){
				if (data == 0) {
					   homemessagerShowtime("与拒绝加友失败",2000);
				}else{
					homemessagerShowtime("拒绝加友成功",2000);
					var delayEventId = +$("#delayEventId").html();
					delayEventId--;
					$("#delayEventId").html(delayEventId);
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
			} );
	}
/**同意加友*/
	function agreeApplyFriend(userFriendId,friendId,friendName){
		$.ajax({
			url:"asossh/chat!doubleFriend.action",
			type:"post",
			data:{"userFriendPojo.userFriendId":userFriendId,"userFriendPojo.userFriendStatus":1},
			success:function(data,type){
				if (data == 1) {
					homemessagerShowtime(friendName+"以成功加为好友",2000);
					$("#addFriendfriendGroup").html(friendName);
					$("#agreeuserFriendGroupId").val(userFriendId);
					$("#agreeuserFriendId").val(friendId);
					var delayEventId = +$("#delayEventId").html();
					delayEventId--;
					$("#delayEventId").html(delayEventId);
					/**加友后获取好友是否在线与好友信息*/
					sendUserFriend(userFriendId,friendId,userId);
				}else{
					homemessagerShowtime(friendName+"加友 失败",2000);
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
			} );
	}
/**加友后获取好友是否在线与好友信息*/
	function sendUserFriend(userFriendId , friendId,userId ){
	 if (ws!=null&&userId!='') {
		ws.send(agreefriend+chatsplit+userId+chatsplit+friendId+chatsplit+userFriendId);
	 }
	}
/**对好友新增分组*/	
	function addApplayGroupFriend(){
		var friendGroupName = $("#addFriendGroup").val().trim();
		if (friendGroupName == "") {
			homemessagerShowtime("是不是该写点什么，再添加分组",2000);
		}else{
		$.ajax({
			url:"asossh/chat!addApplayGroupFriend.action",
			type:"post",
			data:{"friendGroupPojo.friendGroupName":friendGroupName},
			success:function(data,type){
				if (data != 0) {
					homemessagerShowtime(friendGroupName+"分组添加成功",2000);
					$("#selectFriendGroup").append("<option value="+data+" >"+friendGroupName+"</option>");
					$("#addFriendGroup").val();
					$("#agreeuserFriendGroupId").val(userFriendId);
				}else{
					homemessagerShowtime(friendGroupName+"分组添加失败",2000);
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
			} );
		}
	}
/**修改用户的分组*/
	function addApplayFriend(){
		var friendGroupId = $("#selectFriendGroup").val();
		var userFriendId = $("#agreeuserFriendGroupId").val();
		var friendId     = $("#agreeuserFriendId").val();
		$.ajax({
			url:"asossh/chat!addApplyFriend.action",
			type:"post",
			data:{"userFriendPojo.userFriendId":userFriendId,"friendGroupPojo.friendGroupId":friendGroupId},
			success:function(data,type){
				if (data != 0) {
					homemessagerShowtime("成功",2000);
					/**加友后获取好友是否在线与好友信息*/
					sendUserFriend(userFriendId,friendId,userId);
				}else{
					homemessagerShowtime("失败",2000);
				}
			},error:function (XMLHttpRequest, textStatus, errorThrown) {
				homemessagerShowtime("与服务器连接失败",2000);
			}
			} );
	}
	
	
	