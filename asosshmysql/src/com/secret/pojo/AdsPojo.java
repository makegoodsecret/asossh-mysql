package com.secret.pojo;

import java.sql.Timestamp;

/**
 * AdsPojo entity. @author MyEclipse Persistence Tools
 */

public class AdsPojo implements java.io.Serializable {

	// Fields

	private Integer adsId;
	private String adsImage;
	private String adsDis;
	private String adsStatu;
	private Timestamp adsTime;

	// Constructors

	/** default constructor */
	public AdsPojo() {
	}

	/** full constructor */
	public AdsPojo(String adsImage, String adsDis, String adsStatu,
			Timestamp adsTime) {
		this.adsImage = adsImage;
		this.adsDis = adsDis;
		this.adsStatu = adsStatu;
		this.adsTime = adsTime;
	}

	// Property accessors

	 

	public Integer getAdsId() {
		return this.adsId;
	}

	public void setAdsId(Integer adsId) {
		this.adsId = adsId;
	}

	public String getAdsImage() {
		return this.adsImage;
	}

	public void setAdsImage(String adsImage) {
		this.adsImage = adsImage;
	}

	public String getAdsDis() {
		return this.adsDis;
	}

	public void setAdsDis(String adsDis) {
		this.adsDis = adsDis;
	}

	public String getAdsStatu() {
		return this.adsStatu;
	}

	public void setAdsStatu(String adsStatu) {
		this.adsStatu = adsStatu;
	}

	public Timestamp getAdsTime() {
		return this.adsTime;
	}

	public void setAdsTime(Timestamp adsTime) {
		this.adsTime = adsTime;
	}

}