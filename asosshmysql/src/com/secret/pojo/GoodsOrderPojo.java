package com.secret.pojo;

import java.sql.Timestamp;

/**
 * GoodsOrderPojo entity. @author MyEclipse Persistence Tools
 */

public class GoodsOrderPojo implements java.io.Serializable {

	// Fields

	private Integer orderId;
	private String orderNumber;
	/*
	 * private Integer userId; private Integer orderAddressId; private Integer
	 * goodsId; private Integer mealId;
	 */
	private Integer goodsNumber;
	private String orderAds;
	private String goodsormealAds;
	private Timestamp orderTime;
	private String tradeStatus;
	private String  alipayTradeNo ;
	private UserPojo userPojo;
	private OrderAddressPojo orderAddress;
	private GoodsInfoPojo goodsInfoPojo;
	private MealPojo mealPojo;
	private HotelPojo hotelPojo;

	// Constructors

	/** default constructor */
	public GoodsOrderPojo() {
	}

	 
	public GoodsOrderPojo(Integer orderId, String orderNumber,
			Integer goodsNumber, String orderAds, String goodsormealAds,
			Timestamp orderTime, String tradeStatus, String alipayTradeNo,
			UserPojo userPojo, OrderAddressPojo orderAddress,
			GoodsInfoPojo goodsInfoPojo, MealPojo mealPojo, HotelPojo hotelPojo) {
		this.orderId = orderId;
		this.orderNumber = orderNumber;
		this.goodsNumber = goodsNumber;
		this.orderAds = orderAds;
		this.goodsormealAds = goodsormealAds;
		this.orderTime = orderTime;
		this.tradeStatus = tradeStatus;
		this.alipayTradeNo = alipayTradeNo;
		this.userPojo = userPojo;
		this.orderAddress = orderAddress;
		this.goodsInfoPojo = goodsInfoPojo;
		this.mealPojo = mealPojo;
		this.hotelPojo = hotelPojo;
	}


	public String getAlipayTradeNo() {
		return alipayTradeNo;
	}


	public void setAlipayTradeNo(String alipayTradeNo) {
		this.alipayTradeNo = alipayTradeNo;
	}


	public String getTradeStatus() {
		return tradeStatus;
	}

	public void setTradeStatus(String tradeStatus) {
		this.tradeStatus = tradeStatus;
	}

	public String getGoodsormealAds() {
		return goodsormealAds;
	}

	public void setGoodsormealAds(String goodsormealAds) {
		this.goodsormealAds = goodsormealAds;
	}

	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}

	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}

	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getOrderNumber() {
		return this.orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public Integer getGoodsNumber() {
		return this.goodsNumber;
	}

	public void setGoodsNumber(Integer goodsNumber) {
		this.goodsNumber = goodsNumber;
	}

	public String getOrderAds() {
		return this.orderAds;
	}

	public void setOrderAds(String orderAds) {
		this.orderAds = orderAds;
	}

	public Timestamp getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(Timestamp orderTime) {
		this.orderTime = orderTime;
	}

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}

	public OrderAddressPojo getOrderAddress() {
		return orderAddress;
	}

	public void setOrderAddress(OrderAddressPojo orderAddress) {
		this.orderAddress = orderAddress;
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

}