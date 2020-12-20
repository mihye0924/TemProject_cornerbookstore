package com.study.springboot.dto;

import java.sql.Timestamp;
import java.util.Date;
import lombok.Data;
// 상품 정보
@Data
public class ProductDto {
	private int idx;
	private int p_number; //상품번호
	private String p_writer; //작가이름
	private String p_title;  //이름
	private int p_price;  //가격
	private int p_discount_ratio;  //할인율
	private String p_category; //상품 카테고리
	private String p_category2; //상품 카테고리
	private String p_content; //상품 설명
	private String p_filename;  //이미지 
	private String p_filename2;  //이미지2 
	private int p_stock;  //재고
	private Date reg;	//등록일자
	

}
