package com.study.springboot.service;
 
import java.util.ArrayList;
import java.util.List;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OnetoOneBoardDto;

public interface IOnetoOneBoardService { 
	public int write(OnetoOneBoardDto oneBoardDto); //글쓰기
	public List<OnetoOneBoardDto> list(String id,Criteria cri); //글목록 
	public OnetoOneBoardDto content_view(int idx); //유저아이디로 글가져오기  
 	public int boardModify(OnetoOneBoardDto oneBoardDto);//유저아이디와 연결된 글 수정
	public int boardDelete(int idx);  //글삭제
	public OnetoOneBoardDto content_reply(int idx); //관리자답변가져오기
	public List<OnetoOneBoardDto> search_user(String category,String user_id,String keyword); //검색기능
	public List<OnetoOneBoardDto> noanswer_userlist(String check, String user_id);//답변없는글목록_사용자
//	관리자페이지- 1:1문의  
	public List<OnetoOneBoardDto> noanswerlist(String check); //답변없는글목록
	public int adminwrite(int idx,String admin_id,String o_content_A,String o_ans_check); //글쓰기 & 답변 상태 변경
	public int count();
	public int countMember(String id);
	public List<OnetoOneBoardDto> adminlist(Criteria cri); //글목록
	public List<OnetoOneBoardDto> search(String category,String keyword); //검색기능 
	public int adminReplyDelete(int idx,String admin_id,String o_content_A,String o_ans_check); //답변삭제
}
