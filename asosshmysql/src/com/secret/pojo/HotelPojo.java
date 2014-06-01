package com.secret.pojo;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * HotelPojo entity. @author MyEclipse Persistence Tools
 */

public class HotelPojo implements java.io.Serializable {

	// Fields

	private Integer hotelId;
	private String hotelName;
	private String hotelAds;
	private String hotelProvince;
	private String hotelCity;
	private String hotelCounty;
	private String hotelOtherAddress;
	private String hotelCellphone;
	private String hotelPhonesection;
	private String hotelPhonecode;
	private String hotelOtherphone;

	private Float hotelLng;
	private Float hotelLat;
	private String hotelLogo;
	private String hotelCertificate;
	private Double hotelLevel;
	private Integer hotelGrade;
	private String hotelStatus;
	/*private Integer userId;*/
	private Timestamp hotelTime;

	private Time hotelShopAmStart;
	private Time hotelShopAmEnd;
	private Time hotelShopPmStart;
	private Time hotelShopPmEnd;
	private Set<GoodsInfoPojo> goodsInfoPojo = new HashSet<GoodsInfoPojo>();
	private Set<MealPojo> mealPojo = new HashSet<MealPojo>();
	private  UserPojo  userPojo = new UserPojo();
	// Constructors

	/** default constructor */
	public HotelPojo() {
	}
	
	 
	public HotelPojo(Integer hotelId, String hotelName, String hotelAds,
			String hotelProvince, String hotelCity, String hotelCounty,
			String hotelOtherAddress, String hotelCellphone,
			String hotelPhonesection, String hotelPhonecode,
			String hotelOtherphone, Float hotelLng, Float hotelLat,
			String hotelLogo, String hotelCertificate, Double hotelLevel,
			Integer hotelGrade, String hotelStatus, Timestamp hotelTime,
			Time hotelShopAmStart, Time hotelShopAmEnd, Time hotelShopPmStart,
			Time hotelShopPmEnd, Set<GoodsInfoPojo> goodsInfoPojo,
			Set<MealPojo> mealPojo, UserPojo userPojo) {
		this.hotelId = hotelId;
		this.hotelName = hotelName;
		this.hotelAds = hotelAds;
		this.hotelProvince = hotelProvince;
		this.hotelCity = hotelCity;
		this.hotelCounty = hotelCounty;
		this.hotelOtherAddress = hotelOtherAddress;
		this.hotelCellphone = hotelCellphone;
		this.hotelPhonesection = hotelPhonesection;
		this.hotelPhonecode = hotelPhonecode;
		this.hotelOtherphone = hotelOtherphone;
		this.hotelLng = hotelLng;
		this.hotelLat = hotelLat;
		this.hotelLogo = hotelLogo;
		this.hotelCertificate = hotelCertificate;
		this.hotelLevel = hotelLevel;
		this.hotelGrade = hotelGrade;
		this.hotelStatus = hotelStatus;
		this.hotelTime = hotelTime;
		this.hotelShopAmStart = hotelShopAmStart;
		this.hotelShopAmEnd = hotelShopAmEnd;
		this.hotelShopPmStart = hotelShopPmStart;
		this.hotelShopPmEnd = hotelShopPmEnd;
		this.goodsInfoPojo = goodsInfoPojo;
		this.mealPojo = mealPojo;
		this.userPojo = userPojo;
	}


	// Property accessors

	public UserPojo getUserPojo() {
		return userPojo;
	}


	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}


	public Integer getHotelId() {
		return this.hotelId;
	}

	 
 
	public Time getHotelShopAmStart() {
		return hotelShopAmStart;
	}

	public void setHotelShopAmStart(Time hotelShopAmStart) {
		this.hotelShopAmStart = hotelShopAmStart;
	}

	public Time getHotelShopAmEnd() {
		return hotelShopAmEnd;
	}

	public void setHotelShopAmEnd(Time hotelShopAmEnd) {
		this.hotelShopAmEnd = hotelShopAmEnd;
	}

	public Time getHotelShopPmStart() {
		return hotelShopPmStart;
	}

	public void setHotelShopPmStart(Time hotelShopPmStart) {
		this.hotelShopPmStart = hotelShopPmStart;
	}

	public Time getHotelShopPmEnd() {
		return hotelShopPmEnd;
	}

	public void setHotelShopPmEnd(Time hotelShopPmEnd) {
		this.hotelShopPmEnd = hotelShopPmEnd;
	}

	public void setHotelId(Integer hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return this.hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getHotelAds() {
		return this.hotelAds;
	}

	public void setHotelAds(String hotelAds) {
		this.hotelAds = hotelAds;
	}

	public String getHotelProvince() {
		return hotelProvince;
	}

	public void setHotelProvince(String hotelProvince) {
		this.hotelProvince = hotelProvince;
	}

	public String getHotelCity() {
		return hotelCity;
	}

	public void setHotelCity(String hotelCity) {
		this.hotelCity = hotelCity;
	}

	public String getHotelCounty() {
		return hotelCounty;
	}

	public void setHotelCounty(String hotelCounty) {
		this.hotelCounty = hotelCounty;
	}

	public String getHotelOtherAddress() {
		return hotelOtherAddress;
	}

	public void setHotelOtherAddress(String hotelOtherAddress) {
		this.hotelOtherAddress = hotelOtherAddress;
	}

	public String getHotelCellphone() {
		return hotelCellphone;
	}

	public void setHotelCellphone(String hotelCellphone) {
		this.hotelCellphone = hotelCellphone;
	}

	public String getHotelPhonesection() {
		return hotelPhonesection;
	}

	public void setHotelPhonesection(String hotelPhonesection) {
		this.hotelPhonesection = hotelPhonesection;
	}

	public String getHotelPhonecode() {
		return hotelPhonecode;
	}

	public void setHotelPhonecode(String hotelPhonecode) {
		this.hotelPhonecode = hotelPhonecode;
	}

	public String getHotelOtherphone() {
		return hotelOtherphone;
	}

	public void setHotelOtherphone(String hotelOtherphone) {
		this.hotelOtherphone = hotelOtherphone;
	}

	public Float getHotelLng() {
		return this.hotelLng;
	}

	public void setHotelLng(Float hotelLng) {
		this.hotelLng = hotelLng;
	}

	public Float getHotelLat() {
		return this.hotelLat;
	}

	public void setHotelLat(Float hotelLat) {
		this.hotelLat = hotelLat;
	}

	public String getHotelLogo() {
		return this.hotelLogo;
	}

	public void setHotelLogo(String hotelLogo) {
		this.hotelLogo = hotelLogo;
	}

	public String getHotelCertificate() {
		return this.hotelCertificate;
	}

	public void setHotelCertificate(String hotelCertificate) {
		this.hotelCertificate = hotelCertificate;
	}

	public Double getHotelLevel() {
		return hotelLevel;
	}

	public void setHotelLevel(Double hotelLevel) {
		this.hotelLevel = hotelLevel;
	}

	public Integer getHotelGrade() {
		return this.hotelGrade;
	}

	public void setHotelGrade(Integer hotelGrade) {
		this.hotelGrade = hotelGrade;
	}

	public String getHotelStatus() {
		return this.hotelStatus;
	}

	public void setHotelStatus(String hotelStatus) {
		this.hotelStatus = hotelStatus;
	}
 
	public Timestamp getHotelTime() {
		return this.hotelTime;
	}

	public void setHotelTime(Timestamp hotelTime) {
		this.hotelTime = hotelTime;
	}

	public Set<GoodsInfoPojo> getGoodsInfoPojo() {
		return goodsInfoPojo;
	}

	public void setGoodsInfoPojo(Set<GoodsInfoPojo> goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}

	public Set<MealPojo> getMealPojo() {
		return mealPojo;
	}

	public void setMealPojo(Set<MealPojo> mealPojo) {
		this.mealPojo = mealPojo;
	}

}