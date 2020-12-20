package com.study.springboot.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Delete_MemberDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.ProductDto;
/*<!-- 1123수정 -->*/
@Primary
@Service
public class MemberService implements IMemberService{
	 
	@Autowired
	IMemberDao memberDao;
	
	@Autowired
	MemberDto memberDto;
	
	@Autowired
	Delete_MemberDto deleteDto; 
	
	 //회원가입
	@Override 
	public int insertMember(HttpServletRequest request) {
		memberDto.setId(request.getParameter("id"));
		memberDto.setPassword(request.getParameter("password"));
		memberDto.setName(request.getParameter("name")); 
		memberDto.setPhone(request.getParameter("phone"));  
		memberDto.setMail1(request.getParameter("mail1"));
		memberDto.setMail2(request.getParameter("mail2"));  
		memberDto.setAddress1(request.getParameter("address1"));
		memberDto.setAddress2(request.getParameter("address2"));
		memberDto.setAddress3(request.getParameter("address3"));
		memberDto.setAddress4(request.getParameter("address4"));
		memberDto.setBook_profile(request.getParameter("book_profile")); //북스토리 프로필 
		memberDto.setRank(request.getParameter("rank"));//북스토리 랭킹 
		memberDto.setPoint(100);
		memberDto.setReg(new Date()); 
		
		int nResult = memberDao.insertMemberDao(memberDto); 
		return nResult; 

	}

	//아이디 체크
	@Override
	public String idCheck(String id) {
		String nResult = memberDao.idCheckDao(id);
		return nResult;
	}

	// 중복체크 
	@Override
	public int loginCheck(String id, String password) {
		int nResult = memberDao.loginCheckDao(id, password);
		return nResult;
	} 
	 
	//로그아웃 
	@Override
	public int logout() { 
		return 1; //항상 성공
	}
	
	//정보수정 
	@Override
	public int updateMember(HttpServletRequest request) {
		// 세션이 가지고있는 로그인한 ID 정보를 가져온다
		HttpSession session = request.getSession();
		String id = session.getAttribute("sessionID").toString();
		
		System.out.println(id);
		// 수정할 정보를 자바빈에 세팅한다.
		
		memberDto.setId(id);
		memberDto.setPassword(request.getParameter("password")); 
		memberDto.setMail1(request.getParameter("mail1"));
		memberDto.setMail2(request.getParameter("mail2")); 
		memberDto.setPhone(request.getParameter("phone")); 
		memberDto.setAddress1(request.getParameter("address1"));
		memberDto.setAddress2(request.getParameter("address2"));
		memberDto.setAddress3(request.getParameter("address3"));
		memberDto.setAddress4(request.getParameter("address4"));
		int nResult = memberDao.updateMemberDao(memberDto);
		
		System.out.println(nResult+"");
		return nResult;
	}

	//내정보가져오기
	@Override
	public MemberDto getUserInfo(String id) {
		return memberDao.getUserInfoDao(id);
	}
	
	//회원탈퇴
	@Override
	public int deleteMember(String id, String password) {  
		
		int nResult = memberDao.deleteMemberDao(id,password);
		return nResult;
	}
	
	//탈퇴폼-불편사항
	@Override
	public int insertComplain(HttpServletRequest request) { 
		HttpSession session=request.getSession();
		String id = session.getAttribute("sessionID").toString();   
		deleteDto.setSession_id(id);
		deleteDto.setComplain_radio(request.getParameter("complain_radio"));
		deleteDto.setComplain_text(request.getParameter("complain_text"));
		deleteDto.setReg(new Date());
		System.out.println(deleteDto);
		int nResult = memberDao.insertComplainDao(deleteDto);
		return nResult;
	}
	 
	//아이디체크
	@Override
	public String idFindCheck(String name, String mail1, String mail2) {
		String nResult = memberDao.idFindCheckDao(name, mail1, mail2);
		return nResult;
	}

	//비밀번호찾기-이메일가져오기 
	@Override
	public MemberDto pwEmailFindCheck(HttpServletRequest request) {  
		  String email=request.getParameter("email");  
	  	    System.out.println("이메일dd"+email);
	  	    String mail1=null;
	  	    String mail2=null; 
	  	    
	  	    if(email!=null) {
	  	      String [] tokens= email.split("@"); 
		  	    if(tokens !=null && tokens.length>=2) {
		  	        mail1=tokens[0];
		  	        mail2=tokens[1]; 
		  	    }    
	  	    } 
	  	    
	  		memberDto.setId(request.getParameter("id"));
	  		memberDto.setName(request.getParameter("name"));
	  		memberDto.setMail1(mail1);
	  		memberDto.setMail2(mail2);   
		return memberDao.pwEmailFindCheckDao(memberDto);
	 
	}

	@Override
	public MemberDto pwCheck(HttpServletRequest request) {
		String email=request.getParameter("email");   
  	    System.out.println("이메일dd"+email);
  	    String mail1=null;
  	    String mail2=null; 
  	    
  	    if(email!=null) {
  	      String [] tokens= email.split("@"); 
	  	    if(tokens !=null && tokens.length>=2) {
	  	        mail1=tokens[0];
	  	        mail2=tokens[1]; 
	  	    }    
  	    } 
	  	  memberDto.setMail1(mail1);
		  memberDto.setMail2(mail2);   
  	    
		return memberDao.pwCheckDao(memberDto);
	}  
	
	@Override
	public int pointupdate(HttpServletRequest request)  {
		int up=(int)Double.parseDouble(request.getParameter("uppoint")); 
		int down=(int)Double.parseDouble(request.getParameter("downpoint")); 
		int point=(int)(up-down);
		String id="";
		if(request.getParameter("memberId")==null) {
			id=(String) request.getAttribute("memberId");
		}else{
			id=request.getParameter("memberId");
		};
		int nResult = memberDao.pointUpdateDao(point, id);
		return nResult;
	
	}
	@Override
	public List<MemberDto> list() {
		return memberDao.listDao();
	}
	
	//자동로그인 서비스
		@Override
		public int AutologinCheck(String id, String password) {
			int nResult = memberDao.loginCheckDao(id, password);
			return nResult; 
		}
		//회원목록 검색
		@Override
		public List<MemberDto> searchMember(HttpServletRequest request){
			String keyword1=request.getParameter("keyword1"); 
			String keyword2=request.getParameter("keyword2"); 
			String keyword3=request.getParameter("keyword3"); 
			String keyword4=request.getParameter("keyword4"); 
			System.out.println(request.getParameter("keyword1"));
			System.out.println(request.getParameter("keyword2"));
			System.out.println(keyword3);
			System.out.println(request.getParameter("keyword4"));
			return memberDao.searchMemberDao(keyword1,keyword2,keyword3,keyword4);
		}
		
		//탈퇴폼-불편사항
		@Override
		public int insertComplain2(HttpServletRequest request) { 
			
			String id = (String) request.getAttribute("id");
			deleteDto.setSession_id(id);
			deleteDto.setComplain_radio("관리자에 의한 탈퇴");
			deleteDto.setComplain_text("관리자에 의한 탈퇴");
			deleteDto.setReg(new Date());
			int nResult = memberDao.insertComplainDao(deleteDto);
			return nResult;
		}
		//회원탈퇴
		@Override
		public int deleteMember2(String id) {  
			int nResult = memberDao.deleteMemberDao2(id);
			return nResult;
		}
		@Override
		public int countMember() {
			return memberDao.countMemberDao();
		}
		@Override
		public List<MemberDto> getList(Criteria cri) {
			return memberDao.getListWithPaging(cri);
		}
		//탈퇴회원수
		@Override
		public int countDelete() { 
			return memberDao.countDeleteDao();
		}
		@Override
		public List<Delete_MemberDto> deletelist(Criteria cri){
			List<Delete_MemberDto> list = memberDao.deletelistDao(cri);
			return list;
		}

		@Override
		public List<MemberDto> memberManage() {
			List<MemberDto> list=memberDao.memberManageDao();
			return list;
		}
 
		@Override
		public int updateRank(String id,String rank){    
			int nResult = memberDao.updateRankDao(id,rank);
		      return nResult; 
		}

		@Override
		public int update_content_count(String id) {
			int nResult = memberDao.update_content_countDao(id);
		      return nResult; 
		}
		 
		@Override
		public int update_reply_count(String id) {
			int nResult = memberDao.update_reply_countDao(id);
		      return nResult; 
		}

		@Override
		public int delete_content_count(String id) {
			int nResult = memberDao.delete_content_countDao(id);
	        return nResult; 
		}

		@Override
		public int delete_reply_count(String id) {
			int nResult = memberDao.delete_reply_countDao(id);
			return nResult;
		}
  
		@Override
		public List<MemberDto> rankstate(String contentAndReplyCount,int content_count,int reply_count) { 
			return memberDao.rankstateDao(contentAndReplyCount,content_count,reply_count);
		}

		
}
