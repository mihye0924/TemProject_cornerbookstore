package com.study.springboot.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IOnetoOneBoardDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.OnetoOneBoardDto;

@Primary
@Service
public class OnetoOneBoardService implements IOnetoOneBoardService{

	@Autowired
	IOnetoOneBoardDao oneBoardDao;
	@Autowired
	OnetoOneBoardDto oneBoardDto; 
	 
	@Override
	public int write(OnetoOneBoardDto oneBoardDto) {
		int nResult=oneBoardDao.writeDao(oneBoardDto);
		return nResult;
	}

	@Override
	public List<OnetoOneBoardDto> list(String id,Criteria cri) {
		HashMap <String,Object> map = new HashMap <String,Object>();
		map.put("id",id);
		map.put("cri",cri);
		return oneBoardDao.listDao(map);
	}
 
	@Override
	public  OnetoOneBoardDto content_view(int idx) {    
		OnetoOneBoardDto dto=oneBoardDao.content_viewDao(idx);  
 
		return dto;
	}
  
 
	@Override
	public int boardModify(OnetoOneBoardDto oneboardDto) {
		return oneBoardDao.boardModfiyDao(oneboardDto);
	}
      
	@Override
	public int boardDelete(int idx) {
		return oneBoardDao.boardDeleteDao(idx);
	}
	
	public List<OnetoOneBoardDto> search_user(String o_type,String user_id,String keyword){
		
		return oneBoardDao.search_userDao(o_type,user_id, keyword);
	}
	
	@Override
	public List<OnetoOneBoardDto> noanswer_userlist(String check,String user_id) {
		List<OnetoOneBoardDto> list=oneBoardDao.noanswer_userlistDao(check,user_id);
		return list;
	}

	
////	관리자페이지-1:1문의   
	@Override  // 수정
	public List<OnetoOneBoardDto> adminlist(Criteria cri) { 
		 List<OnetoOneBoardDto> list=oneBoardDao.adminlistDao(cri);
		return list;
	}
	@Override
	public List<OnetoOneBoardDto> noanswerlist(String check) { 
		List<OnetoOneBoardDto> list=oneBoardDao.noanswerlistDao(check);
		return list;
	}

	@Override 
	public int adminwrite(int idx,String admin_id,String o_content_A,String o_ans_check) {
		return oneBoardDao.adminwriteDao(idx,admin_id,o_content_A,o_ans_check);
	}

	@Override
	public OnetoOneBoardDto content_reply(int idx) {
		return oneBoardDao.content_replyDao(idx);   
	} 
	
	public List<OnetoOneBoardDto> search(String category,String keyword){
		return oneBoardDao.searchDao(category, keyword);
	}
	@Override
	public int count() {
		return oneBoardDao.countDao();
	}

	@Override
	public int countMember(String id) {
		return oneBoardDao.countMemberDao(id);
	}

	@Override
	public int adminReplyDelete(int idx,String admin_id,String o_content_A,String o_ans_check) {
		return oneBoardDao.adminReplyDeleteDao(idx,admin_id,o_content_A,o_ans_check);
	}
 
	
}
