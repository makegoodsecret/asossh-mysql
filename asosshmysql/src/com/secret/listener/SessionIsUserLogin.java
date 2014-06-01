package com.secret.listener;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import oracle.net.aso.s;

import com.secret.pojo.UserPojo;
import com.secret.util.StatusChat;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class SessionIsUserLogin {
	/**用户是否已经登录*/
	public  static void isUserLoginExist( HttpSession session, UserPojo userPojo) {
		 Map<HttpSession, Integer> attributeMap = SessionListener.getAttributeMap();
		 
		 if (attributeMap.containsKey(session)) {//检测session是否存在，不存在直接删除该session
			 //System.out.println("session坏掉了");
			 session.invalidate();
			 session = ServletActionContext.getRequest().getSession(); //重新创建session
			 attributeMap = SessionListener.getAttributeMap(); 
		}
			 if(attributeMap.containsValue(Integer.valueOf(userPojo.getUserId()))){ //该用户已经登录
				//强制清除已经登录的用户
				Set<HttpSession> keySet = attributeMap.keySet();
				for (HttpSession httpSession : keySet) {
					Integer integer = attributeMap.get(httpSession);
					if (integer == Integer.valueOf(userPojo.getUserId())) {
						attributeMap.remove(httpSession); //移除之前登录的用户
						httpSession.invalidate(); //让session失效
						break;
					}
				}
				
			}
			 //重新添加
			 session.setAttribute("user", userPojo);
			 attributeMap.put(session, Integer.valueOf(userPojo.getUserId()));
			 if (StatusChat.USERPOWERISGENERAL == userPojo.getPower()) {	//普通用户
				 session.removeAttribute("userIp");     //移除用户访问量，重新统计
			 }
	}

}
