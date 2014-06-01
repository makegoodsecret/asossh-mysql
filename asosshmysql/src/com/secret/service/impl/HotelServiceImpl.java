package com.secret.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.HotelPojo;
import com.secret.service.HotelService;

 

public class HotelServiceImpl extends BaseDaoImpl<HotelPojo> implements HotelService {

	@SuppressWarnings({"unchecked"})
	@Override
	public Map<List<HotelPojo>,List<Double>> distancesize(Double hotelLat, Double hotelLng,int size) {
		Map<List<HotelPojo>,List<Double>> map = new HashMap<List<HotelPojo>, List<Double>>();
		String sqlhotel="select getdistance("+hotelLat+","+hotelLng+",h.hotelLat ,h.hotelLng)  ,h "
	                +"  from HotelPojo h   order by  getdistance("+hotelLat+","+hotelLng+",h.hotelLat ,h.hotelLng) asc";	
		Query query = super.getSession().createQuery(sqlhotel);
		query.setFirstResult(0);
		query.setMaxResults(size);
		 List<Object> list = query.list();
		 List<HotelPojo> hotelList = new ArrayList<HotelPojo>();
		 List<Double>  distancesizelist = new ArrayList<Double>();
		 for (Object object : list) {
			 Object[] o= (Object[]) object; 
			 distancesizelist.add(Double.parseDouble((String) o[0]));
			 hotelList.add((HotelPojo) o[1]);
		}
		 map.put(hotelList, distancesizelist);
		 return map;
	}

	
	 

	
	
	
}

 