<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
   String sessionID = (String)session.getAttribute("sessionID");
 %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>상품 문의</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
	</head>
	<style>
/* 상단 상세정보 */
.maincontentswrapper{
 display: flex; 
 flex-direction: row;
 justify-content: center;
}
.product-image-slider{
	width: 380px;
	margin: 160px 100px 30px;
	min-width: 380px;  /* 창 사이즈 조절에도 크기 변화 없게 하기 */
} 
.product-detail{
	margin-top: 160px;
	width: 500px;
	min-width: 480px; /* 창 사이즈 조절에도 크기 변화 없게 하기 */
}
table-striped tr{
height: 30px;
}
.table-title{
font-size: 2ch;
font-weight: bold;
}
.table-striped td{
font-size: 1.5ch;
}
.bottom-detail{
display: inline;
}
/* 하단 상세정보  */
.maincontentswrapper2{
  display: flex; 
  flex-direction: row;
  justify-content: center;
}
.maincontentswrapper2 button{
  border: none;
  width: 200px;
  height: 50px;
  font-size: 3ch;
  font-weight: bold;
}
/* 하단 상세정보 내용*/
.maincontentswrapper3{
  display: flex; 
  flex-direction: row;
  justify-content: center;
}
.maincontentswrapper3bottom{
  margin-top: 60px;
  width: 800px;
}
.maincontentswrapper4{
  display: flex; 
  flex-direction: row;
  justify-content: center;
}
.maincontentswrapper4bottom{
  margin-top: 60px;
  width: 800px;
}

</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	
<body>
	<!-- 메인헤더 -->
	<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
	
<!-- 상품 이미지 슬라이더 시작 -->

 <div class="maincontentswrapper">
		<div  style="width:380px; height:500px; margin-top:180px; margin-left:100px;" class="item active">
			<img src="${dto.p_filename}" style="width:100%; height:100%">
		</div>
		
	    <div class="product-detail" style="margin-left:50px;" >
	    
	    	    <form action="purchase" method="post">  <!-- get으로 가격이랑 수량 넘기기 http://localhost:8081/Product_detail? -->
	    	<h1>상품 정보</h1>
				<table class="table table-striped" style="width:400px">
				    <tr>
					    <td class="table-title" style="width:150px;">상품명</td>
					    <td class="table-content">${dto.p_title}</td>
				    </tr>
				    <tr>
					    <td class="table-title" style="width:150px;">작가</td>
					    <td class="table-content">${dto.p_writer}</td>
				    </tr>
				    <tr>
					    <td class="table-title">판매가</td>
					    <td class="table-content">
					    <fmt:formatNumber value="${dto.p_price}" type="currency"/>
					    </td>
				    </tr>
				    <tr>
					    <td class="table-title">할인가</td>
					    <td class="table-content" >
					    <fmt:formatNumber value="${dto.p_price * (100-dto.p_discount_ratio)/100}" type="currency" />
					    </td>
				    </tr>
				    <tr>
					    <td class="table-title">적립금</td>
					    <td class="table-content">
					    <fmt:formatNumber value="${dto.p_price * 0.03}" type="currency"/>
					    　(판매가 x 3%)</td>
				    </tr>
				    <tr>
					    <td class="table-title">배송비</td>
					    <td class="table-content">일반: 2,500원 | 도서산간: 5,000원</td>
				    </tr>
				    <tr>
					    <td class="table-title">상품수량</td>
					    <td class="table-content"><input type="number" value="0" id="product-number" name="number" onchange="cal_price()" ></td>
				    </tr>
				     <tr>
					    <td class="table-title">결제금액</td>
					    <td class="table-content" id="spanprice">총 <span id="total-price" ></span>원 + 배송비</td>
				    </tr>
				    <tr>
				       <input type="hidden" name="p_title" value="${dto.p_title}"/>
				       <input type="hidden" name="p_writer" value="${dto.p_writer}">
				       <input type="hidden" name="p_price" value="${dto.p_price}"/>
				       <input type="hidden" name="p_discount_ratio" value="${dto.p_discount_ratio}"/>
					   <input type="hidden" name="p_number" value="${dto.p_number}" />
					   <input type="hidden" name="p_filename" value="${dto.p_filename}" />
				    </tr>
				   
				    <tr>
				     <td>
					  <button type="submit" value="buy" class="btn btn-lg btn-danger" style="height:50px; width:110px; font-size: 18px; float:right" 
					  id="btn" onclick="javascript: form.action='/purchase';">구매하기</button>
					 </td>
				   <td><button type="submit" value="cart" class="btn btn-lg btn-danger" 
				   style="height:50px; width:110px; font-size: 18px;" 
				   onclick="javascript: form.action='/addBasket';">장바구니</button>
				 </td> 
				 
				   </tr>
				</table>
			</form>	
	     </div>  
</div>
	<div class="maincontentswrapper2">
	        <div class="bottom-detail">
			    <button><a href="Product_detail?p_number=${dto.p_number}" style="text-decoration:none; font-size:1.3ch; color:black;">상품 상세정보</a></button>
			     <button><a href="ProductDetail2?p_number=${dto.p_number}" style="text-decoration:none; font-size:1.3ch; color:black;">배송 및 결제</a></button>
			     <button><a href="ProductDetail3?p_number=${dto.p_number}" style="text-decoration:none; font-size:1.3ch; color:black;">상품 후기</a></button>
			     <button><a href="ProductDetail4?p_number=${dto.p_number}" style="text-decoration:none; font-size:1.3ch; color:black;">상품 문의</a></button>
		  </div>
	</div>
	
		<div class="maincontentswrapper3">
			<div class="maincontentswrapper3bottom">
				<form action="ProductQnABoard">
				  <table class="table table-striped">
				  <input type="hidden" name="p_title" value="${dto.p_title}">
				  <input type="hidden" name="p_writer" value="${dto.p_writer}">
				  <input type="hidden" name="p_number" value="${dto.p_number}" >
				  <input type="hidden" name="p_answer_state" value="미등록" >
				  <td><textarea name="p_content" cols="70" rows="4" placeholder="내용을 입력하세요." style="font-size: 16px;"></textarea></td>
				  <td style="margin:0 auto;">
				  <button type="submit" class="btn btn-danger" style="width: 100px; height: 30px; font-size: 18px; margin-top: 25%;">등록</button></td>
				  
				  </table>
				</form>
			</div>
	     </div>
	     
	       <div class="maincontentswrapper4">
	     <div class="maincontentswrapper4bottom">
	      <table class="table table-striped">
	      <tr>
	      <td style="font-size: 15px; width: 70px;">번호</td>
	      <td style="width: 500px; font-size: 15px;">문의 내용</td>
	      <td style="font-size: 15px; width: 100px;">작성자</td>
	      <td style="font-size: 15px; width: 70px;">날짜</td>
	      <td style="font-size: 15px; width: 100px;">답변상태</td>
	 
	     <c:forEach var="list" items="${ list }">
	     <fmt:formatDate value="${list.reg}" var="reg" pattern="yyyy.MM.dd"/>
	      <tr>
	      <td style="font-size: 15px; width: 50px;">${list.idx}</td>
	      <td style="width: 500px; font-size: 15px;">${list.p_content}</td>
	      <td style="font-size: 15px;">${list.id}</td>
	      <td style="font-size: 15px;">${reg}</td>
	      <td>${list.p_answer_state}</td>
	      </tr>
	      
	      <c:set var = "p_answer_state" scope = "session" value = "${list.p_answer_state}"/>
	       <c:if test = "${p_answer_state eq '미등록'}">
	       </c:if>
	       
	      <c:set var = "p_answer_state" scope = "session" value = "${list.p_answer_state}"/>
	       <c:if test = "${p_answer_state eq '답변완료'}">
	        <tr>
		      <td></td>
		      <td style="font-size: 15px;">
			      <img src="image/reply.png" style="width:20px;">
			      　${list.p_answer}
		      </td>
		      <td>관리자</td>
		      <td></td>
		      <td></td>
		    </tr>
	      </c:if>
	     </c:forEach>
	      </table>
		</div>
		</div>
	     
	   
	 
	

	<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>

<script type="text/javascript">
	
	    function cal_price(){  /* db에서 가격 받아와서 조정하기 */
	    	var product_price=document.getElementById('product-price').value;
	    	var product_number=document.getElementById('product-number').value;
	    	var total_price=product_price * product_number;
	    	document.getElementById('total-price').innerHTML=total_price;
	        }

		$("#buy").click(function () {
		    $("form").attr("action", "/purchase");
		});
		
		$("#cart").click(function () {
		    $("form").attr("action", "/addBasket");
		});

    </script>
</body>
</html>