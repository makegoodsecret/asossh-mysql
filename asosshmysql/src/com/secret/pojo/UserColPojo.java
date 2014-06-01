package com.secret.pojo;

import java.sql.Timestamp;

/**
 * UserColPojo entity. @author MyEclipse Persistence Tools
 */

public class UserColPojo implements java.io.Serializable {

	// Fields

	private Integer colId;
	/*private Integer goodsId;
	private Integer mealId;
	private Integer hotelId;
	private Integer userId;*/
	private Timestamp colTime;
	
	private UserPojo  userPojo;
	private GoodsInfoPojo goodsInfoPojo;
	private MealPojo  mealPojo ;
	private HotelPojo  hotelPojo;
	// Constructors

	/** default constructor */
	public UserColPojo() {
	}

	 

	public UserColPojo(Integer colId, Timestamp colTime, UserPojo userPojo,
			GoodsInfoPojo goodsInfoPojo, MealPojo mealPojo, HotelPojo hotelPojo) {
		super();
		this.colId = colId;
		this.colTime = colTime;
		this.userPojo = userPojo;
		this.goodsInfoPojo = goodsInfoPojo;
		this.mealPojo = mealPojo;
		this.hotelPojo = hotelPojo;
	}



	// Property accessors

 



	public Integer getColId() {
		return this.colId;
	}

	public void setColId(Integer colId) {
		this.colId = colId;
	}

	

	public UserPojo getUserPojo() {
		return userPojo;
	}



	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}



	public GoodsInfoPojo getGoodsInfoPojo() {
		return goodsInfoPojo;
	}



	public void setGoodsInfoPojo(GoodsInfoPojo goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}



	public MealPojo getMealPojo() {
		return mealPojo;
	}



	public void setMealPojo(MealPojo mealPojo) {
		this.mealPojo = mealPojo;
	}



	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}



	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}



	public Timestamp getColTime() {
		return this.colTime;
	}

	public void setColTime(Timestamp colTime) {
		this.colTime = colTime;
	}

}