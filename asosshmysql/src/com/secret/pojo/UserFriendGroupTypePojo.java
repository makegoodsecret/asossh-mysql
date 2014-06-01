package com.secret.pojo;

/**
 * UserFriendGroupTypePojo entity. @author MyEclipse Persistence Tools
 */

public class UserFriendGroupTypePojo implements java.io.Serializable {

	// Fields

	private Integer userFriendGroupTypeId;
	private String userFriendGroupTypeName;

	// Constructors

	/** default constructor */
	public UserFriendGroupTypePojo() {
	}

	/** full constructor */
	public UserFriendGroupTypePojo(String userFriendGroupTypeName) {
		this.userFriendGroupTypeName = userFriendGroupTypeName;
	}

	// Property accessors

	public Integer getUserFriendGroupTypeId() {
		return this.userFriendGroupTypeId;
	}

	public void setUserFriendGroupTypeId(Integer userFriendGroupTypeId) {
		this.userFriendGroupTypeId = userFriendGroupTypeId;
	}

	public String getUserFriendGroupTypeName() {
		return this.userFriendGroupTypeName;
	}

	public void setUserFriendGroupTypeName(String userFriendGroupTypeName) {
		this.userFriendGroupTypeName = userFriendGroupTypeName;
	}

}