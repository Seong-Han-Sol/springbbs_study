package com.human.app;

import java.util.ArrayList;

public interface iReply {
	//댓글추가
	void addReply(int bbs_id, String content, String writer);
	//댓글 리스트 출력
	ArrayList<Reply> getReplyList(int bbs_id);
	//댓글 삭제
	void deleteReply (int reply_id);
	//댓글 수정
	void updateReply(int reply_id, String content);
}
