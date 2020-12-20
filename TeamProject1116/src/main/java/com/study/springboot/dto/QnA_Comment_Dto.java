package com.study.springboot.dto;

import java.sql.Date;

import lombok.Data;

//1:1 문의 게시판 답글
@Data
public class QnA_Comment_Dto {
	private int idx;
	private int q_idx;  //원글번호
	private String comment; //답글 내용
	private Date date;

}
