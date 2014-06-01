package com.secret.pojo;

import java.sql.Timestamp;

/**
 * RecommendPojo entity. @author MyEclipse Persistence Tools
 */

public class RecommendPojo implements java.io.Serializable {

	// Fields

	private Integer recId;
	private Integer goodsId;
	private Timestamp recommendTime;

	// Constructors

	/** default constructor */
	public RecommendPojo() {
	}

	 

	/** full constructor */
	public RecommendPojo(Integer goodsId, Timestamp recommendTime) {
		this.goodsId = goodsId;
		this.recommendTime = recommendTime;
	}

	// Property accessors

	public Integer getRecId() {
		return this.recId;
	}

	public void setRecId(Integer recId) {
		this.recId = recId;
	}

	public Integer getGoodsId() {
		return this.goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Timestamp getRecommendTime() {
		return this.recommendTime;
	}

	public void setRecommendTime(Timestamp recommendTime) {
		this.recommendTime = recommendTime;
	}

}