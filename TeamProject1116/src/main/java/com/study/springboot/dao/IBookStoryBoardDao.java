package com.study.springboot.dao; 

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BookStoryBoardDto;
import com.study.springboot.dto.BookStoryBoardReplyDto; 
import com.study.springboot.dto.MemberDto; 
/*<!-- 1123수정 -->*/

@Mapper
public interface IBookStoryBoardDao {   
	public List<BookStoryBoardDto> bookstory_searchDao(String keyword); //검색
	public int uploadProfileDao(MemberDto memberDto);  // 이미지 업로드 
	public MemberDto getProfileDao(MemberDto memberDto); //프로필 이미지 등록(수정)
	public List<MemberDto> getMainfileDao(); //메인 프로필- 아이디,회원수  
	public int bookstoryHitDao(int idx) throws Exception; //조회수
	public int bookstoryRelpyWriteDao(BookStoryBoardReplyDto replyDto);//댓글달기 
	public List<BookStoryBoardReplyDto> bookstoryReplyViewDao(int idx); //댓글보기
	public int bookStoryReplyDeleteDao(int reply_no);//댓글삭제
	public List<BookStoryBoardReplyDto> bookStoryReplyCountDao(int idx); //댓글수체크
	public BookStoryBoardDto bookstory_prevListDao(int idx); //이전글
	 
	public int bookstoryWriteDao(BookStoryBoardDto bookstoryDto); //글작성 
	public BookStoryBoardDto bookstoryViewDao(int idx); //해당 글 보기 
	public int bookstoryDeleteDao(int idx); //글 삭제
	public int bookstoryUpdateDao(BookStoryBoardDto dto); //글 수정
	
	public ArrayList<BookStoryBoardDto> bookstoryListDao();//메인 전체 글목록 
	public List<BookStoryBoardDto> bookstoryAllListDao(int startRowNum,int endRowNum); // 전체 글목록 
	public List<BookStoryBoardDto> bookStoryCategoryDao(String bs_category,int startRowNum,int endRowNum); //카테고리별 글 목록 
	public List<BookStoryBoardDto> bookStoryCategory2Dao(String bs_category,int startRowNum,int endRowNum); //작가정보 글 목록,책 미리보기 글 목록   
	public ArrayList<BookStoryBoardDto> bookstory_mainpopularListDao(); //인기있는 게시글 목록 
	public List<BookStoryBoardDto> bookstory_writerInfoListDao(String bs_category,int startRowNum,int endRowNum);  //작가 목록 
	
	public List<BookStoryBoardDto> contents_countDao(String bs_user_id);//게시글 수
	public List<BookStoryBoardReplyDto> replys_countDao(String writer_id); //댓글수
 
	public int bookstoryLike_checkDao(int idx,int like_check) throws Exception; //좋아요기능  
	public int bookstorylike_check_cancleDao(int idx,int like_check)throws Exception;  //좋아요 취소
	public int bookstorylike_cntupDao(int idx,int like_cnt);//좋아요수 증가
	public int bookstorylike_cntdownDao(int idx,int like_cnt);//좋아요수 감소
	
	 
}

