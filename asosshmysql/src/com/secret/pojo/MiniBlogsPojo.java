package com.secret.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * MiniBlogsPojo entity. @author MyEclipse Persistence Tools
 */

public class MiniBlogsPojo implements java.io.Serializable {

	// Fields

	private Integer miniblogsId;
	private String miniblogsContent;
//	private Integer userId;
	private UserPojo  userPojo ;
	
	private Integer userFriendSupport;
	private Integer userFriendFootpoint;
	private String miniblogsStatus;
	private Set<MiniBlogsAssessPojo>  miniBlogsAssessPojos  = new HashSet<MiniBlogsAssessPojo>();
	private Timestamp miniblogsTime;
	
	// Constructors

	/** default constructor */
	public MiniBlogsPojo() {
	}
 

	public MiniBlogsPojo(Integer miniblogsId, String miniblogsContent,
			UserPojo userPojo, Integer userFriendSupport,
			Integer userFriendFootpoint, String miniblogsStatus,
			Set<MiniBlogsAssessPojo> miniBlogsAssessPojos,
			Timestamp miniblogsTime) {
		this.miniblogsId = miniblogsId;
		this.miniblogsContent = miniblogsContent;
		this.userPojo = userPojo;
		this.userFriendSupport = userFriendSupport;
		this.userFriendFootpoint = userFriendFootpoint;
		this.miniblogsStatus = miniblogsStatus;
		this.miniBlogsAssessPojos = miniBlogsAssessPojos;
		this.miniblogsTime = miniblogsTime;
	}





	public Set<MiniBlogsAssessPojo> getMiniBlogsAssessPojos() {
		return miniBlogsAssessPojos;
	}





	public void setMiniBlogsAssessPojos(
			Set<MiniBlogsAssessPojo> miniBlogsAssessPojos) {
		this.miniBlogsAssessPojos = miniBlogsAssessPojos;
	}





	public Integer getMiniblogsId() {
		return this.miniblogsId;
	}

	public void setMiniblogsId(Integer miniblogsId) {
		this.miniblogsId = miniblogsId;
	}

	public String getMiniblogsContent() {
		return this.miniblogsContent;
	}

	public void setMiniblogsContent(String miniblogsContent) {
		this.miniblogsContent = miniblogsContent;
	}

 
	public UserPojo getUserPojo() {
		return userPojo;
	}


	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}


	public Integer getUserFriendSupport() {
		return this.userFriendSupport;
	}

	public void setUserFriendSupport(Integer userFriendSupport) {
		this.userFriendSupport = userFriendSupport;
	}

	public Integer getUserFriendFootpoint() {
		return this.userFriendFootpoint;
	}

	public void setUserFriendFootpoint(Integer userFriendFootpoint) {
		this.userFriendFootpoint = userFriendFootpoint;
	}

	public String getMiniblogsStatus() {
		return this.miniblogsStatus;
	}

	public void setMiniblogsStatus(String miniblogsStatus) {
		this.miniblogsStatus = miniblogsStatus;
	}

 

	public Timestamp getMiniblogsTime() {
		return this.miniblogsTime;
	}

	public void setMiniblogsTime(Timestamp miniblogsTime) {
		this.miniblogsTime = miniblogsTime;
	}

}