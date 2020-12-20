 
package com.study.springboot;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.coyote.RequestGroupInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.INoticeDao; 
import com.study.springboot.dto.BookStoryBoardDto;
import com.study.springboot.dto.BookStoryBoardReplyDto;
import com.study.springboot.dto.CartDto;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.MailDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OnetoOneBoardDto;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.ProductDto;
import com.study.springboot.dto.Product_QnA_Board_Dto;
import com.study.springboot.dto.Review_Board_Dto;
import com.study.springboot.service.IBookStoryBoardService;
import com.study.springboot.service.ICartService;
import com.study.springboot.service.IMemberService;
import com.study.springboot.service.INoticeBoardService;
import com.study.springboot.service.IOnetoOneBoardService;
import com.study.springboot.service.IOrderService;
import com.study.springboot.service.IPointService;
import com.study.springboot.service.IProductQnABoardService;
import com.study.springboot.service.IProductService;
import com.study.springboot.service.IReviewBoardService;
import com.study.springboot.service.MailService;
import com.study.springboot.service.MemberService;

import lombok.AllArgsConstructor;
 
@AllArgsConstructor
@Controller
public class MyController_M {
	@Autowired
	FileUploadService fileUploadService;
	@Autowired
	IMemberService member_service;
	@Autowired
	INoticeDao notice_dao;
	@Autowired
	IMemberDao member_dao;
	@Autowired
	INoticeBoardService notice_service;
	@Autowired
	IProductService product_service;
	@Autowired
	IProductQnABoardService pro_qna_service;
	@Autowired
	IOrderService order_service;
	@Autowired
	ICartService cart_service;
	@Autowired
    IOnetoOneBoardService oneBoardservice; 
	@Autowired
	MailService mailService;  
	@Autowired
	IBookStoryBoardService bookstory_service;
	@Autowired
	MailDto mailDto;
	@Autowired
	IReviewBoardService review_service;
	@Autowired
	IPointService point_service;
	@Autowired
	MemberDto storyboardmemberdto;
	
	/////구매프로세스//////
   @RequestMapping("/purchase")
    public String purchase1(HttpServletRequest request,Model model) {
      HttpSession session = request.getSession();
      String id = (String)session.getAttribute("sessionID");
      String p_num = request.getParameter("p_number");
      int p_number = Integer.parseInt(p_num);
      System.out.println("p_number?"+p_number);
      if (id==null) {
    	  model.addAttribute("msg","로그인이 필요합니다.");
    	  model.addAttribute("url","/Product_detail?p_number="+p_number);
    	  return "redirect";
      }else {
	      ProductDto dto=product_service.viewProductDetail(p_number);
	      model.addAttribute("dto",dto);
	      model.addAttribute("p_discount_ratio",request.getParameter("p_discount_ratio"));
	      model.addAttribute("count",request.getParameter("number"));
	      model.addAttribute("price",request.getParameter("p_price"));
	      MemberDto m_dto = member_service.getUserInfo(id);
	      model.addAttribute("m_dto",m_dto);
      return "purchase/purchase"; }
    }
	
   @RequestMapping("/purchaseAction") //1111
   public String purchaseAction(HttpServletRequest request,Model model)throws Exception {
     
     int nResult = order_service.orderwrite(request);
     
		 member_service.pointupdate(request);
     request.setAttribute("content","["+request.getParameter("p_title")+"] "+"구매");
		point_service.insertPoint(request);
     String p_num = request.getParameter("p_num");
     if( nResult <= 0 ) {
          model.addAttribute("msg","구매실패");
          model.addAttribute("url","MainForm");
     }else {
         model.addAttribute("msg","구매 성공");
         model.addAttribute("url","/purchase_check?o_number="+nResult+"&p_number="+p_num);
     } 
        return "redirect";   
  }
  @RequestMapping("/purchase_check")
   public String purchaseCheck(HttpServletRequest request,Model model)throws Exception {
       String o_num = request.getParameter("o_number");
       String p_num = request.getParameter("p_number");
       ProductDto p_dto=product_service.viewProductDetail(Integer.parseInt(p_num));
       int o_number = Integer.parseInt(o_num);
       OrderDto dto=order_service.orderlist(o_number);
       model.addAttribute("p_dto",p_dto);
       model.addAttribute("dto",dto);
       return "purchase/purchase_check";   
 }
	
///////사용자 폼///////
    @RequestMapping("/") 
	public String root(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
    	int category=3;
		model.addAttribute("carousel",notice_dao.listDao(category));
		category=1;
		System.out.println("리뷰리스트는 "+review_service.reviewlist());
		model.addAttribute("review",review_service.reviewlist());
		model.addAttribute("notice",notice_dao.listDao(category));
		model.addAttribute("list",product_service.bookCategory2Dao("신간"));
		model.addAttribute("list2",product_service.bookCategory2Dao("인기"));
		model.addAttribute("list3",product_service.bookCategory2Dao("추천"));
		
		Cookie[] cookies = request.getCookies(); 
		 if(cookies != null) {
			 for(Cookie cookie : cookies) {  
				 if(cookie.getName().equals("id")) {
					 session.setAttribute("id", cookie.getValue()); 
					 System.out.println("쿠키아이디"+cookie.getValue());  
			 	} 
				 if(cookie.getName().equals("password")) {
					 session.setAttribute("password", cookie.getValue());
					 System.out.println("쿠키비번"+cookie.getValue());  
				 }
			 } 
		 }
		 
	   	String id=(String)session.getAttribute("id");
	   	String password=(String)session.getAttribute("password");  
	   	System.out.println("id쿠키아뒤"+id);
	   	System.out.println("pw쿠키비번"+password);
  	
	   	if(id!=null && password!=null) {
	   	 	 //로그인시 id로 쿠키설정 
			int Autologin = member_service.AutologinCheck(id, password);
			System.out.println("Autologin"+Autologin);
			if( Autologin <= 0 ) {
				System.out.println("자동로그인 실패");
				return "LoginForm";
		        
			}else {  	 
				System.out.println("자동로그인 성공");
				
				MemberDto dto=member_service.getUserInfo(id);
				session.setAttribute("memberDto", dto);
				System.out.println("세션DTO:"+dto); 
		   		session.setAttribute("sessionID", id);    
				model.addAttribute("msg","로그인 성공");
	            model.addAttribute("url","MainForm");
				
				
				return "redirect";
			 } 
	   	}else {
	   		return "MainForm";
	   	}
		}
    
	//메인폼
	@RequestMapping("/MainForm")
	public String MainForm(Model model){
		int category=3;
		model.addAttribute("carousel",notice_dao.listDao(category));
		category=1;
		model.addAttribute("review",review_service.reviewlist());
		model.addAttribute("notice",notice_dao.listDao(category));
		model.addAttribute("list",product_service.bookCategory2Dao("신간"));
		model.addAttribute("list2",product_service.bookCategory2Dao("인기"));
		model.addAttribute("list3",product_service.bookCategory2Dao("추천")); 
		 
		return "MainForm";
		}   
	 
	
	//카테고리 1(소설, 인문학,자기계발 등)
	@RequestMapping(value= {"/novel","/art","/humanities","/records","/independent","/essay","/self-improvement","/economics"})
	public String bookCategory1(HttpServletRequest request, Model model) {
		String requestUrl=(String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String nextUrl="";
		if(requestUrl.equals("/novel")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("소설"));
			nextUrl="category/novel";}
		else if(requestUrl.equals("/art")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("예술"));
			nextUrl="category/art";}
		else if(requestUrl.equals("/humanities")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("인문학"));
			nextUrl="category/humanities";}
		else if(requestUrl.equals("/records")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("음반"));
			nextUrl="category/records";}
		else if(requestUrl.equals("/independent")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("독립서적"));
			nextUrl="category/independent";}
		else if(requestUrl.equals("/essay")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("시/에세이"));
			nextUrl="category/essay";}
		else if(requestUrl.equals("/self-improvement")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("자기계발"));
			nextUrl="category/self-improvement";}
		else if(requestUrl.equals("/economics")) {
			model.addAttribute("dto",product_service.bookCategory1Dao("경제/경영"));
			nextUrl="category/economics";}
			return nextUrl;}	
	
	//카테고리 2(인기, 신간, 추천 등)
	@RequestMapping(value = {"/AllBook","/NewBook", "/BestBook","/RecommendBook"})
	public String bookCategory2(HttpServletRequest request, Model model) {
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String nextUrl = "";
		if (requestUrl.equals("/AllBook")) {
			Criteria cri = new Criteria(1,9);
			int bookcnt=product_service.countProduct();
			int allPageNum; 
			if(bookcnt%5==0) {
				allPageNum =bookcnt/9;
			}else {
				allPageNum =bookcnt/9+1; 
			}
			model.addAttribute("dto",product_service.getAllBook(cri));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);
			nextUrl = "category/AllBook"; }
		else if (requestUrl.equals("/NewBook")) {
			model.addAttribute("dto",product_service.bookCategory2Dao("신간"));
			nextUrl = "category/NewBook"; }
		else if (requestUrl.equals("/BestBook")) {
			model.addAttribute("dto",product_service.bookCategory2Dao("인기"));
			nextUrl = "category/BestBook"; }
		else if (requestUrl.equals("/RecommendBook")) {
			model.addAttribute("dto",product_service.bookCategory2Dao("추천"));
			nextUrl = "category/RecommendBook"; }
		return nextUrl;}	
	
	
	@RequestMapping("/allBookPage")
	public String allBookPage(HttpServletRequest request,Model model) {
		String s_no=request.getParameter("no");
		int no = Integer.parseInt(s_no);
		Criteria cri = new Criteria(no,9);
		
		model.addAttribute("dto",product_service.getAllBook(cri));
		int bookcnt=product_service.countProduct();
		int allPageNum; 
		if(bookcnt%9==0) {
			allPageNum =bookcnt/9;
		}else {
			allPageNum =bookcnt/9+1; 
		}
		request.setAttribute("allPageNum", allPageNum);
		return "category/AllBook";
	}
	
	
	//회원가입 폼 
	@RequestMapping("/JoinForm")
	public String JoinForm() {return "member/JoinForm";} 
	//로그인 폼
	@RequestMapping("/LoginForm")
	public String LoginForm() {return "member/LoginForm";} 
	
	//주문목록 폼
	@RequestMapping("/OrderList")
	public String OrderList(HttpServletRequest request,Model model) {
		Criteria cri = new Criteria(1,7);
		int bookcnt=order_service.countMemberOrder(request);
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		request.setAttribute("list",order_service.listbyUser(request, cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		
		return "member/OrderList";
	} 
	
	//주문 기간 검색 로직
	@RequestMapping("/SearchOrder")
	public String SearchOrder(HttpServletRequest request,Model model) {
		List<OrderDto> list=order_service.SearchOrder(request);
		System.out.println("list는 "+list);
		model.addAttribute("list",list);
		return "member/OrderList";
	}
	
	//주문취소 로직
	@RequestMapping("/cancelOrder")
	public String cancelOrder(HttpServletRequest request,Model model) {
		point_service.cancelPoint(request);
		order_service.cancelOrder(request);
		model.addAttribute("url","/OrderList");
		model.addAttribute("msg","주문이 취소되었습니다.");
		return "redirect";
	}
	
	//장바구니 폼
			@RequestMapping("/Basket")
			public String Basket(HttpServletRequest request,Model model) {
				Criteria cri = new Criteria(1,7);
				int bookcnt=cart_service.countCart(request);
				int allPageNum; 
				if(bookcnt%7==0) {
					allPageNum =bookcnt/7;
				}else {
					allPageNum =bookcnt/7+1; 
				}
				request.setAttribute("list",cart_service.getCart(request, cri));
				cri.setAllPageNum(allPageNum);
				request.setAttribute("allPageNum", allPageNum);
				
				return "member/Basket";
			}
		
	//장바구니 폼 추가 로직
	@RequestMapping("/addBasket")
	public String addBasket(HttpServletRequest request,Model model) {	
		HttpSession session = request.getSession();
	    String id = (String)session.getAttribute("sessionID");
		if(id==null) {
			model.addAttribute("url","/LoginForm");
			model.addAttribute("msg","로그인이 필요합니다.");
		}else if(id!=null) {
			cart_service.insertToCart(request);
			model.addAttribute("url","/Basket");
			model.addAttribute("msg","상품이 장바구니에 추가되었습니다.");
		}
		return "redirect";
	}  
	
	@RequestMapping("/deleteCart")
	public String deleteCart(HttpServletRequest request,Model model) {
		cart_service.deleteCart(request);
		model.addAttribute("url","/Basket");
		model.addAttribute("msg","장바구니에서 삭제되었습니다.");
		return "redirect";
	}
	
	//상품후기 폼
		@RequestMapping("/ProductReivew")
		public String ProductReivew(HttpServletRequest request,Model model) {
			Criteria cri = new Criteria(1,7);
			int bookcnt=order_service.countReview(request);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("list",order_service.reviewToWriteList(request, cri));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);
			return "member/ProductReivew";
	}    
	
	//상품후기작성 폼
	@RequestMapping("/ProductReviewWrite")
	public String ProductReivewWrite(HttpServletRequest request,Model model) {
		String p_num = request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		String o_num = request.getParameter("o_number");
		int o_number = Integer.parseInt(o_num);
		String p_title = request.getParameter("p_title");
		String o_orderid = request.getParameter("o_orderid");
		model.addAttribute("p_title",p_title);
		model.addAttribute("o_orderid",o_orderid);
		model.addAttribute("p_number",p_number);
		model.addAttribute("o_number",o_number);
		return "member/ProductReviewWrite";
	}
	
	//상품후기작성 로직
	@RequestMapping(value="/WriteReviewAction",  method = RequestMethod.POST)
	public String WriteReviewAction(HttpServletRequest request, Model model, 
			@RequestParam("p_filename") MultipartFile file) {
		review_service.writeReview(request,file,model);  //상품 후기 쓰기
		String o_num = request.getParameter("o_number");
		int o_number = Integer.parseInt(o_num);
		review_service.changeReviewState(1,o_number);
		model.addAttribute("msg","상품후기 작성이 완료되었습니다.");
		model.addAttribute("url","/ProductReviewComplete");
		return "redirect";}  	
	
	//상품완료후기 폼
	@RequestMapping("/ProductReviewComplete")
	public String ProductReviewComplete(HttpServletRequest request, Model model) {	
		Criteria cri = new Criteria(1,7);
		int bookcnt=review_service.countReviewComplete(request);
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		request.setAttribute("list",review_service.viewWrittenReview(request, cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		return "member/ProductReviewComplete";
	}
		 
	
	//1:1문의 폼
	@RequestMapping("/OneBoard")
	public String OneBoard() {return "member/OneBoard";}  
	//1:1문의 작성폼
	@RequestMapping("/OneBoardWrite")
	public String OneBoardWrite() {return "member/OneBoardWrite";}  
	//개인정보폼
	@RequestMapping("/MyInfo")
	public String MyInfo() {return "member/MyInfo";}   
	//아이디찾기 폼
	@RequestMapping("/IdCheckForm")
	public String IdCheckForm() {return "member/IdCheckForm";}     
	//비밀번호찾기 폼
	@RequestMapping("/PwCheckForm")
	public String PwCheckForm() {return "member/PwCheckForm";} 
   
    //이용약관 폼
    @RequestMapping("/TermOfUse")
    public String TermOfUse() {return "member/TermOfUse";}    
    //개인정보 이용 동의 폼
    @RequestMapping("/PrivacyPolicy")
    public String PrivacyPolicy() {return "member/PrivacyPolicy";}   
	
	//상품상세페이지
	@RequestMapping(value={"/Product_detail","/ProductDetail2","/ProductDetail4"})
	public String Product_detail(HttpServletRequest request,Model model) {
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String nextUrl = "";
		String p_num = request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		ProductDto dto=product_service.viewProductDetail(p_number);
		model.addAttribute("dto",dto);
		if(requestUrl.equals("/Product_detail")) {
			nextUrl="Product_detail";
		}else if(requestUrl.equals("/ProductDetail2")) {
			nextUrl="productdetail/ProductDetail2";
		}else if(requestUrl.equals("/ProductDetail4")) {
			model.addAttribute("list",pro_qna_service.viewProductQnABoardDao(p_number));
			nextUrl="productdetail/ProductDetail4";}
		return nextUrl;}
	
	@RequestMapping("/ProductDetail3")
	public String ProductDetail3(HttpServletRequest request,Model model) {
		String p_num = request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		ProductDto dto=product_service.viewProductDetail(p_number);
		model.addAttribute("dto",dto);
		
		List<Review_Board_Dto> list=review_service.productReviewList(request);
		System.out.println("list는 "+list);
		model.addAttribute("list",list);
		
		return "productdetail/ProductDetail3";
	}
		
	//상품상세페이지 > 상품 문의 > 상품 문의 등록 로직
	@RequestMapping("/ProductQnABoard")
	public String ProductQnABoard(HttpServletRequest request, Model model){
		String p_num = request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		int nResult=pro_qna_service.ProductQnABoard(request);
		if (nResult==1) {
			model.addAttribute("msg","로그인이 필요합니다.");
			model.addAttribute("url","/ProductDetail4?p_number="+p_number);
		} else if(nResult==0) {
			ProductDto dto=product_service.viewProductDetail(p_number);
			model.addAttribute("msg","문의가 등록되었습니다.");
			model.addAttribute("url","/ProductDetail4?p_number="+p_number);	
		}return "redirect";
	}

	// 사용자 회원가입 로직
	@RequestMapping(value="/MemberJoinAction", method=RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String MemberJoinAction(HttpServletRequest request, Model model) throws Exception {	
		request.setCharacterEncoding("utf-8"); // 인코딩		
		int nResult = member_service.insertMember( request );
		if( nResult <= 0 ) {
	        model.addAttribute("msg","회원가입 실패");
	        model.addAttribute("url","member/JoinForm");
		}else {
			model.addAttribute("msg","회원가입 성공");
            model.addAttribute("url","MainForm");
		}    
		return "redirect"; 
	}
	
	 //회원가입 아이디 중복체크 로직
	 @RequestMapping("/idCheck")
	 public void idCheck(HttpServletRequest request,HttpServletResponse response) throws IOException {
	      String id = request.getParameter("userId");
	      String dbid=member_service.idCheck(id);  
	      if(dbid!=null) {
	         if(id.equals(dbid)) {response.getWriter().print("1");}
	         else { response.getWriter().print("0");}
	      }
	   }
  
	  //로그인 검사
	    @RequestMapping(value="/MemberLoginAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	 	public String loginCheck(HttpServletRequest request, HttpSession session, Model model, HttpServletResponse response) throws IOException{  	
	    	
	    	
	    	String id=request.getParameter("id");
	    	String password=request.getParameter("password");  
	    	String keepLogin=request.getParameter("keepLogin");
	    	System.out.println("keepLogin:"+keepLogin);
	    	 
	    	
			int nResult = member_service.loginCheck(id, password);
			if( nResult <= 0 ) {
				System.out.println("로그인 실패");
		        model.addAttribute("msg","로그인 실패 - 아이디나 암호를 확인해주세요");
		        model.addAttribute("url","LoginForm");
			}else {
				
				if(keepLogin!=null) {  
					//로그인시 id로 쿠키설정
					if(keepLogin.equals("true")){
						Cookie cookieId=new Cookie("id",id);
						Cookie cookiePW=new Cookie("password",password);
						cookieId.setMaxAge(60*60*24*14);//2주간
						cookiePW.setMaxAge(60*60*24*14);
						response.addCookie(cookieId);
						response.addCookie(cookiePW);
						System.out.println("쿠키id생성");
					}else {
						Cookie[] cookies=request.getCookies();
						if(cookies!=null) {
							for(Cookie cookie: cookies) {
								if(cookie.getName().equals("id") && cookie.getName().equals("password")) {
									//삭제:시간설정0
									cookie.setMaxAge(0);
									response.addCookie(cookie);
								}
							}
						}
					}	
				}
				
				System.out.println("로그인 성공"); 
				MemberDto dto=member_service.getUserInfo(id);
				session.setAttribute("memberDto", dto);
				System.out.println("세션DTO:"+dto); 
		   		session.setAttribute("sessionID", id);    
				model.addAttribute("msg","로그인 성공");
	            model.addAttribute("url","MainForm");
			}
			return "redirect";
	    }
	    
	    
	  //로그아웃
	    @RequestMapping("/LogOut")
	 	public String LogOut(HttpServletRequest request, Model model, HttpServletResponse response){  	
	    	HttpSession session=request.getSession();
	    	String id=(String)session.getAttribute("id");
	    	String passowrd=(String)session.getAttribute("password");
	    	
	    	
			int nResult = member_service.logout();
				
				if( nResult <= 0 ) {
			        model.addAttribute("msg","로그아웃 실패");
			        model.addAttribute("url","/");
				}else {

					if(id!=null && passowrd!=null) {  
						
					Cookie[] cookies = request.getCookies(); 
					 if(cookies != null) {
						 for(Cookie cookie : cookies) {  
							 if(cookie.getName().equals("id")) {
								 session.setAttribute("id", cookie.getValue()); 
								 cookie.setMaxAge(0); 
								 response.addCookie(cookie);
								 System.out.println("쿠키아이디"+cookie.getValue());  
								 
						 		} 
							 if(cookie.getName().equals("password")) {
								 session.setAttribute("password", cookie.getValue());
								 cookie.setMaxAge(0); 
								 response.addCookie(cookie);
								 System.out.println("쿠키비번"+cookie.getValue());  
							 	}
						 	} 
					 	} 
					}
					session.invalidate();
					request.getSession().invalidate();
					model.addAttribute("msg","로그아웃 성공");
		            model.addAttribute("url","/");
				
				return "redirect"; //redirect.jsp
		    } 
		    	return "MainForm"; 
			
	    }     
    
    //내정보 아이디, 비밀번호 체크
    @RequestMapping(value="/MyInfoAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
 	public String MyInfoAction(HttpServletRequest request, Model model){
    	String id=request.getParameter("id");
    	String password=request.getParameter("password");  
		int nResult = member_service.loginCheck(id, password);
		if( nResult <= 0 ) {
			System.out.println("정보 확인실패");
	        model.addAttribute("msg","정보확인실패 - 아이디나 암호를 확인해주세요");
	        model.addAttribute("url","MyInfo");
		}else {
			System.out.println("정보 확인완료"); 
			model.addAttribute("msg","정보 확인완료");
            model.addAttribute("url","UpdateMyInfo");
		}
		return "redirect";
    }
    
	// 회원 정보 수정 폼
	@RequestMapping("/UpdateMyInfo")
	public String UpdateMyInfo(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String id=(String)session.getAttribute("sessionID");
		MemberDto dto = member_service.getUserInfo(id);
		System.out.println(dto.toString());
		request.getSession().setAttribute("memberInfo",  dto);
		return "member/UpdateMyInfo";
	}   
 		
	
	// 회원 정보 수정
	@RequestMapping(value="/UpdateAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String ModifyFormAction(HttpServletRequest request, MemberDto dto, Model model) throws UnsupportedEncodingException { 
		request.setCharacterEncoding("utf-8"); // 인코딩 	
		int nResult = member_service.updateMember(request);
		if( nResult < 0 ) {
			System.out.println("회원수정 실패");  
			model.addAttribute("url","UpdateMyInfo");
		}else {
			System.out.println("회원가입 성공");
			model.addAttribute("msg","회원수정 성공");
			model.addAttribute("url","LogOut"); 	
		}
		return "redirect";  
	}  		
	
	//회원탈퇴폼
	@RequestMapping("/DeleteForm")
	public String DeleteForm() { return "member/DeleteForm"; } 
	
	//회원탈퇴
	@RequestMapping(value="/DeleteAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String MemberDeleteAction(HttpServletRequest request, MemberDto memberDto, Model model) {
		int  nResult =member_service.insertComplain(request);
		if( nResult < 1 ) { System.out.println("글쓰기 실패");	 }
		else { System.out.println("글쓰기 성공"); }
		HttpSession session = request.getSession();
		String id = session.getAttribute("sessionID").toString();
		String password = request.getParameter("password"); 

		int nResult2 = member_service.deleteMember(id, password);
		if( nResult2 < 1 ) {
			System.out.println("회원탈퇴 실패");
			model.addAttribute("msg","회원탈퇴 실패");
			model.addAttribute("url","DeleteForm");
		}else {
			System.out.println("회원탈퇴 성공"); 
			model.addAttribute("msg","회원탈퇴 성공");
			model.addAttribute("url","MainForm"); 
			session.invalidate();
		}
		return "redirect";  
	}
		
		
		
		
	//아이디찾기
      @RequestMapping(value="/IdCheckAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
      public String IdCheckAtcion(HttpServletRequest request, MemberDto memberDto, HttpServletResponse response, Model model) {
         String name= request.getParameter("name"); 
         String email=request.getParameter("email");
           
         String mail1=null;
         String mail2=null; 
         
         String [] tokens= email.split("@"); 
         if(tokens !=null && tokens.length>=2) {
            mail1=tokens[0];
            mail2=tokens[1]; 
         }   
         
         System.out.println(name);
         System.out.println(mail1);
         System.out.println(mail2);
         
         String id=member_service.idFindCheck(name, mail1, mail2); 
         
         System.out.println("아이디찾기:"+id);
          if(id != null) { 
            request.getSession().setAttribute("dbid", id);
            model.addAttribute("msg","아이디찾기 성공");
            model.addAttribute("url","IdFindForm"); 
            System.out.println(id);
         }else {
            System.out.println("아이디찾기 실패");
            
            model.addAttribute("msg","아이디찾기 실패");
            model.addAttribute("url","IdCheckForm");
         }  
         return "redirect";
      
      }
      //아이디찾기 성공폼
         @RequestMapping("/IdFindForm")
         public String IdFindForm() {return "member/IdFindForm"; }   
       //비밀번호찾기성공 폼
      	@RequestMapping("/PwFindForm")
      	public String PwFindForm() { 
      		return "member/PwFindForm";
     	}    
      	
     	//이메일 체크 폼
      	@RequestMapping("/EmailCheckForm")
      	public String EmailCheckForm() { 
      		return "member/EmailCheckForm";
     	}   
      	 
        //비밀번호찾기- 이메일가져오기
    @RequestMapping(value="/PwEamilCheckAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    public String PwCheckAtcion(HttpServletRequest request, MemberDto memberDto, HttpServletResponse response, Model model) {
        String email=request.getParameter("email"); 
        MemberDto dto=member_service.pwEmailFindCheck(request);   	 
         if(dto!=null) {
          MemberDto dto_password=member_service.pwCheck(request);     
        	 request.getSession().setAttribute("email", email); 
        	 String password=dto_password.getPassword();
     	 request.getSession().setAttribute("password", password); 
        	 System.out.println("이메일찾기 성공"); 
             model.addAttribute("msg","이메일찾기 성공");
             model.addAttribute("url","PwFindForm");    
         }else {
        	 System.out.println("이메일찾기 실패"); 
             model.addAttribute("msg","이메일찾기 실패");
             model.addAttribute("url","EmailCheckForm"); 
         } 
             return "redirect"; 
     }
    
    @RequestMapping(value="/EmailSendAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    public String EmailSendAction(HttpServletRequest request, MemberDto memberDto, HttpServletResponse response, Model model) {
 	   String email=(String)request.getSession().getAttribute("email"); 
 	   String password=(String)request.getSession().getAttribute("password");
 	   System.out.println(" 이메일:"+ email);
      	  if(email!=null) { 
      		  request.getSession().setAttribute("password", password);
      		  mailDto.setTitle("읽힘사이트에서 가입하신 비밀번호입니다");
          	  mailDto.setMessage(password+"입니다");
          	  mailDto.setAddress(email);
          	  mailService.mailSend(mailDto);
      		  model.addAttribute("msg","이메일을 보냈습니다.");
              model.addAttribute("url","LoginForm");
      	 } 
        return "redirect"; 
 	} 
    
  //1:1 문의 사용자 검색 폼
  	@RequestMapping("/complain")
  	public String complain(HttpServletRequest request,Model model){  
  		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("sessionID");
  		String category=request.getParameter("category");
  		String keyword=request.getParameter("keyword");
  		request.setAttribute("list",oneBoardservice.search_user(user_id,category, keyword));
  		System.out.println("user_id"+user_id);
  		return "member/OnetoOneBoard"; 
  	}  

	@RequestMapping("/NoAnswer_user") 
	public String NoAnswer_user(HttpServletRequest request,Model model,OnetoOneBoardDto oneboardDto) { 
		String check="미등록";
		HttpSession session=request.getSession();
		String user_id=(String)session.getAttribute("sessionID"); 
		List<OnetoOneBoardDto> list=oneBoardservice.noanswer_userlist(check,user_id);
		model.addAttribute("list",list);
		return "member/OnetoOneBoard"; 
	}	 
        
	 //1:1문의 폼
		@RequestMapping("/OnetoOneBoard")
		public String OneBoard(HttpServletRequest request) {
			String user_id=(String)request.getSession().getAttribute("sessionID");//세션아이디가 유저아이디랑 동일
			Criteria cri = new Criteria(1,7);
			int bookcnt=oneBoardservice.countMember(user_id);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("list",oneBoardservice.list(user_id,cri));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);
			
	 
		return "member/OnetoOneBoard";
		}  
 	
     //1:1 문의 글쓰기
     @RequestMapping(value="/OnetoOnewriteAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
     public String OnetoOnewriteAction(HttpServletRequest request,Model model) throws IOException {
   	      request.setCharacterEncoding("UTF-8");
 	      OnetoOneBoardDto dto=new OnetoOneBoardDto();
 	      dto.setO_type(request.getParameter("o_type"));
 	      dto.setUser_id(request.getParameter("user_id"));
 	      dto.setO_phone(request.getParameter("o_phone"));
 	      dto.setO_title(request.getParameter("o_title")); 
 	      dto.setO_content_Q(request.getParameter("o_content_Q")); 
 	      dto.setO_ans_check(request.getParameter("o_ans_check"));  
 	      dto.setReg(new Date());  
 	      int nResult=oneBoardservice.write(dto);  
 	      if(nResult<=0) {
           System.out.println("글쓰기 실패");
           model.addAttribute("msg","글쓰기실패");
           model.addAttribute("url","OnetoOneBoardWrite");
 	      }else {
           System.out.println("글쓰기 성공");
           model.addAttribute("msg","글쓰기성공");
           model.addAttribute("url","OnetoOneBoard");
        }
        return "redirect";
         
     }
      
 	//1:1문의 작성폼
 	@RequestMapping("/OnetoOneBoardWrite")
 	public String OnetoOneBoardWrite() {return "member/OnetoOneBoardWrite";}  
     
 	//1:1문의 글보기
 	@RequestMapping("/OnetoOneBoardView")
 	public String OnetoOneBoardView(HttpServletRequest request) {    
 		String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2);
 		OnetoOneBoardDto dto=oneBoardservice.content_view(idx);
 		request.getSession().setAttribute("content_view", dto); 
 		System.out.println("유저아이디"+dto);
 		return "member/OnetoOneBoardView"; 
 	} 
 	 
 	//1:1문의 글수정
 	@RequestMapping("/OnetoOneBoardModifyAction")
 	public String OnetoOneBoardModifyAction(HttpServletRequest request, Model model) throws Exception { 
 		request.setCharacterEncoding("UTF-8");
 		String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2); 
 		String o_type=request.getParameter("o_type");
 		String o_phone=request.getParameter("o_phone");
 		String o_title=request.getParameter("o_title");
 		String o_content_Q=request.getParameter("o_content_Q"); 
 		String user_id=(String)request.getSession().getAttribute("sessionID");//세션아이디를 통해 수정
 		
 		OnetoOneBoardDto oneBoardDto=new OnetoOneBoardDto();
 		oneBoardDto.setIdx(idx);
 		oneBoardDto.setO_type(o_type);
 		oneBoardDto.setO_phone(o_phone);
 		oneBoardDto.setO_title(o_title);
 		oneBoardDto.setO_content_Q(o_content_Q);  
 		oneBoardDto.setUser_id(user_id); 
 		
 		int nResult=oneBoardservice.boardModify(oneBoardDto); 
 		System.out.println("하:"+nResult);
 		if(nResult<1) {
 			System.out.println("글 수정을 실패하엿습니다.");
 			model.addAttribute("msg","글 수정을 실패하엿습니다.");
 			model.addAttribute("url","OnetoOneBoardView?idx="+idx);
 		}else {
 			System.out.println("글 수정을 성공하셨습니다.");
 			model.addAttribute("msg","글 수정을 성공하셨습니다.");
 			model.addAttribute("url","OnetoOneBoardView?idx="+idx);
 		}
 		 
 		return "redirect"; 
 	}  
 	
 	//1:1문의 글 삭제 
    @RequestMapping("/OnetoOneDeleteBoard")
    public String OnetoOneDeleteBoard(HttpServletRequest request, Model model) throws Exception {
   	 request.setCharacterEncoding("UTF-8");
   	String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2);  
 		
 		int nResult=oneBoardservice.boardDelete(idx); 
 	  	   
   	 System.out.println("찍어보기"+nResult);
   	 if(nResult<1) {
   		 System.out.println("글 삭제를 실패하였습니다.");
   		 model.addAttribute("msg","글 삭제를 실패하였습니다");
   		 model.addAttribute("url","OnetoOneBoardView?idx="+idx);
   	 }else {
   		 System.out.println("글 삭제를 성공하였습니다.");
   		 model.addAttribute("msg","글 삭제를 성공하였습니다.");
   		 model.addAttribute("url","OnetoOneBoard");
   	 }
   	 
 		return "redirect";
   	 
    } 
	//1:1문의 답변
    @RequestMapping(value="/GetReplyA", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
    public String GetReplyA(HttpServletRequest request,Model model){
    	String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2); 
 		OnetoOneBoardDto dto=oneBoardservice.content_reply(idx);
 		request.getSession().setAttribute("content_view", dto);
 		
		return "member/OnetoOneBoardView"; 
    }
  

///////관리자 폼///////
    //관리자 페이지 -> 관리자 로그인폼
    @RequestMapping("/AdminLoginForm")
	public String AdminLoginForm() {
    	return "admin/AdminLoginForm";
    	} 
    
    //관리자 페이지 -> 관리자 로그인 로직
    @RequestMapping(value="/AdminLoginAction", method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
 	public String AdminloginCheck(HttpServletRequest request, Model model){  	
    	String id=request.getParameter("id");
    	String password=request.getParameter("password");  
		int nResult = member_service.loginCheck(id, password);
		if( nResult <= 0 ) {
			System.out.println("로그인 실패");
	        model.addAttribute("msg","로그인 실패 - 아이디나 암호를 확인해주세요");
	        model.addAttribute("url","AdminLoginForm");
		}else {
			System.out.println("로그인 성공");
			if(id.equals("admin")) {
				HttpSession session = request.getSession();
		   		session.setAttribute("sessionID", id);  
				model.addAttribute("msg","로그인 성공");
	            model.addAttribute("url","AdminMainForm");
				
	            MemberDto dto=member_service.getUserInfo(id);
				session.setAttribute("memberDto", dto);
				System.out.println("관리자 세션DTO:"+dto); 
		   		session.setAttribute("sessionID", id); 
		   		
			}else {
				model.addAttribute("msg","관리자 아이디가아닙니다.");
		        model.addAttribute("url","AdminLoginForm");
			}
		}
		return "redirect";
    }
    //관리자 폼 > 메인화면
  	@RequestMapping("/AdminMainForm")
  	public String AdminMainForm(HttpServletRequest request) {
  		SimpleDateFormat format=new SimpleDateFormat("YY/MM/dd");
  		String date=format.format(new Date());
  		request.setAttribute("list",order_service.list());
  		request.setAttribute("list2",review_service.reviewlist());
  		request.setAttribute("check",notice_service.todayCheck(date));
  		request.setAttribute("check2",notice_service.todayCheck2(date));
  		request.setAttribute("check3",notice_service.todayCheck3(date));
  		request.setAttribute("check4",notice_service.todayCheck4(date));
  		request.setAttribute("check5",notice_service.newCheck());
  		request.setAttribute("check6",notice_service.newCheck2());
  		request.setAttribute("check7",notice_service.newCheck3());
  		return "AdminMainForm";
  	}
	//관리자 폼 > 회원관리 화면
	@RequestMapping("/ManageMember")
	public String ManageMember(HttpServletRequest request,Model model) {
		Criteria cri = new Criteria(1,10);
		int bookcnt=member_dao.countMemberDao();
		int allPageNum;
		if(bookcnt%10==0) { allPageNum = bookcnt/10;}
		else { allPageNum = bookcnt/10+1;}
		
		model.addAttribute("list",member_service.getList(cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageMember";}
	
	//관리자 폼 > 주문관리 화면
	@RequestMapping("/ManageOrder")
	public String ManageOrder(HttpServletRequest request) {
		Criteria cri = new Criteria(1,10);
		int bookcnt=order_service.countOrder();
		int allPageNum; 
		if(bookcnt%10==0) {
			allPageNum =bookcnt/10;
		}else {
			allPageNum =bookcnt/10+1; 
		}
		request.setAttribute("list",order_service.getList(cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageOrder";
	}
	
	
	//관리자 폼 > 상품관리 화면 > 상품관리 페이지 셋팅
	@RequestMapping("/ManageProduct")
	public String ManageProduct(HttpServletRequest request,Model model) {
		Criteria cri = new Criteria(1,5);
		int bookcnt=product_service.countProduct();
		int allPageNum; 
		if(bookcnt%5==0) {
			allPageNum =bookcnt/5;
		}else {
			allPageNum =bookcnt/5+1; 
		}
		model.addAttribute("list",product_service.getList(cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageProduct";
	}
	
	//관리자 폼 > 상품관리 화면 페이징
	@RequestMapping("/page")
	public String ManageProductpaging(HttpServletRequest request,Model model) {
		String s_no=request.getParameter("no");
		int no = Integer.parseInt(s_no);
		Criteria cri = new Criteria(no,5);
		
		model.addAttribute("list",product_service.getList(cri));
		int bookcnt=product_service.countProduct();
		int allPageNum; 
		if(bookcnt%5==0) {
			allPageNum =bookcnt/5;
		}else {
			allPageNum =bookcnt/5+1; 
		}
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageProduct";
	}
	
	//관리자 폼 > 주문관리 화면 페이징
	@RequestMapping("/page2")
	public String ManageOrderpaging(HttpServletRequest request,Model model) {
		String s_no=request.getParameter("no");
		int no = Integer.parseInt(s_no);
		Criteria cri = new Criteria(no,10);
		request.setAttribute("list",order_service.getList(cri));
		int bookcnt=order_service.countOrder();
		int allPageNum; 
		if(bookcnt%10==0) {
			allPageNum =bookcnt/10;
		}else {
			allPageNum =bookcnt/10+1; 
		}
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageOrder";
	}
	
	//관리자 폼 > 회원관리 화면 페이징
	@RequestMapping("/page3")
	public String ManageMemberpaging(HttpServletRequest request,Model model) {
		String s_no=request.getParameter("no");
		int no = Integer.parseInt(s_no);
		Criteria cri = new Criteria(no,10);
		request.setAttribute("list",member_service.getList(cri));
		
		int bookcnt=member_service.countMember();
		int allPageNum; 
		if(bookcnt%10==0) {
			allPageNum =bookcnt/10;
		}else {
			allPageNum =bookcnt/10+1; 
		}
		request.setAttribute("allPageNum", allPageNum);
		return "admin/ManageMember";
	}
	//사용자 폼 > 상품문의 페이징
		@RequestMapping("/page4")
		public String MyProductQnApaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,10);
			request.setAttribute("list",pro_qna_service.myProductQnAList(request,cri));
			
			int bookcnt=pro_qna_service.countMyProductQnA(request);
			int allPageNum; 
			if(bookcnt%10==0) {
				allPageNum =bookcnt/10;
			}else {
				allPageNum =bookcnt/10+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/MyProductQnA";
		}
		
	//공지사항 페이징
		@RequestMapping("/page5")
		public String Noticepaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			int category=1;
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",notice_service.getList(cri,category));
			int bookcnt=notice_service.countOrder(category);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "board/Notice_board";
		}
		//자주묻는질문 페이징
		@RequestMapping("/page6")
		public String Questionpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			int category=2;
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",notice_service.getList(cri,category));
			int bookcnt=notice_service.countOrder(category);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "board/Question_board";
		}
		//이벤트 페이징
		@RequestMapping("/page7")
		public String Eventpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			int category=7;
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",notice_service.getList(cri,category));
			int bookcnt=notice_service.countOrder(category);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "board/Event_board";
		}
		//1:1문의 페이징
		@RequestMapping("/page8")
		public String OnetoOnepaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",oneBoardservice.adminlist(cri));
			int bookcnt=oneBoardservice.count();
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "admin/OnetoOneBoard_A";
		}
		//탈퇴회원 페이징
		@RequestMapping("/page9")
		public String Withdrawpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",member_service.deletelist(cri));
			int bookcnt=member_service.countDelete();
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "admin/WithdrawMember";
		}
		
		//사용자 폼 >  주문목록 페이징
		@RequestMapping("/page10")
		public String OrderListpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",order_service.listbyUser(request, cri));
			int bookcnt=order_service.countMemberOrder(request);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/OrderList";
		}
		//사용자 폼 >  장바구니 페이징
		@RequestMapping("/page11")
		public String Basketpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",cart_service.getCart(request, cri));
			int bookcnt=cart_service.countCart(request);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/Basket";
		}
		//사용자 폼 >  포인트 페이징
		@RequestMapping("/page12")
		public String PointInfopaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			 HttpSession session = request.getSession();
		     String id = (String)session.getAttribute("sessionID");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,10);
			request.setAttribute("list",point_service.pointList(id, cri));
			int bookcnt=point_service.count(id);
			int allPageNum; 
			if(bookcnt%10==0) {
				allPageNum =bookcnt/10;
			}else {
				allPageNum =bookcnt/10+1; 
			}
			model.addAttribute("point",member_service.getUserInfo(id));
			request.setAttribute("allPageNum", allPageNum);
			return "member/PointInfo";
		}
		//사용자 폼 >  1:1문의 페이징
		@RequestMapping("/page13")
		public String OnetoOneBoardpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("sessionID");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",oneBoardservice.list(id, cri));
			int bookcnt=oneBoardservice.countMember(id);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/OnetoOneBoard";
		}
		//사용자 폼 >  상품 후기 작성가능
		@RequestMapping("/page14")
		public String ProductReviewpaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",order_service.reviewToWriteList(request, cri));
			int bookcnt=order_service.countReview(request);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/ProductReivew";
		}
		//사용자 폼 >  상품 후기 작성완료
		@RequestMapping("/page15")
		public String ProductReviewCompletepaging(HttpServletRequest request,Model model) {
			String s_no=request.getParameter("no");
			int no = Integer.parseInt(s_no);
			Criteria cri = new Criteria(no,7);
			request.setAttribute("list",review_service.viewWrittenReview(request, cri));
			int bookcnt=review_service.countReviewComplete(request);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("allPageNum", allPageNum);
			return "member/ProductReviewComplete";
		}
		 
		
	//관리자 폼 > 상품관리 화면 > 상품 검색
	@RequestMapping("/SearchProduct")
	public String SearchProduct(HttpServletRequest request,Model model) {
		int bookcnt=product_service.CountSearchProduct(request);
		System.out.println("검색결과는 몇개?"+bookcnt);
		int allPageNum =0;	
		request.setAttribute("bookcnt", bookcnt);
		request.setAttribute("allPageNum", allPageNum);
		List<ProductDto> list=product_service.SearchProduct(request);
		model.addAttribute("list",list);
		return "admin/ManageProduct";
	}
	
	//관리자 폼 > 상품관리 화면 > 상품 삭제
	@RequestMapping("/DeleteProduct")
	public String DeleteProduct(HttpServletRequest request, Model model) { 
		String s_idx=request.getParameter("idx");
		int idx = Integer.parseInt(s_idx);
		product_service.DeleteProduct(idx);
		model.addAttribute("msg","상품이 삭제되었습니다.");
		model.addAttribute("url","/ManageProduct");
		return "redirect";}
	
	//관리자 폼 > 탈퇴회원 화면
	//관리자 폼 > 탈퇴회원 화면
	@RequestMapping("/WithdrawMember")
	public String WithdrawMember(Model model) {
		Criteria cri = new Criteria(1,7);
		int bookcnt=member_service.countDelete();
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		model.addAttribute("list",member_service.deletelist(cri));
		cri.setAllPageNum(allPageNum);
		model.addAttribute("allPageNum", allPageNum);
		return "admin/WithdrawMember";
		}
	
	//관리자 폼 > 상품등록 화면
	@RequestMapping("/UploadProduct")
	public String UploadProduct() {return "admin/UploadProduct";}
	
	//관리자 폼 > 상품등록 화면 > 상품번호 중복 확인
	@RequestMapping("Product_num_Check")
	public void Product_num_Check(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String p_num = request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		int x=product_service.Product_num_Check(p_number);
		if(x==1) {
			response.getWriter().print("1");
		}else if (x==0) {
			response.getWriter().print("0");
		}	
	}
	
	//관리자 폼 > 상품등록 로직 1104수정
	@RequestMapping(value = "/UploadProductAction",  method = RequestMethod.POST)
	public String UploadProductAction(
			Model model, HttpServletRequest request,
			@RequestParam("p_filename") MultipartFile file,
			@RequestParam("p_filename2") MultipartFile file2) {
		product_service.uploadProduct(request, file,file2, model);
		model.addAttribute("msg","상품이 업로드되었습니다.");
		model.addAttribute("url","/ManageProduct");
		return "redirect";}
	
	//관리자폼 > 상품 상세보기, 상품 수정보기 폼
	@RequestMapping(value={"/ProductDetail","/ModifyProduct"})
	public String ProductDetail(HttpServletRequest request,Model model) {
		String p_num=request.getParameter("p_number");
		int p_number = Integer.parseInt(p_num);
		ProductDto dto=product_service.viewProductDetail(p_number);
		model.addAttribute("dto",dto);
		String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		if(requestUrl.equals("/ProductDetail")) {return "admin/ProductDetail";}
		else {return "admin/ModifyProduct"; }
	}
	
	//관리자 폼> 상품수정 로직
	@RequestMapping("/ModifyProductAction")
	public String ModifyProductAction(HttpServletRequest request,Model model,
			@RequestParam("p_filename") MultipartFile file,
			@RequestParam("p_filename2") MultipartFile file2) {
		String p_num = request.getParameter("p_number");
		int p_number=Integer.parseInt(p_num);
		product_service.modifyProduct(request,model,file,file2);
		model.addAttribute("msg","상품이 수정되었습니다.");
		model.addAttribute("url","/ManageProduct");
		return "redirect";
	}
	
	//관리자 폼 > 상품문의
	@RequestMapping("/ProductQnA")
	public String ProductQnA(HttpServletRequest request,Model model) {
		List<Product_QnA_Board_Dto> list=pro_qna_service.viewAllProductQnA();
		model.addAttribute("list",list);
		return "admin/ProductQnA";
	}
	
	//관리자 폼 > 상품문의 상세보기
	@RequestMapping("/ProductQnADetail")
	public String ProductQnADetail(HttpServletRequest request,Model model) {
		//문의받은 상품의 정보 가져오기
		String p_num=request.getParameter("p_number");
		int p_number=Integer.parseInt(p_num);
		ProductDto dto = pro_qna_service.viewProductInfo(p_number); 
		model.addAttribute("dto",dto);
		
		//해당 건의 문의 내용 가져오기
		String s_idx = request.getParameter("idx");
		int idx = Integer.parseInt(s_idx);
		Product_QnA_Board_Dto dto2 = pro_qna_service.viewProductQnABoardDao2(idx);
		model.addAttribute("dto2",dto2);
		return "admin/ProductQnADetail";
	}
	
	//관리자 폼 > 상품문의 상세보기 > 답변하기
	@RequestMapping("/ProductAnswer")
	public String ProductAnswer(HttpServletRequest request, Model model) {
		pro_qna_service.AnswerProductQuestion(request);
		model.addAttribute("msg","답변이 등록되었습니다.");
		model.addAttribute("url","/ProductQnA");
		return "redirect";
	}
	
	//관리자 폼 > 상품문의 상세보기 > 답변 삭제
	@RequestMapping("/ProductAnswerDelete")
	public String ProductAnswerDelete(HttpServletRequest request, Model model) {
		pro_qna_service.ProductAnswerDelete(request);
		model.addAttribute("msg","답변을 삭제했습니다.");
		model.addAttribute("url","/ProductQnA");
		return "redirect";
	}
	
	//관리자 > 1:1문의 리스트
	@RequestMapping("/OnetoOneBoard_A") 
	public String OnetoOneBoard_A(HttpServletRequest request,Model model,OnetoOneBoardDto oneboardDto) { 
		Criteria cri = new Criteria(1,7);
		int bookcnt=oneBoardservice.count();
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		request.setAttribute("list",oneBoardservice.adminlist(cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
	return "admin/OnetoOneBoard_A";
	}
	
	@RequestMapping("/NoAnswer") 
	public String OnetoOneBoard_A2(HttpServletRequest request,Model model,OnetoOneBoardDto oneboardDto) { 
		String check="미등록";
		List<OnetoOneBoardDto> list=oneBoardservice.noanswerlist(check);
		int allPageNum =0;	
		request.setAttribute("allPageNum", allPageNum);
		model.addAttribute("list",list);
	return "admin/OnetoOneBoard_A";
	}	
		
    //관리자  > 1:1문의 리스트 > 1:1문의 글보기
 	@RequestMapping("/OnetoOneBoardView_A")
 	public String OnetoOneBoardView_A(HttpServletRequest request) {    
 		String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2);
 		OnetoOneBoardDto dto=oneBoardservice.content_view(idx);
 		request.getSession().setAttribute("content_view", dto); 
 		System.out.println("유저아이디"+dto);
 		return "admin/OnetoOneBoardView_A"; 
 	} 
	 	
	//관리자  > 1:1문의 리스트 > 1:1문의 글쓰기 폼
	@RequestMapping("/OnetoOneBoardWrite_A")
	public String OnetoOneBoardWrite_A() {return "admin/OnetoOneBoardWrite_A";}
	
 	//관리자  > 1:1문의 리스트 > 1:1문의 글쓰기
 	@RequestMapping(value="/OnetoOneboard_A_Action" , method=RequestMethod.POST)
 	public String OnetoOneboard_A_Action(HttpServletRequest request,Model model) {
 		String idx2=request.getParameter("idx");
 		int idx=Integer.parseInt(idx2); 
 		String admin_id=request.getParameter("admin_id");
 		String o_content_A=request.getParameter("o_content_A");
 		String o_ans_check=request.getParameter("o_ans_check");
 		int nResult=oneBoardservice.adminwrite(idx,admin_id,o_content_A,o_ans_check);
 		if(nResult<1) {
 			System.out.println("글 작성을 실패하였습니다.");
 			model.addAttribute("msg","글 작성을 실패하였습니다.");
 			model.addAttribute("url","OnetoOneBoardView_A");
 		}else {
 			System.out.println("글 작성을 성공하였습니다.");
 			model.addAttribute("msg","글 작성을 성공하였습니다.");
 			model.addAttribute("url","OnetoOneBoard_A");
 		}
		return "redirect";   
 	}
	 	 
	
	//관리자 폼 > 게시판
	//관리자 폼 > 게시판 > 공지사항
 	@RequestMapping("/Notice_board")
	public String Notice_board(HttpServletRequest request,Model model){
		int category=1;
		
		
		Criteria cri = new Criteria(1,7);
		int bookcnt=notice_service.countOrder(category);
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		request.setAttribute("list",notice_service.getList(cri,category));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		
		return "board/Notice_board";
	}
	
	//관리자 폼 > 게시판 > 공지사항 글쓰기
	@RequestMapping("/Board_write")
	public String Notice_write(){return "board/Board_write";} 
	@RequestMapping("/Event_write")
	public String Event_write(){return "board/Event_write";}
	@RequestMapping("/User_Event_board")
	public String User_Event_board(HttpServletRequest request){
		int category=3;
		request.setAttribute("list",notice_dao.listDao(category));
		return "board/User_Event_board";}
	
	//관리자 폼 > 게시판 > 검색 기능
	@RequestMapping("/board_search")
	public String board_search(HttpServletRequest request,Model model){
	System.out.println(request.getParameter("check_category"));
	String category=(request.getParameter("check_category"));
	String keyword=request.getParameter("keyword"); 
	request.setAttribute("list",oneBoardservice.search(category,keyword));
	return "admin/OnetoOneBoard_A"; }
	
	//관리자 폼 > 게시판 > 자주하는 질문
	@RequestMapping("/Question_board")
	public String Question_board(HttpServletRequest request,Model model){
		int category=2;
		
		Criteria cri = new Criteria(1,7);
		int bookcnt=notice_service.countOrder(category);
		int allPageNum; 
		if(bookcnt%7==0) {
			allPageNum =bookcnt/7;
		}else {
			allPageNum =bookcnt/7+1; 
		}
		request.setAttribute("list",notice_service.getList(cri,category));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
		
		return "board/Question_board";}
	
	//관리자 폼 > 게시판 > 이벤트 게시판 // 11.3수정
		@RequestMapping("/Event_board")
		public String Event_board(HttpServletRequest request,Model model){
			int category=3;
			//request.setAttribute("list",notice_dao.listDao(category));
			
			Criteria cri = new Criteria(1,7);
			int bookcnt=notice_service.countOrder(category);
			int allPageNum; 
			if(bookcnt%7==0) {
				allPageNum =bookcnt/7;
			}else {
				allPageNum =bookcnt/7+1; 
			}
			request.setAttribute("list",notice_service.getList(cri,category));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);
			
			
			return "board/Event_board"; }
			
		
	//공지사항 글쓰기 로직
	 @RequestMapping("/BoardWriteAction")
	 public String write(HttpServletRequest request,Model model)throws Exception {
       int nResult = notice_service.write(request);
       if( nResult < 1) {
          model.addAttribute("msg","글쓰기실패");
          model.addAttribute("url","/Notice_board");
          return "redirect";
       }else {
          model.addAttribute("msg","글쓰기 성공");
          model.addAttribute("url","/Notice_board");
          return "redirect";   
       }
    }
	//공지사항 보기 로직
	@RequestMapping("/Board_view")
	public String view(HttpServletRequest request, Model model) {
		String idx = request.getParameter("idx");
		int bHit=Integer.parseInt(request.getParameter("hit"));
		bHit+=1;
		notice_service.hit(idx,bHit);
		request.setAttribute("dto",notice_dao.viewDao(idx));
		model.addAttribute("category",notice_dao.viewDao(idx));   
		
		return "board/Board_view";
	}
	//글 수정
	@RequestMapping("/Board_Modify")
	public String Notice_Modify(HttpServletRequest request, Model model) {
		String idx = request.getParameter("idx");
		request.setAttribute("dto",notice_dao.viewDao(idx));
		return "board/Board_Modify";
	}
	//글 수정 로직
	@RequestMapping(value="/Board_ModifyAction" , method=RequestMethod.POST)
	public String BoardModifyAction(HttpServletRequest request,Model model) {   
	      int nResult=notice_service.update(request);
	      if( nResult <= 0 ) {
	         model.addAttribute("msg","다시시도해주십시오.");
	         model.addAttribute("url","/Notice_board");
	         return "redirect";
	      }else {
	         model.addAttribute("msg","수정 완료했습니다.");
	         model.addAttribute("url","/Notice_board");
	         return "redirect";
	      }   
	   }
	//글 삭제 로직
	@RequestMapping("/Board_delete")
	public String delete(HttpServletRequest request, Model model) {
		String sID = request.getParameter("idx");	
		int nResult = notice_service.delete(sID);
		if( nResult <= 0 ) {
			model.addAttribute("msg","다시시도해주십시오.");
            model.addAttribute("url","/Notice_board");
			return "redirect";
		}else {
			model.addAttribute("msg","삭제 완료했습니다.");
            model.addAttribute("url","/Notice_board");
			return "redirect";
		}	
	}
	//파일 저장 로직
    @PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
    @ResponseBody
    public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) throws FileNotFoundException {
        JsonObject jsonObject = new JsonObject();
		// 프로젝트 저장위치 
		String SAVE_PATH = "/upload/";
		String savepath = ResourceUtils.getFile("classpath:static/").toPath().toString();
		savepath = savepath.replace("\\", "/");
		System.out.println("savepath2 : " + savepath);
		savepath = savepath.replace("/bin/main/static", "/src/main/resources/static/board_image/");
		System.out.println("savepath3 : " + savepath);
		SAVE_PATH = savepath; 
		// 프로젝트 저장위치
        String fileRoot = SAVE_PATH;	//저장될 파일 경로
        String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자

        // 랜덤 UUID+확장자로 저장될 savedFileName
        String savedFileName = UUID.randomUUID() + extension;	    
        File targetFile = new File(fileRoot + savedFileName);
        try {
            InputStream fileStream = multipartFile.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
            jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
            System.out.println(SAVE_PATH+savedFileName);
            jsonObject.addProperty("responseCode", "success");
            System.out.println(targetFile);

        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);	// 실패시 저장된 파일 삭제
            jsonObject.addProperty("responseCode", "error");
            e.printStackTrace();
        }
        return jsonObject;
    }
    @Configuration
	public class WebMvcConfig implements WebMvcConfigurer {
	    //web root가 아닌 외부 경로에 있는 리소스를 url로 불러올 수 있도록 설정
	    //현재 localhost:8080/summernoteImage/1234.jpg
	    //로 접속하면 C:/summernote_image/1234.jpg 파일을 불러온다.
	    @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry){
	    	String SAVE_PATH = "/upload/";
			String savepath = null;
			try {
				savepath = ResourceUtils.getFile("classpath:static/").toPath().toString();
			} catch (FileNotFoundException e) {
				
				e.printStackTrace();
			}
			savepath = savepath.replace("\\", "/");
			
			savepath = savepath.replace("/bin/main/static", "/src/main/resources/static/board_image/");
			
			SAVE_PATH = savepath; 
	        registry.addResourceHandler("/summernoteImage/**")
	                .addResourceLocations("file:///"+SAVE_PATH);
	    }		
	}
	@RequestMapping("/stateUpdate")
	public String stateUpdate(HttpServletRequest request, Model model) {
		String[] o_number = (String[]) request.getParameterValues("chBox");
		int nResult=0;
		String o_state=request.getParameter("o_state2");
		for(int i=0;i<o_number.length;i++) {
			nResult=order_service.state(o_number[i], o_state);
		}
		if( nResult <= 0 ) {
			model.addAttribute("msg","다시시도해주십시오.");
            model.addAttribute("url","/ManageOrder");
			return "redirect";
		}else {
			model.addAttribute("msg","상태수정 완료했습니다.");
            model.addAttribute("url","/ManageOrder");
			return "redirect";
		}	
	}
	@RequestMapping("/stateAlign")
	public String stateAlign(HttpServletRequest request,Model model){
		
		Criteria cri = new Criteria(1,10);
		String state=(request.getParameter("o_stateview"));
		int allPageNum =0;	
		int bookcnt=order_service.countstateOrder(state);
		request.setAttribute("bookcnt", bookcnt);
		request.setAttribute("allPageNum", allPageNum);
		if(!state.equals("6")) {
			
		request.setAttribute("list",order_service.stateView(state));
		}else {
			bookcnt=order_service.countOrder();
			if(bookcnt%10==0) {
				allPageNum =bookcnt/10;
			}else {
				allPageNum =bookcnt/10+1; 
			}
			request.setAttribute("list",order_service.getList(cri));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);
		}
	return "admin/ManageOrder"; }
	

	//북스토리 게시판
		//북스토리-메인

		//메인- 아이디,회원수 가져오기
		@RequestMapping("/BookStoryMain")
			public String BookStoryMain(HttpServletRequest request,Model model) throws Exception{
			int count=bookstory_service.getMainProfile(request);
			model.addAttribute("count",count);
			System.out.println("회원수:"+count);
			 
			
			//전체글 가져오기
			ArrayList<BookStoryBoardDto> list=bookstory_service.bookstoryList(request);
			System.out.println("전체글보기:"+list);
			model.addAttribute("list", list);
			
			
			//인기글 가져오기  
			ArrayList<BookStoryBoardDto> Popular_list=bookstory_service.bookstory_mainpopularList(request);
			model.addAttribute("Popular_list",Popular_list);
			
			//페이징
			String page=request.getParameter("page");
			
			if(page==null) {
				page="1";
				request.getSession().setAttribute("page", page);
			}
		
			return "BookStoryMain";
		} 
		//프로필 폼
		@RequestMapping("/BookStoryProfile")
		public String BookStoryProfile(){return "bookstory/BookStoryProfile";}    
		//내정보- 로그인필요
		@RequestMapping("/myInfoLogin")
		public String myInfoLogin(Model model) {
			model.addAttribute("msg","로그인이 필요합니다.");
			model.addAttribute("url","LoginForm");
			return "redirect";}		
		//내정보 폼
		@RequestMapping("/BookStoryMyInfo")
		public String bookstory_MyInfo(HttpServletRequest request, Model model,HttpSession session){
		//회원수
		int count=bookstory_service.getMainProfile(request);
		model.addAttribute("count",count);
		System.out.println("회원수:"+count);
		 
//		//게시글 수  
		String bs_user_id=(String)session.getAttribute("sessionID");  
		int content_count=bookstory_service.contents_count(bs_user_id);
		System.out.println("게시글 수:"+content_count);
 		session.setAttribute("content_count",content_count);  
		 
		
		//댓글 수
		String writer_id=(String)session.getAttribute("sessionID");
		int reply_count=bookstory_service.replys_count(writer_id); 
		session.setAttribute("reply_count",reply_count); 
		 
		return "bookstory/BookStoryMyInfo";
		}  
	
		
		//글쓰기 폼
		@RequestMapping("/BookStoryWrite")
		public String BookStoryWrite(HttpServletRequest request, Model model){  
			MemberDto dto=bookstory_service.getProfile(request); 
			System.out.println("글쓰기폼"+dto);
			model.addAttribute("dto",dto); 
			return "bookstory/BookStoryWrite";
			}      
		  
		//프로필 이미지등록 
		@RequestMapping(value = "/ProfileRegister",  method = RequestMethod.POST , produces = "text/html; charset=UTF-8")
		public String ProfileRegister(Model model, HttpServletRequest request, @RequestParam("profile_img") MultipartFile file) {
			String filename=bookstory_service.uploadProfile(request, file, model);
			System.out.println("파일명:"+filename); 
			 
			MemberDto dto=bookstory_service.getProfile(request);   
			System.out.println("이미지 업로드:"+dto);
			if(dto==null) {
				System.out.println("이미지 등록실패"); 
				model.addAttribute("msg","이미지업로드를 실패하였습니다");
				model.addAttribute("url","BookStoryProfile");
			}else {
				System.out.println("이미지 등록성공");  
				request.getSession().setAttribute("book_img", dto);
				/* request.getSession().setAttribute("memberDto", dto); */
				model.addAttribute("memberDto",dto);
				model.addAttribute("msg","이미지업로드를 성공하였습니다.");
				model.addAttribute("url","BookStoryProfile");
			}
			 
			 return "redirect"; 
		}   
		
		// 북스토리 -글쓰기
		@RequestMapping(value = "/BookStoryWriteAction",  method = RequestMethod.POST , produces = "text/html; charset=UTF-8")
		public String BookStoryWriteAction(HttpServletRequest request,Model model,HttpSession session){  
			 
			int nResult=bookstory_service.bookstoryWrite(request);
			System.out.println("파일명:"+nResult); 
			if(nResult<1) {
				System.out.println("글 작성을 실패하였습니다."); 
				model.addAttribute("msg","글 작성을 실패하였습니다.");
				model.addAttribute("url","BookStoryWrite");
			}else {  
				//게시글 수 추가
				String id=(String)session.getAttribute("sessionID");   
				int updateCountentCount=member_service.update_content_count(id);
				System.out.println("게시글 수"+updateCountentCount);   
				
				System.out.println("글 작성을 성공하였습니다.");  
				model.addAttribute("msg","글 작성을 성공하였습니다.");
				model.addAttribute("url","BookStoryMain"); 
				
				}
			return "redirect";
			}
		 
		//글보기, 조회수 증가  
		@RequestMapping("/BookStoryView")
		public String BookStoryview(HttpServletRequest request,Model model) throws Exception{
			//회원수
			int count=bookstory_service.getMainProfile(request);
			model.addAttribute("count",count);
			System.out.println("회원수:"+count);
			HttpSession session = request.getSession();
			String sessionID = (String)session.getAttribute("sessionID");
			model.addAttribute("sessionID",sessionID);
			  
			//글보기+이미지보기
			String idx2=request.getParameter("idx");
			int idx=Integer.parseInt(idx2);
			BookStoryBoardDto dto=bookstory_service.bookstoryView(idx);
			session.setAttribute("BookStoryDto", dto);
			session.setAttribute("content_view_bookstory",dto); 
			System.out.println("북스토리글 보기"+dto); 
			session.setAttribute("book_idx", idx);
			
				
			//조회수증가
			int hit=bookstory_service.bookstoryHit(idx); 
			model.addAttribute("hit",hit); 
			
		 
		    //댓글보기
			List<BookStoryBoardReplyDto> replyDto=bookstory_service.bookstoryReplyView(idx);
			request.getSession().setAttribute("reply_view_bookstory", replyDto); 
	 
			
			//댓글 수 
			int replyCount=bookstory_service.bookStoryReplyCount(idx); 
			model.addAttribute("replyCount",replyCount); 
			 
			
			return "bookstory/BookStoryView";  
		} 
		 
		
		 //좋아요 구현 
		  @RequestMapping("/like_check")
		  public void like_check(HttpServletRequest request, HttpServletResponse response) throws Exception{
			  String like_check2=request.getParameter("like_check");
			  String idx2=request.getParameter("idx");  
			  System.out.println("좋아요 수1"+like_check2);
			  int like_check=Integer.parseInt(like_check2); 
			  int idx=Integer.parseInt(idx2);  
 
			  if(like_check==0) {  //좋아요 0 일때, 좋아요수 증가 
				  response.getWriter().print("1"); 
				  bookstory_service.bookstorylike_check(idx,like_check);  
				  System.out.println("좋아요 수2"+like_check2);
				   
			  }else {  
				  response.getWriter().print("0");
				  bookstory_service.bookstorylike_check_cancle(idx,like_check);
				   
				  System.out.println("좋아요 수3"+like_check2);
			  }
			
		}
		

		
		//글보기> 수정폼
		@RequestMapping("/BookStoryModify")
			public String BookStoryModify(HttpServletRequest request,Model model){   
			String idx2=request.getParameter("idx");
				int idx=Integer.parseInt(idx2);
				BookStoryBoardDto dto=bookstory_service.bookstoryView(idx);
				model.addAttribute("content_view",dto);
				System.out.println(dto);
			return "bookstory/BookStoryModify";
		} 
		
		//글보기> 수정하기
		@RequestMapping(value="/BookStoryModifyAction", method = RequestMethod.POST , produces = "text/html; charset=UTF-8")
			public String BookStoryModifyAction(HttpServletRequest request,Model model, BookStoryBoardDto bookstoryDto) throws Exception{ 
			request.setCharacterEncoding("UTF-8");
			
			String idx2=request.getParameter("idx");
			int idx=Integer.parseInt(idx2); 
			
			String bs_category=request.getParameter("bs_category");
			String bs_title=request.getParameter("bs_title");
			String bs_content=request.getParameter("bs_content");
			 
			bookstoryDto.setBs_category(bs_category);
			bookstoryDto.setBs_title(bs_title);
			bookstoryDto.setBs_content(bs_content);  
			
			int nResult=bookstory_service.bookStoryUpdate(bookstoryDto);
			
			
			if(nResult<1) {
				System.out.println(nResult);
				System.out.println("글 수정을 실패하였습니다.");
				model.addAttribute("msg","글 수정을 실패하였습니다.");
				model.addAttribute("url","BookStoryModify");
			}else {
				System.out.println("글 수정을 성공하였습니다.");
				model.addAttribute("msg","글 수정을 성공하였습니다.");
				model.addAttribute("url","BookStoryView?idx="+idx);
			}
			
			return "redirect";
		} 
		 
		
		//글보기> 삭제
		@RequestMapping("/BoardStoryDeleteAction")
			public String BoardStoryDeleteAction(HttpServletRequest request,Model model, HttpSession session)throws Exception{
			String idx2=request.getParameter("idx");
			int idx=Integer.parseInt(idx2);
			 
			 int nResult=bookstory_service.bookstoryDelete(idx);
			System.out.println("nResult"+nResult);
			 
			 if(nResult<0) {
				 System.out.println("삭제를 실패하였습니다");
				 model.addAttribute("msg","BoardStoryDeleteAction?idx="+idx);
				 model.addAttribute("url","BookStoryView");
			 }else {
				 //게시글 수 삭제
				String id=(String)session.getAttribute("sessionID");   
				int deleteCountentCount=member_service.delete_content_count(id);
				System.out.println("게시글 수 차감"+deleteCountentCount);
				 
				 System.out.println("삭제를 성공하였습니다");
				 model.addAttribute("msg","삭제를 성공하였습니다.");
				 model.addAttribute("url","BookStoryMain");
			 }
		
			return "redirect";
		} 
			
			
		//댓글 쓰기
		@RequestMapping(value="/replyAction", method = RequestMethod.POST , produces = "text/html; charset=UTF-8")
		public String replyAction(HttpSession session, HttpServletRequest request, Model model){
			
			String idx2=request.getParameter("idx");
			int idx=Integer.parseInt(idx2); 
			 
			BookStoryBoardReplyDto replyDto=new BookStoryBoardReplyDto();
			replyDto.setIdx(idx);  
			replyDto.setReply_profile(request.getParameter("reply_profile"));
			replyDto.setReply_category(request.getParameter("reply_category"));
			String reply_writer=(String)session.getAttribute("sessionID");
			replyDto.setReply_writer(reply_writer);
			replyDto.setReply_content(request.getParameter("reply_content"));
			replyDto.setReg(new Date()); 
			System.out.println("replyDto"+replyDto);
			int nResult=bookstory_service.bookstoryRelpyWrite(replyDto);
			System.out.println("글쓰기 "+nResult);
			
			if(nResult<1) {
				System.out.println("댓글쓰기를 실패하였습니다.");
				model.addAttribute("msg","댓글쓰기를 실패하였습니다.");
				model.addAttribute("url","BookStoryView?idx="+idx);
			}else {
				String id=(String)session.getAttribute("sessionID");   
				int updateReplyCount=member_service.update_reply_count(id);
				System.out.println("댓글 수 증가"+updateReplyCount);
				 
				System.out.println("댓글쓰기를 성공하였습니다.");
				model.addAttribute("msg","댓글쓰기를 성공하였습니다.");
				model.addAttribute("url","BookStoryView?idx="+idx); 
			} 
			return "redirect";
	    }  
	
		//댓글 삭제
		@RequestMapping("/bookStoryReplyDeleteAction")
		public String bookStoryReplyDeleteAction(HttpServletRequest request, HttpSession session, Model model){

			String idx2=request.getParameter("idx");
			System.out.println("게시글번호"+idx2);
			int idx=Integer.parseInt(idx2);   
			
			
			String reply_no2=request.getParameter("reply_no");
			System.out.println("댓글번호"+reply_no2);
			int reply_no=Integer.parseInt(reply_no2); 
			
			
			int nResult=bookstory_service.bookStoryReplyDelete(reply_no); 
			
			
			if(nResult>0) {
				String id=(String)session.getAttribute("sessionID");   
				int deleteReplyCount=member_service.delete_reply_count(id);
				System.out.println("댓글 수 차감"+deleteReplyCount);
				
				
				System.out.println("댓글이 삭제되었습니다.");
				model.addAttribute("msg","댓글이 삭제되었습니다");
				model.addAttribute("url","BookStoryView?idx="+idx); 
			} 
			
			return "redirect";
		} 
		 
		//전체 글보기 > 전체 글 목록
		@RequestMapping("/BookStoryAllList")
		public String BookStoryAllList(HttpServletRequest request, Model model){
			//회원수
			int count=bookstory_service.getMainProfile(request);
			model.addAttribute("count",count);
			System.out.println("회원수:"+count);
			
			
			
			//페이징처리
			String page = request.getParameter("page");
			System.out.println( "page:" + page);
			
			
			if(page==null) {
				page="1";
			}
			
			List<BookStoryBoardDto> list=bookstory_service.bookstoryAllList(request,page);
			System.out.println("전체글보기:"+list);
			request.getSession().setAttribute("list", list); 
			request.getSession().setAttribute("page", page);
		
			return "bookstory/BookStoryAllList";
			}  
		 
		
		//카테고리-전체글보기,북스토리,한줄서평,책읽고리뷰,좋은글귀남기기
		@RequestMapping(value = {"/BookStoryCommunication","/BookStoryGoodWriting", "/BookStoryOneLineReivew","/BookStoryReadReivew"})
		public String bookStoryCategory(HttpServletRequest request, Model model) {
			String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
			
			//회원수
			int count=bookstory_service.getMainProfile(request);
			model.addAttribute("count",count);
			System.out.println("회원수:"+count);
			
			
			System.out.println("requestURL"+requestUrl);
			String nextUrl = "";
			if (requestUrl.equals("/BookStoryCommunication")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("북스토리,소통",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				
				nextUrl = "bookstory/BookStoryCommunication"; }
			
			else if (requestUrl.equals("/BookStoryGoodWriting")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("좋은글귀 남기기",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryGoodWriting"; }
			
			else if (requestUrl.equals("/BookStoryOneLineReivew")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("한줄서평",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryOneLineReivew"; }
			
			else if (requestUrl.equals("/BookStoryReadReivew")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("책읽고,리뷰남기기",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryReadReivew"; }
			return nextUrl;
		}
		   
		  
		 //관리자> 카테고리 -공지사항,작가정보,책이벤트
		 @RequestMapping(value = {"/BookStoryBookPreview_A","/BookStoryNotice_A","/BookStoryWriterInfo_A","/BookStoryEvent_A"})
			public String bookStoryCategory_A(HttpServletRequest request, Model model) {
			String requestUrl = (String)request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
			
			//회원수
			int count=bookstory_service.getMainProfile(request);
			model.addAttribute("count",count);
			System.out.println("회원수:"+count);
			
			
			System.out.println("requestURL"+requestUrl);
			String nextUrl = "";
			
			 if (requestUrl.equals("/BookStoryWriterInfo_A")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory2("작가정보",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryWriterInfo_A"; } 
			 
			 else  if (requestUrl.equals("/BookStoryBookPreview_A")) {
					String page = request.getParameter("page");
					System.out.println( "page:" + page);
					if(page==null) {
						page="1";
					}
					
					List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory3("책 미리보기",page);
					request.getSession().setAttribute("list", list); 
					request.getSession().setAttribute("page", page);
					
					nextUrl = "bookstory/BookStoryBookPreview_A"; } 
			
			else if (requestUrl.equals("/BookStoryEvent_A")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("책 이벤트",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryEvent_A"; } 
			 
			else if (requestUrl.equals("/BookStoryNotice_A")) {
				String page = request.getParameter("page");
				System.out.println( "page:" + page);
				if(page==null) {
					page="1";
				}
				
				List<BookStoryBoardDto> list=bookstory_service.bookStoryCategory("공지사항",page);
				request.getSession().setAttribute("list", list); 
				request.getSession().setAttribute("page", page);
				
				nextUrl = "bookstory/BookStoryNotice_A"; } 
			   
			 
			return nextUrl;
		} 
			 
		//관리자>북스토리- 회원관리  
		 @RequestMapping("/BookstoryManage")
		 public String BookstoryManage(Model model, HttpServletRequest request,HttpSession session){ 
			 
			 
		 List<MemberDto> list=member_service.memberManage();
		 model.addAttribute("list", list); 
		 
		 return "admin/BookstoryManage";  
		 } 
		 
		  
		 
		//관리자 > 북스토리 등급 수정
		@RequestMapping("/updateRankAction")
		public String updateRankAction(HttpServletRequest request, MemberDto memberDto, Model model) {
			String[] id = (String[]) request.getParameterValues("chBox");
			System.out.println("id"+id);
			int nResult=0;
			String rank=request.getParameter("rank");
			for(int i=0;i<id.length;i++) {
				nResult=member_service.updateRank(id[i], rank);
			}
			System.out.println("nResult"+nResult);
			if(nResult<=0) {
				model.addAttribute("msg","다시시도해주십시오.");
				 model.addAttribute("url","/BookstoryManage");
			}else {
				model.addAttribute("msg","상태수정 완료했습니다.");
				model.addAttribute("url","/BookstoryManage");
			} 
			return "redirect";  
		} 
		
		
		//등급
		@RequestMapping("/Rankstate")
		public String Rankstate(HttpServletRequest request,Model model, HttpSession session){
		 
			String ContentAndReplyCount=(request.getParameter("ContentAndReplyCount")); 
			
			int content_count=(int)storyboardmemberdto.getContent_count(); 
			int reply_count=(int)storyboardmemberdto.getContent_count(); 
			
			
			List<MemberDto> list=member_service.rankstate(ContentAndReplyCount,content_count,reply_count);
			 
			 model.addAttribute("list",list);
		return "admin/BookstoryManage"; 
		}
		 
		 
	//마일리지 적립 
	@RequestMapping("/upPointAction")
	public JsonObject upPointAction(HttpServletRequest request,Model model) {
		 JsonObject jsonObject = new JsonObject();
		 
		String [] user_id=request.getParameterValues("memberid");
		
		for(int i=0;i<user_id.length;i++) {
			request.setAttribute("memberId",user_id[i]);
			member_service.pointupdate(request);
			request.setAttribute("content","관리자 지급");
			point_service.insertPoint(request);
		}
		jsonObject.addProperty("responseCode", "success");
		return jsonObject;
	}
	
	
	@RequestMapping("/PointInfo") 
	public String PointInfo(HttpServletRequest request,Model model) throws Exception{
	 HttpSession session = request.getSession();
      String id = (String)session.getAttribute("sessionID");
      Criteria cri = new Criteria(1,10);
		int bookcnt=point_service.count(id);
		int allPageNum; 
		if(bookcnt%10==0) {
			allPageNum =bookcnt/10;
		}else {
			allPageNum =bookcnt/10+1; 
		}
		request.setAttribute("list",point_service.pointList(id,cri));
		cri.setAllPageNum(allPageNum);
		request.setAttribute("allPageNum", allPageNum);
      model.addAttribute("point",member_service.getUserInfo(id));
	 return"member/PointInfo";
	 }
	 
	//관리자 폼 > 회원 목록 > 회원 검색
	@RequestMapping("/MemberSearch")
	public String MemberSearch(HttpServletRequest request,Model model){
		int bookcnt=member_service.countMember();
		int allPageNum =0;		
		request.setAttribute("bookcnt", bookcnt);
		request.setAttribute("allPageNum", allPageNum);
		request.setAttribute("list",member_service.searchMember(request));
		return "admin/ManageMember"; 
		
		}
	
	//관리자 폼 > 회원 목록 > 회원탈퇴
	@RequestMapping("/AdminDeleteAction")
	public String AdminDeleteAction(HttpServletRequest request, MemberDto memberDto, Model model) {

		String idlist = request.getParameter("deleteid");
		System.out.println("idlist"+idlist);
		String[] idx=idlist.split(",",0);
		for(String id : idx) {
			request.setAttribute("id", id);
			member_service.insertComplain2(request);
			member_service.deleteMember2(id);
		}
		model.addAttribute("msg","회원 삭제를 완료하였습니다.");
		model.addAttribute("url","ManageMember");
		return "redirect";  
	}
	//책 검색
		@RequestMapping("/bookSearch")
		public String bookSearch(HttpServletRequest request,Model model){
		request.setAttribute("list",product_service.BookSearch(request));
		return "category/SearchBook"; }
				
		
		//1116 마이큐엔에이
		@RequestMapping("/MyProductQnA")
		public String MyProductQnA(HttpServletRequest request,Model model) {
			Criteria cri = new Criteria(1,10);
			int bookcnt=pro_qna_service.countMyProductQnA(request);
			int allPageNum; 
			if(bookcnt%10==0) {
				allPageNum =bookcnt/10;
			}else {
				allPageNum =bookcnt/10+1; 
			}
			request.setAttribute("list",pro_qna_service.myProductQnAList(request,cri));
			cri.setAllPageNum(allPageNum);
			request.setAttribute("allPageNum", allPageNum);	
			return "member/MyProductQnA";
		}
		
		//1116 마이큐엔에이 search 기능
		@RequestMapping("/SearchmyProductQnA")
		public String SearchmyProductQnA(HttpServletRequest request,Model model) {
			List<Product_QnA_Board_Dto> list=pro_qna_service.SearchmyProductQnA(request);
			int allPageNum =0;	
			request.setAttribute("allPageNum", allPageNum);
			model.addAttribute("list",list);
			return "member/MyProductQnA";
		}
		
		//1116 마이큐엔에이 답변없는 문의 기능
	   @RequestMapping("/NoAnswer_qna") 
	   public String NoAnswer_qna(HttpServletRequest request,Model model) { 
		  List<Product_QnA_Board_Dto> list=pro_qna_service.noAnswerQnA(request);
		  int allPageNum =0;	
		request.setAttribute("allPageNum", allPageNum);
		  model.addAttribute("list",list);
	      return "member/MyProductQnA"; 
	   }
	   
	   
	   //1118 마이큐엔에이 삭제
	   @RequestMapping("/DeleteMyProductQnA")
	   public String DeleteMyProductQnA(HttpServletRequest request,Model model) {
		   pro_qna_service.DeleteMyProductQnA(request);
		   model.addAttribute("msg","상품문의가 삭제되었습니다.");
		   model.addAttribute("url","/MyProductQnA");
		   return "redirect";
	   }
	   
	   //1117
	   @RequestMapping("/MyPageMain")
	   public String MyPageMain(HttpServletRequest request, Model model) {
		   String id = request.getParameter("id");
		   MemberDto userdto = member_service.getUserInfo(id);
		   Map<String, Integer> map=order_service.getUserOrderInfo(request);
		   List<Product_QnA_Board_Dto> qnalist = pro_qna_service.myProductQnAList2(request);
		   List<OnetoOneBoardDto> onelist=pro_qna_service.onetoonelistDao(request);
		     
		   model.addAttribute("userdto",userdto);
		   model.addAttribute("del1",map.get("del1"));
		   model.addAttribute("del2",map.get("del2"));
		   model.addAttribute("del3",map.get("del3"));
		   model.addAttribute("del4",map.get("del4"));
		   model.addAttribute("del5",map.get("del5"));
		   model.addAttribute("qnalist",qnalist);
		   model.addAttribute("onelist",onelist);

		   return "member/MyPageMain";
	   }
	   
	   @RequestMapping("/deleteReview")
	   public String deleteReview(HttpServletRequest request,Model model) {
		   review_service.deleteReview(request);
		   model.addAttribute("msg","리뷰가 삭제되었습니다.");
		   model.addAttribute("url","/ProductReviewComplete");
		   return "redirect";
	   }
	   
	   //1117 마이큐엔에이 상세보기
	   @RequestMapping("/MyProductQnAView")
	   public String MyProductQnAView(HttpServletRequest request,Model model) {
		   Product_QnA_Board_Dto dto=pro_qna_service.MyProductQnAView(request);
		   System.out.println("마이큐엔에이 리스트: "+dto);
		   model.addAttribute("dto",dto);
		   return "member/MyProductQnAView";
	   } 


	}
