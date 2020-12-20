<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>

	<link rel="stylesheet" href="css/category/bookform.css"> 
    <title>전체게시글</title> 
    </head>
<body>
 <!-- 메인헤더 -->
 <jsp:include page="/WEB-INF/views/MainHeader.jsp"/>

        <!-- 전체카테고리 보기 -->
        <div id="main">
            <div class="wrapper">
                <div class="container new_book_content">  
                    

                    <p>검색 결과</p>   
				
                    <div class="wrapper_section_box"> 
                        <div class="row">
                         
                            <div class="section_content3" style="width: 1100px;">  
			                 <table id="member_list"  class="table table-striped view_box "> 
			                     <tr class="one-list-title ">  
			                         <th scope="col" style="width: 50%;" >제목</th>
			                         <th scope="col" style="width: 10%;" >작성자</th> 
			                         <th scope="col"  style="width: 10%;">작성일</th> 
			                          <th scope="col"  style="width: 10%;">조회수</th> 
			                     </tr> 
			                     <c:forEach var="list" items="${ list }" >  
			                     <tr class="view_box_1">    
			                         <td><a href="BookStoryView?idx=${list.idx}">${list.bs_title}</a></td>
			                         <td>${list.bs_user_id}</td>
			                           <fmt:formatDate var="reg" value="${list.reg}"  pattern="yyyy.MM.dd"/>
			                         <td>${reg}</td>
			                         <td>${list.hit}</td>   
			                     </tr>     
			                     </c:forEach>
			                 </table> 
			                 </div>  
 
                        </div>   <!-- row -->
                    </div>  

                </div> 
            </div> 
        </div>
         
<!-- 메인푸터 -->
 <jsp:include page="/WEB-INF/views/MainFooter.jsp"/> 

</body>
</html>
