<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ page import="com.study.springboot.dto.MemberDto" %> 
<%@page import="com.study.springboot.dto.BookStoryBoardDto"%> 
<%@ page import="com.study.springboot.dto.BookStoryBoardReplyDto" %> 
<%@page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
   <!-- 1123수정 -->
<%
	 BookStoryBoardDto content_view_bookstory=(BookStoryBoardDto)session.getAttribute("content_view_bookstory");   
	 System.out.println("bookstory content_view"+content_view_bookstory);
	 String id = (String) session.getAttribute("sessionID"); 
	 MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");  
	 System.out.println("memberDto"+memberDto);   
	 List<BookStoryBoardReplyDto> reply_view_bookstory= (List<BookStoryBoardReplyDto>)session.getAttribute("reply_view_bookstory");
	  
%>  
  
<html>
<head>
<link rel="stylesheet" href="css/bookstory/bookstoryview.css"> 
<link rel="stylesheet" href="css/bookstory/bookstorymain.css"> 
<title>북스토리 페이지</title>
<script> 
</script>
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
             
             <input type="hidden" name="idx" value="${content_view_bookstory.idx}">
                <div class="content_box">
                    <div class="category_text"> 
                    
                    <a href="#" id="category" value="category">${content_view_bookstory.bs_category}</a>                   
                  <div class="list_box">  
                  
                 
                  	 <a href="BookStoryView?idx=${content_view_bookstory.idx-1}"><button type="button" id="prev" class="btn btn-light" onclick="prev()">이전글</button></a>
                  	 <a href="BookStoryView?idx=${content_view_bookstory.idx+1}"><button type="button" class="btn btn-light">다음글</button></a>
                     <a name="top"></a><button type="button" class="btn btn-light" onclick="goList()">목록</button>
                  	 
                     
                    
                    </div>
                        <div class="title_text" >
                            <span>${content_view_bookstory.bs_title}</span>
                        </div>
                        
                        <table class="reply_box">
                            <tr>
                                <td>
                                    <div class="reply_text">
                                        <span class="reply_img"><img src="image/bookstory/reply.png" width="30" height="30"></span> 
                                        <a href="#reply_start"><span>댓글</span></a><span class="reply_text2">${replyCount}</span>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <div class="profile_info">
                            <table>
                                <tr>
                                    <td>
                                    <%
                                    if(content_view_bookstory.getProfile_img()==null){
                                    %>
	                                    <div>
	                                    
	                                     	<img src="image/bookstory/user.png" width="50px" height="50px">
                                     	</div>
                                    <%	 
                                    }else{
                                	%>    
                                		<div>
                                            <img id="img" src="../uploadPro3_bookstory/${content_view_bookstory.profile_img}" width="50px" height="50px">	
                                        </div> 
                                    <%
                                    } 
                                    %>
                                    </td>
                                    <td>
                                        <td class="myinfo_box">
                                         <div class="id my_info_text"><span>아이디</span>
                                            <span class="my_info_text2">${content_view_bookstory.bs_user_id}</span>
                                        </div>  
                                        <fmt:formatDate var="reg" value="${content_view_bookstory.reg}"  pattern="yyyy.MM.dd HH:mm"/>
                                         <div  class="upload_content my_info_text"><span>등록일</span><span class="my_info_text2">${reg}</span></div> 
                                         <div  class="upload_content hit_count"><span>조회수</span><span class="hit_count2">${content_view_bookstory.hit}</span> </div>
                                    </td>  
                                </tr>
                                </table>
                                
                                
                                <br />
                                <hr />
                                <!-- 콘텐츠 -->
                                <div class="main_content_box">  
									     <span class="content_view_m">${content_view_bookstory.bs_content}</span> 
                                </div>
                           
                                <!-- 댓글기능 -->  
                                <div class="reply_bottom_box"> 

                                    <span class="heart_img"> 
                                    <img src="image/bookstory/like_cancle.png" width="30px" height="30px" alt="좋아요선클릭후" id="like_img" type="button" onclick="like_func()" > 
                                      
                                      <input type="hidden" name="like_check" id="like_check" value="${content_view_bookstory.like_check}" />
                                     <input type="hidden" name="idx" id="idx" value="${content_view_bookstory.idx}" /> 
                                 <input type="hidden" name="like_cnt" id="like_cnt" value="0" /> 
                                     
                                     </span> 
                                   
                                   <span class="heart_text">좋아요</span> <span class="heart_text">0</span> 
                                        
                                    <span class="reply_img2"><img src="image/bookstory/reply.png" width="30" height="30" ><a name="reply_start"></a></span> 
                                    <a class="btn btn"  id="accordion"  data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">댓글</a>
                                <span class="reply_text2">${replyCount}</span>
                                </div>
                                 <hr />
                                 
                                 <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
           						 <div class="card-body">
                    			 
                                 <div class='reply_bottom_box2'>
                                    <span class="reply_text3">댓글</span>
                                 </div>
								   
                                 <!-- 댓글 반복구간 -->
                                 
                                  <c:forEach var="reply_view_bookstory" items="${reply_view_bookstory}">
                                  <div class="reply_content"> 
                                     <table> 
                                     <fmt:formatDate var="reg" value="${reply_view_bookstory.reg}"  pattern="yyyy.MM.dd HH:mm"/>
	                                         <tr>
	                                         
	                                            <td>
	                                            
                                            	     <div class="myInfo_img"><img id="img" src="../uploadPro3_bookstory/${reply_view_bookstory.reply_profile}" width="80px" height="80px"></div> 
                                            	           
	                                           
	                                            </td>
	                                          
	                                            <td> 
                                            	<input type="hidden" name="idx" value="${reply_view_bookstory.idx}">
                                            	<input type="hidden" name="reply_no" value="${reply_view_bookstory.reply_no}">
                                                <span style="font-weight: 800;">아이디 : </span><span>${reply_view_bookstory.reply_writer}</span><span class="reply_date">${reg}</span>
                                                
                                               <% 
                                                String sessionID2=(String)session.getAttribute("sessionID");
                                                
                                               BookStoryBoardReplyDto dto = (BookStoryBoardReplyDto)pageContext.getAttribute("reply_view_bookstory");
                                               String reply_writer = dto.getReply_writer();
                                               System.out.println("reply_writer:"+reply_writer);
                                                if(reply_writer.equals(sessionID2) && sessionID2!=null){
                                                 %>
                                                <!-- 댓글삭제기능 -->
                                              	<a  href="bookStoryReplyDeleteAction?reply_no=${reply_view_bookstory.reply_no}&idx=${reply_view_bookstory.idx}"><img class="delete_reply" src="image/cancel.png" width="20px" height="15px" ></a>
                                               	<%
                                                }else{
                                                %>
                                                <a style="display: none;" href="bookStoryReplyDeleteAction?reply_no=${reply_view_bookstory.reply_no}&idx=${reply_view_bookstory.idx}"><img class="delete_reply" src="image/cancel.png" width="20px" height="15px" ></a>
                                              
                                                <%
                                                }
                                                %> 
                                              	
                                                <div class=" content_text">
                                                   ${reply_view_bookstory.reply_content}
                                                </div>
                                               
                                            </td>
                                         </tr> 
                                     </table>  
                                     </div> 
                                 </c:forEach>
                                 </div>
                				 </div>
                               
                               	<%  
                               	if(session.getAttribute("sessionID")!=null){
                               	%>
                                <form action="replyAction" method="post" name="reply"> 
                                <input type="hidden" name="idx" value="${content_view_bookstory.idx}">
                                <% 
                                if(memberDto.getBook_profile()==null){
                                %>
                                <input type="hidden" name="reply_profile" value="user.png" width="30px" height="30px">
                                <%
                                }else{
                                %>
                                 <input type="hidden" name="reply_profile" value="${memberDto.book_profile}">
                                <%
                                }
                                %>
                                <input type="hidden" name="reply_writer" value="${content_view_bookstory.bs_user_id}">
                                <input type="hidden" name="reply_category" value="${content_view_bookstory.bs_category}"> 
                               
                                <table>
                                    <tr> 
                                        <td style="padding-top: 20px;">
                                            <textarea name="reply_content" id="reply_content" cols="95" rows="5" placeholder="댓글을 달아주세요"></textarea>
                                        </td>
                                        <td>
                                            <input type="submit" class="btn btn-light" value="댓글달기" style="text-align: center;"> 

                                        </td>
                                   
	                                
                                    </tr>
                                </table>  
                                </form> 
                                
                                <%
                                }else{ 
                               	%> 
                               	
                               	<form action="replyAction" method="post" name="reply">
                               	 
                            	 <input type="hidden" name="reply_profile" value="${content_view_bookstory.profile_img}">
                            	 
                               
                                <input type="hidden" name="idx" value="${content_view_bookstory.idx}"> 
                                <input type="hidden" name="reply_category" value="${content_view_bookstory.bs_category}">
                               
                                <table>
                                    <tr> 
                                        <td style="padding-top: 20px; display:none;">
                                            <textarea name="reply_content" id="reply_content" cols="95" rows="5" placeholder="댓글을 달아주세요"></textarea>
                                        </td>
                                        <td style="  display:none;">
                                            <input type="submit" class="btn btn-light" value="댓글달기" style="text-align: center;"> 

                                        </td> 
                                    </tr>
                                </table>  
                                </form> 
                                <%  
                                }
                                %>
                        </div> 
                    </div> 
                    
                     
                    <%
                    String sessionID3=(String)session.getAttribute("sessionID");
                    if(content_view_bookstory.getBs_user_id().equals(sessionID3) && sessionID3!=null){
                    %>
                    <div class="list_box2"> 
                      	<button type="button" class="btn btn-light"><a href="BookStoryModify?idx=${content_view_bookstory.idx}">수정<a></button>
                   		<button type="button" class="btn btn-light"><a href="BoardStoryDeleteAction?idx=${content_view_bookstory.idx}">삭제<a></button>
                        <button type="button" class="btn btn-light" onclick="goList()">목록</button>
                       	<a href="#top"> <button type="button" class="btn btn-light">TOP</button></a>
                    </div> 
                    <%
                    }else{
                 	%>
                 	<div class="list_box2"> 
                      	<button type="button" class="btn btn-light" onclick="goList()">목록</button>
                       	<a href="#top"> <button type="button" class="btn btn-light">TOP</button></a>
                    </div>  
					<%
					}
                    %>
 
                </div>    
                
            </section>  
            
         
           <!-- 푸터	 -->   
		    <jsp:include page="/WEB-INF/views/BookStoryMainFooter.jsp"/>
	 
      
        </div>   
         
     <script> 
     function writeReturn() {
   		alert("로그인해주세요");
   		location.href="LoginForm";
   	  }

   	function goModify(){
		console.log("수정하기");
       	location.href="BookStoryModify";  
   	} 

    function writeReview() {location.href="BookStoryWrite"} 
      
 	   function goList(){   
  		 var category_list = document.getElementById("category").text;
 			console.log(category_list);
			if(category_list == '북스토리,소통'){ 
				  location.href="BookStoryCommunication";
			}else if(category_list == '좋은글귀 남기기'){
				location.href="BookStoryGoodWriting";
			}else if(category_list == '한줄서평'){
				location.href="BookStoryOneLineReivew";
  	  	   }else if(category_list == '책읽고,리뷰남기기'){
  	  	  	   location.href="BookStoryReadReivew"
  	  	   }else if(category_list == '작가정보'){
  	  	  	   location.href="BookStoryWriterInfo_A"
  	  	   }else if(category_list == '책 미리보기'){
  	  	  	   location.href="BookStoryBookPreview_A"
  	  	   }else if(category_list == '책 이벤트'){
  	  	  	   location.href="BookStoryEvent_A"
  	  	   }
	 	}	    
     </script> 
     <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
     <script type="text/javascript">
  
    /* 좋아요 */
    function like_func(){
        var like_cnt=$('#like_cnt').val();
        console.log('like_cnt'+like_cnt);
    
		var like_check = $('#like_check').val(); 
		console.log('like_check'+like_check); 
		var idx = $('#idx').val();  
 
		console.log('idx'+idx);
      	$.ajax({ 
      		url: 'http://localhost:8081/like_check?idx='+idx+'&like_check='+like_check,
      	  	cache: false,
      	    type: "GET", 
      	    success: function(data) { 
          	    
          	console.log(typeof(data));

         	 var like_img =document.getElementById("like_img");
	      	if(data == '0'){ 
		      	  console.log("좋아요 취소");  
		      	  alert('좋아요 취소'); 
	      	 
	      	 $('#like_img').attr('src','image/bookstory/like_cancle.png');
	      	$('#like_check').val('0');
	      	 
	       
	          } else  { 
	        	  console.log("좋아요 클릭");
	        	  alert('좋아요 클릭'); 
	        	  
	        	  $('#like_img').attr('src','image/bookstory/like.png');
	        	  $('#like_check').val('1');
	        	 
	          }       

      	    }

      	});  

    } 
    </script>   
     
</body>
</html>
