package com.secret.pojo;

/**
 * FriendGroupPojo entity. @author MyEclipse Persistence Tools
 */

public class FriendGroupPojo implements java.io.Serializable {

	// Fields

	private Integer friendGroupId;
	private String friendGroupName;
//	private Integer userId;
	private UserPojo userPojo;

	// Constructors

	/** default constructor */
	public FriendGroupPojo() {
	}

	/** full constructor */
	 

	// Property accessors

	public Integer getFriendGroupId() {
		return this.friendGroupId;
	}

	public FriendGroupPojo(Integer friendGroupId, String friendGroupName,
			UserPojo userPojo) {
		this.friendGroupId = friendGroupId;
		this.friendGroupName = friendGroupName;
		this.userPojo = userPojo;
	}

	public void setFriendGroupId(Integer friendGroupId) {
		this.friendGroupId = friendGroupId;
	}

	public String getFriendGroupName() {
		return this.friendGroupName;
	}

	public void setFriendGroupName(String friendGroupName) {
		this.friendGroupName = friendGroupName;
	}

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}

}