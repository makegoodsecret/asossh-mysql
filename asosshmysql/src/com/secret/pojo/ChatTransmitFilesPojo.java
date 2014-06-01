package com.secret.pojo;

import java.sql.Timestamp;

/**
 * ChatTransmitFilesPojo entity. @author MyEclipse Persistence Tools
 */

public class ChatTransmitFilesPojo implements java.io.Serializable {

	private Integer chatTransmitFilesId;
	private String chatFile;
/*	private Integer userFriendId;
	private Integer friendId;*/
	
	private UserFriendPojo userFriendPojo;
	private UserPojo  friendPojo;
	
	
	private String chatTransmitFilesStatus;
	private Timestamp chatTime;
	
	public ChatTransmitFilesPojo(){
		
	}
	
	
	 
	 


	public ChatTransmitFilesPojo(Integer chatTransmitFilesId, String chatFile,
			UserFriendPojo userFriendPojo, UserPojo friendPojo,
			String chatTransmitFilesStatus, Timestamp chatTime) {
		this.chatTransmitFilesId = chatTransmitFilesId;
		this.chatFile = chatFile;
		this.userFriendPojo = userFriendPojo;
		this.friendPojo = friendPojo;
		this.chatTransmitFilesStatus = chatTransmitFilesStatus;
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






	public Integer getChatTransmitFilesId() {
		return chatTransmitFilesId;
	}
	public void setChatTransmitFilesId(Integer chatTransmitFilesId) {
		this.chatTransmitFilesId = chatTransmitFilesId;
	}
	public String getChatFile() {
		return chatFile;
	}
	public void setChatFile(String chatFile) {
		this.chatFile = chatFile;
	}
	  
	public String getChatTransmitFilesStatus() {
		return chatTransmitFilesStatus;
	}
	public void setChatTransmitFilesStatus(String chatTransmitFilesStatus) {
		this.chatTransmitFilesStatus = chatTransmitFilesStatus;
	}
	public Timestamp getChatTime() {
		return chatTime;
	}
	public void setChatTime(Timestamp chatTime) {
		this.chatTime = chatTime;
	}
	
	
	

}