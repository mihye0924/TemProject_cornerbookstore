package com.study.springboot.service;
  
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.FileUploadService;
import com.study.springboot.dao.IProductDao;
import com.study.springboot.dto.Criteria;
import com.study.springboot.dto.ProductDto;

@Primary
@Service
public class ProductService implements IProductService{
	
	@Autowired
	IProductDao dao;
	
	@Autowired
	FileUploadService fileUploadService;
	
	//상품 등록
	@Override
	public int uploadProduct(HttpServletRequest request,MultipartFile file,
			MultipartFile file2, Model model) {
		
		//상품 메인 이미지 1
		String originFilename=file.getOriginalFilename();
		String extName
		= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
		String saveFileName = fileUploadService.genSaveFileName(extName);
		
		//상품 소개 이미지 2
		String originFilename2=file2.getOriginalFilename();
		String extName2
		= originFilename2.substring(originFilename2.lastIndexOf("."), originFilename2.length());
		String saveFileName2 = fileUploadService.genSaveFileName(extName2);
		
		ProductDto dto=new ProductDto();
		// 상품 번호 정수로 전환
		String p_num=request.getParameter("p_number");
		int p_number=Integer.parseInt(p_num);
		// 상품 판매가 정수로 전환
		String p_pri=request.getParameter("p_price");
		int p_price=Integer.parseInt(p_pri);
		// 상품 할인율 정수로 전환
		String p_discount=request.getParameter("p_discount_ratio");
		int p_discount_ratio=Integer.parseInt(p_discount);
		// 상품 재고 정수로 전환
		String p_sto=request.getParameter("p_stock");
		int p_stock=Integer.parseInt(p_sto);
		Date date=new Date();
		
		dto.setP_number(p_number); //상품번호
		dto.setP_title(request.getParameter("p_title")); //상품이름
		dto.setP_writer(request.getParameter("p_writer"));//작가
	    dto.setP_price(p_price); //상품 판매가
	    dto.setP_discount_ratio(p_discount_ratio); //할인율
	    dto.setP_category(request.getParameter("p_category")); //카테고리1
	    dto.setP_category2(request.getParameter("p_category2")); //카테고리2
	    dto.setP_stock(p_stock); //재고
	    dto.setP_content(request.getParameter("p_content")); //상품설명
	    dto.setP_filename("uploadPro/"+saveFileName); //상품 이미지
	    dto.setP_filename2("uploadPro2/"+saveFileName2); //상품 소개 이미지
	    dto.setReg(date); //등록일
	    dao.uploadProductDao(dto);
	    
	    String url = fileUploadService.restore(file);
		System.out.println("url:" + url);
		model.addAttribute("url", url);
		
		String url2 = fileUploadService.restore2(file2);
		System.out.println("url2:" + url2);
		model.addAttribute("url2", url2);
	
		return 0;
	}
	
	//상품 번호 중복
	@Override
	public int Product_num_Check(int p_number) {
		Integer db_number = dao.ProductnumCheckDao(p_number);
		int x = 0;
		if(db_number!=null) {
			if(p_number==db_number) {
				x=1;
			}else {
				x=0;
			}
			}
		return x;
	}
	
	//상품 목록
	@Override
	public List<ProductDto> productList() {
		List<ProductDto> list = dao.productListDao();
		return list;
	}

	//상품 수정
	@Override
	public int modifyProduct(HttpServletRequest request, Model model,
			MultipartFile file,
			MultipartFile file2) {
		
		//상품 메인 이미지 1
		String originFilename=file.getOriginalFilename();
		String extName
		= originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
		String saveFileName = fileUploadService.genSaveFileName(extName);
		
		//상품 소개 이미지 2
		String originFilename2=file2.getOriginalFilename();
		String extName2
		= originFilename2.substring(originFilename2.lastIndexOf("."), originFilename2.length());
		String saveFileName2 = fileUploadService.genSaveFileName(extName2);
		
		
		ProductDto dto=new ProductDto();
		// 상품 번호 정수로 전환
		String p_num=request.getParameter("p_number");
		int p_number=Integer.parseInt(p_num);
		// 상품 판매가 정수로 전환
		String p_pri=request.getParameter("p_price");
		int p_price=Integer.parseInt(p_pri);
		// 상품 할인율 정수로 전환
		String p_discount=request.getParameter("p_discount_ratio");
		int p_discount_ratio=Integer.parseInt(p_discount);
		// 상품 재고 정수로 전환
		String p_sto=request.getParameter("p_stock");
		int p_stock=Integer.parseInt(p_sto);
        Date date=new Date();
      
		dto.setP_number(p_number);
		dto.setP_title(request.getParameter("p_title")); //상품이름
		dto.setP_writer(request.getParameter("p_writer"));//작가
	    dto.setP_price(p_price); //상품 판매가
	    dto.setP_discount_ratio(p_discount_ratio); //할인율
	    dto.setP_category(request.getParameter("p_category")); //카테고리1
	    dto.setP_category2(request.getParameter("p_category2")); //카테고리2
	    dto.setP_stock(p_stock); //재고
	    dto.setP_content(request.getParameter("p_content")); //상품설명
	    dto.setP_filename("uploadPro/"+saveFileName); //상품 표지 이미지
	    dto.setP_filename2("uploadPro2/"+saveFileName2); //상품 소개 이미지
	    dto.setReg(date); //등록일
	    dao.modifyProductDao(dto);
	    
	    String url = fileUploadService.restore(file);
		System.out.println("url:" + url);
		model.addAttribute("url", url);
		
		String url2 = fileUploadService.restore2(file2);
		System.out.println("url2:" + url2);
		model.addAttribute("url2", url2);
		
		return 0;
	}
	
	//상품 삭제
	public void DeleteProduct(int idx) {
		dao.DeleteProduct(idx);
	}

	//상품 상세보기
	@Override
	public ProductDto viewProductDetail(int p_number) {
		ProductDto dto=dao.viewProductDetailDao(p_number);
		return dto;
	}
	
	@Override
	public List<ProductDto> bookCategory1Dao(String category) {
		return dao.bookCategory1Dao(category);
	}
	
	@Override
	public List<ProductDto> bookCategory2Dao(String category) {
		return dao.bookCategory2Dao(category);
	} 
	
   //페이징 처리
	@Override
	public List<ProductDto> getList(Criteria cri) {
		return dao.getListWithPaging(cri);
	}

	@Override
	public int countProduct() {
		dao.countProductDao();
		return dao.countProductDao();
	}

	@Override
	public List<ProductDto> SearchProduct(HttpServletRequest request) {
		String check_category = request.getParameter("check_category");
		String searchName = request.getParameter("searchName");
		System.out.println("카테고리는 "+check_category+", 검색어는 "+searchName);
		List<ProductDto> list=dao.SearchProductDao(check_category,searchName);
		return list;
	}

	@Override
	public int CountSearchProduct(HttpServletRequest request) {
		String check_category = request.getParameter("check_category");
		String searchName = request.getParameter("searchName");
		
		return dao.CountSearchProductDao(check_category,searchName);
	}
	@Override
	public List<ProductDto> BookSearch(HttpServletRequest request) {
		String keyword = request.getParameter("search");
		List<ProductDto> list=dao.BookSearchDao(keyword);
		return list;
	}

	@Override
	public List<ProductDto> getAllBook(Criteria cri) {
		return dao.getAllBookDao(cri);
	}
} 
