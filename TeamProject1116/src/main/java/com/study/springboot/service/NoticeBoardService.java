package com.study.springboot.service;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.INoticeDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Notice_Board_Dto;

@Service
@Primary
public class NoticeBoardService implements INoticeBoardService{
	
	@Autowired
	INoticeDao dao;
	
	
	@Override
	public List<Notice_Board_Dto> list(int category) {
		return dao.listDao(category);
	}
	@Override
	public Notice_Board_Dto view(String idx) {
		return dao.viewDao(idx);
	}
	@Override
	   public int write(HttpServletRequest request) throws ParseException {
	      String title = request.getParameter("text_Title");
	      String writer = request.getParameter("text_Writer");
	      String category = request.getParameter("n_Category");
	      String content = request.getParameter("text_Content");
	      Notice_Board_Dto dto = new Notice_Board_Dto();
	      dto.setN_title(title);
	      dto.setN_writer(writer);
	      dto.setCategory(Integer.parseInt(category));
	      dto.setN_content(content);
	      dto.setReg(new Date());
	      int nResult = dao.writeDao(dto);
	      return nResult;
	   }

	@Override
	   public int update(HttpServletRequest request) {
	      
	      String title = request.getParameter("text_Title");
	      String writer = request.getParameter("text_Writer");
	      String category = request.getParameter("n_Category");
	      String content = request.getParameter("text_Content");
	      String idx=request.getParameter("idx");
	      Notice_Board_Dto dto = new Notice_Board_Dto();
	      dto.setIdx(Integer.parseInt(idx));
	      dto.setN_title(title);
	      dto.setN_writer(writer);
	      dto.setCategory(Integer.parseInt(category));
	      dto.setN_content(content);
	      
	      int nResult = dao.updateDao(dto);
	      return nResult;
	   }
	@Override
	public int hit(String idx,int hit) {
		int nResult = dao.hitDao(idx,hit);
		return nResult;
	}
	@Override
	public int delete(String idx) {
		int nResult = dao.deleteDao(idx);
		return nResult;
	}
	
	@Override 
	public int todayCheck(String date) {
		int nResult = dao.todayCheckDao(date);
		return nResult;
	}
	@Override 
	public int todayCheck2(String date) {
		int nResult = dao.todayCheckDao2(date);
		return nResult;
	}
	@Override 
	public int todayCheck3(String date) {
		int nResult = dao.todayCheckDao3(date);
		return nResult;
	}
	@Override 
	public int todayCheck4(String date) {
		int nResult = dao.todayCheckDao4(date);
		return nResult;
	}
	@Override 
	public int newCheck() {
		String state="미등록";
		int nResult = dao.newCheckDao(state);
		return nResult;
	}
	@Override 
	public int newCheck2() {
		String state="미등록";
		int nResult = dao.newCheckDao2(state);
		return nResult;
	}
	@Override 
	public int newCheck3() {
		String state="미등록";
		String type1="교환문의";
		String type2="반품문의";
		int nResult = dao.newCheckDao3(state,type1,type2);
		return nResult;
	}
	@Override
	public int countOrder(int category) {
	return dao.countOrderDao(category);
	}
	@Override
	public List<Notice_Board_Dto> getList(Criteria cri,int category) {
		HashMap <String,Object> map = new HashMap<String,Object>();
		map.put("category",category);
		map.put("cri",cri);
		return dao.getListWithPaging(map);
	}
}
