<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- 1123수정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 화면</title>
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
				<table style="width: 150px;" cellpadding="10px" cellspaing="10px">
				<p>회원관리</p>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageMember">회원 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="WithdrawMember">탈퇴 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageOrder">주문 관리</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
				
				<table style="margin-top:30px">
					<tr >
						<td>
						    <div class="sidebarlist">
							<a href="BookstoryManage">북스토리목록</a>
							<span>&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->     
		<div class="contents">
		<div class="section"> 
		<h2>탈퇴 목록</h2>
		<hr>
		<br>
		 <table id="member_list"  class="table table-striped">
		   <tr>
		   <th scope="col">번호</th><th scope="col">아이디</th><th scope="col">탈퇴사유</th><th scope="col">탈퇴메세지</th><th scope="col">탈퇴일</th>
		   </tr>
		   <c:forEach items="${ list }" var="dto" >
			<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
		   <tr>
		  <td>${dto.idx}</td><td>${dto.session_id}</td><td>${dto.complain_radio}</td><td>${dto.complain_text}</td><td>${reg}</td>
		   </tr>
		   </c:forEach>
		 </table> 
		</div>
		
		<nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page9?no=<%=i%>" class="page-link"><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav>  
		</div>
	   </div>  <!-- AdminWrapper2 -->
	   </div>  <!-- AdminWrapper1 -->

<script src="js/jquery-2.2.4.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
   
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
</body>
</html>