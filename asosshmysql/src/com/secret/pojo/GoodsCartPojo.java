package com.secret.pojo;

/**
 * GoodsCartPojo entity. @author MyEclipse Persistence Tools
 */

public class GoodsCartPojo implements java.io.Serializable {

	// Fields

	private Integer cartId;
	/*private Integer userId;
	private Integer goodsId;
	private Integer mealId;
	*/
	private Integer goodsNumber;
	private String orderAds;

	private UserPojo  userPojo ;
	private GoodsInfoPojo goodsInfoPojo;
	private MealPojo  mealPojo;
	/** default constructor */
	public GoodsCartPojo() {
	}

	
	public GoodsCartPojo(Integer cartId, Integer goodsNumber, String orderAds,
			UserPojo userPojo, GoodsInfoPojo goodsInfoPojo, MealPojo mealPojo
			 ) {
		this.cartId = cartId;
		this.goodsNumber = goodsNumber;
		this.orderAds = orderAds;
		this.userPojo = userPojo;
		this.goodsInfoPojo = goodsInfoPojo;
		this.mealPojo = mealPojo;
	}

 
	 
 

	public Integer getCartId() {
		return this.cartId;
	}

	public void setCartId(Integer cartId) {
		this.cartId = cartId;
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

	
}