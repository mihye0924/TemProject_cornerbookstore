package com.study.springboot.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.Notice_Board_Dto;

@Mapper
public interface INoticeDao {
	public List<Notice_Board_Dto> listDao(int category);
	
	public Notice_Board_Dto viewDao(String idx);
	public int writeDao(Notice_Board_Dto dto);
	public int hitDao(String idx,int hit);
	public int updateDao(Notice_Board_Dto dto);
	public int deleteDao(String idx);
	public int todayCheckDao(String date);//신규회원 Member
	public int todayCheckDao2(String date);//상품등록수 Product
	public int todayCheckDao3(String date);//상품주문수 Order
	public int todayCheckDao4(String date);//탈퇴회원 Delete_member
	public int newCheckDao(String state); // 상품문의
	public int newCheckDao2(String state); // 1:1문의 전부 
	public int newCheckDao3(String state,String type1,String type2); // 1:1문의 교환/환불신청
	public int countOrderDao(int category);
	public List<Notice_Board_Dto> getListWithPaging(HashMap <String,Object> map);
}
