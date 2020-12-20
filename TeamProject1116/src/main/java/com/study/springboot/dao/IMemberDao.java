package com.study.springboot.dao;
   
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.Delete_MemberDto;
import com.study.springboot.dto.MemberDto;
import com.study.springboot.dto.OrderDto;
import com.study.springboot.dto.Review_Board_Dto;
/*<!-- 1123수정 -->*/
//로그인, 회원가입
@Mapper
public interface IMemberDao {
	public int insertMemberDao(MemberDto memberDto);  
	public String idCheckDao(String id);
	public int loginCheckDao(String id, String pw);
	public MemberDto getUserInfoDao(String id);  
	public int updateMemberDao(MemberDto memberDto);  
	public int deleteMemberDao(String id, String password);   
	public int deleteMemberDao2(String id);   
	public int insertComplainDao(Delete_MemberDto deleteDto);
	public String idFindCheckDao(String name, String mail1, String mail2);    
	public MemberDto pwEmailFindCheckDao(MemberDto memberDto);  
	public MemberDto pwCheckDao(MemberDto memberDto);
	public List<MemberDto> listDao();
	public int pointUpdateDao(int point,String id);
	public int writeReviewDao(Review_Board_Dto dto);
	public List<Review_Board_Dto> viewWrittenReviewDao(HashMap<String,Object> map);// 상품후기 완료리스트
	public int countReviewCompleteDao(String id); // 상품후기완료 수
	public List<Review_Board_Dto> reviewlistDao();
	public int changeReviewStateDao(int i,int o_number);
	public int deleteReviewDao(int idx);
	public int changeReviewState(int o_number);
	public List<OrderDto> SearchOrderDao(String fromDate, String toDate);
	public int AutologinCheckDao(String id, String password); //자동로그인 서비스 
	public List<MemberDto> searchMemberDao(String keyword1,String keyword2,String keyword3,String keyword4); //Admin 회원정보검색
	public int countMemberDao();
	public List<MemberDto> getListWithPaging(Criteria cri);
	public int countDeleteDao();
	public List<Delete_MemberDto> deletelistDao(Criteria cri);  // 수정
  
	//1119 리뷰 수정
	public Review_Board_Dto modifyReviewFormDao(int idx);
	public int modifyReviewDao(Review_Board_Dto dto);
	
	//북스토리회원-등급관리
	public List<MemberDto> memberManageDao();
	public int updateRankDao(String id, String rank);
	public int update_content_countDao(String id); 
	public int update_reply_countDao(String id);
	public int delete_content_countDao(String id); 
	public int delete_reply_countDao(String id);
	public List<MemberDto> rankstateDao(String contentAndReplyCount, int content_count, int reply_count); //게시글,댓글 수 찾기
}

