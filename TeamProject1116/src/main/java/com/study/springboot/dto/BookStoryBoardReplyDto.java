package com.study.springboot.dto;
 

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
/*<!-- 1123수정 -->*/
@Component
@Data
public class BookStoryBoardReplyDto {
	private int idx;
	private int reply_no;
	private String reply_profile;
	private String reply_category;
	private String reply_writer;
	private String reply_content;
	private Date reg; 
	private int like_check;//좋아요
}
