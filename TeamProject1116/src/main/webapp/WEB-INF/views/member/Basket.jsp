<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head> 
<link rel="stylesheet" href="css/member/basket.css">
    <title>장바구니</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 
             
        <!-- 장바구니 -->
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
                            <div class="head_basket"> 
                                <h4>장바구니</h4>  
                                  
                                <table id="member_list"  class="table table-striped  ">
                                    <div class="basket-form">
                                <tr class="table_col">
                                    <th scope="col" style="width: 10%;" >이미지</th>
                                    <th scope="col" style="width: 50%;" >상품정보</th>
                                    <th scope="col" style="width: 15%;" >날짜</th>
                                    <th scope="col" style="width: 10%;" >수량</th>
                                    <th scope="col" style="width: 13%;" >상품금액</th>
                                    <th scope="col"  style="width: 20%;">주문여부</th> 
                                </tr>
                                <c:forEach var="list" items="${ list }">
                                <fmt:formatDate value="${list.reg}" var="reg" pattern="yyyy.MM.dd"/>
                                <tr class="box_center">
                                	<td><img src="${list.p_filename}" style="width: 70px;"></td>
                                    <td><span class="product_num"><br>제목: ${list.p_title}<br>
                                    작가명: ${list.p_writer}</span></td>
                                    <td><span>${reg}</span></td>
                                    <td><span>${list.product_number}</span></td>
                                    <td><span><fmt:formatNumber value="${list.p_price * (100-list.p_discount_ratio)/100}" type="currency"/></span></td>
                                    
                                    <td> 
                                        <div class="box_center order"><button type="button" class="btn btn-danger order_cancle" onclick="order()">주문</button></div>
                                        <div class="box_center delete"><button type="button" class="btn btn-danger order_cancle">
                                        <a href="deleteCart?idx=${list.idx}" style="text-decoration:none; color:white">삭제</a> 
                                        </button></div>
                                    </td> 
                                </tr> 
                                <input type="hidden" id="p_number" value="${list.p_number}">
                                <input type="hidden" id="count" value="${list.product_number}">
                                <input type="hidden" id="price" value="${list.p_price}"> 
                                <input type="hidden" id="p_discount_ratio" value="${list.p_discount_ratio}">
                                </c:forEach>
                                
                                </table>
                                              <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page11?no=<%=i%>" class="page-link"><%=i%></a></li>
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
function order(){
	var p_number = document.getElementById('p_number').value;
	var count = document.getElementById('count').value;
	var p_price = document.getElementById('price').value;
	var p_discount_ratio = document.getElementById('p_discount_ratio').value;
	
	location.href ="purchase?p_number="+p_number+"&number="+count+"&p_price="+p_price+"&p_discount_ratio="+p_discount_ratio;
   }
 </script>
</body>
</html>

