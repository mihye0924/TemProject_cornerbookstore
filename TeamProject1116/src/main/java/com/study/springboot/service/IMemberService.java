package com.study.springboot.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Delete_MemberDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OnetoOneBoardDto;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.ProductDto;
import com.study.springboot.dto.Review_Board_Dto;
/*<!-- 1123수정 -->*/
 
public interface IMemberService {
	public int insertMember(HttpServletRequest request);//회원가입
	public String idCheck(String id);   //아이디 중복확인
	public int loginCheck(String id, String password);//로그인체크
	public int logout(); //로그아웃
	public MemberDto getUserInfo(String id); //회원정보가져오기
	public int updateMember(HttpServletRequest request);//회원수정
	public int deleteMember(String id, String password);//회원삭제
	public int deleteMember2(String id);//관리자>회원삭제
	public int insertComplain(HttpServletRequest request);//불편사항 : delete_member db생성
	public int insertComplain2(HttpServletRequest request);//관리자>탈퇴db생성 : delete_member db생성
    public String idFindCheck(String name, String mail1, String mail2); //회원찾기완료폼 아이디 가져오기
	public MemberDto pwEmailFindCheck(HttpServletRequest request); // 비밀번호찾기폼 이메일 가져오기
	public MemberDto pwCheck(HttpServletRequest request); // 비밀번호가져오기  
	public List<MemberDto> list();
	public int pointupdate(HttpServletRequest request);//회원수정
	public int AutologinCheck(String id, String password); //자동로그인 서비스 
	public List<MemberDto> searchMember(HttpServletRequest request); // 회원목록 검색
	public int countMember();
	public List<MemberDto> getList(Criteria cri);
	public int countDelete();
	public List<Delete_MemberDto> deletelist(Criteria cri);  // 수정
	public List<MemberDto> memberManage(); // 북스토리 회원 정보가져오기  
	public int updateRank(String id, String rank);//북스토리 회원 랭킹변경 
	public int update_content_count(String id); // 게시글 수 증가 
	public int update_reply_count(String id);//댓글 수 증가
	public int delete_content_count(String id);//게시글 수 감소
	public int delete_reply_count(String id); //댓글 수 감소    
	public List<MemberDto> rankstate(String contentAndReplyCount, int content_count, int reply_count);//게시글,댓글 수 찾기
	
}
