package com.secret.pojo;

import java.sql.Timestamp;

/**
 * ApplysellerPojo entity. @author MyEclipse Persistence Tools
 */

public class ApplySellerPojo implements java.io.Serializable {

	// Fields

	private Integer applysellerId;
	private String applysellerLogo;
	private String applysellerCertificate;
	private Timestamp applysellerTime;
	private String  applysellerStatus ;
	private UserPojo  userPojo;
	// Constructors

	/** default constructor */
	public ApplySellerPojo() {
	}

	 

	public ApplySellerPojo(Integer applysellerId, String applysellerLogo,
			String applysellerCertificate, Timestamp applysellerTime,
			String applysellerStatus, UserPojo userPojo) {
		this.applysellerId = applysellerId;
		this.applysellerLogo = applysellerLogo;
		this.applysellerCertificate = applysellerCertificate;
		this.applysellerTime = applysellerTime;
		this.applysellerStatus = applysellerStatus;
		this.userPojo = userPojo;
	}



	// Property accessors

	public String getApplysellerStatus() {
		return applysellerStatus;
	}



	public void setApplysellerStatus(String applysellerStatus) {
		this.applysellerStatus = applysellerStatus;
	}



	public UserPojo getUserPojo() {
		return userPojo;
	}



	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}



	public Integer getApplysellerId() {
		return this.applysellerId;
	}

	public void setApplysellerId(Integer applysellerId) {
		this.applysellerId = applysellerId;
	}

	public String getApplysellerLogo() {
		return this.applysellerLogo;
	}

	public void setApplysellerLogo(String applysellerLogo) {
		this.applysellerLogo = applysellerLogo;
	}

	public String getApplysellerCertificate() {
		return this.applysellerCertificate;
	}

	public void setApplysellerCertificate(String applysellerCertificate) {
		this.applysellerCertificate = applysellerCertificate;
	}

	public Timestamp getApplysellerTime() {
		return this.applysellerTime;
	}

	public void setApplysellerTime(Timestamp applysellerTime) {
		this.applysellerTime = applysellerTime;
	}

}