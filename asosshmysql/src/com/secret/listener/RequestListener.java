package com.secret.listener;

import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class RequestListener implements ServletRequestListener,
		ServletRequestAttributeListener {

	@Override
	public void attributeAdded(ServletRequestAttributeEvent arg0) {
		//System.out.println("attributeAdded arg0.getName()=       "+arg0.getName()+"          arg0.getValue()=     "+arg0.getValue());
		
	}

	@Override
	public void attributeRemoved(ServletRequestAttributeEvent arg0) {
		//System.out.println("attributeRemoved arg0.getName()=     "+arg0.getName()+"          arg0.getValue()=     "+arg0.getValue());
		
	}

	@Override
	public void attributeReplaced(ServletRequestAttributeEvent arg0) {
		//System.out.println("attributeReplaced arg0.getName()=    "+arg0.getName()+"          arg0.getValue()=     "+arg0.getValue());
		
	}

	@Override
	public void requestDestroyed(ServletRequestEvent arg0) {
		//System.out.println("requestDex销毁了      "+arg0.hashCode());
		
		
	}

	@Override
	public void requestInitialized(ServletRequestEvent arg0) {
		//System.out.println("request创建了           "+arg0.hashCode());
		
	}}
