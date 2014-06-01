package com.secret.pojo;

/**
 * OrderAddressPojo entity. @author MyEclipse Persistence Tools
 */

public class OrderAddressPojo implements java.io.Serializable {

	// Fields

	private Integer orderAddressId;
	private String orderName;
	private String province;
	private String city;
	private String county;
	private String otherAddress;
	private Integer postCode;
	private String cellphone;
	private String phonesection;
	private String phonecode;
	private String otherphone;
/*	private Integer userId;*/
	private UserPojo userPojo;
	private String orderAddressStatus;

	// Constructors

	/** default constructor */
	public OrderAddressPojo() {
	}

	public OrderAddressPojo(Integer orderAddressId, String orderName,
			String province, String city, String county, String otherAddress,
			Integer postCode, String cellphone, String phonesection,
			String phonecode, String otherphone, UserPojo userPojo,
			String orderAddressStatus) {
		this.orderAddressId = orderAddressId;
		this.orderName = orderName;
		this.province = province;
		this.city = city;
		this.county = county;
		this.otherAddress = otherAddress;
		this.postCode = postCode;
		this.cellphone = cellphone;
		this.phonesection = phonesection;
		this.phonecode = phonecode;
		this.otherphone = otherphone;
		this.userPojo = userPojo;
		this.orderAddressStatus = orderAddressStatus;
	}

	public Integer getOrderAddressId() {
		return orderAddressId;
	}

	public void setOrderAddressId(Integer orderAddressId) {
		this.orderAddressId = orderAddressId;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getOtherAddress() {
		return otherAddress;
	}

	public void setOtherAddress(String otherAddress) {
		this.otherAddress = otherAddress;
	}

	public Integer getPostCode() {
		return postCode;
	}

	public void setPostCode(Integer postCode) {
		this.postCode = postCode;
	}

	public String getCellphone() {
		return cellphone;
	}

	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}

	public String getPhonesection() {
		return phonesection;
	}

	public void setPhonesection(String phonesection) {
		this.phonesection = phonesection;
	}

	public String getPhonecode() {
		return phonecode;
	}

	public void setPhonecode(String phonecode) {
		this.phonecode = phonecode;
	}

	public String getOtherphone() {
		return otherphone;
	}

	public void setOtherphone(String otherphone) {
		this.otherphone = otherphone;
	}

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}

	public String getOrderAddressStatus() {
		return orderAddressStatus;
	}

	public void setOrderAddressStatus(String orderAddressStatus) {
		this.orderAddressStatus = orderAddressStatus;
	}

	

}