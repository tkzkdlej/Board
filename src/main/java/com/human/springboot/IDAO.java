package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IDAO {
	ArrayList<bbsDTO> doList();
	void doNewInsert(String b, String c, String d);
	void doviewList(int seqno);
	void doreadcount(int seqno);
	void doupdated(int seqno);
	
	void doModify(String a, String b, int c);
	void doDelete(int a);
	
	ArrayList<bbsDTO> doView(int seqno);
	bbsDTO showButton(int seqno);
	
	ArrayList<MDTO> m_select();
	void signinsert(String a, String b,String c, String d, String e);
	
	int login(String a, String b);
	String nickname(String a);
	
	int checkid(String a);
	int checkNickname(String a);
}
