package com.human.app;

import java.util.ArrayList;

public interface iBBS {
	//게시글 등록
	void writebbs(String title, String content, String writer, String passcode);
	//게시글 전체 목록 보기위한 ArrayList
	ArrayList<BBSrec> getList();
	//게시글 수정
	void updateBBS(int bbs_id, String title, String content);
	//게시글 삭제
	void deleteBBS(int bbs_id);
	//게시글 1개 선택
	BBSrec getPost(int bbs_id);
	//수정할 게시글 정보 불러오기
	UpdateRec getUpdate(int bbs_id);
}
