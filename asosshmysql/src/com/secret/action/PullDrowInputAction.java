package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.secret.ipAddress.ArrayProvinceCity;
import com.secret.page.base.PageView;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.service.GoodsInfoService;
import com.secret.service.GoodsOrderService;
import com.secret.service.HotelService;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class PullDrowInputAction extends  BaseAction {
	 
	private GoodsInfoService   goodsInfoService;
	private GoodsOrderService  goodsOrderService ;
	private HotelService    hotelService;
	
	private String   province  ;
	private String 	 city  ;
	private HotelPojo  hotelPojo ;
	private List<HotelPojo>  hotelPojoList;
	private PageView<HotelPojo>  pageView;
	private String province_city  ;
	private HttpServletResponse response = ResponseSetCharacterEncoding.getInstance();
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void pullDrowInput(){
		try {
			//System.out.println("province="+province+"city==="+city);
			PrintWriter   out  = response.getWriter();
			Map   map  = new HashMap();
			map.put("hotelTopInfo", getTopHotels(province,city));
			JSONObject   json  = JSONObject.fromObject(map);
			//System.out.println("json.toString()==="+json.toString());
			out.println(json.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//得到饭店
		private String getTopHotels(String  province,String  city) {
			LinkedHashMap<HotelPojo, Map<String, Integer>> linkedHashMap = goodsOrderService.orderHotel(province, city);
			Set<HotelPojo> keySet = linkedHashMap.keySet();
			StringBuffer   hotelinfo = new StringBuffer();
			int i  =0; 
			for (HotelPojo hotelPojo : keySet) {
				Map<String, Integer> map = linkedHashMap.get(hotelPojo);
				Set<String> keySet2 = map.keySet();
				for (String string : keySet2) {
					Integer integer = map.get(string);
					province_city = string;
					if (i++==0) {
						hotelinfo.append("<li class='hwtitle' >每日最火饭店TOP10：范围:<b id='province_city'>"+province_city+"</b></li>");
					}
						hotelinfo.append("<li  ><a  href='asossh/hotel!mainhotel.action?hotelPojo.hotelId="
						+hotelPojo.getHotelId()+"'><h1>"
						+hotelPojo.getHotelName()+"</h1><span>总销量："+integer+"</span></a></li>");
				}
			}
			return hotelinfo.toString();
		}
	//查询饭店或美食
	public String seekGoodorHotel(){
		pageView=new PageView<HotelPojo>(10, 0);
		String wherejpql="o.hotelName like ? ";
		Object[] queryParams={"%"+hotelPojo.getHotelName()+"%"};
		pageView.setQueryResult(hotelService.getScrollData(pageView.getFirstResult(), 10, wherejpql, queryParams));
		hotelPojoList=hotelService.findAll();
		return "seekGoodorHotel";
	}
	// 点击上下页按钮
	public String pageing() {
		pageView=new PageView<HotelPojo>(10, super.getPage());
		String wherejpql="o.hotelName like ? ";
		Object[] queryParams={"%"+hotelPojo.getHotelName()+"%"};
		pageView.setQueryResult(hotelService.getScrollData(pageView.getFirstResult(), 10, wherejpql, queryParams));
		hotelPojoList=hotelService.findAll();
		return "seekGoodorHotel";
	}

	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}
	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}
	public HotelService getHotelService() {
		return hotelService;
	}
	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public List<HotelPojo> getHotelPojoList() {
		return hotelPojoList;
	}
	public void setHotelPojoList(List<HotelPojo> hotelPojoList) {
		this.hotelPojoList = hotelPojoList;
	}
	public PageView<HotelPojo> getPageView() {
		return pageView;
	}
	public void setPageView(PageView<HotelPojo> pageView) {
		this.pageView = pageView;
	}
	public String getProvince_city() {
		return province_city;
	}
	public void setProvince_city(String province_city) {
		this.province_city = province_city;
	}
	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}
	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}
	
}
