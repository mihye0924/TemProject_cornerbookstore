<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ page import="com.study.springboot.dto.OnetoOneBoardDto" %> 
<%@ page import="com.study.springboot.dto.MemberDto" %>

<%
String id = (String) session.getAttribute("sessionID"); 
%>
  
<html>
<head> 
<link rel="stylesheet" href="css/member/onetooneboard.css">
    <title>1:1문의게시판</title>  
</head>
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
                            <h4>1:1문의게시판</h4>     
                                <div class="form-row align-items-center">              
                                   <form action="complain" method="post" class="complain_form"> 
                                    <table style="margin-left:280px;">
                                    
                                              <p class="noreply_view">  <input type="button" class="btn btn-outline-secondary reply_no" value="답변 없는 문의만 보기" style="width:170px;height:40px;"onclick="ChangeForm()"  /> </p>
                           
                                        <tr>
                                            <td>
                                            <div class="col-auto my-1 search-text-form"> 
                                               
                                                <select class="custom-select mr-sm-2 searchform" id="category" name="category">
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
                                            <td>
                                                <input class="form-control search-text" type="search-1" placeholder="Search" aria-label="Search" name="keyword">
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
                                      <th scope="col"  style="width: 12%;" >유형</th>
                                      <th scope="col"  style="width: 30%;" >제목</th>
                                      <th scope="col"  style="width: 10%;" >작성자</th>
                                      <th scope="col"  style="width: 10%;">답변상태</th> 
                                      <th scope="col"  style="width: 10%;">작성일</th> 
                                  </tr>
                                   <c:forEach var="list" items="${ list }" >
                                   
                                  <tr class="one-list-text">
                                  <fmt:formatDate var="reg" value="${list.reg}"  pattern="yyyy.MM.dd"/>
                                      <td>${list.idx}</td>
                                      <td>${list.o_type}</td>
                                      <td><a href="OnetoOneBoardView?idx=${list.idx}" style="color:black;">${list.o_title}</a></td>
                                      <td id="user_id" value="user_id"  onchange="check_id()" >${list.user_id}</td>
                                       <div id="check"></div>
                                        <!-- 미등록, 답변완료 --> 
                                        <c:set var = "o_ans_check" scope = "session" value ="${list.o_ans_check}"/>
                                 <c:if test = "${o_ans_check eq '미등록'}">
                                <td style="color:red;"><c:out value = "${list.o_ans_check}"/></td>
                                 </c:if>
                                  <c:if test = "${o_ans_check eq '답변완료'}">
                                 <td style="color:blue;"><c:out value = "${list.o_ans_check}"/></td>
                                  </c:if>
                                   
                                      <td>${reg}</td>  
                                  </tr> 
                             </c:forEach>
                            </table>  
                           
                              <input class="btn btn-danger" type="button" value="작성하기" onclick="goOnetoOneBoardWirte()">  
                            
                                <nav aria-label="Page navigation example">
					            <ul class="pagination justify-content-center">
					             <%
					             int allPageNum=(Integer)request.getAttribute("allPageNum");
					             for(int i=1; i<=allPageNum; i++){
					                   %>
					              <li class="page-item"><a href="page13?no=<%=i%>" class="page-link"><%=i%></a></li>
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
   function ChangeForm(){ location.href="NoAnswer_user"; }
   function goOnetoOneBoardWirte(){ location.href="OnetoOneBoardWrite";  }
   function ProductReview(){location.href="ProductReivew";}
   function ReviewWrite() { location.href="ProductReviewWrite"; } 
   function completePage(){ location.href="ProductReviewComplete";}

    
    
   </script> 
 
</body>