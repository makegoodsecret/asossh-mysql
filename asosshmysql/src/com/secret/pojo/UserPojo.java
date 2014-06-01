package com.secret.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * UserPojo entity. @author MyEclipse Persistence Tools
 */

public class UserPojo implements java.io.Serializable {

	// Fields

	private Integer userId;
	private String username;
	private String password;
	private String qq;
	private String email;
	private String dis;
	private String mood;
	private String sex;
	private Integer integral;
	private String hobby;
	private String emailstatu;
	private Integer level;
	private Integer number;
	private String power;
	private Timestamp time;
	private String payname;
	private UserHeadPojo userHeadPojo;
	private String userLoginCity;
	
	private Set<UserFriendGroupPojo> userFriendGroupPojos = new HashSet<UserFriendGroupPojo>();

	// Constructors

	/** default constructor */
	public UserPojo() {
	}

	 
	 


	public UserPojo(Integer userId, String username, String password,
			String qq, String email, String dis, String mood, String sex,
			Integer integral, String hobby, String emailstatu, Integer level,
			Integer number, String power, Timestamp time, String payname,
			UserHeadPojo userHeadPojo, String userLoginCity,
			Set<UserFriendGroupPojo> userFriendGroupPojos) {
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.qq = qq;
		this.email = email;
		this.dis = dis;
		this.mood = mood;
		this.sex = sex;
		this.integral = integral;
		this.hobby = hobby;
		this.emailstatu = emailstatu;
		this.level = level;
		this.number = number;
		this.power = power;
		this.time = time;
		this.payname = payname;
		this.userHeadPojo = userHeadPojo;
		this.userLoginCity = userLoginCity;
		this.userFriendGroupPojos = userFriendGroupPojos;
	}





	// Property accessors

	public Set<UserFriendGroupPojo> getUserFriendGroupPojos() {
		return userFriendGroupPojos;
	}





	public void setUserFriendGroupPojos(
			Set<UserFriendGroupPojo> userFriendGroupPojos) {
		this.userFriendGroupPojos = userFriendGroupPojos;
	}





	public String getUserLoginCity() {
		return userLoginCity;
	}


	public void setUserLoginCity(String userLoginCity) {
		this.userLoginCity = userLoginCity;
	}


	public String getPayname() {
		return payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public UserHeadPojo getUserHeadPojo() {
		return userHeadPojo;
	}

	public void setUserHeadPojo(UserHeadPojo userHeadPojo) {
		this.userHeadPojo = userHeadPojo;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDis() {
		return this.dis;
	}

	public void setDis(String dis) {
		this.dis = dis;
	}

	public String getMood() {
		return this.mood;
	}

	public void setMood(String mood) {
		this.mood = mood;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getIntegral() {
		return this.integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}

	public String getHobby() {
		return this.hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getEmailstatu() {
		return this.emailstatu;
	}

	public void setEmailstatu(String emailstatu) {
		this.emailstatu = emailstatu;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getNumber() {
		return this.number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getPower() {
		return this.power;
	}

	public void setPower(String power) {
		this.power = power;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

}