<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
    String id = (String) session.getAttribute("sessionID");
 %>
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
      <h2>상품 문의 상세보기</h2>
      <table class="table table-striped">
	  <tbody>
	    <tr>
	      <th scope="row">상품번호</th>
	      <td>${dto.p_number}</td>
	    </tr>
	    <tr>
	      <th scope="row">상품명</th>
	      <td>${dto.p_title}</td>
	    </tr>
	    <tr>
	      <th scope="row">작가명</th>
	      <td>${dto.p_price}</td>
	    </tr>
	    <tr>
	      <th scope="row">카테고리</th>
	      <td>${dto.p_category}</td>
	    </tr>
	     <tr>
	      <th scope="row">책 이미지</th>
	      <td><img src="${dto.p_filename}"></td>
	    </tr>
	    <tr>
	  </tbody> 
	</table>
	
	<table class="table table-bordered">
		  <thead>
		    <tr class="table-info">
		      <th scope="col" style="width: 550px">문의 내용</th>
		      <th scope="col">문의 날짜</th>
		      <th scope="col">아이디</th>
		    </tr>
		  </thead>
		  <tbody>
		  <tr class="table-light">
		  <fmt:formatDate value="${dto2.reg}" var="reg" pattern="yyyy.MM.dd"/>
		  <td>${dto2.p_content}</td>
		  <td>${reg}</td>
		  <td>${dto2.id}</td>
		  </tr>
		  </tbody>
	</table>
		<table class="table table-bordered">
			<thead>
			    <tr class="table-info">
			      <th scope="col" style="width: 550px">답변 내용</th>
			      <th scope="col">수정</th>
			    </tr>
			</thead>
			<tbody>
			<c:set var = "p_answer_state" scope = "session" value = "${dto2.p_answer_state}"/>
	        <c:if test = "${p_answer_state eq '미등록'}">
	        </c:if>
			<c:set var = "p_answer_state" scope = "session" value = "${dto2.p_answer_state}"/>
	        <c:if test = "${p_answer_state eq '답변완료'}">
				<tr class="table-light">
				  <td>
				  <img src="image/reply.png" style="width: 20px; ">
				  ${dto2.p_answer}</td>
				  <td><button class="btn btn-danger btn-sm" style="width:40px; height:20px; font-size:10px;">
				  <a href="ProductAnswerDelete?idx=${dto2.idx}" style="color:white; text-decoration:none;">삭제</a></button></td>
		   	    </tr>	
		   	</c:if>  
			</tbody>
	</table>
	
	<div>
	<form action="ProductAnswer" method="POST">
	<input type="hidden" name="idx" value="${dto2.idx}">
	<textArea name="p_answer" cols="80" row="30" style="font-size: 16px;"></textArea>
	<select name="p_answer_state">
	  <option value="미등록" selected>미등록</option>
	  <option value="답변완료">답변완료</option>  
	</select>
	<button type="submit" class="btn btn-info btn-sm">답변</button>
	</form>
	</div>
      
      
      </div>
      
 </div>  <!-- AdminWrapper2 -->
 </div>  <!-- AdminWrapper1 -->
      
      
<script src="js/jquery-2.2.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>     
</body>
</html>