<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head> 
<link rel="stylesheet" href="css/member/orderlist.css">
    <title>주문목록</title> 
<% String id = (String)session.getAttribute("sessionID"); %>
</head>
<style>
.btn-danger{
width: 95px;
height: 25px; 
}

</style>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 
             
        <!-- 주문내역 -->
          <div id="main"> 
            <div class="MyPage_Form">  
                 <table>
                    <tr>
                    	<td> 
	                        <div class="section">
	                         <div class="aside">
	                            <table cellpadding="10px" cellspaing="10px">
	                                <p><a href="MyPageMain?id=<%=id%>" style="text-decoration:none; color:black;">마이페이지</a></p> 
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
                                <h4>주문내역</h4>   
    
                                <p>※ 배송이 시작되면 주문을 취소할 수 없습니다.</p>
                                <table id="member_list"  class="table table-striped order-list ">
                                <tr class="table_col" style="text-align: center;">
                                    <th scope="col" style="width: 10%; font-size : 1.5ch;">날짜/주문번호</th>
                                    <th scope="col" style="font-size : 1.5ch;" >이미지</th>
                                    <th scope="col" style="width: 40%; font-size : 1.5ch;" >상품명</th>
                                    <th scope="col" style="width: 12%; font-size : 1.5ch;" >수량</th>
                                    <th scope="col" style="width: 18%; font-size : 1.5ch;" >상품금액</th>
                                    <th scope="col"  style="width: 20%; font-size : 1.5ch;">주문상태</th> 
                                </tr>
                                
                                <c:forEach items="${ list }" var="list" >
                                <fmt:formatDate value="${list.reg}" var="reg" pattern="yyyy.MM.dd"/>
                                  <tr class="box_center">
                                    <td style="font-size : 1.3ch;">${reg} / ${list.o_number}</td>
                                    <td><img src="${list.p_filename}" style="width: 80px;"></td>
                                    <td>${list.p_title}</td>
                                    <td >${list.count}</td>
                                    <td >${list.o_price}</td>
                                    <c:if test="${list.o_state == 1}" >
                                       <td>주문 확인 중
		                                    <div class="box_center">
		                                    <button type="button" class="btn btn-danger order_cancel">
		                                    <a href="cancelOrder?o_number=${list.o_number}" style="text-decoration:none; color:white; font-size: 1.4ch;">주문취소</a>
		                                    </button>
		                                    </div>
	                                    </td>
                                    </c:if>
									<c:if test="${list.o_state == 2}">
										<td>주문 확인
											<div class="box_center">
		                                    <button type="button" class="btn btn-danger order_cancel">
		                                    <a href="cancelOrder?o_number=${list.o_number}" style="text-decoration:none; color:white; font-size: 1.4ch;">주문취소</a>
		                                    </button>
		                                    </div>
	                                    </td>
	                                </c:if>
									<c:if test="${list.o_state == 3}">
										<td>배송 준비 중
											<div class="box_center">
		                                    <button type="button" class="btn btn-danger order_cancel">
		                                    <a href="cancelOrder?o_number=${list.o_number}" style="text-decoration:none; color:white; font-size: 1.4ch;">주문취소</a>
		                                    </button>
		                                    </div>
	                                    </td>
									</c:if>
									<c:if test="${list.o_state == 4}"><td>배송 중</td></c:if>
								 	<c:if test="${list.o_state == 5}">
									 	<td>배송 완료
										 	<div class="box_center">
											 	<button type="button" class="btn btn-danger review_write">
											 		<a href="ProductReivew" style="text-decoration:none; color:white; font-size: 1.4ch;">후기쓰기</a>
											 	</button>
										 	</div>
		                                    <div  class="box_center">
			                                    <button type="button" class="btn btn-danger change_refund">
			                                    	<a href="OnetoOneBoard" style="text-decoration:none; color:white; font-size: 1.4ch;">교환/환불</a>
			                                    </button>
		                                    </div>
		                                </td>
								 	</c:if>
                                     <input type="hidden" id="o_number" value="${list.o_number}">
                                </tr> 
                                </c:forEach>
                                </table>                     
                               <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page10?no=<%=i%>" class="page-link"><%=i%></a></li>
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

</body>
</html>

