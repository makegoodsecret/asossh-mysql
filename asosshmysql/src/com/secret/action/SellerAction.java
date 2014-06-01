package com.secret.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsAssessPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsAssessService;
import com.secret.service.GoodsOrderService;
import com.secret.service.HotelService;
import com.secret.util.DataUtil;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class SellerAction {
		
	private HotelService   hotelService;
	private HotelPojo   hotelPojo ;
	private List<HotelPojo> hotelPojoList;
	private GoodsOrderService   goodsOrderService;
	private GoodsOrderPojo  goodsOrderPojo;
	private List<GoodsOrderPojo> goodsOrderList;
	private GoodsAssessService   goodsAssessService;
	private List<GoodsAssessPojo>  goodsAssessList;
	
	private Map<String, Map<String, List<GoodsOrderPojo>>> goodsOrdermap ;
	
	// 进入卖家页面
	public String sellermain(){
		UserPojo userPojo = (UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
		if (userPojo.getEmailstatu().equals("2")) {
			  hotelPojoList = hotelService.findProperty("userPojo", userPojo);
		}else if (userPojo.getPower().equals("1")) {//管理员
			hotelPojoList = hotelService.findAll();
		}
		return "sellermain";
	}
	//卖家进入饭店
	public String  sellerinhotel(){
		  hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		  goodsOrderList = goodsOrderService.findProperty("hotelPojo", hotelPojo);
		  goodsOrdermap=DataUtil.createordermap(goodsOrderList);
		  //卖家收到的评价
		String wherejpql="o.hotelPojo=?";
		Object[] queryParams={hotelPojo};
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("assTime", "desc");
		goodsAssessList = goodsAssessService.findESCData(wherejpql, queryParams, orderby);
		return "sellerinhotel";
	}
	//发货
	public String shipments(){
		goodsOrderPojo= goodsOrderService.findProperty("orderNumber", goodsOrderPojo.getOrderNumber()).get(0);
		return "shipments";
	}
	//对订单数据处理
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



	public List<HotelPojo> getHotelPojoList() {
		return hotelPojoList;
	}



	public void setHotelPojoList(List<HotelPojo> hotelPojoList) {
		this.hotelPojoList = hotelPojoList;
	}



	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}



	public List<GoodsOrderPojo> getGoodsOrderList() {
		return goodsOrderList;
	}
	public void setGoodsOrderList(List<GoodsOrderPojo> goodsOrderList) {
		this.goodsOrderList = goodsOrderList;
	}
	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}
	public Map<String, Map<String, List<GoodsOrderPojo>>> getGoodsOrdermap() {
		return goodsOrdermap;
	}
	public void setGoodsOrdermap(
			Map<String, Map<String, List<GoodsOrderPojo>>> goodsOrdermap) {
		this.goodsOrdermap = goodsOrdermap;
	}
	public GoodsOrderPojo getGoodsOrderPojo() {
		return goodsOrderPojo;
	}
	public void setGoodsOrderPojo(GoodsOrderPojo goodsOrderPojo) {
		this.goodsOrderPojo = goodsOrderPojo;
	}
	public GoodsAssessService getGoodsAssessService() {
		return goodsAssessService;
	}
	public void setGoodsAssessService(GoodsAssessService goodsAssessService) {
		this.goodsAssessService = goodsAssessService;
	}
	public List<GoodsAssessPojo> getGoodsAssessList() {
		return goodsAssessList;
	}
	public void setGoodsAssessList(List<GoodsAssessPojo> goodsAssessList) {
		this.goodsAssessList = goodsAssessList;
	}
	
	
	
	
	
}
