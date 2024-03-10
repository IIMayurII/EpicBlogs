package com.entities;

import java.sql.Blob;

public class User {
	int uid;
	String fname;
	String lname;
	String username;
	String password;
	String gender;
	String phone;
	Blob profilePhoto;

	public User() {
	}

	public User(int uid, String fname, String lname, String username, String password, String gender, String phone,
			Blob profilePhoto) {
		super();
		this.uid = uid;
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.phone = phone;
		this.profilePhoto = profilePhoto;
	}

	public User(String fname, String lname, String username, String password, String gender, String phone,
			Blob profilePhoto) {
		super();
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.phone = phone;
		this.profilePhoto = profilePhoto;
	}
	public User(int uid, String username, String fname, String lname, String phone, String gender,Blob profilePhoto) {
		super();
		this.uid = uid;
		this.username = username;
		this.fname = fname;
		this.lname = lname;
		this.phone = phone;
		this.gender = gender;
		this.profilePhoto = profilePhoto;
	}

	public User(int uid, String fname, String lname, String username, String password, String gender, String phone) {
		super();
		this.uid = uid;
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.phone = phone;
	}

	
	
	public User(String fname, String lname, String username, String password, String gender, String phone) {
		super();
		this.fname = fname;
		this.lname = lname;
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.phone = phone;
	}

	public int getUid(String username) {
		return uid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Blob getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(Blob profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

}