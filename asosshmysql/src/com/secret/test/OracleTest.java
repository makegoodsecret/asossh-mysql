package com.secret.test;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.pojo.GoodsImagePojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.SortPojo;
import com.secret.service.GoodsImageService;
import com.secret.service.GoodsInfoService;
import com.secret.service.GoodsOrderService;
import com.secret.service.HotelService;
import com.secret.service.SortService;
import com.secret.service.UserService;
import com.secret.util.FinalStatus;

public class OracleTest {
	 
	public static void main(String[] args) {
		
		GoodsInfoService goodsInfoService;
		SortService   sortService;
	    HotelService    hotelService;
	    UserService   userService;
		GoodsImageService goodsImageService;
	    GoodsInfoPojo  goodsPojo ;
	    SortPojo    sortPojo;
	    HotelPojo  hotelPojo;
	    GoodsImagePojo   goodsImagePojo;
	    GoodsOrderService goodsOrderService;
	 	ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml"); 
	 	  goodsOrderService = (GoodsOrderService) applicationContext.getBean("goodsOrderService");
	 	 hotelService = (HotelService) applicationContext.getBean("hotelService");
	 	goodsInfoService = (GoodsInfoService) applicationContext.getBean("goodsInfoService");
	  Map<List<HotelPojo>, List<Double>> distancesize = hotelService.distancesize(23.00d, 127.00d, 2);
	 	 
	 	  
	 	/* GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
	 	 d.add(Calendar.DAY_OF_MONTH, -2);
	 	 // select count(*) from GOODS_ORDER  where substr(to_char(ORDER_TIME,'yyyy-mm-dd'),1,10)='2013-10-22' ;
	 	 String wherejpql  = " o.goodsInfoPojo.goodsId=? and o.tradeStatus in (?,?,?)  and substr(to_char(o.orderTime,'yyyy-mm-dd'),1,10)=? ";
		Object[] queryParams = {2, FinalStatus.WAIT_BUYER_CONFIRM_GOODS,FinalStatus.TRADE_FINISHED,FinalStatus.USER_ASSESS_SUCCESS , new SimpleDateFormat("yyyy-MM-dd").format(d.getTime()) };
			List<GoodsOrderPojo> findESCData = goodsOrderService.findESCData(wherejpql, queryParams, null);
	 	System.out.println("findESCData="+findESCData.size());*/
	 	
	 /*	BasicDataSource databean = (BasicDataSource)applicationContext.getBean("dataSource");   
	 	String driverClassName = databean.getDriverClassName();
	 	System.out.println("driverClassName="+driverClassName);*/
	 	
	 	
	 	
	 	
	 	/*
		  userService = (UserService) applicationContext.getBean("userService");
		  hotelService=(HotelService)applicationContext.getBean("hotelService");
		  sortService=(SortService)applicationContext.getBean("sortService");
		  goodsInfoService=(GoodsInfoService)applicationContext.getBean("goodsInfoService");
		
		 Map<List<HotelPojo>, List<Double>> distancesize = hotelService.distancesize(29.0, 127.1,10);
		 Set<List<HotelPojo>> keySet = distancesize.keySet();
		 for (List<HotelPojo> list : keySet) {
			for (HotelPojo hotelPojo2 : list) {
				System.out.println("hotelPojo2="+hotelPojo2.getHotelProvince());
				List<Double> doub = distancesize.get(list);
				for (Double double1 : doub) {
					System.out.println("double1="+double1);
				}
			}
		}*/
		 
	/*	//保存饭店信息
		List<HotelPojo> hotellist = hotelService.findProperty("hotelId", 1);
		goodsPojo  = new GoodsInfoPojo();
		goodsPojo.setHotelPojo(hotellist.get(0));
		goodsPojo.setGoodsName("红烧鱼头");
		//保存商品类别
		List<SortPojo> sortlist=sortService.findProperty("sortId", 1);
		goodsPojo.setSortId(sortlist.get(0).getSortId());			
		goodsPojo.setSortPojo(sortlist.get(0));
		goodsPojo.setGoodsTime(new Timestamp(new Date().getTime()));
		 goodsPojo.setUserId(2);
		 goodsPojo.setGoodsPrice(1.02d);
		 
		 goodsImagePojo = new GoodsImagePojo();
		 goodsImagePojo.setGimageTime(new Timestamp(new Date().getTime()));
		 goodsImagePojo.setGoodsInfoPojo(goodsPojo);
		 goodsImagePojo.setGimageImage("imagetest.jpg");
		 goodsPojo.setGoodsImagePojo(goodsImagePojo);
		 goodsInfoService.merge(goodsPojo);
		 System.out.println("成功");*/
		
	}

	 

}
