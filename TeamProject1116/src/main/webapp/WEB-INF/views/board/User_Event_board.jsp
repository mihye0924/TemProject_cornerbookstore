<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
    th, td {
	    font-size: 1.4ch !important;
	}
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	
	#bt{
	 relative : bottom;
	}
	</style>
 
</head>
<body>
<!-- 헤더 부분  -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
<!-- 헤더 부분  -->

 <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	   
	   <!-- 왼쪽 사이드 메뉴바 시작 -->
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>이벤트</p>
					<tr>
						<td>
						<div class="sidebarlist">
							<a href="User_Event_board">이벤트</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
	   
	  <!-- 오른쪽 컨텐츠 시작 -->
	<div class="contents">
        <h2>이벤트</h2>
	<table id="notice_list" class="table table-striped" style="width :800px;">
	<c:forEach items="${ list }" var="dto" >
	<tr>
	<!-- 컨텐츠 내용을 string 1에 저장 
	 컨텐츠 내용을 '>' 기준으로 item 객체에 저장
	 if item객체에 'img'문자열을 가지고있는것이있다면 
	 item 문자열을 가져옴 == <img src="...> 
	 item 문자열에서 style로시작하는 문자열가져와서 string2저장
	 string3에 style형식 문자열로 적어줌 
	 replace함수로 item객체에 string2문자열을 string3로 바꿔준것을 image에저장
	  -->
	<c:set var="string1" value="${dto.n_content}" /> 
	<c:forEach items="${fn:split(string1,'>')}" var="item">
	<c:if test="${fn:contains(item,'img')}">
	<c:set var="string2" value="${fn:substringAfter(item,'style')}" />
	
	<c:set var="string3" value='=width:800px;height:200px;"' />
	<c:set var="image" value="${fn:replace(item,string2,string3) }" />
	<td><a href="Board_view?idx=${dto.idx}&hit=${dto.n_hit}" >${image}</a></td>
	</c:if>
	</c:forEach>
	<td><p></p></td>
	
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
		    </div>
 <!-- 메인 컨텐츠  -->

	</div>  <!-- AdminWrapper2 -->
	</div>  <!-- AdminWrapper1 -->
	 <!-- 푸터  -->
 
 <jsp:include page="/WEB-INF/views/MainFooter.jsp"/>
 
</body>
</html>