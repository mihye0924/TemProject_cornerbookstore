package com.study.springboot.dao;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Notice_Board_Dto;
import com.study.springboot.dto.OrderDto;

@Mapper
public interface IOrderDao {
	public int orderwriteDao(OrderDto dto);
	public OrderDto orderlistDao(int o_number);
	public List<OrderDto> listDao();
	public List<OrderDto> listbyUserDao(HashMap <String,Object> map);
	public List<OrderDto> stateviewDao(String o_state);
	public int stateDao(String o_number,String o_state);
	public int cancelOrderDao(int o_number);
	public List<OrderDto> reviewToWriteListDao(HashMap <String,Object> map); // 리뷰작성가능 리스트
	public int countReviewDao(String id,String r_state,String o_state);
	public int countOrderDao();
	public int countMemberOrderDao(String sessionID);
	public int countstateOrderDao(String state);
	public List<OrderDto> getListWithPaging(Criteria cri);
	
	//1117
	public int getUserOrderInfoDao(String id, int o_state);
	
	
}
