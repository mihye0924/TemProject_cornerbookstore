<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
String id = (String) session.getAttribute("sessionID"); 
%>
  
<html>
<head> 
<link rel="stylesheet" href="css/member/onetooneboard.css">
    <title>상품문의게시판</title>  
</head>

<style>
.multiline-ellipsis{
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical; 
    table-layout: fixed; 
    text-overflow: ellipsis; 
     max-width: 200px !important;  
}
</style>

<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 1:1문의 -->
        <div id="main">
            <div class="MyPage_Form">  
                <table>
                    <tr>
                    <td> 
                        <div class="section">
                            <div class="aside">
                                <table  cellpadding="10px" cellspaing="10px">
                                <p><a href="MyPageMain?id=<%=session.getAttribute("sessionID")%>" style="text-decoration:none; color:black;">마이페이지</a></p> 
                                <tr>
                                    <td>
                                        <div class="orderlist">
                                        <a href="OrderList">주문내역</a> 
                                        <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="basket">
                                        <a href="Basket">장바구니</a>
        
                                         <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="review">
                                        <a href="ProductReivew">상품후기</a>
                                          <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="point">
                                        <a href="PointInfo">적립금</a>
                                           <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="ask">
                                        <a href="OnetoOneBoard">1:1문의</a>
                                         <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                    <div class="my_info">
                                    <a href="MyInfo">내정보</a>
                                      <span>&gt</span> 
                                    </div>
                                    </td>
                                </tr>
                                 <tr>
                                <td>
                                <div class="orderlist">
                                <a href="MyProductQnA">상품문의</a>
                                  <span>&gt</span> 
                                </div>
                                </td>
                            </tr>
                                </table>
                            </div>
                          <div class="head_orderlist"> 
                            <h4>상품문의게시판</h4>     
                                <div class="form-row align-items-center">              
                                   <form action="SearchmyProductQnA" method="post" class="complain_form"> 
                                   <table style="margin-left:330px;">
                                             <p class="noreply_view">  <input type="button" class="btn btn-outline-secondary reply_no" value="답변 없는 문의만 보기" style="width:170px; height:40px;"onclick="ChangeForm()" /> </p>
                                        <tr>
                                            <td>
                                            <div class="col-auto my-1 search-text-form"> 
                                               
                                                <select class="custom-select mr-sm-2 searchform" id="complian_search" name="category">
                                                  <option selected value="p_title">도서명</option>
                                                  <option value="p_writer">작가명</option>
                                                  <option value="p_content">내용</option>
                                                </select>
                                                
                                    		</div> 
                                            </td> 
                                            <td>
                                                <input class="form-control search-text" type="search-1" placeholder="Search" aria-label="Search"  name="keyword">
                                            </td>
                                            <td>
                                                <button class="btn btn-danger" type="submit">검색</button> 
                                            </td> 
                                        </tr>  
                                    </table>
                                    </form>
                                </div>  
                                <table id="member_list"  class="table table-striped order-list ">
                                
		                            <tr class="one-list-title">
		                                <th scope="col"  style="width: 8%;" >번호</th>
		                                <th scope="col"  style="width: 20%;" >도서명/작가</th>
		                                <th scope="col"  style="width: 20%;" >내용</th>
		                                <th scope="col"  style="width: 10%;" >작성자</th>
		                                <th scope="col"  style="width: 10%;">답변상태</th> 
		                                <th scope="col"  style="width: 10%;">작성일</th> 
		                            </tr>
		                        
		                           <c:forEach var="list" items="${list}">
		                           <fmt:formatDate value="${list.reg}" var="reg" pattern="yyyy.MM.dd"/>
		                            <tr class="one-list-text">
		                                <td>${list.idx}</td>
		                                <td>${list.p_title}/${list.p_writer}</td>
		                                <td><a href="MyProductQnAView?idx=${list.idx}" style="color:black;" class="multiline-ellipsis">${list.p_content}</a></td>
		                                <td id="user_id" value="user_id" >${list.id}</td>
		                                
		                                <c:set var = "p_answer_state" scope="session" value = "${list.p_answer_state}"/>
		                                <c:if test = "${p_answer_state eq '미등록'}">
		                                <td style="color:red;"><c:out value="${list.p_answer_state}"/></td>
		                                </c:if>
		                                <c:if test = "${p_answer_state eq '답변완료'}">
		                                <td style="color:blue;"><c:out value="${list.p_answer_state}"/></td>
		                                </c:if>
		                                <td>${reg}</td>
		                                 <div id="check"></div>
		                               	<!-- 미등록, 답변완료 --> 
		                            </tr>
		                            </c:forEach>
		                            
                  
                            </table>  
                            
                                <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page4?no=<%=i%>" class="page-link"><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav> 	    
                        </div> 
                    </div>
                    </td>
                </tr>
               </table> 
	        </div> 
	    </div>     
        
<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>


	<script type="text/javascript"> 
	function ChangeForm(){ location.href="NoAnswer_qna"; }
	function goOnetoOneBoardWirte(){ location.href="OnetoOneBoardWrite";  }
	function ProductReview(){location.href="ProductReivew";}
	function ReviewWrite() { location.href="ProductReviewWrite"; } 
	function completePage(){ location.href="ProductReviewComplete";}

	 
    
	</script> 
 
</body>