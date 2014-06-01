package com.secret.pojo;

import java.sql.Timestamp;

/**
 * UserFriendPojo entity. @author MyEclipse Persistence Tools
 */

public class UserFriendPojo implements java.io.Serializable {

	// Fields

	private Integer userFriendId;
	/*
	 * private Integer userId; 
	 * private Integer friendId; 
	 * private Integer friendgroupid;
	 */

	private UserPojo userPojo;
	private UserPojo friendPojo;

	private FriendGroupPojo friendGroupPojo;
	private String   friendApplyForStatus;
	private String hidingStatus;
	private String gpsShare;
	private String userFriendStatus;
	private Timestamp userFriendTime;

	public UserFriendPojo() {
	}

	 

	public UserFriendPojo(Integer userFriendId, UserPojo userPojo,
			UserPojo friendPojo, FriendGroupPojo friendGroupPojo,
			String friendApplyForStatus, String hidingStatus, String gpsShare,
			String userFriendStatus, Timestamp userFriendTime) {
		this.userFriendId = userFriendId;
		this.userPojo = userPojo;
		this.friendPojo = friendPojo;
		this.friendGroupPojo = friendGroupPojo;
		this.friendApplyForStatus = friendApplyForStatus;
		this.hidingStatus = hidingStatus;
		this.gpsShare = gpsShare;
		this.userFriendStatus = userFriendStatus;
		this.userFriendTime = userFriendTime;
	}



	public String getFriendApplyForStatus() {
		return friendApplyForStatus;
	}



	public void setFriendApplyForStatus(String friendApplyForStatus) {
		this.friendApplyForStatus = friendApplyForStatus;
	}



	public Integer getUserFriendId() {
		return userFriendId;
	}

	public void setUserFriendId(Integer userFriendId) {
		this.userFriendId = userFriendId;
	}

	public UserPojo getUserPojo() {
		return userPojo;
	}

	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
	}

	public UserPojo getFriendPojo() {
		return friendPojo;
	}

	public void setFriendPojo(UserPojo friendPojo) {
		this.friendPojo = friendPojo;
	}

	public FriendGroupPojo getFriendGroupPojo() {
		return friendGroupPojo;
	}

	public void setFriendGroupPojo(FriendGroupPojo friendGroupPojo) {
		this.friendGroupPojo = friendGroupPojo;
	}

	public String getHidingStatus() {
		return hidingStatus;
	}

	public void setHidingStatus(String hidingStatus) {
		this.hidingStatus = hidingStatus;
	}

	public String getGpsShare() {
		return gpsShare;
	}

	public void setGpsShare(String gpsShare) {
		this.gpsShare = gpsShare;
	}

	public String getUserFriendStatus() {
		return userFriendStatus;
	}

	public void setUserFriendStatus(String userFriendStatus) {
		this.userFriendStatus = userFriendStatus;
	}

	public Timestamp getUserFriendTime() {
		return userFriendTime;
	}

	public void setUserFriendTime(Timestamp userFriendTime) {
		this.userFriendTime = userFriendTime;
	}

}