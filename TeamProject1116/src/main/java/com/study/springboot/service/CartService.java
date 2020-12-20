package com.study.springboot.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IProductDao;
import com.study.springboot.dto.CartDto;
import com.study.springboot.dto.Criteria;

@Primary
@Service
public class CartService implements ICartService{

	@Autowired
	IProductDao dao;
	
	@Override
	public void insertToCart(HttpServletRequest request) {
		
		String p_num = request.getParameter("p_number");
		String product_num = request.getParameter("number");
		String p_pri = request.getParameter("p_price");
		String p_discount = request.getParameter("p_discount_ratio");
		
		int p_number = Integer.parseInt(p_num);
		int product_number = Integer.parseInt(product_num);
		int p_price = Integer.parseInt(p_pri);
		int p_discount_ratio = Integer.parseInt(p_discount);
		int p_discount_price = p_price * (100-p_discount_ratio)/100;
		String user_id=(String)request.getSession().getAttribute("sessionID");
		String p_filename = request.getParameter("p_filename");
		String p_title = request.getParameter("p_title");
		String p_writer = request.getParameter("p_writer");
		
		CartDto dto = new CartDto();
		dto.setP_number(p_number);
		dto.setP_title(p_title);
		dto.setP_writer(p_writer);
		dto.setProduct_number(product_number);
		dto.setUser_id(user_id);
		dto.setP_discount_ratio(p_discount_ratio);
		dto.setP_price(p_price);
		dto.setP_filename(p_filename);
		dto.setReg(new Date());
		
		dao.CartDao(dto);	
	}

	@Override
	public List<CartDto> getCart(HttpServletRequest request,Criteria cri) {
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionID");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("id",user_id);
		map.put("cri", cri);
		return dao.getCartDao(map);
	}

	@Override
	public void deleteCart(HttpServletRequest request) {
		String s_idx = request.getParameter("idx");
		int idx = Integer.parseInt(s_idx);
		dao.deleteCartDao(idx);
	}

	@Override
	public int countCart(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String user_id = (String)session.getAttribute("sessionID");
		return dao.countCartDao(user_id);
	}


}
