package com.study.springboot.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OnetoOneBoardDto;
 
@Mapper
public interface IOnetoOneBoardDao {  
	public int writeDao(OnetoOneBoardDto oneBoardDto); 
	public List<OnetoOneBoardDto> listDao(HashMap<String,Object> map); 
	public OnetoOneBoardDto content_viewDao(int idx);
    public int boardModfiyDao(OnetoOneBoardDto dto);    
	public int boardDeleteDao(int idx); 
	public OnetoOneBoardDto content_replyDao(int idx); //관리자답변가져오기
	public List<OnetoOneBoardDto> search_userDao(String category,String user_id,String keyword); 
	public List<OnetoOneBoardDto> noanswer_userlistDao(String check, String user_id);
	public int countMemberDao(String id);
//	관리자페이지- 1:1문의    
	public List<OnetoOneBoardDto> noanswerlistDao(String check);     
	public int adminwriteDao(int idx, String admin_id, String o_content_A, String o_ans_check);
	public List<OnetoOneBoardDto> adminlistDao(Criteria cri); // 수정 
	public int countDao();
	public List<OnetoOneBoardDto> searchDao(String category,String keyword);  
	public int adminReplyDeleteDao(int idx, String admin_id, String o_content_A, String o_ans_check); //답변삭제
	 
}
