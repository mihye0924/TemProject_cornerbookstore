package com.study.springboot.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.ProductDto;

public interface IProductService {
	//public int uploadProduct(HttpServletRequest request);
	public List<ProductDto> productList();
	public int uploadProduct(HttpServletRequest request, MultipartFile file,
			MultipartFile file2, Model model);
	public int modifyProduct(HttpServletRequest request, Model model, MultipartFile file, MultipartFile file2);
	public ProductDto viewProductDetail(int p_number);
	public void DeleteProduct(int idx); //상품 삭제
	public int Product_num_Check(int p_number);
	
	public List<ProductDto> getAllBook(Criteria cri);
	public List<ProductDto> bookCategory1Dao(String category);
	public List<ProductDto> bookCategory2Dao(String category);
	
	//페이징처리
    public List<ProductDto> getList(Criteria cri);
	public int countProduct();
	
	//상품 검색
	public List<ProductDto> SearchProduct(HttpServletRequest request);
	public List<ProductDto> BookSearch(HttpServletRequest request);
	public int CountSearchProduct(HttpServletRequest request);
	 
} 
