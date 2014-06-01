package com.secret.listener;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.service.CallMeSocketService;
import com.secret.socketcallme.CallMeEchoServlet;
import com.secret.socketcallme.CallMeMessageInbound;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
/**监听session的创建与销毁*/
public class SessionListener implements HttpSessionListener, 
		ServletContextListener, ServletContextAttributeListener {
	
	/**attributeMap 中的key为每个客户端对应服务器的session ，value为登录用户的id*/
	private static Map<HttpSession, Integer>   attributeMap = new HashMap<HttpSession, Integer>();
	private static CallMeSocketService callMeSocketService = (CallMeSocketService) new  ClassPathXmlApplicationContext("applicationContext.xml").getBean("callMeSocketService"); 
	
	/**attributeMap 中的key为每个客户端对应服务器的session ，value为登录用户的id*/
	public static synchronized Map<HttpSession, Integer> getAttributeMap() {
		return attributeMap;
	}


	/**创建一个session时触发*/
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		attributeMap.put(se.getSession(), null);
		//System.out.println("创建一个session时触发");
	}
	/**session失效时触发*/
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		 //System.out.println("session失效时触发");
		if (attributeMap.containsKey(se.getSession())) {
			Integer integer = attributeMap.get(se.getSession());
			Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
			if (userIdSocketMap.containsKey(integer)) {
				CallMeMessageInbound  callMeMessageInbound = userIdSocketMap.get(integer);
				  try {
					  if ( CallMeEchoServlet.getSocketList().contains(callMeMessageInbound)) {
						  /**好友离线推送*/
						  callMeSocketService.userFriendOutloginSend(callMeMessageInbound);
					  }
					  } catch (IOException e) {
				  }
			}
			attributeMap.remove(se.getSession());
		}
		
	}
	/**新增加一个属性时触发*/
	@Override
	public void attributeAdded(ServletContextAttributeEvent se) {
		//System.out.println("新增加一个属性时触发se.hashCode()="+se.hashCode());
	}
	/**删除一个属性时触发*/
	@Override
	public void attributeRemoved(ServletContextAttributeEvent se) {
		 
		//System.out.println("删除一个属性时触发");
	}
	/**替换一个属性时触发*/
	@Override
	public void attributeReplaced(ServletContextAttributeEvent se) {
		//System.out.println("替换一个属性时触发");
	}
	/**context创建时激发*/
	@Override
	public void contextInitialized(ServletContextEvent se) {
		//System.out.println("context创建时激发");
	}
	/**context删除时触发*/
	@Override
	public void contextDestroyed(ServletContextEvent se) {
		//System.out.println("context删除时触发");
	}



	
	
	 
}
