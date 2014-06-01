package com.secret.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * SortPojo entity. @author MyEclipse Persistence Tools
 */

public class SortPojo implements java.io.Serializable {

	// Fields

	private Integer sortId;
	private String sortName;
	private HotelPojo  hotelPojo ;
	private Set<GoodsInfoPojo> goodsInfoPojos = new HashSet<GoodsInfoPojo>();
	// Constructors

	/** default constructor */
	public SortPojo() {
	}

	 
  

 



	public SortPojo(Integer sortId, String sortName, HotelPojo hotelPojo,
			Set<GoodsInfoPojo> goodsInfoPojos) {
		this.sortId = sortId;
		this.sortName = sortName;
		this.hotelPojo = hotelPojo;
		this.goodsInfoPojos = goodsInfoPojos;
	}








	// Property accessors

	public Set<GoodsInfoPojo> getGoodsInfoPojos() {
		return goodsInfoPojos;
	}








	public void setGoodsInfoPojos(Set<GoodsInfoPojo> goodsInfoPojos) {
		this.goodsInfoPojos = goodsInfoPojos;
	}








	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}



	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}



	public Integer getSortId() {
		return this.sortId;
	}

	public void setSortId(Integer sortId) {
		this.sortId = sortId;
	}

	public String getSortName() {
		return this.sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	 
}