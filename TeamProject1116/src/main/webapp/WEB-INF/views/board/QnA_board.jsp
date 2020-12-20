<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<title>게시판리스트</title>
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
	
	#bt{
	 relative : bottom;
	}
	.actionbar{
	width:150px;
	}
	</style>
    <script type="text/javascript">
    function goFirstForm() {
		location.href = "Notice_board";
	}
	function goNotice_write() {
		location.href = "QnA_write";
	}
	
    </script>
</head>
<body>
<!-- 헤더 부분  -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<!-- 헤더 부분  -->

 <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	

	<!-- <div class="sidebar">
			<ul>
				<li>고객센터</li>
				<li><a href="Notice_board">공지사항</a></li>
				<li><a href="#">1:1문의</a></li>
				<li><a href="QnA_board">자주묻는 질문</a></li>
				<li><a href="#">이벤트</a></li>
			</ul>
	   </div> -->
	   
	   <!-- 왼쪽 사이드 메뉴바 시작 -->
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>게시판 관리</p>
					<tr>
						<td>
							<a href="Notice_board">공지사항</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
						    <a href="QnA_board">1:1문의</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
							<a href="Event_board">이벤트</a>
							<span href="#">&gt</span>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
	   
	  <!-- 오른쪽 컨텐츠 시작 -->
	<div class="contents">
        <h2>1:1 문의</h2>
        <table>
        <tr>
        <td class="actionbar" ><button>답변없는 문의만 보기</button></td>
        
        <td class="actionbar"></td>
        <td class="actionbar"></td>
        
        <td class="actionbar" style="width:350px"><form class="board_search" method="POST" action="board_search">
         <span><select name="check_category">
			<option value="1">제목</option>
			<option value="2" >제목+내용</option>
			</select></span>
              <span><button class="search_click btn btn-link" type="submit"><img src="/image/search.png" width="15px" height="15px"></button>
                 <input name="keyword" class="search_main mr-sm-2" type="search" aria-label="Search" placeholder="검색"> </span>
        </form></td> 
        </tr>
        </table>
	<table id="notice_list" class="table table-striped" style="width :800px;">
	<tr>
	<th scope="col" class="num">카테고리</th><th scope="col" class="category">유형</th><th scope="col" class="title" >제목</th><th scope="col" class="writer">작성자</th><th scope="col" class="date">작성일</th><th scope="col" class="answer">답변여부</th>
	</tr>
	<c:forEach items="${ list }" var="dto" >
	<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
	<tr>
	<td><a class="num" >1:1 문의</a></td>
	<td><a class="title" href="QnA_view">${dto.n_title}</a></td>
	<td><a class="writer">${dto.n_writer}</a></td>
	<td><a class="date">${reg}</a></td>
	<td><a class="hit">${dto.n_hit}</a></td>
	</tr>
	</c:forEach>
	</table>
	
	 
	<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item disabled">
			      <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#">Next</a>
			    </li>
			  </ul>
			</nav>	   
		    <button onclick="goNotice_write()">글작성</button>  
		    </div>
		    
	</div>  <!-- AdminWrapper2 -->
	</div>  <!-- AdminWrapper1 -->
 <!-- 메인 컨텐츠  -->
  <div class="container">
	       <footer>
	           <p>Copyright (c) 2015 <a href="http://markgoodyear.com">Mark Goodyear</a><span class="top"><a href="#top">#top</a></span></p>
	       </footer>
       </div>
	<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
	
	 <!-- jQuery first, then Popper.js, then Bootstrap JS -->  
    
     <script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

</body>
</html>