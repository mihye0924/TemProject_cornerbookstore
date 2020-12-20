<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    th, td {
	    font-size: 1.4ch;
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
	
	#bt{
	 relative : bottom;
	}
	</style>
	
    <script type="text/javascript">
	function goNotice_write() {
		location.href = "Board_write";
	}
    </script>
</head>
<body>
<!-- 헤더 부분  -->
<%if("admin".equals(session.getAttribute("sessionID"))){  %>
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<%} else{%>
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
<% }%>
<!-- 헤더 부분  -->
 <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	   
	   <!-- 왼쪽 사이드 메뉴바 시작 -->
	   <%if("admin".equals(session.getAttribute("sessionID"))){  %>
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>게시판 관리</p>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Notice_board">공지사항</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
						    <a href="OnetoOneBoard_A">1:1문의</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Event_board">이벤트</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
	    <%} else{%>
	    <div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>고객센터</p>
					<tr>
						<td>
						<div class="sidebarlist">
							<a href="Notice_board">공지사항</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						<div class="sidebarlist">
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
	    <% }%>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
	   
	  <!-- 오른쪽 컨텐츠 시작 -->
	<div class="contents">
        <h2>공지 사항</h2>
        <hr>
	<table id="notice_list" class="table table-striped" style="width :800px;">
	<tr>
	<th scope="col" class="num" style="width:100px">카테고리</th><th scope="col" class="title2" style="width:400px">제목</th><th scope="col" class="writer" style="width:100px">작성자</th><th scope="col" class="date" style="width:150px">작성일</th><th scope="col" class="hit" style="width:50px">조회</th>
	</tr>
	<c:forEach items="${ list }" var="dto" >
	<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
	<tr>
	<td><a class="num" >공지사항</a></td>
	<td><a class="title2" href="Board_view?idx=${dto.idx}&hit=${dto.n_hit}" >${dto.n_title}</a></td>
	<td><a class="writer">${dto.n_writer}</a></td>
	<td><a class="date">${reg}</a></td>
	<td><a class="hit">${dto.n_hit}</a></td>
	</tr>
	</c:forEach>
	</table>
	<%if("admin".equals(session.getAttribute("sessionID"))){  %>
		    <button style="float:right; width:60px; height:30px;" onclick="goNotice_write()" class="btn btn-sm btn-danger">글작성</button> 
		    <% }%> 
	 
	<nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");	
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item" id="pageNum" value=<%=i%>><a href="page5?no=<%=i%>"  class="page-link" onclick="goPage(<%=i%>);" ><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav>        
			
		    </div>
		    </div>  <!-- AdminWrapper2 -->
	</div>  <!-- AdminWrapper1 -->
 <!-- 메인 컨텐츠  -->
 
	<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
	
	 <!-- jQuery first, then Popper.js, then Bootstrap JS -->  
    
     <script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>