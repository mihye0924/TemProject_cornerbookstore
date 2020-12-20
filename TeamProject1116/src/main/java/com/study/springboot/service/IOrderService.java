package com.study.springboot.service;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.ProductDto;

public interface IOrderService {
	public int orderwrite(HttpServletRequest request) throws ParseException;
	public OrderDto orderlist(int o_number);
	public List<OrderDto> list();
	public List<OrderDto> listbyUser(HttpServletRequest request,Criteria cri);
	public List<OrderDto> stateView(String o_state);
	public int state(String o_number,String o_state);
	public int cancelOrder(HttpServletRequest request);
	public int countOrder();
	public int countMemberOrder(HttpServletRequest request);
	public int countstateOrder(String state);
	public List<OrderDto> reviewToWriteList(HttpServletRequest request,Criteria cri);
	public int countReview(HttpServletRequest request);
	public List<OrderDto> SearchOrder(HttpServletRequest request);
	public List<OrderDto> getList(Criteria cri);
	
	
	//1117
	public Map<String,Integer> getUserOrderInfo(HttpServletRequest request);
}
