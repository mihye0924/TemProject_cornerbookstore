package com.study.springboot.dto;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
// 회원정보
@Component
@Data
public class PointDto {
	
	private int idx;
	private String id_member;
	private String pt_content;
	private int pt_move;
	private int pt_result;
	private Date reg;	
}
 
