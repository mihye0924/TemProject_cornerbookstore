<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 1123수정 -->
<html>
<head> 
    <title>메인페이지</title>
</head>
<style>
.multiline-ellipsis{
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical; 
    table-layout: fixed; 
    text-overflow: ellipsis; 
     max-width: 200px !important;
   
}
</style>
<body>   
<!-- 메인헤더 -->

<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
    
    <!-- 메인 슬라이드 --> 
    <div id="main">
        <div class="carousel" data-flickity='{ "autoPlay": 2000 }'>
        <c:forEach items="${ carousel }" var="event" >
        <c:set var="string1" value="${event.n_content}" /> 
	<c:forEach items="${fn:split(string1,'>')}" var="item">
	<c:if test="${fn:contains(item,'img')}">
	<c:set var="string2" value="${fn:substringAfter(item,'style')}" />	
	<c:set var="string3" value='=width:1210px;height:501px; " />' />
	<c:set var="image" value="${fn:replace(item,string2,string3) }" />
	<div class="carousel-cell"><a href="Board_view?idx=${event.idx}&hit=${event.n_hit}">${image}</a></div>
	</c:if>
	</c:forEach>
        </c:forEach>
        </div>  
    </div>
    <!-- 신작도서 -->
     <div id="wrapper">
     <div class="container new_book">
     <span>신작도서<span>
     	<div class="owl-carousel owl-theme">
            <c:forEach items="${ list }" var="dto" >
             <div class="item book1" > 
                <div class="title"> 
                <div>
                <a style="color:#ccc; font-size:15px; " href="Product_detail?p_number=${dto.p_number}"> 
               				 <span>
               				 		<br/>
                                    ${dto.p_title}
                                    <br/><br/>  
                                    ${dto.p_writer}
                                    <br/><br/> <br/><br/>  
                                    ${dto.p_price}
                            </span>
                            </a>
                            </div>
                            </div>   
                    <img src="${dto.p_filename}" height="220px"> 
                </a>
            </div>
            </c:forEach>
        </div>
    </div>
    </div> 
    <!-- 베스트도서 -->  
     <div id="wrapper">
     <div class="container new_book">
     <span>베스트도서<span>
     	<div class="owl-carousel owl-theme">
            <c:forEach items="${ list2 }" var="dto2" >
             <div class="item book1" > 
                <div class="title"> 
                <div>
                <a style="color:#ccc; font-size:15px; " href="Product_detail?p_number=${dto2.p_number}"> 
               				<span>
               				 		<br/>
                                    ${dto2.p_title}
                                    <br/><br/>  
                                    ${dto2.p_writer}
                                    <br/><br/> <br/><br/>  
                                    ${dto2.p_price}
                            </span>
                            </a>
                            </div>
                            </div>   
                    <img src="${dto2.p_filename}" height="220px"> 
                </a>
            </div>
            </c:forEach>
        </div>
    </div>
    </div> 
    
     <!-- 추천도서 --> 
     <div id="wrapper">
     <div class="container new_book">
     <span>추천도서<span>
     	<div class="owl-carousel owl-theme">
            <c:forEach items="${ list3 }" var="dto3" >
             <div class="item book1" > 
                <div class="title"> 
                <div>
                <a style="color:#ccc; font-size:15px; " href="Product_detail?p_number=${dto3.p_number}"> 
               				 <span>
               				 		<br/>
                                    ${dto3.p_title}
                                    <br/><br/>  
                                    ${dto3.p_writer}
                                    <br/><br/> <br/><br/>  
                                    ${dto3.p_price}
                            </span>
                            </a>
                            </div>
                            </div>   
                    <img src="${dto3.p_filename}" height="220px" > 
                </a>
            </div>
            </c:forEach>
        </div>
    </div>
    </div> 
      <!-- 위로가되는 책 -->
     <div id="wrapper">
     <div class="container new_book">
     <span>집콕생활, 위로가 되는 책<span>
     	<div class="owl-carousel owl-theme">
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=50">    
                    <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                    <img src="image/bookstory/main/book1.jpg" width="100px" height="220px"> 
                </a>
            </div>
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=49">    
                     <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                     <img src="image/bookstory/main/book2.jpg" width="100px" height="220px"> 
                </a>
            </div>
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=43">    
                    <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                    <img src="image/bookstory/main/book3.jpg" width="100px" height="220px"> 
                </a>
            </div>
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=42">    
                     <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                     <img src="image/bookstory/main/book4.jpg" width="100px" height="220px"> 
                </a>
            </div>
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=47">    
                    <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                   <img src="image/bookstory/main/book5.jpg" width="100px" height="220px">
                </a>
            </div>
            <div class="item book1"> 
                <a href="http://localhost:8081/BookStoryView?idx=46">    
                     <div class="title" style="text-overflow:ellipsis; white-space:normal; display: inline-block;"> 
                        <div style=" font-size:18px; padding-top:90px; padding-left:45px;">미리보기</div>
                    </div>
                     <img src="image/bookstory/main/book6.jpg" width="100px" height="220px">
                </a>
            </div>
        </div>
        </div>
    </div> 
    <!-- 후기 -->
    <div class="flex container">
    <section class="review_import">
    <div class="head_review">
             <span style="padding:10px;">책 리뷰</span>     
         
    <table class="table_review"cellpadding="30px" cellspacing="30px"> 
                
         	 
     </table>    
     
         	<table>
         	<tr class="review_box2">
	        	<c:forEach var="review" items="${review}" begin="0" end="3" step="1">
		        <c:if test="${review.p_filename !=null}">
	         	 
	         	<div class="pre_img">
	             <div class="pre_img_left">  
	             <fmt:formatDate value="${review.reg}" var="reg" pattern="yyyy.MM.dd" /> 
	          
	                 <div class="review_box_width"><a href="ProductDetail3?p_number=${review.p_number}"><img src="${review.p_filename}" style="width: 170px; height: 160px;"></a></div> 
	                 <div class="review_box_width1" style="margin:3%;"><strong>[${review.p_title}]<br>[${review.rate}/${reg}]</strong><br><p class="multiline-ellipsis">${review.description}</p></div> 
	             </div>
	             </div>
	             </c:if>   
	             </c:forEach> 
	        </tr>         
	     	</table>
	  	 </div>   	
     </section>   
   
      <!-- 공지사항 -->
      <section class="notice_import">
      
      <div class="banner_img" style="padding-top:35px;">
              <img src="image/banner.png" style="width: 380px; height: 150px;">
             </div>  
             <div class="banner_img" style="padding-top:35px;">
              <img src="image/ddd.PNG" style="width: 380px; height: 150px;">
             </div>  
              
             <div style="padding-top:60px;">
      		<span>공지사항</span>   
             <span class="notice_board"><a href="Notice_board">+</a></span>
              <div class="notice"  style="display: table; width: 100%;">
              <table class="table_review" cellpadding="30px" cellspacing="30px" style="width:100%; height:100%;"> 
              	 <div class="hr_line"></div>
                   <c:forEach var="notice" items= "${ notice }"  end="6" >
                   <fmt:formatDate value="${notice.reg}" var="reg" pattern="yyyy.MM.dd" />
                  <tr>
                      <td><li></li></td>  
                      <td><a href="Board_view?idx=${notice.idx}&hit=${notice.n_hit}" style="color: black">${notice.n_title}</a></td>
                      <td>${reg}</td>
                  </tr>
              </c:forEach> 
               </table> 
          	</div>  
            </div>    
            
            
             
      </section>      
  </div>
  
  <!-- 메인푸터 -->
 <jsp:include page="/WEB-INF/views/MainFooter.jsp"/>
  
</body>
</html>
