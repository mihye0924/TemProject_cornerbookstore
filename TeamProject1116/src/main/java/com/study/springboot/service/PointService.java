package com.study.springboot.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IOrderDao;
import com.study.springboot.dao.IPointDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.PointDto;

@Primary
@Service
public class PointService implements IPointService{
		
	@Autowired
	IPointDao PointDao;
	
	@Autowired
	PointDto PointDto;
	
	@Autowired
	IMemberDao MemberDao;
	
	@Autowired
	IOrderDao orderDao;
	 //회원가입
	@Override 
	public int insertPoint(HttpServletRequest request) {
		String id="";
		if(request.getParameter("memberId")==null) {
			id=(String)request.getAttribute("memberId");
		}else {
			id=request.getParameter("memberId");
		}
		MemberDto mem_dto = MemberDao.getUserInfoDao(id);
		int up=(int)Double.parseDouble(request.getParameter("uppoint")); 
		int down=(int)Double.parseDouble(request.getParameter("downpoint")); 
		int point=(int)(up-down);
		System.out.println(point);
		PointDto.setId_member(id);
		PointDto.setPt_content((String)request.getAttribute("content"));
		PointDto.setPt_move(point);
		PointDto.setPt_result(mem_dto.getPoint());
		PointDto.setReg(new Date());
		int nResult = PointDao.insertPointDao(PointDto); 
		return nResult; 

	}
	@Override 
	public List<PointDto> pointList(String id,Criteria cri) {
		HashMap <String,Object> map = new HashMap <String,Object>();
		map.put("id",id);
		map.put("cri",cri);
		return PointDao.pointListDao(map);
	}
	@Override 
	public int cancelPoint(HttpServletRequest request) {
		String o_num=request.getParameter("o_number");
		int o_number = Integer.parseInt(o_num);
		System.out.println(o_number);
		OrderDto o_dto = orderDao.orderlistDao(o_number);
		String id =o_dto.getO_orderid();
		String content="주문 취소로 인한 포인트 반환";
		int downPoint = o_dto.getO_point();
		int upPoint = (o_dto.getCount()*o_dto.getO_price())/(100/3);
		int point = downPoint-upPoint; 
		MemberDao.pointUpdateDao(point, id);
		PointDto.setId_member(id);
		PointDto.setPt_content(content);
		PointDto.setPt_move(point);
		MemberDto mem_dto = MemberDao.getUserInfoDao(id);
		PointDto.setPt_result(mem_dto.getPoint());
		PointDto.setReg(new Date());
		int nResult = PointDao.cancelPointDao(PointDto); 
		return nResult; 
	}
	@Override
	public int count(String id) {
		return PointDao.countDao(id);
	}

} 
