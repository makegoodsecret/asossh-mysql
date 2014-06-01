package com.secret.pojo;

import java.sql.Timestamp;

/**
 * MiniBlogsAssessPojo entity. @author MyEclipse Persistence Tools
 */

public class MiniBlogsAssessPojo implements java.io.Serializable {

	// Fields

	private Integer miniblogsAssessId;
//	private Integer userFriendId;
	
	private  UserFriendPojo  userFriendPojo;
	private String miniblogsAssessContent;
	private Timestamp miniblogsAssessTime;
    private  MiniBlogsPojo  miniBlogsPojo ; 
	// Constructors

	/** default constructor */
	public MiniBlogsAssessPojo() {
	}

	 
	 
	public MiniBlogsAssessPojo(Integer miniblogsAssessId,
			UserFriendPojo userFriendPojo, String miniblogsAssessContent,
			Timestamp miniblogsAssessTime, MiniBlogsPojo miniBlogsPojo) {
		super();
		this.miniblogsAssessId = miniblogsAssessId;
		this.userFriendPojo = userFriendPojo;
		this.miniblogsAssessContent = miniblogsAssessContent;
		this.miniblogsAssessTime = miniblogsAssessTime;
		this.miniBlogsPojo = miniBlogsPojo;
	}



	// Property accessors

	public MiniBlogsPojo getMiniBlogsPojo() {
		return miniBlogsPojo;
	}



	public void setMiniBlogsPojo(MiniBlogsPojo miniBlogsPojo) {
		this.miniBlogsPojo = miniBlogsPojo;
	}



	public Integer getMiniblogsAssessId() {
		return this.miniblogsAssessId;
	}

	public void setMiniblogsAssessId(Integer miniblogsAssessId) {
		this.miniblogsAssessId = miniblogsAssessId;
	}

	 
	public UserFriendPojo getUserFriendPojo() {
		return userFriendPojo;
	}


	public void setUserFriendPojo(UserFriendPojo userFriendPojo) {
		this.userFriendPojo = userFriendPojo;
	}


	public String getMiniblogsAssessContent() {
		return this.miniblogsAssessContent;
	}

	public void setMiniblogsAssessContent(String miniblogsAssessContent) {
		this.miniblogsAssessContent = miniblogsAssessContent;
	}

	public Timestamp getMiniblogsAssessTime() {
		return this.miniblogsAssessTime;
	}

	public void setMiniblogsAssessTime(Timestamp miniblogsAssessTime) {
		this.miniblogsAssessTime = miniblogsAssessTime;
	}

}