package com.secret.service;



import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;

public interface GoodsOrderService extends BaseDao<GoodsOrderPojo> {
	 /** 统计美食销量 */
	List<Object> getGoodsSales(int goodId , int size);
	 /** 统计套餐销量 */
	List<Object> getMealdsSales(int mealId , int size);
	 /** 统计系列销量 */
	List<Object> getSortSales(int sortId , int size);
	 /**输入框统计附近饭店的销量*/
	 LinkedHashMap<HotelPojo, Map<String, Integer>>  orderHotel(String province,String city);
	 
	 
}
