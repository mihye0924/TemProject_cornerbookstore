package com.study.springboot.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;
// 상품별 문의 게시판
@Data
public class Product_QnA_Board_Dto {
	private int idx;  //번호
	private String id;
	private int p_number;  //상품 번호
	private String p_content;  //질문 내용
	private String p_answer; //질문 답변
	private String p_answer_state; //답변 상태
	private Date reg; //날짜
	private String p_title;
	private String p_writer;
}
