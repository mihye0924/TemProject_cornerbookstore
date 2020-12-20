<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   	.sidebar{   
      width: 180px;
      height: 700px; 
    } 
    .sidebar table tr td{
      width: 150px; 
      border:1px solid rgb(155, 155, 155);
      border-collapse: collapse;    
    } 
    .sidebarlist{
      padding-left:25px;
   	  padding: 8px;
      width: 178px;
      height: 40px;
    }
    .sidebarlist>a{
      color: rgb(40, 40, 40);
      text-decoration: none;   
    }
    .sidebarlist:hover{
      background-color: rgb(239, 239, 239);
    }
    /* 사이드바 메인컨텐츠 기본양식 끝 */
    a{
    text-decoration: none;
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
						    <div class="sidebarlist">
							<a href="ManageProduct">상품 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="UploadProduct">상품 등록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="ProductQnA">상품 문의</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
		
      
     <div class="contents">
		<h2>상품 등록</h2>
				<table class="table table-striped">
			  <tbody>
			    <tr>
			      <th scope="row" width=120px>상품번호</th>
			      <td>${dto.p_number}</td>
			    </tr>
			    <tr>
			      <th scope="row">상품명</th>
			      <td>${dto.p_title}</td>
			    </tr>
			     <tr>
			      <th scope="row">작가명</th>
			      <td>${dto.p_writer}</td>
			    </tr>
			    <tr>
			      <th scope="row">판매가</th>
			      <td>
					${dto.p_price} 원   <!-- 천 단위 콤마 기능 추가하기 -->
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">할인율</th>
						<td>${dto.p_discount_ratio}</td>
			    </tr>
			    <tr>
			      <th scope="row">카테고리1</th>
						<td>
						${dto.p_category}
						</td>
			    </tr>
			        <tr>
			      <th scope="row">카테고리2</th>
						<td>
						${dto.p_category2}
						</td>
			    </tr>
			    <tr>
			      <th scope="row">재고수량</th>
				  <td>${dto.p_stock}</td>
			    </tr>
			    <tr>
			      <th scope="row">상품 설명</th>
				  <td>
					${dto.p_content}
				  </td>
			    </tr>
			    <tr>
			     <th scope="row">이미지 등록</th>
			     <td><img src="${dto.p_filename}"></td>
			    </tr>
			  </tbody>
			</table>
		<button class="btn btn-danger"><a href="ModifyProduct?p_number=${dto.p_number}" style="color:white;">수정</a></button>
		<button class="btn btn-danger"><a href="ManageProduct" style="color: white;" >목록으로</a></button>
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
















