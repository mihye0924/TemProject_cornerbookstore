package com.study.springboot.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Review_Board_Dto;

public interface IReviewBoardService {

	public int writeReview(HttpServletRequest request, MultipartFile file, Model model);
	public List<Review_Board_Dto> viewWrittenReview(HttpServletRequest request,Criteria cri);
	public int changeReviewState(int i,int o_number);
	public List<Review_Board_Dto> productReviewList(HttpServletRequest request);
	public List<Review_Board_Dto> reviewlist();
	public int deleteReview(HttpServletRequest request);
	public int countReviewComplete(HttpServletRequest request);
	
	public Review_Board_Dto modifyReviewForm(HttpServletRequest request);
	public int modifyReview(HttpServletRequest request, MultipartFile file, Model model);

}
