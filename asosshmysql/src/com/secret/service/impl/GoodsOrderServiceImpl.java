package com.secret.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.service.GoodsOrderService;
import com.secret.util.FinalStatus;

 

@SuppressWarnings("unchecked")
public class GoodsOrderServiceImpl extends BaseDaoImpl<GoodsOrderPojo> implements GoodsOrderService {
	/*查询某一美食的销量 */
	@Override
	public List<Object> getGoodsSales(int goodId , int size) {
		  String  hql ="select  sum(o.goodsNumber), o.orderTime ,mydatebetween(o.orderTime)  "
						+" from  GoodsOrderPojo o where o.goodsInfoPojo.goodsId =? and o.tradeStatus in (?,?,?) "
						+" and  mydatebetween(o.orderTime) < "+size
					    +" group by   mydatebetween(o.orderTime)  , o.orderTime  ";
		  return super.getHibernateTemplate().
				  find(hql, new Object[]{goodId, FinalStatus.WAIT_BUYER_CONFIRM_GOODS,
				  						FinalStatus.TRADE_FINISHED,
				  						FinalStatus.USER_ASSESS_SUCCESS  });
	}
	@Override
	public List<Object> getMealdsSales(int mealId, int size) {
		  String  hql ="select  sum(o.goodsNumber), o.orderTime ,mydatebetween(o.orderTime)   "
					+" from  GoodsOrderPojo o where o.mealPojo.mealId =? and o.tradeStatus in (?,?,?) "
					+" and  mydatebetween(o.orderTime) < "+size
				    +" group by   mydatebetween(o.orderTime)  ,  o.orderTime  ";
	  return super.getHibernateTemplate().
			  find(hql, new Object[]{mealId, FinalStatus.WAIT_BUYER_CONFIRM_GOODS,
			  						FinalStatus.TRADE_FINISHED,
			  						FinalStatus.USER_ASSESS_SUCCESS  });
	}
	@Override
	public List<Object> getSortSales(int sortId, int size) {
		  String  hql ="select  sum(o.goodsNumber), o.orderTime ,mydatebetween(o.orderTime)   "
					+" from  GoodsOrderPojo o where o.goodsInfoPojo.sortPojo.sortId=? and o.tradeStatus in (?,?,?) "
					+" and  mydatebetween(o.orderTime) < "+size
				    +" group by   mydatebetween(o.orderTime)  , o.orderTime  ";
	  return super.getHibernateTemplate().
			  find(hql, new Object[]{sortId, FinalStatus.WAIT_BUYER_CONFIRM_GOODS,
			  						FinalStatus.TRADE_FINISHED,
			  						FinalStatus.USER_ASSESS_SUCCESS  });
	}
	@Override
	public LinkedHashMap<HotelPojo, Map<String, Integer>> orderHotel(String province, String city) {
		LinkedHashMap<HotelPojo, Map<String, Integer>> map = new LinkedHashMap<HotelPojo, Map<String, Integer>>();
		Map<String, Integer> map2 ;
		String  str  = city;
		String  hql  = "select sum(o.goodsNumber) , o.hotelPojo.hotelName ,o.hotelPojo.hotelId   from  GoodsOrderPojo as o  " +
				"	   where o.hotelPojo.hotelCity = ? group by o.hotelPojo.hotelName ,o.hotelPojo.hotelId  order by sum(o.goodsNumber) desc "; 
		Query query = super.getSession().createQuery(hql);
		query.setParameter(0, city);
		if (query.list().size()<11) {
			//全省
		  hql  = "select sum(o.goodsNumber) , o.hotelPojo.hotelName  ,o.hotelPojo.hotelId from  GoodsOrderPojo as o   " +
					"	   where o.hotelPojo.hotelProvince = ? group by o.hotelPojo.hotelName  ,o.hotelPojo.hotelId   order by sum(o.goodsNumber) desc"; 
		  query = super.getSession().createQuery(hql);
		  query.setParameter(0, province);
		  str  = province;
			  if (query.list().size()<11) {
				  //全国
		  str  = "全国";
				  hql  = "select sum(o.goodsNumber) , o.hotelPojo.hotelName  ,o.hotelPojo.hotelId from  GoodsOrderPojo as o   " +
							" group by o.hotelPojo.hotelName ,o.hotelPojo.hotelId  order by sum(o.goodsNumber) desc "; 
				  query = super.getSession().createQuery(hql);
			}
		} 
		query.setFirstResult(0);
		query.setMaxResults(10);
		List list = query.list();
		HotelPojo hotelPojo ;
		for (Object object : list) {
			hotelPojo  = new HotelPojo();
			Object[] obj = (Object[]) object;
			map2 = new HashMap<String, Integer>();
			map2.put(str, ((Long) obj[0]).intValue());
			hotelPojo.setHotelId((Integer) obj[2]);
			hotelPojo.setHotelName((String) obj[1]);
			map.put(hotelPojo, map2);
		}
		return map;
	}
	public static void main(String[] args) {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext(new String[]{"applicationContext.xml"});
		GoodsOrderService goodsOrderService = (GoodsOrderService) applicationContext.getBean("goodsOrderService", GoodsOrderService.class);
		//HotelService hotelService = (HotelService) applicationContext.getBean("hotelService", HotelService.class);
		//hotelService.findProperty("hotelCity", "杭州市"); 
		// LinkedHashMap<HotelPojo, Map<String, Integer>> orderHotel = goodsOrderService.orderHotel("浙江","杭州市" );
		List<Object> list = goodsOrderService.getGoodsSales(1,7);
	   System.out.println(list.size());
	   
	   
	}
}
