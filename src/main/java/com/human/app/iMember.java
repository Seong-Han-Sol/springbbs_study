package com.human.app;

public interface iMember {
	//회원가입정보 insert
	void newUser(String name, String userId, String passcode);
	//로그인시 등록된 회원인지 조회하기
	int checkUser(String userId, String passcode);
}
