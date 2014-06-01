package com.secret.test;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.service.GoodsOrderService;


public class GoodsHibernateTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		  ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		  GoodsOrderService goodsOrderService = (GoodsOrderService) applicationContext.getBean("goodsOrderService", GoodsOrderService.class);
	}

}
