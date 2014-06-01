package com.secret.pojo;

import java.sql.Timestamp;

/**
 * UserHeadPojo entity. @author MyEclipse Persistence Tools
 */

public class UserHeadPojo implements java.io.Serializable {

	// Fields

	private Integer headId;
	private String headImage;
	private Timestamp headTime;

	private UserPojo  userpojo;
	// Constructors

	/** default constructor */
	public UserHeadPojo() {
	}

	/** full constructor */
	public UserHeadPojo(String headImage, Timestamp headTime, UserPojo  userpojo) {
		this.headImage = headImage;
		this.headTime = headTime;
		this.userpojo=userpojo;
	}

	// Property accessors
	
	public Integer getHeadId() {
		return this.headId;
	}

	 
	public void setHeadId(Integer headId) {
		this.headId = headId;
	}

	public String getHeadImage() {
		return this.headImage;
	}

	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}

	public Timestamp getHeadTime() {
		return this.headTime;
	}

	public void setHeadTime(Timestamp headTime) {
		this.headTime = headTime;
	}

	public UserPojo getUserpojo() {
		return userpojo;
	}

	public void setUserpojo(UserPojo userpojo) {
		this.userpojo = userpojo;
	}

	 

}