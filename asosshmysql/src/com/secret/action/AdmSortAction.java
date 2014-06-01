package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.HotelPojo;
import com.secret.pojo.SortPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.AdsService;
import com.secret.service.HotelService;
import com.secret.service.SortService;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
//美食的管理
public class AdmSortAction extends BaseAction{
	private AdsService  adsService ;
	private SortService   sortService;
	private SortPojo   sortPojo  ;
	private List<SortPojo> sortlist ;
	private HotelService  hotelService ;
	private HotelPojo  hotelPojo;
	
	//美食的种类
	public String  findAllSort(){
		UserPojo userPojo = (UserPojo) ServletActionContext.getRequest().getSession().getAttribute("user");
		 if (userPojo.getPower().equals("1")) {  //管理员
			sortlist= sortService.findAll();  //查找出所有的品牌
		}else if (userPojo.getPower().equals("0")&&userPojo.getEmailstatu().equals("2")) { //饭店管理员
			sortlist = sortService.findProperty("hotelPojo.hotelId", hotelPojo.getHotelId());
		} 
		 
		 return "admSort";
	}
	//添加美食的种类
	 public String addSort(){
		 UserPojo userPojo = (UserPojo) ServletActionContext.getRequest().getSession().getAttribute("user");
		 HotelPojo hotelPojosort ;
		 if (userPojo.getPower().equals("1")) {  //管理员
			 hotelPojosort = hotelService.findProperty("hotelName", hotelPojo.getHotelName()).get(0);
		 }else{
			 hotelPojosort = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		 }
		sortPojo.setHotelPojo(hotelPojosort);
		 sortService.save(sortPojo);
		 findAllSort();
		 return "admSort";
	 }
	 //修改
	 public String   updateSort(){
		 SortPojo updatesortPojo = sortService.findProperty("sortId", sortPojo.getSortId()).get(0);
		 updatesortPojo.setSortName(sortPojo.getSortName());
		 boolean update = sortService.update(updatesortPojo);
		 findAllSort();
		 return  "admSort";
	 }
	 //参看所属饭店的信息
	 public void showhotel(){
		 SortPojo  sort =sortService.findProperty("sortId", sortPojo.getSortId()).get(0);
		 HotelPojo sorthotelPojo = sort.getHotelPojo();
		 Map<String, String>  map  = new HashMap<String, String>();
		 map.put("hotelId", sorthotelPojo.getHotelId()+"");
		 map.put("hotelName", sorthotelPojo.getHotelName());
		 map.put("hotelAds", sorthotelPojo.getHotelAds());
		 map.put("hotelCellphone", sorthotelPojo.getHotelCellphone());
		 map.put("hotelCertificate", sorthotelPojo.getHotelCertificate());
		 map.put("hotelCity", sorthotelPojo.getHotelCity());
		 map.put("hotelCounty", sorthotelPojo.getHotelCounty());
		 map.put("hotelLogo", sorthotelPojo.getHotelLogo());
		 map.put("hotelOtherAddress", sorthotelPojo.getHotelOtherAddress());
		 map.put("hotelOtherphone", sorthotelPojo.getHotelOtherphone());
		 map.put("hotelPhonecode", sorthotelPojo.getHotelPhonecode());
		 map.put("hotelPhonesection", sorthotelPojo.getHotelPhonesection());
		 map.put("hotelProvince", sorthotelPojo.getHotelProvince());
		 
		 map.put("hotelShopAmEnd", sorthotelPojo.getHotelShopAmEnd().toString());
		 map.put("hotelShopAmStart", sorthotelPojo.getHotelShopAmStart().toString());
		 map.put("hotelShopPmEnd", sorthotelPojo.getHotelShopPmEnd().toString());
		 map.put("hotelShopPmStart", sorthotelPojo.getHotelShopPmStart().toString());
		 
		 map.put("hotelStatus", sorthotelPojo.getHotelStatus());
		 map.put("hotelTime", sorthotelPojo.getHotelTime().toString());
		 map.put("username", sorthotelPojo.getUserPojo().getUsername());
		 JSONObject  jsonObject = JSONObject.fromObject(map);
		 HttpServletResponse response =   ResponseSetCharacterEncoding.getInstance();
		 try {
			PrintWriter out = response.getWriter();
			out.print(jsonObject.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	 
	 }
	public AdsService getAdsService() {
		return adsService;
	}
	public void setAdsService(AdsService adsService) {
		this.adsService = adsService;
	}

	public List<SortPojo> getSortlist() {
		return sortlist;
	}
	public void setSortlist(List<SortPojo> sortlist) {
		this.sortlist = sortlist;
	}
	public SortService getSortService() {
		return sortService;
	}
	public void setSortService(SortService sortService) {
		this.sortService = sortService;
	}
	public SortPojo getSortPojo() {
		return sortPojo;
	}
	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}
	public HotelService getHotelService() {
		return hotelService;
	}
	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	 
	
}
