<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ page import="com.study.springboot.dto.MemberDto" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<%@ page import="com.study.springboot.dto.BookStoryBoardDto" %>
<%@ page import="java.util.List"%>
<!-- 1123수정 -->
 <%
 String id = (String) session.getAttribute("sessionID"); 
 MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");   
 
 List<BookStoryBoardDto> list = (List<BookStoryBoardDto>)session.getAttribute("list"); 
	System.out.println( "list count:" + list.size() );
	String list_page = (String)session.getAttribute("page");
	System.out.println( "list_page:" + list_page );
	String page1_active = "";
	String page2_active = "";
	String page3_active = "";
	if(list_page.equals("1")) 
		page1_active = "active";
	if(list_page.equals("2")) 
		page2_active = "active";
	if(list_page.equals("3")) 
		page3_active = "active";
 %>  
  <!-- 수정1119  --> 
<html>
<head>
<link rel="stylesheet" href="css/bookstory/bookstorymain.css"> 
<title>북스토리 책 미리보기</title>
</head>
<body>
<!-- 북스토리메인헤더 -->
<jsp:include page="/WEB-INF/views/BookStoryMainHeader.jsp"/>

     <div id="main">

            <aside>
                <div class="hr"></div>
                <div class="info_head">
                     <div class="bookstory_Info"><a href="BookStoryMain"><span>북스토리</span></a></div>  
               	<%
            	if(session.getAttribute("sessionID")==null){
           		%>	   
                    <div class="bookstory_MyInfo"><a href="myInfoLogin"><span>내정보</span> </a>  </div>
                <%
            	}else{
            	%>
            		 <div class="bookstory_MyInfo"><a href="BookStoryMyInfo"><span>내정보</span></a></div> 
            	<%
            	}
                %>  
                </div> 
             	<%
            	if(session.getAttribute("sessionID")==null){
           		%>	
           		<div class="info_body">
           		  <hr />
                    <img src="image/bookstory/user.png" width="200px" height="200px"> 
                </div>
                <div class="info-text">
                 <table>
                     <tr class="aside_box"> 
                         <td class="text_p"><span style="text-align: center">로그인을해주세요</span></td>
                     </tr>
                     <tr class="aside_box2">
                         <td class="text_p"><span>회원수</span></td>
                         <td class="text_p"><span>${count}</span></td>
                     </tr> 
                 </table>
             	</div>
                <div>
                    <input type="button" class="btn btn-warning" value="글쓰기" name="write" onclick="writeReturn()"> 
                </div> 
           		<%
            	}else{	
            	%>
            	<div class="info_body">
            	<%
            		if(memberDto.getBook_profile()!=null){
       			%>		     
  					  <img src="../uploadPro3_bookstory/${memberDto.book_profile}" width="200px" height="200px">	 
                      <p style="padding-top:5px"><a href="BookStoryProfile">이미지 등록</a></p>
                <%
                      
            		}else{
            	%>
            	      <img src="image/bookstory/user.png" width="200px" height="200px"> 
            	        <p style="padding-top:5px"><a href="BookStoryProfile">이미지 등록</a></p>
            	<%		
            		}
           	    %>
            	</div>
                
                   <div class="info-text">
                    <table>
                        <tr class="aside_box">
                            <td class="text_p"><span>아이디</span></td>
                            <td class="text_p"><span>${memberDto.id}</span></td>
                        </tr>
                        <tr class="aside_box2">
                            <td class="text_p"><span>회원수</span></td>
                            <td class="text_p"><span>${count}</span></td>
                        </tr> 
                    </table>
                </div>
                <div>
                 
                    <input type="button" class="btn btn-warning" value="글쓰기" name="write" onclick="writeReview()">   
                </div>  
            	<%	
            	}
             	 %> 
                <nav class="navbar navbar-light bg-light navbar_aside">
                    <form class="form-inline aside_form_box" action="SearchBookStory">
                        <input class="form-control mr-sm-2" type="search1" placeholder="내용을입력하세요" aria-label="Search" style="margin:0 auto" name="bookstory-search">
                        <button class="btn btn-outline-dark" type="submit" style="margin:0 auto">검색하기</button>
                    </form>
                </nav>  
                <div class="hr2"></div>
                <div class="board">
                    <div class="board_box_category">
                        <a href="BookStoryAllList">전체글보기</a>
                    </div>
                    <hr />
                    <table>
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/book.png" width="20px" height="20px"><a href="BookStoryCommunication"><span>북스토리,소통</span></a>
                            </td>
                        </tr>
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/book.png" width="20px" height="20px"><a href="BookStoryOneLineReview"><span>한줄서평</span></a>
                            </td>
                        </tr>
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/book.png" width="20px" height="20px"><a href="BookStoryReadReview"><span>책읽고,리뷰남기기</span></a>
                            </td>
                        </tr>
                         <tr class="category_box">
                            <td>
                                <img src="image/bookstory/book.png" width="20px" height="20px"><a href="BookStoryGoodWriting"><span>좋은글귀 남기기</span></a>
                            </td>
                        </tr>
                    </table> 
                    <div class="hr2"></div>
                     <div class="board_box_category">
                        <a href="BookStoryNotice_A">공지사항</a>
                    </div>
                    <hr />
                     <table>
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/wirterInfo.png" width="20px" height="20px"><a href="BookStoryWriterInfo_A"><span>작가정보</span></a>
                            </td>
                        </tr> 
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/wirterInfo.png" width="20px" height="20px"><a href="BookStoryBookPreview_A"><span>책 미리보기</span></a>
                            </td>
                        </tr> 
                        <tr class="category_box">
                            <td>
                                <img src="image/bookstory/wirterInfo.png" width="20px" height="20px"><a href="BookStoryEvent_A"><span>책 이벤트</span></a>
                            </td>
                        </tr> 
                    </table>
                </div> 
            </aside> 
            <section>        
              		<div class="all_view"><span>책 미리보기</span></div>
             	<div class="hr3"></div> 
             	 
             	 <div class="prev_img">
             	  <table>
                        <tr>
                        <c:forEach var="dto" items="${ list }"  >  
                		<input type="hidden" name="idx" value="${dto.idx}">  
                        <td class="section_box" scope="col"> 
                            <!-- 이미지 반복구간 -->
                        	<c:set var="string1" value="${dto.bs_content}" />
                        	<c:forEach items="${fn:split(string1,'>')}" var="item" >
                        	<c:if test="${fn:contains(item,'img')}">
                        	<c:set var="string2" value="${fn:substringAfter(item, 'style')}" /> 
                        	<c:set var="string3" value='=width:190px;height:280px;>' /> 
                        	<c:set var="image" value="${fn:replace(item,string2,string3) }" />  
                        	</c:if>
                        	</c:forEach>
                        	
                        	 <span><a href="BookStoryView?idx=${dto.idx}">${image}</a></span> 
                            <div class="content_box">
                                <div class="section_title"><a href="#"><span>${dto.bs_title}</span></a></div>
                                <div class="section_id"><a href="#"><span>${dto.bs_user_id}</span></a></div>
                            </div>  
                            
                        </td>  
                        </c:forEach> 
                        </tr>
                    </table> 
             	  </div>
             	  
             	  <!-- 페이징처리 -->
          	      <nav aria-label="Page navigation example ">
				  	<ul class="pagination  justify-content-center ">
					  	<li class="page-item">
					    	<a class="page-link"  href="BookStoryBookPreview_A?page=1">1</a>
					    </li>
					  	<li class="page-item">
					      	<a class="page-link" href="BookStoryBookPreview_A?page=2">2</a>
					    </li>
					    <li class="page-item">
					    	<a class="page-link" href="BookStoryBookPreview_A?page=3">3</a>
					    </li>
					      <li class="page-item">
					    	<a class="page-link" href="BookStoryBookPreview_A?page=4">4</a>
					    </li>  
			  		</ul>
				  </nav> 
            </section>
        </div>

    
 	<!-- 메인푸터 --> 
	<jsp:include page="/WEB-INF/views/BookStoryMainFooter.jsp"/>
     
 	<!-- 글쓰기  -->
     <script> 
      function writeReturn() {
   		alert("로그인해주세요");
   		location.href="LoginForm"
   	 }
      function writeReview() {location.href="BookStoryWrite"}  
    </script>
</body>
</html>