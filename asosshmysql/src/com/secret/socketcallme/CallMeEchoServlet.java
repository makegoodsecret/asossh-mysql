package com.secret.socketcallme;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;

import com.secret.pojo.UserFriendPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class CallMeEchoServlet extends WebSocketServlet {

	 	private Logger  logger  = Logger.getLogger(CallMeEchoServlet.class.getName());
	 	/**服务器*/
		private static   List<CallMeMessageInbound>  socketList = 
																new ArrayList<CallMeMessageInbound>();
		/**服务器与用户好友关系*/
		private static   Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>>   socketMap = 
																new LinkedHashMap<CallMeMessageInbound, Map<Integer,List<UserFriendPojo>>>(); 
		/**服务器与用户的id*/
		private static Map<CallMeMessageInbound,Integer>  socketUserIdMap =
																new LinkedHashMap<CallMeMessageInbound, Integer>();
		/**用户的id与服务器*/
		private static Map<Integer,CallMeMessageInbound >  userIdSocketMap =
																new LinkedHashMap<Integer,CallMeMessageInbound >();
		/**与服务器握手*/
		@Override
		protected StreamInbound createWebSocketInbound(String arg0, HttpServletRequest arg1) {
			//logger.info("与服务器连接成功new……");
			return new CallMeMessageInbound();
		}
		/**服务器*/
		public synchronized static   List<CallMeMessageInbound> getSocketList() {
			return socketList;
		}
		/**服务器与用户好友关系*/
		public synchronized static Map<CallMeMessageInbound, Map<Integer, List<UserFriendPojo>>> getSocketMap() {
			return socketMap;
		}
		/**服务器与用户的id*/
		public synchronized static Map<CallMeMessageInbound, Integer> getSocketUserIdMap() {
			return socketUserIdMap;
		}
		/**用户的id与服务器*/
		public synchronized static Map<Integer, CallMeMessageInbound> getUserIdSocketMap() {
			return userIdSocketMap;
		}
		
}
