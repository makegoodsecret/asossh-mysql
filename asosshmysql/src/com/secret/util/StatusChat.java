package com.secret.util;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public final class StatusChat {
	/**聊天时的消息头*/
	/**单聊*/ 
	public static final String HEADERSTATUSCHAT = "headerstatuschat";         
	/**群聊*/
	public static final String HEADERSTATUSALLCHAT= "headerstatusallchat";   
	/**获取用户信息*/
	public static final String HEADERSTATUSNOTREAD = "headerstatusnotread";   
	/**推送好友上线*/
	public static final String HEADERSTATUSFRIENDUP = "headerstatusfriendup"; 
	/**推送出好友下线*/
	public static final String HEADERSTATUSFRIENDDROP = "headerstatusfrienddrop"; 
	/**未登录聊天面板，但是提示好友登录*/
	public static final String HEADERSTATUSONLYLOGIN = "headerstatusonlylogin";
	/**推送加友请求*/
	public static final String HEADERSTATUSADDFRIEND = "headerstatusaddfriend";
	/**同意加友后获取好友是否在线以及信息*/
	public static final String HEADERSTATUAGREEFRIEND = "headerstatuagreefriend";
	
	
	
	
	/**好友关系表中是否隐身*/
	/**不隐身*/
    public static final String HIDINGSTATUSSHOW  = "0" ;				    
    /**隐身*/
    public static final String  HIDINGSTATUSHIDDEN = "1";  
    
	/**是否共享GPS*/
    /**不共享GPS定位*/
    public static final String  GPSSHARENOT        = "0" ;                    
    /**共享GPS定位*/
	public static final String  GPSSHAREYES        = "1" ;		
	
	
	/**是否为申请好友那一方*/
	/**为申请好友的那一方*/
	public static final String FRIENDAPPLYFORYES =  "0";
	/**为被申请好友的那一方*/
    public static final String FRIENDAPPLYFORNOT = "1";
    
    /**好友关系表中的状态*/
	/**没有处理好友请求,*/
	public static final String USERFRIENDSTATUSNOT = "n";       
	/**代表为申请好友的那一方(没有处理好友请求)*/
	public static final String USERFRIENDSTATUSYES = "y";   
	/**解除好友关系*/
	public static final String USERFRIENDSTATUSZERO = "0";                  
	/**接受好友*/ 
	public static final String USERFRIENDSTATUSACCEPT = "1";                
	/**拒绝加为好友*/
	public static final String USERFRIENDSTATUSREFUSE = "2";				
	/**加入黑名单*/
	public static final String USERFRIENDSTATUSBLACK  = "3";				
	/**加为密友*/
	public static final String USERFRIENDSTATUSCRONY  = "4";                  
	/**临时聊天*/
	public static final String  USERFRIENDSTATUSTEMPORARY = "5";
	
	
	/**是否查看了消息*/
	/**未读信息*/
	public static final String CHATSTATUSNOT          = "n";				
	/**已读*/
	public static final String CHATSTATUSYES          = "y" ;                 

	/**发送大图片是否接收*/
	/**未接收*/
	public static final String CHATTRANSMITFILESSTATUSNOT          = "n";	  
	/**已接收*/
	public static final String CHATTRANSMITFILESSTATUSYES          = "y" ;    
	
	/**用户权限*/
	/**管理员*/
	public static final String USERPOWERISADMIN    = "1";
	/**普通用户*/
	public static final String USERPOWERISGENERAL   = "0";	
 
	
	
	
	/**
	 * 在线聊天的分隔
	 * @return
	 */
	public static String getChatSplit(){
			return  "O@@O";
	}
	 
}
