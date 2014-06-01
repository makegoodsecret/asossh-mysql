package com.secret.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.secret.pojo.ChatPojo;
import com.secret.pojo.UserFriendPojo;
import com.secret.socketcallme.CallMeMessageInbound;
/**
 * 
 * @author makegoodsecret
 */
 
 public interface CallMeSocketService {
	/**
	 * 获取用户信息
	 * @param userid   用户的id
	 * @param callMeMessageInbound websocket实现类
	 * @throws IOException 
	 */
	void headerIsGetUserInfo(int userid, CallMeMessageInbound callMeMessageInbound) throws IOException;
	/**未进入聊天页向好友推送自己上线
	 * @param userId  用户的Id
	* @throws IOException */
	void sendUserFriendMeUp(int userId) throws IOException;
	/**处理未读信息
	 * @param chatPojoList  
	 * */
	Map<String,String> getnotreadmap(List<ChatPojo> chatPojoList);
		
	/**处理好友列表
	 * 
	 * @param userid
	 * @param userFriendList
	 * @param callMeMessageInbound
	 * @return
	 */
	Map<String,String> getfriendmap(int userid,List<UserFriendPojo> userFriendList,CallMeMessageInbound callMeMessageInbound);
	/**群聊
	 * 
	 * @param split
	 * @throws IOException
	 */
	void headerIsGroup(String[] split) throws IOException;
	/**好友离线推送
	 * 
	 * @param callMeMessageInbound
	 * @throws IOException
	 */
	 void userFriendOutloginSend( CallMeMessageInbound callMeMessageInbound) throws IOException;
	/**单聊
	 * 
	 * @param split
	 * @param callMeMessageInbound
	 * @throws IOException
	 */
	void headerIsSimple(String[] split, CallMeMessageInbound callMeMessageInbound) throws IOException;
		
	/**保存聊天记录
	 * 
	 * @param userId
	 * @param friendId
	 * @param textMsg
	 * @return
	 */
	Long callMeSocketSave(int userId , int friendId ,String textMsg);
	/**加友请求
	 * 
	 * @param userId
	 * @param friendId
	 * @param callMeMessageInbound
	 * @throws IOException
	 */
	void headeraddUserFriend(int userId, int friendId, CallMeMessageInbound callMeMessageInbound) throws IOException;
	/**推送同意加为好友后的在线信息
	 * 
	 * @param userId
	 * @param friendId
	 * @param userFriendId
	 * @param callMeMessageInbound
	 * @throws IOException
	 */
	void headerAgreeUserFriend(int userId, int friendId,int userFriendId,CallMeMessageInbound callMeMessageInbound) throws IOException;
	/**处理自己与好友的发生请求数据
	 * 
	 * @param userFriendPojo
	 * @param userId
	 * @param friendId
	 * @param userIdSocketMap
	 */
	void getMapFriendPojo( UserFriendPojo userFriendPojo, int userId,int friendId,
							Map<Integer, CallMeMessageInbound> userIdSocketMap) throws IOException ;
	/**如果好友在线推送信息
	 * 
	 * @param userId
	 * @param userFriendId
	 */
	 void senduserFriendHotelCallMe(Integer userId,  Integer userFriendId) throws IOException;
}
