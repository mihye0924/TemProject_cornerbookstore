package com.study.springboot.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class Delete_MemberDto {
	private int idx;
	private String session_id;
	private String complain_radio;
	private String complain_text;
	private Date reg;
} 
