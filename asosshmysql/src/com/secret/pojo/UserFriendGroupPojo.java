package com.secret.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * UserFriendGroupPojo entity. @author MyEclipse Persistence Tools
 */

public class UserFriendGroupPojo implements java.io.Serializable {

	// Fields

	private Integer userFriendGroupId;
	//private Integer userId;
	private UserPojo  userPojo;
	private String userFriendGroupName;
	private String userFriendGroupPublicnotice;
//	private Integer userFriendGroupTypeId;
	
	private UserFriendGroupTypePojo  userFriendGroupTypePojo;

	private Set<UserPojo> userPojoSet =  new HashSet<UserPojo>();
	private Timestamp userFriendGroupTime;

	// Constructors

	public UserFriendGroupPojo() {
	}

	public UserFriendGroupPojo(Integer userFriendGroupId, UserPojo userPojo,
			String userFriendGroupName, String userFriendGroupPublicnotice,
			UserFriendGroupTypePojo userFriendGroupTypePojo,
			Set<UserPojo> userPojoSet, Timestamp userFriendGroupTime) {
		this.userFriendGroupId = userFriendGroupId;
		this.userPojo = userPojo;
		this.userFriendGroupName = userFriendGroupName;
		this.userFriendGroupPublicnotice = userFriendGroupPublicnotice;
		this.userFriendGroupTypePojo = userFriendGroupTypePojo;
		this.userPojoSet = userPojoSet;
		this.userFriendGroupTime = userFriendGroupTime;
	}



	public Set<UserPojo> getUserPojoSet() {
		return userPojoSet;
	}



	public void setUserPojoSet(Set<UserPojo> userPojoSet) {
		this.userPojoSet = userPojoSet;
	}



	public Integer getUserFriendGroupId() {
		return this.userFriendGroupId;
	}

	public void setUserFriendGroupId(Integer userFriendGroupId) {
		this.userFriendGroupId = userFriendGroupId;
	}

	 

	public UserPojo getUserPojo() {
		return userPojo;
	}


	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}


	public String getUserFriendGroupName() {
		return this.userFriendGroupName;
	}

	public void setUserFriendGroupName(String userFriendGroupName) {
		this.userFriendGroupName = userFriendGroupName;
	}

	public String getUserFriendGroupPublicnotice() {
		return this.userFriendGroupPublicnotice;
	}

	public void setUserFriendGroupPublicnotice(
			String userFriendGroupPublicnotice) {
		this.userFriendGroupPublicnotice = userFriendGroupPublicnotice;
	}
 

	public UserFriendGroupTypePojo getUserFriendGroupTypePojo() {
		return userFriendGroupTypePojo;
	}


	public void setUserFriendGroupTypePojo(
			UserFriendGroupTypePojo userFriendGroupTypePojo) {
		this.userFriendGroupTypePojo = userFriendGroupTypePojo;
	}


	public Timestamp getUserFriendGroupTime() {
		return this.userFriendGroupTime;
	}

	public void setUserFriendGroupTime(Timestamp userFriendGroupTime) {
		this.userFriendGroupTime = userFriendGroupTime;
	}

}