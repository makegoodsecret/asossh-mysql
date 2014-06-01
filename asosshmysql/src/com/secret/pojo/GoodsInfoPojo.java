package com.secret.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * GoodsInfoPojo entity. @author MyEclipse Persistence Tools
 */

public class GoodsInfoPojo implements java.io.Serializable {

	// Fields

	private Integer goodsId;
	private String goodsName;
	private String goodsDis;
	private Integer sortId;
	private Double goodsPrice;
	private Timestamp goodsTime;
	private Integer userId ;
	private GoodsImagePojo goodsImagePojo;
	private SortPojo sortPojo ;
	private HotelPojo hotelPojo;
	
	private Set<MealPojo> mealPojo= new HashSet<MealPojo>();
	private Set<GoodsOrderPojo>  goodsOrderPojo = new HashSet<GoodsOrderPojo>();
	// Constructors

	/** default constructor */
	public GoodsInfoPojo() {
	}
	public GoodsInfoPojo(Integer goodsId, String goodsName, String goodsDis,
			Integer sortId, Double goodsPrice, Timestamp goodsTime,
			Integer userId, GoodsImagePojo goodsImagePojo, SortPojo sortPojo,
			HotelPojo hotelPojo, Set<MealPojo> mealPojo,
			Set<GoodsOrderPojo> goodsOrderPojo) {
		this.goodsId = goodsId;
		this.goodsName = goodsName;
		this.goodsDis = goodsDis;
		this.sortId = sortId;
		this.goodsPrice = goodsPrice;
		this.goodsTime = goodsTime;
		this.userId = userId;
		this.goodsImagePojo = goodsImagePojo;
		this.sortPojo = sortPojo;
		this.hotelPojo = hotelPojo;
		this.mealPojo = mealPojo;
		this.goodsOrderPojo = goodsOrderPojo;
	}
	 
	public Integer getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getGoodsDis() {
		return goodsDis;
	}
	public void setGoodsDis(String goodsDis) {
		this.goodsDis = goodsDis;
	}
	public Integer getSortId() {
		return sortId;
	}
	public void setSortId(Integer sortId) {
		this.sortId = sortId;
	}
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public Timestamp getGoodsTime() {
		return goodsTime;
	}
	public void setGoodsTime(Timestamp goodsTime) {
		this.goodsTime = goodsTime;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public GoodsImagePojo getGoodsImagePojo() {
		return goodsImagePojo;
	}
	public void setGoodsImagePojo(GoodsImagePojo goodsImagePojo) {
		this.goodsImagePojo = goodsImagePojo;
	}
	public SortPojo getSortPojo() {
		return sortPojo;
	}
	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public Set<MealPojo> getMealPojo() {
		return mealPojo;
	}
	public void setMealPojo(Set<MealPojo> mealPojo) {
		this.mealPojo = mealPojo;
	}
	public Set<GoodsOrderPojo> getGoodsOrderPojo() {
		return goodsOrderPojo;
	}
	public void setGoodsOrderPojo(Set<GoodsOrderPojo> goodsOrderPojo) {
		this.goodsOrderPojo = goodsOrderPojo;
	}
	

}