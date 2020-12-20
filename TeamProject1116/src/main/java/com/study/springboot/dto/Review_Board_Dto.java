package com.study.springboot.dto;

import java.util.Date;

import lombok.Data;
 
// 후기게시판
@Data
public class Review_Board_Dto {
	private int idx; //글 번호
	private String o_orderid;//아이디
	private int o_number;
	private String p_title; //상품명
	private String p_writer; //작가
	private int p_number; //상품번호
	private String description; //후기 내용
	private String rate; //만족도
	private String p_filename; //상품사진
	private Date reg;
}
