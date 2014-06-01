package com.secret.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * MealPojo entity. @author MyEclipse Persistence Tools
 */

public class MealPojo implements java.io.Serializable {

	// Fields

	private Integer mealId;
	private String mealName;
	private Integer hotelId;
	private Double mealPrice;
	private String mealStatu;
	private Timestamp mealTime;
	private HotelPojo  hotelPojo;
	// Constructors
	private Set<GoodsInfoPojo> goodsInfoPojo= new HashSet<GoodsInfoPojo>();
	private Set<GoodsOrderPojo>  orderPojos  = new HashSet<GoodsOrderPojo>();
	/** default constructor */
	public MealPojo() {
	}
	public MealPojo(Integer mealId, String mealName, Integer hotelId,
			Double mealPrice, String mealStatu, Timestamp mealTime,
			HotelPojo hotelPojo, Set<GoodsInfoPojo> goodsInfoPojo,
			Set<GoodsOrderPojo> orderPojos) {
		this.mealId = mealId;
		this.mealName = mealName;
		this.hotelId = hotelId;
		this.mealPrice = mealPrice;
		this.mealStatu = mealStatu;
		this.mealTime = mealTime;
		this.hotelPojo = hotelPojo;
		this.goodsInfoPojo = goodsInfoPojo;
		this.orderPojos = orderPojos;
	}
	 
	public Integer getMealId() {
		return mealId;
	}
	public void setMealId(Integer mealId) {
		this.mealId = mealId;
	}
	public String getMealName() {
		return mealName;
	}
	public void setMealName(String mealName) {
		this.mealName = mealName;
	}
	public Integer getHotelId() {
		return hotelId;
	}
	public void setHotelId(Integer hotelId) {
		this.hotelId = hotelId;
	}
	public Double getMealPrice() {
		return mealPrice;
	}
	public void setMealPrice(Double mealPrice) {
		this.mealPrice = mealPrice;
	}
	public String getMealStatu() {
		return mealStatu;
	}
	public void setMealStatu(String mealStatu) {
		this.mealStatu = mealStatu;
	}
	public Timestamp getMealTime() {
		return mealTime;
	}
	public void setMealTime(Timestamp mealTime) {
		this.mealTime = mealTime;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public Set<GoodsInfoPojo> getGoodsInfoPojo() {
		return goodsInfoPojo;
	}
	public void setGoodsInfoPojo(Set<GoodsInfoPojo> goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}
	public Set<GoodsOrderPojo> getOrderPojos() {
		return orderPojos;
	}
	public void setOrderPojos(Set<GoodsOrderPojo> orderPojos) {
		this.orderPojos = orderPojos;
	}
	
}