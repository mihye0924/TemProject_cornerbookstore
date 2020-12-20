<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문확인서</title>
<!-- 다음 주소 API -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.purchaseWrapper {
	display: flex;
	justify-content: center;
	align-content: center;
}

.cardPurchaseDetail {
	font-size: 1.4ch;
}

.personalInfo {
	font-size: 1.6ch;
}

.agreecheck {
	color: #A0522D;
}

#newAd {
	float: right;
	width: 450px;
	height: 200px;
	text-align: center;
	border-left: 1px solid #ccc;
}

.recipeth{
	width:150px;
	
}
.recipetd{
	width:150px;
	text-align:left;
}
.inrecipe{
	padding-left: 15px;
	font-size:13px;
}
.btn-danger{
	background-color:#D4B886 !important; 
	color:black !important; 
	border:1px solid #D4B886 !important;
}
		td{
		border:0 !important;
		}
		th{
		border:0 !important;
		}
		hr{
		border:2px;
		background-color: black;
		}
		.form-control{
		border:0 !important;
		border-bottom:1px solid black !important;
		}
</style>
<script>

	function setDisplay(select) {
		var cardDiv = document.getElementById("cardDiv");
		if (select == "1") {
			cardDiv.style.display = "block";
		} else {
			cardDiv.style.display = "none";
		}
	}


	function goFirstForm(){
		
		location.href = "MainForm";
		}
</script>
</head>
<body>
	<!-- 메인헤더 -->
	<jsp:include page="/WEB-INF/views/MainHeader.jsp" />

	<div class="purchaseWrapper">
		<div class="purchaseContents"
			style="width: 800px; padding-top: 160px;">
			<h2 style="text-align: center;">
				<strong>주문확인서</strong>
			</h2>
			<hr>
				<br>
				<h3>
					<strong>상품정보</strong>
				</h3>

				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">상품 번호</th>
							<th scope="col">상품 이미지</th>
							<th scope="col">상품 정보</th>
							<th scope="col">상품 수량</th>
							<th scope="col">상품 금액</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td><img src="${dto.p_filename}"></td>
							<td>${dto.p_title}</td>
							<td>${dto.count}개</td>
							<td>${dto.o_price}원</td>
						</tr>
					</tbody>
				</table>
				<div style="height: 250px;">
					<br>
				<h3>
					<strong>수령자 정보</strong>
				</h3>
				<table class="table"
					style="width: 800px; float: left;">
					<tr>
						<th>수령인*</th>
						<td>${dto.o_receiver}</td>
					</tr>
					<tr>
						<th>휴대폰*</th>
						<td>${dto.o_phone}</td>
					</tr>
					
					<tr>
					<th>주소*</th>
					<td>${dto.o_address}</td>
					</tr>
				</table>
				
				</div>
				<table style="width:800px;">
				<tr>
				<th>요청사항</th>
				</tr>
				<tr>
				<td><textarea style="width:800px; height:100px;"rows="2" name="memo" disabled>${dto.o_memo}</textarea></td>
				</tr>
				</table>
				<br>
				<div style="width:800px; float:left;">
					<h3>
						<strong>지불방식</strong>
					</h3>
					<table class="table">
						<tr>
							
							<c:choose>
							<c:when test="${dto.o_charge eq 'card'}">
							<th style="width:100px;"><span>${dto.o_charge}</span></th>
							</c:when>
							<c:when test="${dto.o_charge eq 'phone'}">
							<th style="width:100px;"><span>${dto.o_charge}</span></th>
							</c:when>
							<c:when test="${dto.o_charge eq 'toss'}">
							<span><img src="image/purcaseimage/toss.PNG"></span>
							</c:when>
							<c:when test="${dto.o_charge eq 'naver'}">
							<img src="image/purcaseimage/naver.PNG">
							</c:when>
							<c:when test="${dto.o_charge eq 'payco'}">
							<img src="image/purcaseimage/payco.PNG">
							</c:when>
							</c:choose>
							<c:if test="${dto.o_charge eq 'card'}" >
							<td>${dto.o_charge2}</td>
							</c:if>
						</tr>
					</table>
				</div>
				
				<br>
				
					<div class="recipe" >
				<h3>
					<strong>결제 금액</strong>
				</h3>
				
				<table style="height:250px;">
				<tr>
				<th class="recipeth">주문 금액</th>
				<td class="recipetd"> <fmt:formatNumber value="${dto.o_price*dto.count*(100-p_dto.p_discount_ratio)/100}" type="currency" />원</td>
				</tr>
				<tr>
				<th class="recipeth inrecipe" >└상품 금액</th>
				<td class="recipetd" style="font-size:13px;"><fmt:formatNumber value="${dto.o_price*dto.count}" type="currency" />원</td>
				</tr>
				<tr>
				<th class="recipeth inrecipe" >└상품 할인</th>
				<td class="recipetd" style="font-size:13px;"><fmt:formatNumber value="${(dto.o_price*dto.count)-(dto.o_price*dto.count*(100-p_dto.p_discount_ratio)/100)}" />원</td>
				</tr>
				<tr>
				<th class="recipeth">배송비</th>
				<td class="recipetd"> ₩2,500원</td>
				</tr>
				<tr>
				<th class="recipeth">적립금 사용</th>
				<td class="recipetd" id="welcome"><fmt:formatNumber value="${dto.o_point}" type="currency" />원</td>
				</tr>
				<tr>
				<td colspan="2" style="border-bottom:1px solid #ccc"></td>
				</tr>
				<tr>
				<th class="recipeth">최종 결제 금액</th>
				<td class="recipetd" id="total"><fmt:formatNumber value="${dto.o_total}" type="currency" />원</td>
				</tr>
				<tr>
				<th colspan="2" style="font-size:12px;">구매시 적립 금액 <fmt:formatNumber value="${dto.o_price*dto.count/(100/3)}" type="currency" />원</th>
				</tr>
				</table>
				
				</div>	
					<div style="text-align: center;  ">
					<button style="margin-left:5px;" class="btn btn-danger" onclick="goFirstForm()">확인</button>
				</div>

			
		</div>

	</div>





	<!-- 메인푸터 -->
	<jsp:include page="/WEB-INF/views/MainFooter.jsp" />

</body>
</html>