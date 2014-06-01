package com.secret.pojo;

import java.sql.Timestamp;

/**
 * ChatPojo entity. @author MyEclipse Persistence Tools
 */

public class ChatPojo implements java.io.Serializable {

	// Fields

	private Long chatId;
/*	private Long userFriendId;*/
	private String chatText;
/*	private Long friendId;*/
	private UserFriendPojo  userFriendPojo ;
	private UserPojo  friendPojo ;
	private String chatStatus;
	private Timestamp chatTime;

	// Constructors

	/** default constructor */
	public ChatPojo() {
	}
 

	public ChatPojo(Long chatId, String chatText,
			UserFriendPojo userFriendPojo, UserPojo friendPojo,
			String chatStatus, Timestamp chatTime) {
		this.chatId = chatId;
		this.chatText = chatText;
		this.userFriendPojo = userFriendPojo;
		this.friendPojo = friendPojo;
		this.chatStatus = chatStatus;
		this.chatTime = chatTime;
	}


	public UserFriendPojo getUserFriendPojo() {
		return userFriendPojo;
	}

	public void setUserFriendPojo(UserFriendPojo userFriendPojo) {
		this.userFriendPojo = userFriendPojo;
	}
 

	public UserPojo getFriendPojo() {
		return friendPojo;
	}


	public void setFriendPojo(UserPojo friendPojo) {
		this.friendPojo = friendPojo;
	}


	/** full constructor */
 
	// Property accessors

	public Long getChatId() {
		return this.chatId;
	}

	public void setChatId(Long chatId) {
		this.chatId = chatId;
	}

 
	public String getChatText() {
		return this.chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}

	 

	public String getChatStatus() {
		return this.chatStatus;
	}

	public void setChatStatus(String chatStatus) {
		this.chatStatus = chatStatus;
	}

	public Timestamp getChatTime() {
		return this.chatTime;
	}

	public void setChatTime(Timestamp chatTime) {
		this.chatTime = chatTime;
	}

}