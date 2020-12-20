package com.study.springboot.dto;

import lombok.Data;

@Data
public class Criteria {
	private int allPageNum; //전체 페이지 수
	private int pageNum; //페이지 수
	private int amount; //한 페이지당 몇개 보일건지
	private int bookcnt;  //전체 책 권수
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}


}
