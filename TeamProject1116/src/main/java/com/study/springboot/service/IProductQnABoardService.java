package com.study.springboot.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OnetoOneBoardDto;
import com.study.springboot.dto.ProductDto;
import com.study.springboot.dto.Product_QnA_Board_Dto;

public interface IProductQnABoardService {
	public int ProductQnABoard(HttpServletRequest request);
	public List<Product_QnA_Board_Dto> viewProductQnABoardDao(int p_number);
	public Product_QnA_Board_Dto viewProductQnABoardDao2(int idx);
	public List<Product_QnA_Board_Dto> viewAllProductQnA();
	public ProductDto viewProductInfo(int p_number);
	public int AnswerProductQuestion(HttpServletRequest request);
	public int ProductAnswerDelete(HttpServletRequest request);
	
	
	//1116 productQnA 목록
	public List<Product_QnA_Board_Dto> myProductQnAList(HttpServletRequest request,Criteria cri);
	public List<Product_QnA_Board_Dto> myProductQnAList2(HttpServletRequest request);
	public int countMyProductQnA(HttpServletRequest request);
	public List<Product_QnA_Board_Dto> SearchmyProductQnA(HttpServletRequest request);
	public List<Product_QnA_Board_Dto> noAnswerQnA(HttpServletRequest request);
	public Product_QnA_Board_Dto MyProductQnAView(HttpServletRequest request);
	
	public List<OnetoOneBoardDto> onetoonelistDao(HttpServletRequest request);
	//1118 상품문의 삭제
	public int DeleteMyProductQnA(HttpServletRequest request);
	
	//1124 상품문의 페이징
	public List<Product_QnA_Board_Dto> viewAllProductQnAWithPaging(Criteria cri);
	public int countPrductQnA();
	public List<Product_QnA_Board_Dto> noAnswerQnAAdmin(HttpServletRequest request);
	//1124 상품문의 검색
	public List<Product_QnA_Board_Dto> searchProductQnAAdmin(HttpServletRequest request);
	
}
