package com.study.springboot.dto;

import java.util.Date;
import lombok.Data;

//공지사항+자주하는 질문+이벤트
@Data
public class Notice_Board_Dto {
	private int idx;  //글 번호
	private int category; //공지사항,자주하는 질문,이벤트 체
	private String n_writer; // 작성자
	private String n_title;  //글 제목
	private String n_content;  //글 내용
	private int n_hit; // 조회수
	private Date reg; //날짜
}
