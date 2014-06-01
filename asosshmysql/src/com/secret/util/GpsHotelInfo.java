package com.secret.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.secret.pojo.HotelPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class GpsHotelInfo {
	/*
	 * 重新拼凑需要的地图信息 {title:"奥亚酒店",content:"北苑路169号",
	 * point:"122.422792|30.009471",isOpen:1,
	 * icon:{w:21,h:21,l:115,t:46,x:1,lb:10}},
	 */
	public List<Map<String,Object>> getGpsBaiduMapHotelInfo(List<HotelPojo>  hotelList){
		List<Map<String,Object>>  maplist = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < hotelList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title",
					"<a  href='asossh/hotel!mainhotel.action?hotelPojo.hotelId="
							+ hotelList.get(i).getHotelId()+ "' titel='"+hotelList.get(i).getHotelName()+"'"
							+" class='titleclass' >"
							+ hotelList.get(i).getHotelName()+ "</a>");
			map.put("content", hotelList.get(i).getHotelProvince()+hotelList.get(i).getHotelCity()+hotelList.get(i).getHotelCounty()+hotelList.get(i).getHotelOtherAddress());
			map.put("point", hotelList.get(i).getHotelLng() + "|"
					+ hotelList.get(i).getHotelLat());
			map.put("hotelnumber", hotelList.size());
			map.put("hotemName", 
					"<div style='border-radius:10px 10px 10px 10px; border: 1px solid #aa0000; font-family:仿宋;font-size: 18px;'>"
					+hotelList.get(i).getHotelName()+"</div>");
			//System.out.println("title==" + map.get("title"));
			if (i == 0) {
				map.put("isOpen", "1");
			} else {
				map.put("isOpen", "0");
			}
			map.put("icon", "{w:21,h:21,l:115,t:46,x:1,lb:10}");
			maplist.add(map);
		}
		return maplist;
	}
	/**
	 * 处理重新拼凑饭店在tab(地图右侧导航栏)上的信息
	 * @param list    距离
	 * @return
	 */
	public List<Map<String, Object>> getGpsBaiduMapHotelTabInfo(List<HotelPojo>  hotelList,List<Double> list) {
		List<Map<String,Object>>  maplist = new ArrayList<Map<String,Object>>();
		for (int i = 0; i < hotelList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("maptablib", strmaptablib(hotelList.get(i),i));
			map.put("maptabdistance", strmaptabdistance(hotelList.get(i),list.get(i)));
			maplist.add(map);
		}
		return maplist;
	}
	/**
	 * 饭店导航栏div
	 * @param hotelPojo
	 * @param double1
	 * @param i
	 * @return
	 */
	 private String strmaptabdistance(HotelPojo hotelPojo, Double double1) {
		 StringBuffer  stringBuffer  = new StringBuffer();
		 stringBuffer.append("<div><div class='class_hotelName'><a title='点击进入"+hotelPojo.getHotelName()+"' href='asossh/hotel!mainhotel.action?hotelPojo.hotelId="+hotelPojo.getHotelId()+"'>"+hotelPojo.getHotelName()+"</a></div>");
		 stringBuffer.append("<div style='margin-top: 3px;'><a title='点击进入"+hotelPojo.getHotelName()+"' href='asossh/hotel!mainhotel.action?hotelPojo.hotelId="+hotelPojo.getHotelId()+"'>");
		 stringBuffer.append("<img src='photo/"+hotelPojo.getHotelLogo()+"' alt='"+hotelPojo.getHotelName()+"' width='170px;'  height='130px;'/></a></div>");
		 stringBuffer.append("<div style='margin-top: 3px;'>简介:"+hotelPojo.getHotelAds()+"</div><div style='margin-top: 3px;'>饭店等级:");
		 if (hotelPojo.getHotelLevel()<0.2) {
			 stringBuffer.append("一星级");
		}else if(hotelPojo.getHotelLevel()<0.3) {
			 stringBuffer.append("二星级");
		}else if(hotelPojo.getHotelLevel()<0.3) {
			 stringBuffer.append("三星级");
		}else if(hotelPojo.getHotelLevel()<0.3) {
			 stringBuffer.append("四星级");
		}else{
			 stringBuffer.append("五星级");
		}
		 stringBuffer.append("</div><div style='margin-top: 3px;'> 营业时间: <br/><font style='font-size: 13px;'>上午:"+hotelPojo.getHotelShopAmStart()+"-"+hotelPojo.getHotelShopAmEnd()+"<br/>下午:"+hotelPojo.getHotelShopPmStart()+"-"+hotelPojo.getHotelShopPmEnd()+"</font></div>");
		 stringBuffer.append("<div style='margin-top: 3px;'>联系方式:<font style='font-size: 12px;'>"+hotelPojo.getHotelCellphone()+"<br/>");
		
		 if (hotelPojo.getHotelPhonecode()!=null) {
			stringBuffer.append(hotelPojo.getHotelPhonesection()+"-"+hotelPojo.getHotelPhonecode()+"-"+hotelPojo.getHotelOtherphone()+"</font></div>");
		}
		stringBuffer.append("<div style='margin-top: 3px;'>地址:"+hotelPojo.getHotelProvince()+hotelPojo.getHotelCity()+hotelPojo.getHotelCounty()+hotelPojo.getHotelOtherAddress()+"</div>");
		String distence;
		if (double1<1) { //距离小于一千米
			Double s=double1*1000;
			distence= s.intValue()+"m";
		}else{
			distence=double1+"km";
		}
		stringBuffer.append("<div style='margin-top: 3px;'>距离:"+distence+"</div></div>");
		 return stringBuffer.toString();
	}
	 /**
	  * 饭店导航栏lib
	  * @param hotelPojo
	  * @param i
	  * @return
	  */
	private String strmaptablib(HotelPojo hotelPojo,int i) {
		String maptablib ="";
		if (i==0) {
			maptablib="<li class='curr'>"+hotelPojo.getHotelName()+"</li>";
		}else{
			maptablib="<li >"+hotelPojo.getHotelName()+"</li>";
		}
		return maptablib;
	} 
	  public static void main(String[] args) {
		  Double double1=0.2022;
		  String distence;
		  if (double1<1) { //距离小于一千米
				Double s=double1*1000;
				distence= s.intValue()+"m";
			}else{
				distence= double1+"";
			}
		  System.out.println(distence);
	}
}
