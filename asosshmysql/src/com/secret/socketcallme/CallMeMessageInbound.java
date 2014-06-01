package com.secret.socketcallme;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.logging.Logger;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.WsOutbound;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.service.CallMeSocketService;
import com.secret.util.StatusChat;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class CallMeMessageInbound extends MessageInbound {
	private int userNameId = 0;
	private Logger logger  = Logger.getLogger(CallMeEchoServlet.class.getName());
	private CallMeSocketService  callMeSocketService  ;
	
	public CallMeMessageInbound(){
		ApplicationContext applicationContext =
					new  ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		callMeSocketService = (CallMeSocketService) applicationContext.getBean("callMeSocketService",CallMeSocketService.class);
		//logger.info("");
	}
	 

	public int getUserNameId() {
		
		return userNameId;
	}
    
	/**
	 * 打开连接
	 */
	 @Override
	protected void onOpen(WsOutbound outbound) {
		super.onOpen(outbound);
		userNameId = outbound.hashCode();
		//System.out.println("userNameId= \n "+userNameId);
		CallMeEchoServlet.getSocketList().add(this);   //记录服务器为每个连接用户分配的唯一标识
	}
	/**
	 * 有二进制消息数据到达，比如音频文件传输
	 */
	@Override
	protected void onBinaryMessage(ByteBuffer arg0) throws IOException {
		 
		
	}
	/**
	 * 发送信息
	 * @throws IOException 
	 */
	@Override
	protected void onTextMessage(CharBuffer buffer) throws IOException   {
			 String msgOriginal  = buffer.toString();
			 String[] split = msgOriginal.split(StatusChat.getChatSplit());
			 String headerstatus = split[0];						//获取消息头
			if (StatusChat.HEADERSTATUSNOTREAD.equals(headerstatus)) {
				//发送消息头为获取用户信息
				callMeSocketService.headerIsGetUserInfo(Integer.parseInt(split[1].trim()),this);
			}else if (StatusChat.HEADERSTATUSALLCHAT.equals(headerstatus)) {
				//获取的消息头为群聊
				headerstatus = StatusChat.HEADERSTATUSALLCHAT;
				callMeSocketService.headerIsGroup(split);
			}else if (StatusChat.HEADERSTATUSCHAT.equals(headerstatus)){//单聊
				 //logger.info("当前在线"+CallMeEchoServlet.getSocketList().size()+"人");
				callMeSocketService.headerIsSimple(split,this);
			}else if(StatusChat.HEADERSTATUSADDFRIEND.equals(headerstatus)){
				//推送加友请求
				callMeSocketService.headeraddUserFriend(Integer.parseInt(split[1].trim()),Integer.parseInt(split[2].trim()),this);
			}else if(StatusChat.HEADERSTATUAGREEFRIEND.equals(headerstatus)){
				//推送同意加为好友后的在线信息
				callMeSocketService.headerAgreeUserFriend(Integer.parseInt(split[1].trim()),Integer.parseInt(split[2].trim()),Integer.parseInt(split[3].trim()),this);
			}else if(StatusChat.HEADERSTATUSONLYLOGIN.equals(headerstatus)){
				//用户登录但是没有进入聊天面板
				
			}
	}
	/**
	 * 关闭连接
	 */
	@Override
	protected void onClose(int status)  {
				try {
					/**好友离线推送*/
				if ( CallMeEchoServlet.getSocketList().contains(this)) {
					callMeSocketService.userFriendOutloginSend(this);
				}
				} catch (IOException e) {
				}
			 super.onClose(status);
		 
	}

	 
}
