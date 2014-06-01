package com.secret.service.impl;

import java.io.IOException;
import java.nio.CharBuffer;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.catalina.websocket.WsOutbound;

import com.secret.listener.SessionListener;
import com.secret.pojo.ChatPojo;
import com.secret.pojo.UserFriendPojo;
import com.secret.service.CallMeSocketService;
import com.secret.service.ChatService;
import com.secret.service.ChatTransmitFilesService;
import com.secret.service.FriendGroupService;
import com.secret.service.MiniBlogsAssessService;
import com.secret.service.MiniBlogsService;
import com.secret.service.UserFriendGroupService;
import com.secret.service.UserFriendGroupTypeService;
import com.secret.service.UserFriendService;
import com.secret.socketcallme.CallMeEchoServlet;
import com.secret.socketcallme.CallMeMessageInbound;
import com.secret.util.StatusChat;

public class CallMeSocketServiceImpl implements CallMeSocketService {
	
	private   FriendGroupService         friendGroupService ;            /**用户自己好友的分组*/
	private   UserFriendService 		   userFriendService; 			  /**好友关系*/
	private   ChatService 			   chatService;					  /**聊天记录*/
	
	private   ChatTransmitFilesService    chatTransmitFilesService;       /**传送大文件*/
    private   UserFriendGroupTypeService userFriendGroupTypeService ;   /**群的类型*/
	private   UserFriendGroupService     userFriendGroupService ;		  /**群*/
	private   MiniBlogsService            miniBlogsService;               /**个人微博*/
	private   MiniBlogsAssessService      miniBlogsAssessService;         /**微博评价*/
   

	private  String nikeNameid;
	private  String nikeName;
	private  String friendNameid;
	private  String friendName;
	private  String textMsg;
	private String  userFriendId;
	private  String chatSplit = StatusChat.getChatSplit();
	
	
	/**
	 * 获取用户信息
	 * @param nikeNameid
	 * @throws IOException 
	 */
	public  void headerIsGetUserInfo(int nikeNameid, CallMeMessageInbound callMeMessageInbound) throws IOException   {
			String wherejpql = " o.userPojo.userId = ? and o.userFriendStatus in (?,?,?,?,?) ";
	    	Object[] queryParams =  {nikeNameid,
	    			 					 StatusChat.USERFRIENDSTATUSNOT,
	    								 StatusChat.USERFRIENDSTATUSACCEPT,
	    								 StatusChat.USERFRIENDSTATUSBLACK,
	    								 StatusChat.USERFRIENDSTATUSCRONY,
	    								 StatusChat.USERFRIENDSTATUSTEMPORARY
	    								};
			List<UserFriendPojo> userFriendList = userFriendService.findESCData(wherejpql, queryParams, null); 
			//未读信息
			List<ChatPojo> getnotreadList = chatService.findDoubleProperty("friendPojo.userId", nikeNameid, "chatStatus", StatusChat.CHATSTATUSNOT);   		
			//将用户与浏览器对象一起绑定在map中
			Map<CallMeMessageInbound, Map<Integer,List<UserFriendPojo>>> socketMap = CallMeEchoServlet.getSocketMap();
			Map<CallMeMessageInbound, Integer> socketUserIdMap = CallMeEchoServlet.getSocketUserIdMap();
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			Map<Integer,List<UserFriendPojo>> userFriendmap = new  LinkedHashMap<Integer, List<UserFriendPojo>>();
			
			socketUserIdMap.put(callMeMessageInbound, nikeNameid);
			userFriendmap.put(nikeNameid, userFriendList);
			socketMap.put(callMeMessageInbound, userFriendmap);
			userIdSocketMap.put(nikeNameid, callMeMessageInbound);
			
			Map<String,String> notreadmap = getnotreadmap(getnotreadList); //获取未读的信息
			Map<String, String> mapfriend = getfriendmap(nikeNameid,userFriendList,callMeMessageInbound);  //处理好友列表
			Set<CallMeMessageInbound> keySet = socketMap.keySet();
			  WsOutbound wsOutbound = null ;
			for (CallMeMessageInbound messageInbound : keySet) {
					  boolean userFriendup=false;
						for (UserFriendPojo userFriendPojo : userFriendList) {
							if(socketUserIdMap.get(messageInbound).equals(userFriendPojo.getFriendPojo().getUserId())){
								userFriendup =true;    //websocket服务器找中找到了自己的好友
							}
						}
					  Map<String, Object> map  = new HashMap<String, Object>();
					  boolean booleanstatus=false;
					  if (userFriendup) { 											//发给自己的好友
						  map.put("headerstatus", StatusChat.HEADERSTATUSFRIENDUP); 
						  map.put("friendup", nikeNameid);							//向服务器推送出自己在好友列表中的上线状况
						  booleanstatus=true;
						  wsOutbound = messageInbound.getWsOutbound();
					  }else if(messageInbound==callMeMessageInbound){ 
						  //更新自己的好友列表
						  map.put("headerstatus", StatusChat.HEADERSTATUSNOTREAD);   //状态为更新好友上线列表与未读信息
						  map.put("notreadmap", notreadmap);						//未读信息
						  map.put("mapfriend", mapfriend);							//好友上线列表
						  booleanstatus=true;
						  wsOutbound = messageInbound.getWsOutbound();
					  }
					if (booleanstatus) {
						JSONObject jsonObject  = JSONObject.fromObject(map);
						CharBuffer msgCb = CharBuffer.wrap(jsonObject.toString().toCharArray());
						wsOutbound.writeTextMessage(msgCb);
						wsOutbound.flush();
					}
			 }
		 
	}
		 /**未进入聊天页向好友推送自己上线
		 * @throws IOException */
		public void sendUserFriendMeUp(int userId) throws IOException{
			String wherejpql = " o.userPojo.userId = ? and o.userFriendStatus in (?,?,?,?,?) ";
	    	Object[] queryParams =  {userId,
	    			 					 StatusChat.USERFRIENDSTATUSNOT,
	    								 StatusChat.USERFRIENDSTATUSACCEPT,
	    								 StatusChat.USERFRIENDSTATUSBLACK,
	    								 StatusChat.USERFRIENDSTATUSCRONY,
	    								 StatusChat.USERFRIENDSTATUSTEMPORARY
	    								};
			List<UserFriendPojo> userFriendList = userFriendService.findESCData(wherejpql, queryParams, null); 
			Map<HttpSession, Integer> sessionUserMap = SessionListener.getAttributeMap(); //获取服务器中的user session
			Map<String, Object> map  = new HashMap<String, Object>();
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			for (UserFriendPojo userFriendPojo : userFriendList) {
				if(sessionUserMap.containsValue(userFriendPojo.getFriendPojo().getUserId())){ //好友在线
					    map.put("headerstatus", StatusChat.HEADERSTATUSFRIENDUP); 
					    map.put("friendup", userId);	
						JSONObject jsonObject  = JSONObject.fromObject(map);
						CharBuffer msgCb = CharBuffer.wrap(jsonObject.toString().toCharArray());
						if (userIdSocketMap.containsKey(userFriendPojo.getFriendPojo().getUserId())) { //好友在websocket中
							WsOutbound wsOutbound = userIdSocketMap.get(userFriendPojo.getFriendPojo().getUserId()).getWsOutbound();
							wsOutbound.writeTextMessage(msgCb);
							wsOutbound.flush();
						}
				}
			}
			
		}
		/**处理未读信息*/
		public   Map<String,String> getnotreadmap(List<ChatPojo> getnotreadList) {
			Map<String,String>  map  = new LinkedHashMap<String, String>();
			Set<Integer>  set = new HashSet<Integer>();
			StringBuffer stringBuffer = new StringBuffer();
			for (ChatPojo chatPojo : getnotreadList) {
				set.add(chatPojo.getUserFriendPojo().getUserFriendId());
			}
			for (Integer userFriendId : set) {
				int size = 0; 	//未读信息条数
				int group = 0;	//好友表的编号
				String  userFriendName = "";
				String  userFriendlastinfo = "";
				String  userFriendlastinfoTime ="";
				int    friendId =0;
				for (int i = 0; i < getnotreadList.size(); i++) {
					ChatPojo chatPojo = getnotreadList.get(i);
					if (userFriendId==chatPojo.getUserFriendPojo().getUserFriendId()) {
						size++;
						group = chatPojo.getUserFriendPojo().getFriendGroupPojo().getFriendGroupId();
						userFriendName = chatPojo.getUserFriendPojo().getUserPojo().getUsername();
						userFriendlastinfo = chatPojo.getChatText();
						SimpleDateFormat format  = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						userFriendlastinfoTime = format.format(chatPojo.getChatTime());
						friendId = chatPojo.getUserFriendPojo().getUserPojo().getUserId();
					}
				}
				stringBuffer.append(userFriendId+chatSplit+group+chatSplit+size
						+chatSplit+userFriendName+chatSplit+userFriendlastinfo
						+chatSplit+userFriendlastinfoTime+chatSplit+friendId+"&"+chatSplit+"&");
			}
			map.put("notreaduserIdandsize",stringBuffer.toString());
			return map;
		}
		
		/**处理好友列表*/
		public  Map<String,String> getfriendmap(int nikeNameid,List<UserFriendPojo> userFriendList,CallMeMessageInbound callMeMessageInbound) {
			Map<String,String>  map  = new LinkedHashMap<String, String>();
			Map<CallMeMessageInbound, Integer> socketUserIdMap = CallMeEchoServlet.getSocketUserIdMap();
			for (UserFriendPojo userFriendPojo : userFriendList) {
				if (socketUserIdMap.containsValue(userFriendPojo.getFriendPojo().getUserId())) {//检测好友是否存在
					map.put("userfriendidup",userFriendPojo.getFriendPojo().getUserId()+chatSplit+userFriendPojo.getFriendGroupPojo().getFriendGroupId()+chatSplit+userFriendPojo.getFriendGroupPojo().getFriendGroupName());
				}
			}
			return map;
		}
		/**群聊
		 * @throws IOException */
		public  void headerIsGroup(String[] split) throws IOException   {
				  nikeNameid= split[1];
				  nikeName= split[2];
				  String  chatroomnumber= split[3];
				  textMsg = split[4];
				  for (CallMeMessageInbound messageInbound : CallMeEchoServlet.getSocketList()) {
					  Map<String, String> map  = new HashMap<String, String>();
					  map.put("headerstatus", StatusChat.HEADERSTATUSALLCHAT);
					  map.put("nikeNameid", nikeNameid);
					  map.put("nikeName", nikeName);
					  map.put("chatroomnumber",chatroomnumber);
					  map.put("textMsg", textMsg);
					  map.put("countMsg", CallMeEchoServlet.getSocketList().size()+"");
					  map.put("endtime",new SimpleDateFormat("MM/dd HH:mm:ss").format(new Date()));
					  JSONObject  jsonObject = JSONObject.fromObject(map);
					CharBuffer  mBuffer2 = CharBuffer.wrap(jsonObject.toString().toCharArray());
					WsOutbound outbound = messageInbound.getWsOutbound();
						outbound.writeTextMessage(mBuffer2);
					outbound.flush();
				  }
			 
		}
		/**好友离线推送
		 * @throws IOException */
		public void userFriendOutloginSend( CallMeMessageInbound callMeMessageInbound) throws IOException  {
			  Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>> socketMap = CallMeEchoServlet.getSocketMap();
			  Map<CallMeMessageInbound, Integer> socketUserIdMap = CallMeEchoServlet.getSocketUserIdMap();
			  Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			  /**获取下线用户的好友关系表的信息*/
			  if (socketUserIdMap.containsKey(callMeMessageInbound)) {
				  Integer userId = socketUserIdMap.get(callMeMessageInbound);
				if (socketMap.get(callMeMessageInbound).containsKey(userId)) {
					List<UserFriendPojo> outUserFriendlist = socketMap.get(callMeMessageInbound).get(userId);
					CallMeMessageInbound userFriendCallMeMessageInbound ;
					for (UserFriendPojo userFriendPojo : outUserFriendlist) {
						if(userIdSocketMap.containsKey(userFriendPojo.getFriendPojo().getUserId())){
							userFriendCallMeMessageInbound = userIdSocketMap.get(userFriendPojo.getFriendPojo().getUserId());
							Map<String, String> map;
							map  = new HashMap<String, String>();
							map.put("headerstatus", StatusChat.HEADERSTATUSFRIENDDROP);  //推送好友下线推送的消息头
							map.put("userFriendId", userId.toString());
							JSONObject  jsonObject   = JSONObject.fromObject(map);
							CharBuffer  mBuffer2 = CharBuffer.wrap(jsonObject.toString().toCharArray());
							WsOutbound outbound = userFriendCallMeMessageInbound.getWsOutbound();
							/**向好友推送自己下线*/
							outbound.writeTextMessage(mBuffer2);
							outbound.flush();
						}
					}
				}
			}
			  /**移除服务器中的记录*/
			  if ( CallMeEchoServlet.getSocketList().contains(callMeMessageInbound)) {
				  CallMeEchoServlet.getSocketList().remove(callMeMessageInbound);
			}
			  if ( CallMeEchoServlet.getSocketMap().containsKey(callMeMessageInbound)) {
				  CallMeEchoServlet.getSocketMap().remove(callMeMessageInbound);
			}
			  if ( CallMeEchoServlet.getSocketUserIdMap().containsKey(callMeMessageInbound)) {
				  CallMeEchoServlet.getSocketUserIdMap().remove(callMeMessageInbound);
			}
			  if (CallMeEchoServlet.getUserIdSocketMap().containsKey(callMeMessageInbound)) {
				  CallMeEchoServlet.getUserIdSocketMap().remove(callMeMessageInbound);  
			}
			  
			  
			 
		}
		/**单聊
		 * @throws IOException */
		public  void headerIsSimple(String[] split, CallMeMessageInbound callMeMessageInbound) throws IOException   {
			  nikeNameid= split[1]; //自己的id
			  nikeName= split[2];   //自己的名字
			  friendNameid=split[3]; //好友的id
			  friendName=split[4];	//好友的名字
			  textMsg = split[5];	//聊天的内容
			  userFriendId = split[6]; //好友关系的id
			/**保存聊天记录*/
			 Long addChatwebsocketId = callMeSocketSave(Integer.parseInt(nikeNameid.trim()),Integer.parseInt(friendNameid.trim()),textMsg);
			 Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>> socketMap = CallMeEchoServlet.getSocketMap();
			 Set<CallMeMessageInbound> keySet = socketMap.keySet();
			 Map<String, String> map ;
		 for (CallMeMessageInbound myMessageInbound : keySet) {
			 map  = new HashMap<String, String>();
			 map.put("headerstatus", StatusChat.HEADERSTATUSCHAT);
			 map.put("nikeNameid", nikeNameid);
			 map.put("nikeName", nikeName);
			 map.put("friendName", friendName);
			 map.put("textMsg", textMsg);
			 map.put("friendNameid", friendNameid);
			 map.put("userFriendId", userFriendId);
			 map.put("addChatId", addChatwebsocketId.toString()); //保存后的id
			 map.put("endtime",new SimpleDateFormat("MM/dd HH:mm:ss").format(new Date()));
			 JSONObject  jsonObject = JSONObject.fromObject(map);
			 CharBuffer  mBuffer2 = CharBuffer.wrap(jsonObject.toString().toCharArray());
				 WsOutbound outbound = myMessageInbound.getWsOutbound();
			     if (myMessageInbound.getUserNameId()!=callMeMessageInbound.getUserNameId()) {
			    	 //单聊发给好友
			    	 Set<Integer> keySet2 = socketMap.get(myMessageInbound).keySet();
			    	 for (Integer userfriendid : keySet2) {
			    		 if (socketMap.get(myMessageInbound).containsKey(userfriendid)&&userfriendid==Integer.parseInt(friendNameid.trim())) {
								outbound.writeTextMessage(mBuffer2);
			    			 outbound.flush();
			    		 }
			    	 }
				}else{  //发回自己 
					if (addChatwebsocketId >0) { //将聊天记录发送为好友成功
						outbound.writeTextMessage(mBuffer2);
						outbound.flush();
					}else{
						 map.put("textMsg", "发送失败");
						outbound.writeTextMessage(mBuffer2);
						outbound.flush();
					}
				}
		}
		 
		}
		
		/**保存聊天记录*/
		public  Long callMeSocketSave(int userId , int friendId ,String textMsg){
			ChatPojo  chatPojo = new ChatPojo();
			  UserFriendPojo userFriendPojo = userFriendService.findDoubleProperty("userPojo.userId", userId,"friendPojo.userId",friendId).get(0);
			  chatPojo.setFriendPojo(userFriendPojo.getFriendPojo());
			  chatPojo.setUserFriendPojo(userFriendPojo);
			  chatPojo.setChatText(textMsg);
			  chatPojo.setChatTime(new Timestamp(new Date().getTime()));
			  chatPojo.setChatStatus(StatusChat.CHATSTATUSNOT);
			  boolean save = chatService.save(chatPojo);
			  if (save) {
				  return  chatPojo.getChatId(); //利用缓存获取id
			}
			return 0L;
		}
		/**加友请求
		 * @throws IOException */
		public void headeraddUserFriend(int userId, int friendId, CallMeMessageInbound callMeMessageInbound) throws IOException {
			UserFriendPojo userFriendPojo = userFriendService.findDoubleProperty("userPojo.userId", friendId,"friendPojo.userId",userId).get(0);
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			if (userIdSocketMap.containsKey(friendId)) {  //检测好友是否在线
				CallMeMessageInbound callMeMessageInbound2 = userIdSocketMap.get(friendId);
				WsOutbound wsOutbound = callMeMessageInbound2.getWsOutbound();
				Map<String, String> hashMap = new HashMap<String, String>();
					hashMap.put("headerstatus", StatusChat.HEADERSTATUSADDFRIEND);
					hashMap.put("friendUserName", userFriendPojo.getFriendPojo().getUsername());
					hashMap.put("friendId", userFriendPojo.getFriendPojo().getUserId().toString());
					hashMap.put("userFriendId", userFriendPojo.getUserFriendId().toString());
					hashMap.put("userFriendTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:SS ").format(userFriendPojo.getUserFriendTime()));
				JSONObject  jsonObject  = JSONObject.fromObject(hashMap);
				wsOutbound.writeTextMessage(CharBuffer.wrap(jsonObject.toString().toCharArray()));
				wsOutbound.flush();
			}
		}
		/**推送同意加为好友后的在线信息
		 * @throws IOException */
		public void headerAgreeUserFriend(int userId, int friendId,int userFriendId,CallMeMessageInbound callMeMessageInbound) throws IOException {
			UserFriendPojo userFriendPojo = userFriendService.findProperty("userFriendId", userFriendId).get(0);
			UserFriendPojo friendPojo = userFriendService.findDoubleProperty("userPojo.userId", friendId, "friendPojo.userId", userId).get(0);
			
			Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>> socketMap = CallMeEchoServlet.getSocketMap();
			if (socketMap.containsKey(callMeMessageInbound)) {
				List<UserFriendPojo> list = socketMap.get(callMeMessageInbound).get(userId);
				list.add(userFriendPojo);  //重新添加新用户信息
			}
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			if (userIdSocketMap.containsKey(userId)) { //发回自己好友的信息
				getMapFriendPojo(userFriendPojo,userId ,friendId,userIdSocketMap);
			}
			 if (userIdSocketMap.containsKey(friendId)) {//发给好友
				 CallMeMessageInbound callMeMessageInbound2 = userIdSocketMap.get(friendId);
				 socketMap.get(callMeMessageInbound2).get(friendId).add(friendPojo);  //重新添加新用户信息
			     getMapFriendPojo(friendPojo,friendId,userId ,userIdSocketMap);
			}
		}

		public void getMapFriendPojo( UserFriendPojo userFriendPojo, int userId,int friendId,
				Map<Integer, CallMeMessageInbound> userIdSocketMap) throws IOException  {
				WsOutbound wsOutbound = userIdSocketMap.get(userId).getWsOutbound();
				Map<String, String>   map  = new LinkedHashMap<String, String>();
			   map.put("headerstatus", StatusChat.HEADERSTATUAGREEFRIEND);
			   map.put("friendUserName", userFriendPojo.getFriendPojo().getUsername());
			   map.put("friendUserImage", userFriendPojo.getFriendPojo().getUserHeadPojo().getHeadImage());
			   map.put("friendUserId",  friendId+"");
			   map.put("userFriendId", userFriendPojo.getUserFriendId().toString());
			   map.put("friendGroupId", userFriendPojo.getFriendGroupPojo().getFriendGroupId().toString());
			   map.put("friendGroupName", userFriendPojo.getFriendGroupPojo().getFriendGroupName());
			   map.put("userFriendStatus", userFriendPojo.getUserFriendStatus());
			   if (userIdSocketMap.containsKey(friendId)) {  //检测好友是否上线
				   map.put("friendup", friendId+""); 
			   }else{
				   map.put("friendup", 0+"");    //好友未在线
			   }
			   wsOutbound.writeTextMessage(CharBuffer.wrap(JSONObject.fromObject(map).toString().toCharArray()));
			   wsOutbound.flush();
		}
		 /**如果好友在线推送信息
		 * @throws IOException */
		public void senduserFriendHotelCallMe(Integer userId,  Integer userFriendId) throws IOException {
			UserFriendPojo friendPojo = userFriendService.findDoubleProperty("userPojo.userId", userFriendId, "friendPojo.userId", userId).get(0);
			Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>> socketMap = CallMeEchoServlet.getSocketMap();
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			if (userIdSocketMap.containsKey(userFriendId)) { //检测好友是否在聊天页面
				CallMeMessageInbound callMeMessageInbound = userIdSocketMap.get(userFriendId);
				 socketMap.get(callMeMessageInbound).get(userFriendId).add(friendPojo);  //重新添加新用户信息
			     getMapFriendPojo(friendPojo,userFriendId,userId ,userIdSocketMap); //发给好友自己的信息
			}
		}
		public FriendGroupService getFriendGroupService() {
			return friendGroupService;
		}
		public void setFriendGroupService(FriendGroupService friendGroupService) {
			this.friendGroupService = friendGroupService;
		}
		public UserFriendService getUserFriendService() {
			return userFriendService;
		}
		public void setUserFriendService(UserFriendService userFriendService) {
			this.userFriendService = userFriendService;
		}
		public ChatService getChatService() {
			return chatService;
		}
		public void setChatService(ChatService chatService) {
			this.chatService = chatService;
		}
		public ChatTransmitFilesService getChatTransmitFilesService() {
			return chatTransmitFilesService;
		}
		public void setChatTransmitFilesService(
				ChatTransmitFilesService chatTransmitFilesService) {
			this.chatTransmitFilesService = chatTransmitFilesService;
		}
		public UserFriendGroupTypeService getUserFriendGroupTypeService() {
			return userFriendGroupTypeService;
		}
		public void setUserFriendGroupTypeService(
				UserFriendGroupTypeService userFriendGroupTypeService) {
			this.userFriendGroupTypeService = userFriendGroupTypeService;
		}
		public UserFriendGroupService getUserFriendGroupService() {
			return userFriendGroupService;
		}
		public void setUserFriendGroupService(
				UserFriendGroupService userFriendGroupService) {
			this.userFriendGroupService = userFriendGroupService;
		}
		public MiniBlogsService getMiniBlogsService() {
			return miniBlogsService;
		}
		public void setMiniBlogsService(MiniBlogsService miniBlogsService) {
			this.miniBlogsService = miniBlogsService;
		}
		public MiniBlogsAssessService getMiniBlogsAssessService() {
			return miniBlogsAssessService;
		}
		public void setMiniBlogsAssessService(
				MiniBlogsAssessService miniBlogsAssessService) {
			this.miniBlogsAssessService = miniBlogsAssessService;
		}
		
		
		
	 
}
