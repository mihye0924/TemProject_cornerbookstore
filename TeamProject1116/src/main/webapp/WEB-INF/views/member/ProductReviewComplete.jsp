<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<html>
<head> 
<link rel="stylesheet" href="css/member/productreivew.css">
    <title>작성완료후기</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 
       <!-- 상품후기완료 -->  
        <div id="main">
            <div class="MyPage_Form">  
                <table>
                    <tr>
                    <td>
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
                    <tr>
                    <td>
                      <div class="section">

                            <div class="head_orderlist">  
                            <h4>상품후기</h4>  
                            <div class="product-review_box">
                                <button type="button" class="btn btn-outline-secondary complete_Productreview" onclick="ProductReivew()">작성가능후기</button>
                                <button type="button" class="btn btn-secondary possible_Productreview" onclick="completePage()">작성완료후기</button> 
                               
                            </div>
                            
 
                            <table id="member_list"  class="table table-striped product-review">
                            
                            <tr style="text-align: center;">
                                <th scope="col" style="width:10%;">이미지</th>
                                <th scope="col" style="width: 30%;" >상품명/작가</th>  
                                <th scope="col"  style="width: 60%;">내용</th> 
                                <th scope="col">작성일</th> 
                                <th scope="col">　</th> 
                            </tr>
                            
                            
                             <c:forEach items="${ list }" var="list">
                             <fmt:formatDate value="${list.reg}" var="reg" pattern="yyyy.MM.dd"/>
                      
                            <c:if test="${list.p_filename == null}">
                            <tr class="box_center">
                            <td style="font-size: 1.5ch;">이미지 없음</td>
                            <td style="font-size: 1.5ch;">${list.p_title} / ${list.p_writer}</td>
                            <td style="font-size: 1.5ch;">${list.description} </td>
                            <td style="font-size: 1.3ch;">${reg}</td>
                            <td style="font-size: 1.3ch;">
                               <button class="btn btn-sm btn-danger" style="font-size: 1.6ch; width: 40px;">
                               <a href="deleteReview?idx=${list.idx}&o_number=${list.o_number}" style="color:white">삭제</a>
                               </button>
                               <button class="btn btn-sm btn-danger" style="font-size: 1.6ch; width: 40px; margin-top: 10px;">
                               <a href="modifyReviewForm?idx=${list.idx}&o_number=${list.o_number}" style="color:white">수정</a>
                               </button>
                            </td>
                            </tr>
                            </c:if>
                            
                            <c:if test="${list.p_filename != null}">
                            <tr class="box_center">
                            <td><img src="${list.p_filename}" style="width:100px;"></td>
                            <td style="font-size: 1.5ch;">${list.p_title} / ${list.p_writer}</td>
                            <td style="font-size: 1.5ch;">${list.description} </td>
                            <td style="font-size: 1.3ch;">${reg}</td>
                            <td style="font-size: 1.3ch;">
                               <button class="btn btn-sm btn-danger" style="font-size: 1.6ch; width: 40px;">
                               <a href="deleteReview?idx=${list.idx}&o_number=${list.o_number}"  style="color:white">삭제</a>
                               </button>
                               <button class="btn btn-sm btn-danger" style="font-size: 1.6ch; width: 40px; margin-top: 10px;">
                               <a href="modifyReviewForm?idx=${list.idx}" style="color:white">수정</a>
                               </button>
                            </td>
                            </tr>
                            </c:if>
                            
                            </c:forEach>  

                            </table> 

                        </div>  
                            <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-center">
             <%
             int allPageNum=(Integer)request.getAttribute("allPageNum");
             for(int i=1; i<=allPageNum; i++){
                   %>
              <li class="page-item"><a href="page15?no=<%=i%>" class="page-link"><%=i%></a></li>
                <%
              }
             %>    
           </ul> 
         </nav>     
                            </div>  
                       </td>
                   </tr>
                  </table> 
            </div> 
        </div>   
    
<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>


   <script type="text/javascript"> 
   function ProductReivew(){location.href="ProductReivew";}
   function ReviewWrite() {location.href="ProductReviewWrite";} 
   function completePage(){location.href="ProductReviewComplete";}
   </script> 
 
</body>
</html>