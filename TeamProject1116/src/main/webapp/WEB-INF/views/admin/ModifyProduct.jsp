<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
	/* 사이드바 메인컨텐츠 기본양식 시작 */
 	.AdminWrapper1{
	width: 100%;
	text-align:center; 
	min-width:1200px;
	}
	 .AdminWrapper2{
	display: inline-block;  
	margin-top:250px;
	}  
 	.sidebar, .contents{
	display: inline-block;
	}
	.sidebar>p{
    font-size: 30px;
    font-weight: 900; 
    }  
    table tr td >a{
    text-decoration:none;
    color: rgb(40, 40, 40);
    }
    /* 사이드바 메인컨텐츠 기본양식 끝 */
    textarea{
	width:500px; 
	height:250px; 
    resize:none;
    }
	</style>

</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<!-- 헤더부분 -->
    <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	
      <!-- 왼쪽 사이드 메뉴바 시작 -->
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>상품관리</p>
					<tr>
						<td>
							<a href="ManageProduct">상품 목록</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
						    <a href="UploadProduct">상품 등록</a>
							<span href="#">&gt</span>
						</td>
					</tr>
				</table>
			 
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
		
      
     <div class="contents">
		<form action="ModifyProductAction" method="post" enctype="multipart/form-data"> 
		<h2>상품 등록</h2>
				<table class="table table-striped">
			  <tbody>
			    <tr>
			      <th scope="row" width=120px>상품번호</th>
			      <td><input type="text" name="p_number" value="${dto.p_number}"></td>
			    </tr>
			    <tr>
			      <th scope="row">상품명</th>
			      <td><input type="text" name="p_title" value="${dto.p_title}"></td>
			    </tr>
			     <tr>
			      <th scope="row">작가명</th>
			      <td><input type="text" name="p_writer" value="${dto.p_writer}"></td>
			    </tr>
			    <tr>
			      <th scope="row">판매가</th>
			      <td>
					<input type="text" name="p_price" value="${dto.p_price}"> 
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">할인율</th>
						<td>
							<select name="p_discount_ratio" id="discount_rate" onchange="cal_price()" >
								<option value="0" <c:if test="${dto.p_discount_ratio eq '0'}">selected</c:if>>없음</option>
								<option value="5" <c:if test="${dto.p_discount_ratio eq '5'}">selected</c:if>>5%</option>
								<option value="10" <c:if test="${dto.p_discount_ratio eq '10'}">selected</c:if>>10%</option>
								<option value="15" <c:if test="${dto.p_discount_ratio eq '15'}">selected</c:if>>15%</option>
								<option value="20" <c:if test="${dto.p_discount_ratio eq '20'}">selected</c:if>>20%</option>
								<option value="30" <c:if test="${dto.p_discount_ratio eq '30'}">selected</c:if>>30%</option>
							</select>
						</td>
			    </tr>
			    <tr>
			      <th scope="row">카테고리1</th>
						<td>
							<select name="p_category">
								<option value="소설" <c:if test="${dto.p_category eq '소설'}">selected</c:if>>소설</option>
								<option value="경제/경영" <c:if test="${dto.p_category eq '경제/경영'}">selected</c:if>>경제/경영</option>
								<option value="시/에세이" <c:if test="${dto.p_category eq '시/에세이'}">selected</c:if>>시/에세이</option>
								<option value="인문학" <c:if test="${dto.p_category eq '인문학'}">selected</c:if>>인문학</option>
								<option value="예술" <c:if test="${dto.p_category eq '예술'}">selected</c:if>>예술</option>
								<option value="자기계발" <c:if test="${dto.p_category eq '자기계발'}">selected</c:if>>자기계발</option>
								<option value="독립서적" <c:if test="${dto.p_category eq '독립서적'}">selected</c:if>>독립서적</option>
								<option value="음반" <c:if test="${dto.p_category eq '음반'}">selected</c:if>>음반</option>
							</select>
						</td>
			    </tr>
			        <tr>
			      <th scope="row">카테고리2</th>
			            <td>
							<select name="p_category2">
								<option value="일반" <c:if test="${dto.p_category2 eq '일반'}">selected</c:if>>일반도서</option>
								<option value="인기" <c:if test="${dto.p_category2 eq '인기'}">selected</c:if>>인기도서</option>
								<option value="신간" <c:if test="${dto.p_category2 eq '신간'}">selected</c:if>>신간도서</option>
								<option value="추천" <c:if test="${dto.p_category2 eq '추천'}">selected</c:if>>추천도서</option>
							</select>
						</td>			
			    </tr>
			    <tr>
			      <th scope="row">재고수량</th>
				  <td><input type="text" name="p_stock" value="${dto.p_stock}"></td>
			    </tr>
			    <tr style="height:300px;">
			      <th scope="row">상품 설명</th>
				  <td><textArea name="p_content" cols="70" row="100">
					${dto.p_content}
					</textArea>
				  </td>
			    </tr>
			    <tr>
			     <th scope="row">상품 표지 이미지 등록</th>
			     <td>
			     <input type="file" name="p_filename">
			     </td>
			    </tr>
			    <tr>
			     <th scope="row">상품 소개이미지 등록</th>
			     <td>
			     <input type="file" name="p_filename2"></td>
			    </tr>
			  </tbody>
			</table>
		
		<button type="submit" class="btn btn-danger" style="color: white;">수정</button>
		<button class="btn btn-danger"><a href="ManageProduct" style="color: white;">목록으로</a></button>
		</form>      
     </div> 
   
    </div>  <!-- AdminWrapper2 -->
	</div>  <!-- AdminWrapper1 -->
 <script src="js/jquery-2.2.4.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>

</body>

</html>






