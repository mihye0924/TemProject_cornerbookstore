<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" href="css/category/bookform.css"> 
    <title>예술</title>
</head>
<body>
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>

        <!-- 베스트도서 -->
        <div id="main">
            <div class="wrapper">
                <div class="container new_book_content">  
                    <span>예술</span>  <span>|</span>
                    <span><a href="AllBook">전체보기</a><span>
                    <div class="wrapper_section_box"> 
                        <div class="row">
                        
                     <c:forEach var="dto" items="${ dto }">
                            <div class="column">
                                <div class="box_content_img"> 
                                    <a href="Product_detail?p_number=${dto.p_number}">  
                                    <span>
                                    ${dto.p_title}
                                    <br/><br/>  
                                    ${dto.p_writer}
                                    <br/><br/> <br/><br/>  
                                    ${dto.p_price}
                                    </span>   
                                    </a> 
                                </div> 
                                <img src="${dto.p_filename}" alt="" width="200px" height="300px">    
                            </div>
                            </c:forEach>
                </div> 
            </div> 
        </div>

<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>
</body>
</html>