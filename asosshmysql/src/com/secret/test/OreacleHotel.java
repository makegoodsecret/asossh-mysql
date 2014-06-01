package com.secret.test;

import java.util.List;
import java.util.Set;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.service.HotelService;


public class OreacleHotel {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		 HotelService hotelService = (HotelService) applicationContext.getBean("hotelService",HotelService.class);
		 List<HotelPojo> findAll = hotelService.findAll();
		 for (HotelPojo hotelPojo : findAll) {
			 Set<MealPojo> mealPojo = hotelPojo.getMealPojo();
			 System.out.println("mealPojo.size()="+mealPojo.size());
			 for (MealPojo mealPojo2 : mealPojo) {
				 Set<GoodsInfoPojo> goodsInfoPojo = mealPojo2.getGoodsInfoPojo();
				 System.out.println("goodsInfoPojo.size()="+goodsInfoPojo.size());
				 for (GoodsInfoPojo goodsInfoPojo2 : goodsInfoPojo) {
					System.out.println("goodsInfoPojo2.getGoodsName()="+goodsInfoPojo2.getGoodsName());
				}
			}
			 
		}
	}

}
