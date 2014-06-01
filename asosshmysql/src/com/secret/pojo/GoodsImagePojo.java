package com.secret.pojo;

import java.sql.Timestamp;

/**
 * GoodsImagePojo entity. @author MyEclipse Persistence Tools
 */

public class GoodsImagePojo implements java.io.Serializable {

	// Fields

	private Integer gimageId;
	private Integer goodsId;
	private String gimageImage;
	private Timestamp gimageTime;
	
	private GoodsInfoPojo goodsInfoPojo ;
	// Constructors

	/** default constructor */
	public GoodsImagePojo() {
	}

	/** full constructor */
	public GoodsImagePojo(Integer goodsId, String gimageImage,
			Timestamp gimageTime ,GoodsInfoPojo goodsInfoPojo) {
		this.goodsId = goodsId;
		this.gimageImage = gimageImage;
		this.gimageTime = gimageTime;
		this.goodsInfoPojo=goodsInfoPojo;
	}

	// Property accessors

	 
	public Integer getGimageId() {
		return this.gimageId;
	}

	public void setGimageId(Integer gimageId) {
		this.gimageId = gimageId;
	}

	public Integer getGoodsId() {
		return this.goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public GoodsInfoPojo getGoodsInfoPojo() {
		return goodsInfoPojo;
	}

	public void setGoodsInfoPojo(GoodsInfoPojo goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}

	public String getGimageImage() {
		return this.gimageImage;
	}

	public void setGimageImage(String gimageImage) {
		this.gimageImage = gimageImage;
	}

	public Timestamp getGimageTime() {
		return this.gimageTime;
	}

	public void setGimageTime(Timestamp gimageTime) {
		this.gimageTime = gimageTime;
	}

}