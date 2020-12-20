package com.study.springboot.service;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Notice_Board_Dto;

public interface INoticeBoardService {
	
	public List<Notice_Board_Dto> list(int category);
	public Notice_Board_Dto view(String idx);
	public int write(HttpServletRequest request) throws ParseException;
	public int update(HttpServletRequest request);
	public int hit(String idx,int hit);
	public int delete(String idx);
	public int todayCheck(String date);
	public int todayCheck2(String date);
	public int todayCheck3(String date);
	public int todayCheck4(String date);
	public int newCheck();
	public int newCheck2();
	public int newCheck3();
	public int countOrder(int category);
	public List<Notice_Board_Dto> getList(Criteria cri,int category);
}
