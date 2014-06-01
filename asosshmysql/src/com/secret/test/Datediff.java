package com.secret.test;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.service.GoodsOrderService;



public class Datediff {
	static ApplicationContext cxt;	
	static GoodsOrderService goodsOrderService;
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		cxt = new ClassPathXmlApplicationContext("applicationContext.xml");
		goodsOrderService = (GoodsOrderService)cxt.getBean("goodsOrderService");
	}
  @Test
  public void testdate(){
	  
  }
	
	
}
