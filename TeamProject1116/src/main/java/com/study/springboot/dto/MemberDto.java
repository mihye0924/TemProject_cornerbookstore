package com.study.springboot.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
// 회원정보
@Component
@Data
public class MemberDto {
	private int idx;
	private String id;
	private String password;
	private String name;
	private String mail1;
	private String mail2;
	private String phone;
	private String address1;
	private String address2;
	private String address3;
	private String address4;
	private int point;
	private Date reg;	 
	private String book_profile; //북스토리 프로필 
	private String rank;// 북스토리 등급
	private int content_count; //북스토리 게시글 수
	private int reply_count; //북스토리 댓글 수
	
	private boolean cookieDel; 
	private String complain_radio; //탈퇴시 불편사항
	private String complain_text; //탈퇴시 내용 
	
	
	
}
 
