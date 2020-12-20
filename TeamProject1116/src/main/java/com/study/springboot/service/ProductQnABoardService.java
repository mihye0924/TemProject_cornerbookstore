package com.study.springboot.service;


import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IProductDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OnetoOneBoardDto;
import com.study.springboot.dto.ProductDto;
import com.study.springboot.dto.Product_QnA_Board_Dto;
@Primary
@Service
public class ProductQnABoardService implements IProductQnABoardService{
	
	@Autowired
	IProductDao dao;
	
	@Override
	public int ProductQnABoard(HttpServletRequest request) {
		Product_QnA_Board_Dto dto = new Product_QnA_Board_Dto();
			
		String p_num = request.getParameter("p_number"); //상품번호
		int p_number = Integer.parseInt(p_num);
		String p_answer_state = request.getParameter("p_answer_state");
		String p_content = request.getParameter("p_content");  //질문 내용
		String p_title = request.getParameter("p_title");
		String p_writer = request.getParameter("p_writer");
		HttpSession session = request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		Date date= new Date();
		int x=0;
		if (sessionID==null) {	
			x=1;
		}else if(sessionID!=null){
		dto.setP_number(p_number);
		dto.setP_title(p_title);
		dto.setP_writer(p_writer);
		dto.setP_content(p_content);
		dto.setP_answer_state(p_answer_state);
		dto.setId(sessionID);
		dto.setReg(date);
		dao.ProductQnABoardDao(dto);
		    x=0;
		}
		return x;
	}

	@Override
	public List<Product_QnA_Board_Dto> viewProductQnABoardDao(int p_number) {
		List<Product_QnA_Board_Dto> list=dao.viewProductQnABoardDao(p_number);
		return list;
	}

	@Override
	public List<Product_QnA_Board_Dto> viewAllProductQnA() {
		return dao.viewAllProductQnABoardDao();
	}
	
	//1124
	@Override
	public List<Product_QnA_Board_Dto> viewAllProductQnAWithPaging(Criteria cri){
		return dao.getListWithPaging2Dao(cri);
	}
	
	//1124
	@Override
	public int countPrductQnA() {
		return dao.countProduct2Dao();
	}
	

	@Override
	public ProductDto viewProductInfo(int p_number) {
		return dao.viewProductDetailDao(p_number);
	}

	@Override
	public Product_QnA_Board_Dto viewProductQnABoardDao2(int idx) {
		return dao.viewProductQnABoardDao2(idx);
	}

	@Override
	public int AnswerProductQuestion(HttpServletRequest request) {
		String s_idx=request.getParameter("idx");
		int idx = Integer.parseInt(s_idx);
		String p_answer=request.getParameter("p_answer");
		String p_answer_state=request.getParameter("p_answer_state");
		dao.AnswerProductQuestionDao(p_answer,p_answer_state, idx);
		return 0;
	}

	@Override
	public int ProductAnswerDelete(HttpServletRequest request) {
		String s_idx = request.getParameter("idx");
		 int idx = Integer.parseInt(s_idx);
		 String p_answer_state="미등록";
		 dao.ProductAnswerDeleteDao(idx, p_answer_state);
		return 0;
	}

	@Override
	public List<Product_QnA_Board_Dto> myProductQnAList(HttpServletRequest request,Criteria cri) {
		HttpSession session = request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("id", sessionID);
		map.put("cri", cri);
		return dao.myProductQnAListDao(map);
	}

	@Override
	public List<Product_QnA_Board_Dto> SearchmyProductQnA(HttpServletRequest request) {
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		HttpSession session =request.getSession();
		String id = (String)session.getAttribute("sessionID");
		return dao.SearchmyProductQnADao(category, keyword, id);
	}

	@Override
	public List<Product_QnA_Board_Dto> noAnswerQnA(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		String answerCheck="미등록";
		return dao.noAnswerQnADao(sessionID,answerCheck);
	}

	@Override
	public Product_QnA_Board_Dto MyProductQnAView(HttpServletRequest request) {
		String s_idx = request.getParameter("idx");
		int idx=Integer.parseInt(s_idx);
		return dao.MyProductQnAViewDao(idx);
	}

	@Override
	public int countMyProductQnA(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String sessionID=(String)session.getAttribute("sessionID");
		return dao.countMyProductQnADao(sessionID);
	}

	@Override
	public List<Product_QnA_Board_Dto> myProductQnAList2(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sessionID");	
		return dao.myProductQnAListDao2(id);
	}

	@Override
	public List<OnetoOneBoardDto> onetoonelistDao(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sessionID");
		return dao.onetoonelistDao(id);
	}

	@Override
	public int DeleteMyProductQnA(HttpServletRequest request) {
		String s_idx = request.getParameter("idx");
		int idx = Integer.parseInt(s_idx);
		dao.DeleteMyProductQnADao(idx);
		return 0;
	}

	//1124
	@Override
	public List<Product_QnA_Board_Dto> noAnswerQnAAdmin(HttpServletRequest request) {
		String check="미등록";
		return dao.noAnswerProductQnaDao(check);
	}

	//1124
	@Override
	public List<Product_QnA_Board_Dto> searchProductQnAAdmin(HttpServletRequest request) {
		String category = request.getParameter("check_category");
		String keyword = request.getParameter("keyword");
		return dao.searchProductQnAAdminDao(category, keyword);
	}
	
	
	
	
	
}
