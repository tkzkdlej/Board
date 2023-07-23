package com.human.springboot;

import lombok.Data;

@Data
public class MDTO {
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getInterest() {
		return interest;
	}

	public void setInterest(String interest) {
		this.interest = interest;
	}

	public int getId_seq() {
		return id_seq;
	}

	public void setId_seq(int id_seq) {
		this.id_seq = id_seq;
	}

	String id;
	String pw;
	String nickname;
	String gender;
	String interest;
	
	int id_seq;
}
