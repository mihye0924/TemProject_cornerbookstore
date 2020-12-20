package com.study.springboot.service;

import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IOrderDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OrderDto;

@Service
@Primary
public class OrderService implements IOrderService{
	@Autowired
	IOrderDao dao;
	@Autowired
	IMemberDao dao2;
	
	@Override
	 public int orderwrite(HttpServletRequest request) throws ParseException {
		OrderDto dto = new OrderDto();
	      dto.setO_receiver(request.getParameter("recive")); 
	      dto.setO_phone(request.getParameter("phone"));
	      dto.setP_number(Integer.parseInt(request.getParameter("p_num")));
	      dto.setCount(Integer.parseInt(request.getParameter("count")));
	      dto.setO_orderid(request.getParameter("memberId")); //멤버아이디
	      dto.setO_price(Integer.parseInt(request.getParameter("price")));
	      dto.setO_address(request.getParameter("newaddress1") + request.getParameter("newaddress2")
	      +request.getParameter("newaddress3")+request.getParameter("newaddress4"));
	      dto.setO_point(Integer.parseInt(request.getParameter("downpoint")));
	      dto.setO_memo(request.getParameter("memo"));
	      dto.setO_charge(request.getParameter("purchase"));
	      dto.setP_filename(request.getParameter("p_filename"));
	      dto.setO_total(Integer.parseInt(request.getParameter("price"))+2500);
	      dto.setO_state("1");
	      dto.setO_charge2(request.getParameter("Card"));
	      dto.setP_title(request.getParameter("p_title"));
	      dto.setP_writer(request.getParameter("p_writer"));
	      dto.setReg(new Date());
	      dto.setReview_state(0);
	      dao.orderwriteDao(dto);
	      int nResult = dto.getO_number();
	      return nResult;
	   }
	
	@Override
	public OrderDto orderlist(int o_number) {
		return dao.orderlistDao(o_number);
	}
	@Override
	public List<OrderDto> list() {
		return dao.listDao();
	}
	
	@Override
	public List<OrderDto> listbyUser(HttpServletRequest request,Criteria cri) {
		HttpSession session = request.getSession();
		HashMap <String,Object> map = new HashMap <String,Object>();
		String sessionID = (String)session.getAttribute("sessionID");
		map.put("id",sessionID);
		map.put("cri",cri);
		return dao.listbyUserDao(map);
	}
	
	@Override
	public List<OrderDto> stateView(String o_state) {
		return dao.stateviewDao(o_state);
	}
	@Override
	 public int state(String o_number,String o_state)  {
	      int nResult = dao.stateDao(o_number, o_state);
	      return nResult;
	   }

	@Override
	public int cancelOrder(HttpServletRequest request) {
		String o_num=request.getParameter("o_number");
		int o_number = Integer.parseInt(o_num);
		System.out.println("o_number?"+o_number);
		
		dao.cancelOrderDao(o_number);
		return 0;
	}

	@Override
	   public List<OrderDto> reviewToWriteList(HttpServletRequest request,Criteria cri) {
	      HttpSession session = request.getSession();
	      String o_orderID = (String)session.getAttribute("sessionID");
	      HashMap <String,Object> map = new HashMap <String,Object>();
	      String r_state = "0";
	      String o_state = "5";
	      map.put("id",o_orderID);
	      map.put("r_state",r_state);
	      map.put("o_state",o_state);
	      map.put("cri",cri);
	      return dao.reviewToWriteListDao(map);
	   }

	@Override
	public List<OrderDto> SearchOrder(HttpServletRequest request) {
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		List<OrderDto> list = dao2.SearchOrderDao(fromDate, toDate);
		return list;
	}
	@Override
	public int countOrder() {
		dao.countOrderDao();
		return dao.countOrderDao();
	}
	@Override
	public int countstateOrder(String state) {
		dao.countstateOrderDao(state);
		return dao.countstateOrderDao(state);
	}
	//페이징 처리
		@Override
		public List<OrderDto> getList(Criteria cri) {
			return dao.getListWithPaging(cri);
		}

		@Override
		public int countMemberOrder(HttpServletRequest request) {
			HttpSession session = request.getSession();
			String sessionID = (String)session.getAttribute("sessionID");
			return dao.countMemberOrderDao(sessionID);
		}

		@Override
		public int countReview(HttpServletRequest request) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("sessionID");
			return dao.countReviewDao(id, "0", "5");
		}

		@Override
		public Map<String,Integer> getUserOrderInfo(HttpServletRequest request) {
			HttpSession session = request.getSession();
			String sessionID = (String)session.getAttribute("sessionID");
			Map<String,Integer> map= new HashMap();
			
			map.put("del1", dao.getUserOrderInfoDao(sessionID, 1));
			map.put("del2", dao.getUserOrderInfoDao(sessionID, 2));
			map.put("del3", dao.getUserOrderInfoDao(sessionID, 3));
			map.put("del4", dao.getUserOrderInfoDao(sessionID, 4));
			map.put("del5", dao.getUserOrderInfoDao(sessionID, 5));
			
			return map;
		}
		
	
}
