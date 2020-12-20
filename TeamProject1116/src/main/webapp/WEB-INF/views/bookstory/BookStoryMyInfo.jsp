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
<link rel="stylesheet" href="css/bookstory/bookstorymyInfo.css"> 
<link rel="stylesheet" href="css/bookstory/bookstorymain.css"> 
<title>북스토리 내정보</title>
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
  					 
					<div class="MyInfo_boxsize">
						<div class="myImage">
							<img src="../uploadPro3_bookstory/${memberDto.book_profile}" width="120px" height="120px">	 
						
						</div>
						<hr />
						<div class="myRank">
						<table class="myRank_table">
						<tr>
						<td class="myRank_box">
					     <img src="/image/bookstory/pencil.png" width="30px" height="30px" alt="등급" ><span class="myRank_text">내 등급 :</span> <span class="myRank_text"> ${memberDto.rank} </span>
						</td>
						</tr>
						<tr>
						<td class="myRank_box">
					    <img src="/image/bookstory/writing.png" width="30px" height="30px" alt="게시글"><span class="myRank_text"> 내 게시물수 :</span> <span class="myRank_text">${content_count} </span>
						</td>
						</tr>
						<tr>
						<td class="myRank_box">
					    <img src="/image/bookstory/reply.png" width="30px" height="30px" alt="댓글"><span class="myRank_text">내 댓글수 :</span> <span class="myRank_text">${reply_count}</span> 
						</td>
						</tr> 
						
						</table> 
						<hr />				
						</div>
						
					</div>
                <%
                      
            		}else{
            	%>
            	      <img src="image/bookstory/user.png" width="150px" height="150px"> 
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
                <div class="read_rank_box">
                <span class="read_rank">구석책방 랭킹</span>
                <p>연필 한자루부터 다섯자루까지, 열심히 활동해서 카페 랭킹을 올려보세요.</p>
                </div>
                <img src="image/bookstory/rank.jpg"  alt="구석책방등급표" width="1000px">
                <div class="rank_text_box">
                   
                    <ul class="rank_text1">
                        <li>
                            구석책방은 <strong>한자루부터 다섯자루까지 5등급으로</strong> 나누어져 있습니다.
                        </li>
                        <li class="rank_text2">
                           랭킹은 활동 점수에 따라 월 <strong>2회(1일 경) 업데이트 되며,</strong> 각 단계별로 <strong>조건이 충족시에 한단계 씩 증가</strong>합니다.
                        </li>
                        <li class="rank_text2">
                            자세한 카페 등급 조건은 
                            <a style="color:red " class="btn btn" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                                <strong>구석책방</strong>
                              </a>
                            을 클릭하세요
                         </li>
                    </ul> 
                </div>  
                  <div class="collapse dropdown_rankConditional" id="collapseExample">
                    <div class="card card-body">
                        <p class="rank_text2">한자루 : 게시글 20개, 댓글 20개</p>
                        <p class="rank_text2">두자루 : 게시글 40개, 댓글 40개</p>
                        <p class="rank_text2">세자루 : 게시글 60개, 댓글 60개</p>
                        <p class="rank_text2">네자루 : 게시글 80개, 댓글 80개</p>
                        <p class="rank_text2">다섯자루 : 게시글 100개, 댓글 100개</p>
                    </div>
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