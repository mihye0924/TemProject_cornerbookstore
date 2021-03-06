<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.study.springboot.dto.BookStoryBoardDto"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.study.springboot.dto.MemberDto" %>
<!-- 1123수정 -->
 <% 
 String id = (String) session.getAttribute("sessionID"); 
 MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");  
 System.out.println("memberDto"+memberDto);   
  
 %>  
  
<html>
<head>
<link rel="stylesheet" href="css/bookstory/bookstorymain.css"> 
<title>북스토리메인</title>
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
                <div class="book_img">
                	<img src="image/bookstory/bookmain.jpeg" width="990px" height="400px">   
                </div>
              
                <div class="all_view"><span>인기글</span></div>
               
                
                <div class="hr3"></div>
                <div class="section_content"> 
                
                    <table>
                        <tr>
                        <c:forEach var="dto" items="${ Popular_list }"  >  
                		<input type="hidden" name="idx" value="${dto.idx}"> 
                		<input type="hidden" name="hit" value="${dto.hit}">
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
                            <div class="content_box" style="margin-top:15px; text-overflow: ellipsis; ">
                                <div class="section_title"><a href="BookStoryView?idx=${dto.idx}"><span>${dto.bs_title}</span></a></div>
                                <div class="section_id"><span>${dto.bs_user_id}</span></div>
                            </div>  
                            
                        </td>  
                        </c:forEach> 
                        </tr>
                    </table> 
                </div>
 	 			
 
                <div class="all_view">
                <a href="BookStoryAllList"><span>전체글보기</span></a>
                <a  class="all_more" href="BookStoryAllList"><span>더보기</span></a>
                </div>
                
                <div class="hr3"></div>
                <div class="section_content2"> 
               
                    <table id="member_list"  class="table table-striped view_box "> 
                        <tr class="one-list-title "> 
                            <th scope="col" style="width: 50%;" >제목</th>
                            <th scope="col" style="width: 10%;" >작성자</th> 
                            <th scope="col"  style="width: 10%;">작성일</th> 
                            <th scope="col"  style="width: 6%;">조회수</th> 
                        </tr> 
                        <c:forEach var="dto" items="${ list }" > 
                        <tr class="view_box_1">   
                            <td><a href="BookStoryView?idx=${dto.idx}">${dto.bs_title}</a></td>
                            <td>${dto.bs_user_id}</td>
                              <fmt:formatDate var="reg" value="${dto.reg}"  pattern="yyyy.MM.dd"/>
                            <td>${reg}</td>
                            <td>${dto.hit}</td>   
                        </tr>     
                        </c:forEach>
                    </table>  
                </div>  
                
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