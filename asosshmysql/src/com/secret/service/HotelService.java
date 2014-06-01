package com.secret.service;


import java.util.List;
import java.util.Map;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.HotelPojo;

public interface HotelService extends BaseDao<HotelPojo> {
	/**
	 * 根据gps定位用户的信息查处附件的饭店
	 * @param hotelLat   用户所在地的纬度
	 * @param hotelLng   用户所在地的经度
	 * @return
	 */
	Map<List<HotelPojo>,List<Double>> distancesize(Double hotelLat,Double hotelLng,int size);
}
