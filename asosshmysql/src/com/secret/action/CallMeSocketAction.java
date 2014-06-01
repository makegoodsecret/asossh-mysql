package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;



import org.apache.struts2.ServletActionContext;

import com.secret.pojo.ChatPojo;
import com.secret.pojo.ChatTransmitFilesPojo;
import com.secret.pojo.FriendGroupPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.UserFriendGroupPojo;
import com.secret.pojo.UserFriendGroupTypePojo;
import com.secret.pojo.UserFriendPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.CallMeSocketService;
import com.secret.service.ChatService;
import com.secret.service.ChatTransmitFilesService;
import com.secret.service.FriendGroupService;
import com.secret.service.MiniBlogsAssessService;
import com.secret.service.MiniBlogsService;
import com.secret.service.UserFriendGroupService;
import com.secret.service.UserFriendGroupTypeService;
import com.secret.service.UserFriendService;
import com.secret.service.UserService;
import com.secret.util.ResponseSetCharacterEncoding;
import com.secret.util.StatusChat;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class CallMeSocketAction extends BaseAction {
	private FriendGroupService         friendGroupService ;             /**用户自己好友的分组*/
	private UserFriendService 		   userFriendService; 			    /**好友关系*/
	private ChatService 			   chatService;					    /**聊天记录*/
	private ChatTransmitFilesService   chatTransmitFilesService;       /**传送大文件*/
    private UserFriendGroupTypeService userFriendGroupTypeService ;     /**群的类型*/
	private UserFriendGroupService     userFriendGroupService ;		    /**群*/
	private MiniBlogsService           miniBlogsService;               /**个人微博*/
	private MiniBlogsAssessService     miniBlogsAssessService;         /**微博评价*/
	private UserService                userService ;
	
	private UserPojo                    userPojo;						/**用户*/
	private UserPojo                    friendPojo ;					/**好友*/
	private UserFriendPojo              userFriendPojo ;                /**用户好友关系*/
	private FriendGroupPojo             friendGroupPojo;                /**好友分组表*/
	private UserFriendGroupPojo         userFriendGroupPojo;            /**群*/
	private UserFriendGroupTypePojo     userFriendGroupTypePojo;        /**群的类型*/
	private ChatTransmitFilesPojo       chatTransmitFilesPojo ;         /**传输的为文件*/
	private ChatPojo                    chatPojo    ;                   /**聊天内容*/
	private HotelPojo                   hotelPojo  ;                    /**餐厅管理员*/
	
	private HttpServletResponse  response  = ResponseSetCharacterEncoding.getInstance();
    private PrintWriter out ;
    
    
    private List<UserFriendGroupPojo> userFriendGroupPojoList  ;   // 群
    private List<UserFriendPojo> userFriendPojosList ;				//用户的关系
    private List<FriendGroupPojo> friendGroupPojoList ;             //用户对好友的分组
    private List<UserFriendPojo> userFriendApplyList  ;             //好友申请
    
    private CallMeSocketService callMeSocketService ;
	
    
	/**取到session中的用户*/
    private void getUserInfo(){
    	  userPojo=(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
    }
    
    
    /**与餐厅老板聊天
     * @throws IOException */
    public String gotoCallHotel() throws IOException{
    	hotelPojo.setHotelName(new String(hotelPojo.getHotelName().getBytes("ISO-8859-1"),"UTF-8"));
    	hotelPojo.getUserPojo().setUsername(new String(hotelPojo.getUserPojo().getUsername().getBytes("ISO-8859-1"),"UTF-8"));
    		getUserInfo(); 
    		List<UserPojo> friendUserInfoList = userService.findProperty("userId", hotelPojo.getUserPojo().getUserId());
    	if (friendUserInfoList.size()!=0) {
    		userFriendPojosList =  userFriendService.findDoubleProperty("userPojo.userId", userPojo.getUserId(), "friendPojo.userId", hotelPojo.getUserPojo().getUserId());
    		
    		if (userFriendPojosList.size() == 0
    			&&(!hotelPojo.getUserPojo().getUserId().equals(userPojo.getUserId()))) { //没有加为好友，将饭店管理员添加为临时聊天好友
    		  userFriendPojo = new UserFriendPojo();  
    		  friendPojo= friendUserInfoList.get(0);
    		  userFriendPojo.setUserPojo(userPojo);
			  userFriendPojo.setFriendPojo(friendPojo);
    		  userFriendPojo.setUserFriendTime(new Timestamp(new Date().getTime()));
			  userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSTEMPORARY);		 //为临时聊天
			  userFriendPojo.setGpsShare(StatusChat.GPSSHARENOT);   					//不共享GPS
			  userFriendPojo.setHidingStatus(StatusChat.HIDINGSTATUSSHOW);  			//不隐身
			  userFriendPojo.setFriendApplyForStatus(StatusChat.FRIENDAPPLYFORYES);    //申请好友的那一方
			  friendGroupPojo=friendGroupService.findProperty("userPojo.userId",userPojo.getUserId()).get(0); 	//查询默认组别
			  userFriendPojo.setFriendGroupPojo(friendGroupPojo);						//组别
			  boolean usermerge = userFriendService.merge(userFriendPojo);
			  if (usermerge) {
				  //被加好友那一方也加一行
				  userFriendPojo.setUserPojo(friendPojo);
				  userFriendPojo.setFriendPojo(userPojo);
				  userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSTEMPORARY);		//为临时聊天
				  userFriendPojo.setFriendApplyForStatus(StatusChat.FRIENDAPPLYFORNOT);     //被申请好友的那一方
				  friendGroupPojo.setUserPojo(friendPojo);
				  friendGroupPojo=friendGroupService.findProperty("userPojo.userId", friendPojo.getUserId()).get(0); 	//查询组别0为默认
				  userFriendPojo.setFriendGroupPojo(friendGroupPojo);	
				  boolean userFriendmerge = userFriendService.merge(userFriendPojo);
				  if (userFriendmerge) {
					  userFriendPojo =  userFriendService.findDoubleProperty("userPojo.userId", userPojo.getUserId(), "friendPojo.userId", friendPojo.getUserId()).get(0);
					  /**如果好友在线推送信息*/
					  callMeSocketService.senduserFriendHotelCallMe(userPojo.getUserId(),friendPojo.getUserId());
					  return gotoCallMeHome();
				  }
			  }
			}else{
				if (!hotelPojo.getUserPojo().getUserId().equals(userPojo.getUserId())) {
					userFriendPojo = userFriendPojosList.get(0);
				}
				 return gotoCallMeHome();
			}
    	}
    	 return "globalrequestIsExist";
    }
	/**进入聊天页*/
    public String gotoCallMeHome(){
    	getUserInfo();
		String wherejpql = " o.userPojo.userId = ? and o.userFriendStatus in (?,?,?,?,?) ";
    	Object[] queryParams =  {userPojo.getUserId(),
    								 StatusChat.USERFRIENDSTATUSNOT,
    								 StatusChat.USERFRIENDSTATUSACCEPT,
    								 StatusChat.USERFRIENDSTATUSBLACK,
    								 StatusChat.USERFRIENDSTATUSCRONY,
    								 StatusChat.USERFRIENDSTATUSTEMPORARY
    								};
		userFriendPojosList = userFriendService.findESCData(wherejpql, queryParams, null);
		userFriendGroupPojoList = userFriendGroupService.findProperty("userPojo.userId", userPojo.getUserId());
		friendGroupPojoList = friendGroupService.findProperty("userPojo.userId", userPojo.getUserId());
		/**好友申请*/
		userFriendApplyList = userFriendService.findDoubleProperty("userPojo.userId ",userPojo.getUserId() ,"userFriendStatus", StatusChat.USERFRIENDSTATUSNOT );
    	return "gotoCallMeHome";
    }
    /**新增好友分组*/
    public void addApplayGroupFriend(){
    	 try {
    		 out = response.getWriter();
    		 getUserInfo();
    		 friendGroupPojo.setUserPojo(userPojo);
    		 boolean save = friendGroupService.save(friendGroupPojo);
    		 if (save) {
				out.println(friendGroupPojo.getFriendGroupId());
			}else{
				out.println("0");
			}
    		  out.flush();
			  out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	/**添加好友 */
	 public void addUserFriend(){
		 try {
			  getUserInfo();
			  out = response.getWriter();
			  List<UserPojo> friendUserInfoList = userService.findProperty("email", friendPojo.getEmail());
			 if (friendUserInfoList.size() == 0) { 
				  out.println("-1");//邮箱不存在
			}else if(friendPojo.getEmail().equals(userPojo.getEmail())){
				out.println("-2");  //自己的邮箱
			}else{
			  userFriendPojo = new UserFriendPojo();
			  friendPojo=friendUserInfoList.get(0);
			  userFriendPojo.setUserPojo(userPojo);
			  userFriendPojo.setFriendPojo(friendPojo);
			  List<UserFriendPojo> friendlist = userFriendService.findDoubleProperty("userPojo.userId", userPojo.getUserId(), "friendPojo.email", friendPojo.getEmail());
			  if (friendlist.size()==0) {//没有加好友
				  userFriendPojo.setUserFriendTime(new Timestamp(new Date().getTime()));
				  userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSYES);		//代表为申请好友的那一方(没有处理好友请求)
				  userFriendPojo.setGpsShare(StatusChat.GPSSHARENOT);   					//不共享GPS
				  userFriendPojo.setHidingStatus(StatusChat.HIDINGSTATUSSHOW);  			//不隐身
				  userFriendPojo.setFriendApplyForStatus(StatusChat.FRIENDAPPLYFORYES);     //为申请好友的那一方
				  friendGroupPojo=friendGroupService.findProperty("friendGroupId",friendGroupPojo.getFriendGroupId()).get(0); 	//查询组别
				  userFriendPojo.setFriendGroupPojo(friendGroupPojo);						//组别
				  boolean usermerge = userFriendService.merge(userFriendPojo);
				  if (usermerge) {
					  //被加好友那一方也加一行
					  userFriendPojo.setUserPojo(friendPojo);
					  userFriendPojo.setFriendPojo(userPojo);
					  userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSNOT);		//没有处理好友
					  userFriendPojo.setFriendApplyForStatus(StatusChat.FRIENDAPPLYFORNOT);     //被申请好友的那一方
					  friendGroupPojo.setUserPojo(friendPojo);
					  friendGroupPojo=friendGroupService.findProperty("userPojo.userId", friendPojo.getUserId()).get(0); 	//查询组别0为默认
					  userFriendPojo.setFriendGroupPojo(friendGroupPojo);	
					  boolean userFriendmerge = userFriendService.merge(userFriendPojo);
					  if (userFriendmerge) {
						  out.println(userFriendPojo.getUserPojo().getUserId()); //加友成功
					}else{
						out.println("0");
					}
				  }
			  }else{//已经加为好友，
				    userFriendPojo = friendlist.get(0);
				    if(userFriendPojo.getUserFriendStatus().equals(StatusChat.USERFRIENDSTATUSZERO)||
				       userFriendPojo.getUserFriendStatus().equals(StatusChat.USERFRIENDSTATUSREFUSE)||
				       userFriendPojo.getUserFriendStatus().equals(StatusChat.USERFRIENDSTATUSTEMPORARY)
				       ){ 
				    	//已经解除好友关系或者已经拒绝加友请求
				    userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSYES);		//代表为申请好友的那一方(没有处理好友请求)
				    userFriendPojo.setUserFriendTime(new Timestamp(new Date().getTime()));
				    boolean saveorupdate = userFriendService.saveorupdate(userFriendPojo);
				    if (saveorupdate) { //修改好友表中加为好友的那一方
				    	userFriendPojo = userFriendService.findDoubleProperty("userPojo", friendPojo, "friendPojo", userPojo).get(0);
				    	userFriendPojo.setUserFriendStatus(StatusChat.USERFRIENDSTATUSNOT);		//没有处理好友请求
				    	userFriendPojo.setUserFriendTime(new Timestamp(new Date().getTime()));
						boolean saveorupdate2 = userFriendService.saveorupdate(userFriendPojo);
						 if (saveorupdate2) {
							 out.println(userFriendPojo.getUserPojo().getUserId()); //加友成功
						}else{
							out.println("0");
						}
					}else{
						out.println("0");
					}
			  }else{
				  out.println("-3"); //好友已经存在
			  }
			  }
			}
			  out.flush();
			  out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		 
	 }
	 
	 /**对好友隐身操作 */
	public void hiddenUser(){
		  try {
			out = response.getWriter();
		    userFriendPojo = userFriendService.findProperty("userFriendId", userFriendPojo.getUserFriendId()).get(0);
		    if (userFriendPojo.getHidingStatus().equals(StatusChat.HIDINGSTATUSSHOW)) { //不隐身
		    	userFriendPojo.setHidingStatus(StatusChat.HIDINGSTATUSHIDDEN);   //设为隐身
			}else{
				userFriendPojo.setHidingStatus(StatusChat.HIDINGSTATUSSHOW);   //设为不隐身
			}
		    boolean saveorupdate = userFriendService.saveorupdate(userFriendPojo);
		    if (saveorupdate) {
				out.println("1");
			}else{
				out.println("0");
			}
		    out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**对GPS操作*/
	public void hiddenGps(){
		  try {
				out = response.getWriter();
			    userFriendPojo = userFriendService.findProperty("userFriendId", userFriendPojo.getUserFriendId()).get(0);
			    if (userFriendPojo.getGpsShare().equals(StatusChat.GPSSHARENOT)) { //不共享GPS
			    	userFriendPojo.setGpsShare(StatusChat.GPSSHAREYES);                //共享GPS
				}else{
					userFriendPojo.setGpsShare(StatusChat.GPSSHARENOT);                //不共享GPS
				}
			    boolean saveorupdate = userFriendService.saveorupdate(userFriendPojo);
			    if (saveorupdate) {
					out.println("1");
				}else{
					out.println("0");
				}
			    out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	/**双方的好友关系*/
	public void doubleFriend(){
	/* 结果由userFriendPojo.getUserFriendStatus()控制
     	0代表解除好友关系,1代表接受，2代表拒绝，
     * */
		 try {
			 	getUserInfo();
				out = response.getWriter();
			    UserFriendPojo userFriendPojo2 = userFriendService.findProperty("userFriendId", userFriendPojo.getUserFriendId()).get(0);
				userFriendPojo2.setUserFriendStatus(userFriendPojo.getUserFriendStatus());  
			    boolean saveorupdate = userFriendService.saveorupdate(userFriendPojo2);
			    if (saveorupdate) {
			    	userFriendPojo2 = userFriendService.findDoubleProperty("userPojo.userId", userFriendPojo2.getFriendPojo().getUserId(), "friendPojo.userId", userFriendPojo2.getUserPojo().getUserId()).get(0);
			    	userFriendPojo2.setUserFriendStatus(userFriendPojo.getUserFriendStatus());                 
			    	boolean saveorupdate2 = userFriendService.saveorupdate(userFriendPojo2);
			    	if (saveorupdate2) {
			    		out.println("1");
					}else{
						out.println("0");
					}
				}else{
					out.println("0");
				}
			    out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	/**单方面处理好友关系*/
	public void applyFriend(){
		 try {
			 	getUserInfo();
				out = response.getWriter();
			    UserFriendPojo userFriendPojo2 = 
			    		userFriendService.findProperty("userFriendId", userFriendPojo.getUserFriendId()).get(0);
			    userFriendPojo2.setUserFriendStatus(userFriendPojo.getUserFriendStatus());
			    /* 
			     	结果由userFriendPojo.getUserFriendStatus()控制
			     	3代表拉入黑名单,4代表加为密友
			     * */
			    boolean saveorupdate = userFriendService.saveorupdate(userFriendPojo2);
			    if (saveorupdate) {
			    		out.println("1");
				}else{
					out.println("0");
				}
			    out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
		}
	}
	/**修改用户的分组*/
	public void addApplyFriend(){
		try {
			getUserInfo();
			out = response.getWriter();
			 userFriendPojo = userFriendService.findProperty("userFriendId", userFriendPojo.getUserFriendId()).get(0);
			 friendGroupPojo = friendGroupService.findProperty("friendGroupId", friendGroupPojo.getFriendGroupId()).get(0);
			 userFriendPojo.setFriendGroupPojo(friendGroupPojo);
			 boolean update = userFriendService.merge(userFriendPojo);
			 if (update) {
				out.println("1");
			}else{
				out.println("0");
			}
			 out.flush();
			 out.close();
			} catch (IOException e) {
				e.printStackTrace();
		}
	}
	/**获取用户的聊天记录，并将标记为已读*/
	public void readerChatGetJson(){
		try {
			out = response.getWriter();
		 	String wherejpql = " o.friendPojo.userId = ? and o.chatStatus = ?";
			Object[] queryParams = {userPojo.getUserId() , StatusChat.CHATSTATUSNOT};
			List<ChatPojo> readerChat = chatService.findESCData(wherejpql, queryParams, null);
			StringBuffer buffer  = new StringBuffer();
			for (ChatPojo chatPojo : readerChat) {
				/**修改为已读*/
				chatPojo.setChatStatus(StatusChat.CHATSTATUSYES);
				boolean saveorupdate = chatService.saveorupdate(chatPojo);
				if (saveorupdate) {
					buffer.append("<div class='alert alert-block' style='margin:5px 5px;'>"
							+"<a class='close' data-dismiss='alert' href='#'><i class='icon-large icon-remove-circle'></i></a>"
							+"<h5 class='alert-heading' style='margin-top:-10px;'>"+chatPojo.getUserFriendPojo().getUserPojo().getUsername()
							+"&nbsp;&nbsp; "+new SimpleDateFormat("MM/dd HH:mm:ss").format(chatPojo.getChatTime())
							+"</h5><p style='font-family: 仿宋; font-size: 18px;color: black;'>"+chatPojo.getChatText()+"</P></div>");
				}
			}
			out.println(buffer.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**正在聊天标记为已读*/
	public void updateChatReaderStatus(){
		try {
			out = response.getWriter();
			 chatPojo = chatService.findProperty("chatId", chatPojo.getChatId()).get(0);
			 chatPojo.setChatStatus(StatusChat.CHATSTATUSYES);
			 boolean update = chatService.update(chatPojo);
			 if (update) {
				out.println("1");
			}else{
				out.println("0");
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
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

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}

	public UserPojo getFriendPojo() {
		return friendPojo;
	}

	public void setFriendPojo(UserPojo friendPojo) {
		this.friendPojo = friendPojo;
	}

	public UserFriendPojo getUserFriendPojo() {
		return userFriendPojo;
	}

	public void setUserFriendPojo(UserFriendPojo userFriendPojo) {
		this.userFriendPojo = userFriendPojo;
	}

	public FriendGroupPojo getFriendGroupPojo() {
		return friendGroupPojo;
	}

	public void setFriendGroupPojo(FriendGroupPojo friendGroupPojo) {
		this.friendGroupPojo = friendGroupPojo;
	}

	public UserFriendGroupPojo getUserFriendGroupPojo() {
		return userFriendGroupPojo;
	}

	public void setUserFriendGroupPojo(UserFriendGroupPojo userFriendGroupPojo) {
		this.userFriendGroupPojo = userFriendGroupPojo;
	}

	public UserFriendGroupTypePojo getUserFriendGroupTypePojo() {
		return userFriendGroupTypePojo;
	}

	public void setUserFriendGroupTypePojo(
			UserFriendGroupTypePojo userFriendGroupTypePojo) {
		this.userFriendGroupTypePojo = userFriendGroupTypePojo;
	}

	public ChatTransmitFilesPojo getChatTransmitFilesPojo() {
		return chatTransmitFilesPojo;
	}

	public void setChatTransmitFilesPojo(ChatTransmitFilesPojo chatTransmitFilesPojo) {
		this.chatTransmitFilesPojo = chatTransmitFilesPojo;
	}

	public ChatPojo getChatPojo() {
		return chatPojo;
	}

	public void setChatPojo(ChatPojo chatPojo) {
		this.chatPojo = chatPojo;
	}

	public List<UserFriendGroupPojo> getUserFriendGroupPojoList() {
		return userFriendGroupPojoList;
	}

	public void setUserFriendGroupPojoList(
			List<UserFriendGroupPojo> userFriendGroupPojoList) {
		this.userFriendGroupPojoList = userFriendGroupPojoList;
	}

	public List<UserFriendPojo> getUserFriendPojosList() {
		return userFriendPojosList;
	}

	public void setUserFriendPojosList(List<UserFriendPojo> userFriendPojosList) {
		this.userFriendPojosList = userFriendPojosList;
	}

	public List<FriendGroupPojo> getFriendGroupPojoList() {
		return friendGroupPojoList;
	}

	public void setFriendGroupPojoList(List<FriendGroupPojo> friendGroupPojoList) {
		this.friendGroupPojoList = friendGroupPojoList;
	}

	public List<UserFriendPojo> getUserFriendApplyList() {
		return userFriendApplyList;
	}

	public void setUserFriendApplyList(List<UserFriendPojo> userFriendApplyList) {
		this.userFriendApplyList = userFriendApplyList;
	}


	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}


	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}


	public CallMeSocketService getCallMeSocketService() {
		return callMeSocketService;
	}


	public void setCallMeSocketService(CallMeSocketService callMeSocketService) {
		this.callMeSocketService = callMeSocketService;
	}
	 
}
