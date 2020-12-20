<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.OnetoOneBoardDto" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	OnetoOneBoardDto content_view=(OnetoOneBoardDto)session.getAttribute("content_view");
%> 
  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/member/onetooneboardwrite.css">
<title>1:1문의보기</title>
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
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	
	#bt{
	 relative : bottom;
	}
	.actionbar{
	width:150px;
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
	</style>
  
</head>
<body>
<!-- 헤더 부분  -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<!-- 헤더 부분  -->

 <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2"> 
	   <!-- 왼쪽 사이드 메뉴바 시작 -->
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
      <!-- 왼쪽 사이드 메뉴바 끝 -->
	   
	  <!-- 오른쪽 컨텐츠 시작 -->
	<div class="contents">
	  <div class="section"> 
        <div class="head_orderlist" style="padding-left: 0px; width:800px;"> 
            <h4>글 보기</h4>   
            
            <!-- 상품명 -->  
            <table>
             	<tr>
                    <td> 
                    <div class="input-group choose-product">  
                        <span>문의유형</span>
                    <div class="select-box-type"> 
                    <select class="custom-select" id="inputGroupSelect04" name="o_type" value="${content_view.o_type}" disabled>
                    <option selected value="배송지연/불만">배송지연/불만</option>
                    <option value="교환문의">교환문의</option>
                    <option value="반품문의">반품문의</option>
                    <option value="상품손상">상품손상</option>
                    <option value="주문/결제 문의">주문/결제 문의</option>
                    <option value="입고 문의">입고 문의</option>
                    <option value="기타">기타</option> 
                    </select> 
                    </div>
                    </td> 
                </tr> 
                <tr> 
                    <td colspan="2"> 
                        <div class="input-group review-id">
                            <span>아이디</span> 
                        <div class="select-box"> 
                         <input class="form-control" type="text" name="user_id" value="${content_view.user_id}" disabled>                                 
                    </div>
                        </div>
                    </td>  
                </tr>
                <tr>
                    <td colspan="2"> 
                        <div class="input-group phone-num">
                            <span>휴대폰</span>   
                        <div class="select-box"> 
                          <input class="form-control" type="text" name="o_phone" value="${content_view.o_phone}" disabled>                                 
                        </div>
                       
                    </td> 
                </tr>
                 <tr>
                    <td colspan="2"> 
                        <div class="input-group o_title">
                            <span>제목</span> 
                        <div class="select-box o_title_box">
                          <input class="form-control" type="text" name="o_title" value="${content_view.o_title}" disabled >      
                        </div>
                        </div>
                    </td> 
                 </tr>
                <tr> 
                    <td colspan="2"> 
                        <div class="input-group content">
                            <span>내용</span> 
                            <div class="text-box"> 
                            <textarea name="o_content_Q" cols="75" rows="10" style="border: 1px solid rgb(206, 206, 206);" disabled>${content_view.o_content_Q}</textarea>
                            
                        </div>
                        </div>
                    </td> 
                </tr>
                </table> 
                
                <%
                	if(content_view.getO_content_A()!=null){
                %> 
                <form action="adminReplyDelete" method="post">
                 <input type="hidden" name="idx" value="${content_view.idx}" >
       		    <input type="hidden" name="admin_id" value="">
       		    <input type="hidden" name="o_content_A" value="">
       		    <input type="hidden" name="o_ans_check" value="미등록">
                <table> 
                <tr>
                <td>  
                <div class="input-group reply_answer">   
               		<span>문의글 답변</span>   
       		    </div>
       		   
       		    <div style="padding-top:10px;"> 
			       <input type="submit" class="btn btn-secondary" value="삭제하기"> 
			 
			    </div>
       		    </td>
       		    
                <td colspan="2">  
			         <div class="text-box2"> 
			            <textarea name="o_content_A" cols="75" rows="5" style="border: 1px solid rgb(206, 206, 206); ">${content_view.o_content_A}</textarea> 
			        </div>
			    </td>  
			    </tr>    
                </table> 
                </form>
                <%
                	}
                %>
                 
                
                <!-- 글작성 -->
                <form action="OnetoOneboard_A_Action" method="post" >    
                <input type="hidden" name="idx" value="${content_view.idx}">
                <input type="hidden" name="admin_id" value="관리자">
                <table>    
                <hr />
               	<tr> 
                	
				    <td rowspan="2">
				        <div class="text-box_admin"> 
				            <textarea name="o_content_A" cols="72" rows="5" style="border: 1px solid rgb(206, 206, 206); "></textarea> 
				        </div>
				    </td>  
			        <td class="button_position">
			        <div class="input-group content option_box"> 
			        <select class="custom-select" id="inputGroupSelect04" name="o_ans_check">
			            <option value="미등록">미등록</option>
			            <option value="답변완료">답변완료</option>  
			            </select> 
			        </div>  
			        <input type="submit" class="btn btn-secondary reply_A" value="답변하기" style="text-align:center"> 
			        </td> 
			   </tr>  
	       	   </table> 
	       	   </form> 
		</div>
        </div>
    </div>  
    </div>  <!-- AdminWrapper2 --> 
	</div>  <!-- AdminWrapper1 -->
	
	
	<div class="footer">
	<!-- 푸터 부분  -->
	<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
	</div>
	<script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>