package com.study.springboot.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data; 

@Component
@Data
public class OnetoOneBoardDto {
	private int idx;//번호
	private String o_type; //유형 
	private String o_phone;//번호
	private String user_id;//작성자
	private String o_title;//제목
	private String o_content_Q;// 사용자 질문
	private String admin_id;//관리자아이디
	private String o_content_A;//관리자 답변
	private String o_ans_check; //답변여부 컬럼
	private Date reg_a;
	private Date reg;
	
	
//	페이징구현
	private int pageCnt;//전체페이지 수
	private int startRow;//시작페이지
	private int endRow;//끝페이지
	
//	현재페이지
	private int pageIndex=1; //게시판 시작번호
	private int pageSize=10; //한 페이지에 나오는 게시물 개수
	private int pageGroupSize=5; //페이지 번호 몇개 보여줄것인지
	
	private boolean prev; //시작버튼
	private boolean next; //끝버튼
	
	
	
}
	 