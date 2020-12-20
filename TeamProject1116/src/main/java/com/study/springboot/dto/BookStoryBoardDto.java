package com.study.springboot.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

/*<!-- 1123수정 -->*/
@Component
@Data
public class BookStoryBoardDto {
	private int idx; //게시글 번호
	private String bs_category; //게시글 카테고리
	private String bs_user_id; //게시글 아이디
	private String bs_title; //게시글 제목
	private String bs_content; //게시글 내용
	private String profile_img; //게시글 프로필
	private String bs_file1;//게시글 내용 이미지
	private Date reg; //등록일자
	private int hit; //조회수 
 
	private int like_check; //좋아요 체크확인여부
	
}