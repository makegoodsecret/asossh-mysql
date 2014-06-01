package com.secret.pojo;

import java.sql.Timestamp;

/**
 * GoodsAssessPojo entity. @author MyEclipse Persistence Tools
 */

public class GoodsAssessPojo implements java.io.Serializable {

	// Fields

	private Integer assId;
/*	private Integer goodsId;
	private Integer mealId;
	private Integer hotelId;
	private Integer userId;*/
	private Integer assStars;
	private String assDis;
	private Timestamp assTime;
	private GoodsInfoPojo  goodsInfoPojo;
	private MealPojo  mealPojo ;
	private String   assIp    ;
	private HotelPojo  hotelPojo;
	private UserPojo  userPojo;
	private GoodsOrderPojo  goodsOrderPojo;
	// Constructors

	/** default constructor */
	public GoodsAssessPojo() {
	}
	 


	public GoodsAssessPojo(Integer assId, Integer assStars, String assDis,
			Timestamp assTime, GoodsInfoPojo goodsInfoPojo, MealPojo mealPojo,
			String assIp, HotelPojo hotelPojo, UserPojo userPojo,
			GoodsOrderPojo goodsOrderPojo) {
		this.assId = assId;
		this.assStars = assStars;
		this.assDis = assDis;
		this.assTime = assTime;
		this.goodsInfoPojo = goodsInfoPojo;
		this.mealPojo = mealPojo;
		this.assIp = assIp;
		this.hotelPojo = hotelPojo;
		this.userPojo = userPojo;
		this.goodsOrderPojo = goodsOrderPojo;
	}



	public GoodsOrderPojo getGoodsOrderPojo() {
		return goodsOrderPojo;
	}



	public void setGoodsOrderPojo(GoodsOrderPojo goodsOrderPojo) {
		this.goodsOrderPojo = goodsOrderPojo;
	}



	public String getAssIp() {
		return assIp;
	}






	public void setAssIp(String assIp) {
		this.assIp = assIp;
	}






	public Integer getAssStars() {
		return assStars;
	}




	public void setAssStars(Integer assStars) {
		this.assStars = assStars;
	}




	public Integer getAssId() {
		return assId;
	}

	public void setAssId(Integer assId) {
		this.assId = assId;
	}

	public String getAssDis() {
		return assDis;
	}

	public void setAssDis(String assDis) {
		this.assDis = assDis;
	}

	public Timestamp getAssTime() {
		return assTime;
	}

	public void setAssTime(Timestamp assTime) {
		this.assTime = assTime;
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

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}
  

}