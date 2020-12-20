package com.study.springboot.dto;

import java.util.Date;

import lombok.Data;
// 주문목록
@Data
public class OrderDto {
	private int o_number; //주문번호
	private int p_number; //상품번호 
	private String p_title; //책제목
	private String p_writer; //작가
	private int count; //상품갯수
	private String o_orderid;  //주문자 이름
	private int o_price;  //상품가격
	private String o_receiver;  //수령인
	private String o_address; // 수령인 주소
	private String o_phone;  //수령인 전화번호
	private int o_point;  //마일리지
	private int o_total;  //총 금액
	private String o_memo;  //메모
	private String p_filename; //사진
	private String o_charge;  //결제방식
	private String o_charge2;  //결제방식 (신용카드인경우)
	private String o_state;  //배송상태  
	private int review_state;
	private Date reg; //날짜
}
