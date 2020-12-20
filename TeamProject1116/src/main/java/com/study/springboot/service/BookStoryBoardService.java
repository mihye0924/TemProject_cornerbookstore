package com.study.springboot.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.FileUploadService;
import com.study.springboot.dao.IBookStoryBoardDao;
import com.study.springboot.dto.BookStoryBoardDto;
import com.study.springboot.dto.BookStoryBoardReplyDto;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.ProductDto;
 
/*<!-- 1123수정 -->*/
@Primary
@Service
public class BookStoryBoardService implements IBookStoryBoardService { 
	
	@Autowired
	BookStoryBoardReplyDto replyDto; 
	@Autowired
	IBookStoryBoardDao bookstoryDao; 
	@Autowired
	BookStoryBoardDto bookstoryDto;
	
	@Autowired
	FileUploadService fileUploadService;
	 
	@Override
	public String uploadProfile(HttpServletRequest request, MultipartFile file, Model model) { 
		//프로필 이미지등록
		String originFilename=file.getOriginalFilename();
		String extName
		= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
		String saveFileName = fileUploadService.genSaveFileName(extName);
		System.out.println("이미지경로"+saveFileName);
		HttpSession session = request.getSession();
		MemberDto memberDto=(MemberDto)session.getAttribute("memberDto"); 
		memberDto.setBook_profile(saveFileName);
		System.out.println("출력:"+memberDto);
		bookstoryDao.uploadProfileDao(memberDto); 
		
		String url=fileUploadService.restore3(file); 
		model.addAttribute("url", url); 
		
		return saveFileName;
		 
	}
   
	//프로필 이미지 가져오기
	@Override
	public MemberDto getProfile(HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDto memberDto=(MemberDto)session.getAttribute("memberDto"); 
		MemberDto dto=bookstoryDao.getProfileDao(memberDto);
		System.out.println("nResult값"+dto);
		return dto;
	}

	//메인프로필 -아이디, 회원수
	@Override
	public int getMainProfile(HttpServletRequest request) { 
		HttpSession session=request.getSession();
		MemberDto dto=(MemberDto)session.getAttribute("memberDto");
		List<MemberDto> list=bookstoryDao.getMainfileDao();
		System.out.println("nResult값"+list.size());
		return list.size();
	}
	
	    
	@Override
	public int bookstoryWrite(HttpServletRequest request) {
		HttpSession session=request.getSession();
		String bs_user_id=(String)session.getAttribute("sessionID");
		String bs_category=request.getParameter("bs_category");
		
		String bs_title=request.getParameter("bs_title");
		String bs_content=request.getParameter("bs_content");
		String profile_img=request.getParameter("profile_img");  
		bookstoryDto.setBs_category(bs_category);
		bookstoryDto.setBs_title(bs_title);
		bookstoryDto.setBs_content(bs_content);
		bookstoryDto.setBs_user_id(bs_user_id);
		bookstoryDto.setProfile_img(profile_img); 
		bookstoryDto.setReg(new Date());  
		
		int nResult=bookstoryDao.bookstoryWriteDao(bookstoryDto);
		return nResult;
	}
 
	
	public int bookstoryHit(int idx) throws Exception {
		return bookstoryDao.bookstoryHitDao(idx);
	}

	@Override
	public BookStoryBoardDto bookstoryView(int idx) {
		BookStoryBoardDto dto=bookstoryDao.bookstoryViewDao(idx);
		return dto;
	} 
 
	@Override
	public int bookstoryDelete(int idx) {
		int nResult=bookstoryDao.bookstoryDeleteDao(idx);
		return nResult;
	}
    
	@Override
	public int bookStoryUpdate(BookStoryBoardDto bookstoryDto) {
		int nResult=bookstoryDao.bookstoryUpdateDao(bookstoryDto);
		return nResult;
	}
	
	@Override
	public int bookstoryRelpyWrite(BookStoryBoardReplyDto replyDto) {
		int nResult=bookstoryDao.bookstoryRelpyWriteDao(replyDto);
		return nResult;
	}
 
	@Override
	public List<BookStoryBoardReplyDto> bookstoryReplyView(int idx) {
		List<BookStoryBoardReplyDto> list=bookstoryDao.bookstoryReplyViewDao(idx);
		return list;
	}

	@Override
	public int bookStoryReplyDelete(int reply_no) {
		int nResult=bookstoryDao.bookStoryReplyDeleteDao(reply_no);
		return nResult;
	}
 

	@Override
	public int bookStoryReplyCount(int idx) {
		List<BookStoryBoardReplyDto> list=bookstoryDao.bookStoryReplyCountDao(idx);
		System.out.println("댓글수"+list.size());
		return list.size();
	}
	
 
	@Override
	public ArrayList<BookStoryBoardDto> bookstoryList(HttpServletRequest request) {
		ArrayList<BookStoryBoardDto> list=bookstoryDao.bookstoryListDao();
		return list;
	} 
   
  
	@Override
	public List<BookStoryBoardDto> bookstoryAllList(HttpServletRequest request,String page) {  
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 20; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		List<BookStoryBoardDto> list=bookstoryDao.bookstoryAllListDao(startRowNum, endRowNum);
		return list;
	} 

	@Override
	public List<BookStoryBoardDto> bookStoryCategory(String bs_category,String page) { 
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 20; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		List<BookStoryBoardDto> list=bookstoryDao.bookStoryCategory2Dao(bs_category,startRowNum, endRowNum);
		
		return list;
	}

	@Override
	public ArrayList<BookStoryBoardDto> bookstory_mainpopularList(HttpServletRequest request) { 
		ArrayList<BookStoryBoardDto> list=bookstoryDao.bookstory_mainpopularListDao();
		return list;
	}
 
  
	@Override
	public List<BookStoryBoardDto> bookStoryCategory2(String bs_category,String page) { 
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 4; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		List<BookStoryBoardDto> list=bookstoryDao.bookStoryCategory2Dao(bs_category,startRowNum, endRowNum);
		
		return list;
	}
	 
	
	@Override
	public List<BookStoryBoardDto> bookStoryCategory3(String bs_category,String page) { 
		int num_page_no = Integer.parseInt( page ); //page번호 1,2,3,4
		int num_page_size = 20; //한페이지당 Row갯수
		int startRowNum = (num_page_no - 1) * num_page_size + 1; // 1, 6, 11 페이지 시작 줄번호
		int endRowNum = (num_page_no * num_page_size); //5, 10, 15 페이지 끝 줄번호
		
		System.out.println("startRowNum:"+startRowNum);
		System.out.println("endRowNum:"+endRowNum);
		
		List<BookStoryBoardDto> list=bookstoryDao.bookStoryCategory2Dao(bs_category,startRowNum, endRowNum);
		
		return list;
	}
	 

	@Override
	public int contents_count(String bs_user_id) { 
		List<BookStoryBoardDto> list= bookstoryDao.contents_countDao(bs_user_id);
		return list.size();
	}

	@Override
	public int replys_count(String reply_writer) {
		List<BookStoryBoardReplyDto> list= bookstoryDao.replys_countDao(reply_writer);
		return list.size();
	}
	  
	@Override
	public int bookstorylike_check(int idx, int like_check) throws Exception {
		int like=bookstoryDao.bookstoryLike_checkDao(idx,like_check);
		return like;
	}   
	@Override
	public int bookstorylike_check_cancle(int idx,int like_check) throws Exception {
		int like_cancle=bookstoryDao.bookstorylike_check_cancleDao(idx,like_check);
		return like_cancle;
	}

	@Override
	public int bookstorylike_cntup(int idx,int like_cnt) {
		int like_cntup=bookstoryDao.bookstorylike_cntupDao(idx,like_cnt);
		return like_cntup;
	}

	@Override
	public int bookstorylike_cntdown(int idx,int like_cnt) {
		int like_cntdown=bookstoryDao.bookstorylike_cntdownDao(idx,like_cnt);
		return like_cntdown;
	}

	@Override
	public List<BookStoryBoardDto> bookstory_search(HttpServletRequest request) {
		String keyword = request.getParameter("bookstory-search");
		List<BookStoryBoardDto> list=bookstoryDao.bookstory_searchDao(keyword);
		return list;
	}
 
  
	 
}
