<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<html>
<head> 
<link rel="stylesheet" href="css/member/myinfo.css">
    <title>상품후기</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 마일리지 -->
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
                             <h4>포인트 이용 내역</h4>  
                             <br />
                             
  							<table>
  							<tr>
  							
  							<th>보유 적립금: </th>
  							<th style="padding-left:10px;">${point.point}P</th>
  							</tr>
  							</table>
                             <table id="member_list"  class="table table-striped product-review" style="text-align: center;">
                             <tr >
                                 <th scope="col" style="width: 20%;">적립 일</th>
                                 <th scope="col" style="width: 40%;" >적립 내역</th>  
                                 <th scope="col"  style="width: 20%;">적립 포인트</th> 
                                 <th scope="col"  style="width: 20%;">잔여 포인트</th> 
                             </tr>
                             <c:forEach items="${ list }" var="dto" >
							 <fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
                          <tr>
                             <td> ${reg}</td> 
                             <td> ${dto.pt_content}</td> 
                             <td> ${dto.pt_move}</td> 
                             <td> ${dto.pt_result}</td> 
                             </tr>
                             </c:forEach>
                     
                             </table>
                                          <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page12?no=<%=i%>" class="page-link"><%=i%></a></li>
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
	function ProductReview(){location.href="ProductReivew";}
	function completePage(){ location.href="ProductReviewComplete";}
	</script> 
 
</body>
</html>
