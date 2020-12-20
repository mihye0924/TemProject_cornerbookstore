package com.study.springboot.dto;

import java.util.Date;

import lombok.Data;

//장바구니
@Data
public class CartDto {
	private int idx;
	private int p_number; //상품번호
	private String p_title; //상품명
	private String p_writer;  //작가명
	private int product_number; //상품 갯수
	private String user_id; //사용자 id
	private int p_discount_ratio;
	private int p_price;
	private String p_filename;
	private Date reg; 
}
