package com.study.springboot.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.CartDto;
import com.study.springboot.dto.Criteria;

public interface ICartService {

	public void insertToCart(HttpServletRequest request);
	
	public List<CartDto> getCart(HttpServletRequest request,Criteria cri);
	public int countCart(HttpServletRequest request);
	public void deleteCart(HttpServletRequest request);
}
