package com.study.springboot.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.BookStoryBoardDto;
import com.study.springboot.dto.BookStoryBoardReplyDto; 
import com.study.springboot.dto.MemberDto; 
/*<!-- 1123수정 -->*/
public interface IBookStoryBoardService {  
	public List<BookStoryBoardDto> bookstory_search(HttpServletRequest request); //검색
	public String uploadProfile(HttpServletRequest request, MultipartFile file, Model model);   
	public MemberDto getProfile(HttpServletRequest request);
	public int getMainProfile(HttpServletRequest request);
	public int bookstoryWrite(HttpServletRequest request);  
	public int bookstoryHit(int idx) throws Exception;
	public BookStoryBoardDto bookstoryView(int idx);  
	public int bookstoryDelete(int idx);   
	public int bookStoryUpdate(BookStoryBoardDto dto); 
	public int bookstoryRelpyWrite(BookStoryBoardReplyDto replyDto); 
	public List<BookStoryBoardReplyDto> bookstoryReplyView(int idx);  
	public int bookStoryReplyDelete(int reply_no); 
	public int bookStoryReplyCount(int idx);  
	
	public ArrayList<BookStoryBoardDto> bookstoryList(HttpServletRequest request);
	public ArrayList<BookStoryBoardDto> bookstory_mainpopularList(HttpServletRequest request);   
	public List<BookStoryBoardDto> bookStoryCategory(String bs_category, String page); 
	public List<BookStoryBoardDto> bookStoryCategory2(String bs_category, String page);
	public List<BookStoryBoardDto> bookStoryCategory3(String bs_category, String page);
	public List<BookStoryBoardDto> bookstoryAllList(HttpServletRequest request,String page);
	public int contents_count(String bs_user_id);
	public int replys_count(String reply_writer);  
	    
	public int bookstorylike_check(int idx, int like_check) throws Exception;//좋아요 표시
	public int bookstorylike_check_cancle(int idx, int like_check) throws Exception;  //좋아요 취소 표시
	public int bookstorylike_cntup(int idx,int like_cnt);//좋아요수 증가
	public int bookstorylike_cntdown(int idx,int like_cnt);//좋아요수 감소
	
	
	 
	 
 
 }
