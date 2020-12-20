<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매프로세스1</title>
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
.recipe{
	width:300px; 
	float:right; 
	border:2px solid black; 
	text-align:center;
	margin-left:50px;
	margin-right:50px;
}
.recipeth{
	width:150px;
	padding-left: 30px;
}
.recipetd{
	width:150px;
	text-align:left;
}
.inrecipe{
	padding-left: 50px;
	font-size:13px;
}
.btn-danger{
	background-color:#D4B886 !important; 
	color:black !important; 
	border:1px solid #D4B886 !important;
}
/* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 800px; 
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 800px !important;/* Could be more or less, depending on screen size */                          
        }
		.form-control{
		border:0 !important;
		border-bottom:1px solid black !important;
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
</style>
<script>
	/*우편번호 찾기 기능*/
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr = '';
				var extraAddr = '';
				if (data.userSelectedType === 'R') {
					addr = data.roadAddress;
				} else {
					addr = data.jibunAddress;
				}

				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					document.getElementById("result3").value = extraAddr;

				} else {
					document.getElementById("result3").value = '';
				}
				document.getElementById('result1').value = data.zonecode;
				document.getElementById("result2").value = addr;
				document.getElementById("result4").focus();
			}
		}).open();
	}

	function setDisplay(select) {
		var cardDiv = document.getElementById("cardDiv");
		if (select == "1") {
			cardDiv.style.display = "block";
		} else {
			cardDiv.style.display = "none";
		}
	}

	function check(s) {
		if (s.checked) {
			document.getElementById("result1").value = document
					.getElementById("sample6_postcode").value;
			document.getElementById("result2").value = document
					.getElementById("sample6_address").value;
			document.getElementById("result3").value = document
					.getElementById("sample6_extraAddress").value;
			document.getElementById("result4").value = document
					.getElementById("sample6_detailAddress").value;
			document.getElementById("recive").value = document
					.getElementById("recive0").value;
			document.getElementById("phone").value = document
					.getElementById("phone0").value;
			document.getElementById("email").value = document
					.getElementById("email0").value;
			document.getElementById("modifyAd").disabled = true;

		} else {
			document.getElementById("result1").value = "";
			document.getElementById("result2").value = "";
			document.getElementById("result3").value = "";
			document.getElementById("result4").value = "";
			document.getElementById("modifyAd").disabled = false;

		}
	}
	function point(t) {
		
		
		if (t.checked) {
			document.getElementById("text_point").value =${m_dto.point};
			var total=${price*count*(100-dto.p_discount_ratio)/100+2500-m_dto.point};
			var val = comma(uncomma(${m_dto.point}));
			total = comma(uncomma(total));
			$("#welcome").text("₩"+val+"원");
			$("#total").text("₩"+total+"원");
		} else {
			document.getElementById("text_point").value = "";
			var total=${price*count*(100-dto.p_discount_ratio)/100+2500};
			var val = comma(uncomma(${m_dto.point}));
			total = comma(uncomma(total));
			$("#welcome").text("₩"+0+"원");
			$("#total").text("₩"+total+"원");
		}
	}

	function checkValue() {
		if (!purchaseForm.newaddress1.value) {
			alert("주소를 입력해주세요.");
			return false;
		}
		if (!purchaseForm.newaddress2.value) {
			alert("주소를 입력해주세요.");
			return false;
		}
		if (!purchaseForm.newaddress3.value) {
			alert("상세주소를 입력해주세요.");
			return false;
		}
		if (!purchaseForm.newaddress4.value) {
			alert("상세주소를 입력해주세요.");
			return false;
		}
		if (!purchaseForm.recive.value) {
			alert("수령인 성함을 입력해주세요.");
			return false;
		}
		if (!purchaseForm.phone.value) {
			alert("핸드폰 번호를 입력해주세요.");
			return false;
		}
		if (!purchaseForm.email.value) {
			alert("이메일을 입력해주세요.");
			return false;
		}
		var radiocheck = $('input:radio[name=purchase]').is(':checked');
		var radiocheck2 = $('input[name=purchase]:checked').val();
		var radiocheck3 = $("#Card option:selected").val();
		if (radiocheck == false) {
			alert("결제방식을 선택해주세요.");
			return false;
		}
		if (radiocheck2 == "card") {
			if (radiocheck3 == "none") {
				alert("카드사를 선택해주세요.");
				return false;
			}
		}
		var infocheck = $('input[name=infocheck]:checked').is(':checked');
		if(infocheck==false){
			alert("결제진행필수동의에 체크해주세요.");
			return false;
			}
		
	}
	function goFirstForm(){
		var p_num=$('#p_num').val();
		location.href = "Product_detail?p_number="+p_num;
		}
	function modal() {
        $('#myModal').show();
	};

	function close_pop(flag) {
     $('#myModal').hide();
	};

	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	 
	//콤마풀기
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	function go(val){
		var point = ${m_dto.point};
		if(val>point){
			alert("보유 포인트를 초과할수없습니다.");
			document.getElementById("text_point").value = 0;
			return false;
			}
		var total=${price*count*(100-dto.p_discount_ratio)/100+2500}-val;
		val = comma(uncomma(val));
		total = comma(uncomma(total));
		$("#welcome").text("₩"+val+"원");
		$("#total").text("₩"+total+"원");
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
				<strong>주문서</strong>
			</h2>
			<hr>
			<form id="purchaseForm" action="purchaseAction" method="post"
				onsubmit="return checkValue()">
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
							<td><img src="${dto.p_filename}" ></td>
							<td>${dto.p_title}</td>
							<td>${count}개</td>
							<td><fmt:formatNumber value="${price*count}" type="currency" />원</td>
						</tr>
					</tbody>
				</table>
				<div style="height: 250px;">
					<br>
					<h3>
						<strong>주문자 정보</strong>
					</h3>

					<table class="table"
						style="width: 400px; float: left;">
						<tr>
							<th>보내는 분*</th>
							<td><input type="text" name="recive0" value="${m_dto.name}" id="recive0" ></td>
						</tr>
						<tr>
							<th>휴대폰*</th>
							<td><input type="text" name="phone0" value="${m_dto.phone}" id="phone0"></td>
						</tr>
						<tr>
							<th style="padding-bottom: 17px;">이메일*</th>
							<td><input type="text" name="email0" id="email0"
								value="${m_dto.mail1}@${m_dto.mail2}"></td>
						</tr>
					</table>
					<table style="width: 400px; float: right;">
						<tr>
							<td><input type="text" class="form-control"
								id="sample6_postcode" name="address1" value="${m_dto.address1}"
								disabled></td>
							<td><input type="button"
								class="form-control searchpostnum btn-outline-primary btset"
								onclick="execDaumPostcode()" value="배송지 변경" style="background-color:#D4B886; color:black; border:1px solid #D4B886;" disabled>
							</td>
						</tr>
						<tr>
							<td colspan="2"><input type="text"
								class="form-control address" id="sample6_address"
								name="address2" value="${m_dto.address2}" disabled></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" class="form-control etc"
								id="sample6_extraAddress" value="${m_dto.address3}" disabled>
							</td>
						</tr>
						<tr>
							<td colspan="2"><input type="text"
								class="form-control address_long" id="sample6_detailAddress"
								name="address3" value="${m_dto.address4}" disabled></td>
						</tr>
					</table>
					<br>
				</div>

				<h3>
					<strong>수령자 정보</strong>
				</h3>
				<span>기본 배송지</span> <span> <input type="checkbox"
					id="sameAddress" name="sameAddress" onclick="check(this)" /></span>
				<hr>

				<table class="table "
					style="width: 400px; float: left;">
					<tr>
						<th>수령인*</th>
						<td><input type="text" name="recive" id="recive" ></td>
					</tr>
					<tr>
						<th>휴대폰*</th>
						<td><input type="text" name="phone" id="phone"></td>
					</tr>
					<tr>
						<th style="padding-bottom: 17px;">이메일*</th>
						<td><input type="text" name="email" id="email"></td>
					</tr>
				</table>
				<table style="width: 400px; float: right;">
					<tr>
						<td><input type="text" class="form-control" id="result1"
							name="newaddress1" placeholder="우편번호" readonly></td>
						<td><input type="button"
							class="form-control searchpostnum btn-outline-primary"
							id="modifyAd" onclick="execDaumPostcode()" value="배송지 변경" style="background-color:#D4B886; color:black; border:1px solid #D4B886;">
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="text"
							class="form-control address" id="result2" name="newaddress2"
							placeholder="주소" readonly></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" class="form-control etc"
							id="result3" name="newaddress3" placeholder="참고항목"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="text"
							class="form-control address_long" id="result4" name="newaddress4"
							placeholder="상세주소"></td>
					</tr>
				</table>
				<table style="width:800px;">
				<tr>
				<th>요청사항</th>
				
				</tr>
				<tr>
				<td><textarea style="width:800px; height:100px;"rows="2" placeholder="요청사항을 입력해주세요." name="memo"></textarea></td>
				</tr>
				</table>
				<br>

				<div>
					<h3 >
						<strong>적립금</strong>
					</h3>
					<hr>
					<table class="table">
						<tr>
							<td>적립금 사용</td>
							<td><input type="text" id="text_point" name="downpoint" value=0 onkeyup="go(this.value)"></td>
							<td><input type="checkbox" onclick="point(this)">모두
								사용</td>
						</tr>
						<tr>
							<td></td>
							<td><h6>보유 적립금 : ${m_dto.point} 원</h6></td>
							<td></td>
						</tr>
					</table>
				</div>

				<br>
				<div style="width:400px; float:left;">
				<h3>
					<strong>결제 수단</strong>
				</h3>
				<hr>
				<label><input type="radio" name="purchase" value="card"
					id="card" onclick="setDisplay('1')"> 신용카드</label><br>
				<div id="cardDiv" style="display: none">

					<select name="Card" id="Card">
						<option value="none">카드를 선택해주세요</option>
						<option value="국민">KB국민</option>
						<option value="현대">현대</option>
						<option value="신한">신한</option>
						<option value="BC">비씨</option>
						<option value="삼성">삼성</option>
						<option value="롯데">롯데</option>
						<option value="우리">우리</option>
					</select>

					<p class="cardPurchaseDetail">
						- 무이자할부 유의사항은 은행계열/체크/기프트/선불/법인/개인사업자 기업카드는 제외<br> - 우리카드 6만원
						이상 결제 시 5천원 즉시할인, 10/28 0시 ~ 11/04 24시, 기간 내 1회, 선착순<br> -
						신한카드 6만원 이상 결제 시 3천원 즉시할인, 11/01 0시 ~ 11/03 24시, 기간 내 1회, 선착순
					</p>
				</div>
				
				<label><input type="radio" name="purchase" value="toss"
					onclick="setDisplay('0')"> 토스결제</label><img
					src="image/purcaseimage/toss.PNG"><br> <label><input
					type="radio" name="purchase" value="naver"
					onclick="setDisplay('0')"> 네이버페이 결제</label><img
					src="image/purcaseimage/naver.PNG"><br> <label><input
					type="radio" name="purchase" value="payco"
					onclick="setDisplay('0')"> 페이코 결제</label><img
					src="image/purcaseimage/payco.PNG"><br> <label><input
					type="radio" name="purchase" value="phone"
					onclick="setDisplay('0')" onclick="setDisplay2('1')"> 휴대폰
					결제</label><br> <br>
					
					</div>
					
					<div class="recipe" >
				<h3>
					<strong>결제 금액</strong>
				</h3>
				
				<table style="height:250px;">
				<tr>
				<th class="recipeth">주문 금액</th>
				<td class="recipetd"> <fmt:formatNumber value="${price*count*(100-dto.p_discount_ratio)/100}" type="currency" />원</td>
				</tr>
				<tr>
				<th class="recipeth inrecipe" >└상품 금액</th>
				<td class="recipetd" style="font-size:13px;"><fmt:formatNumber value="${price*count}" type="currency" />원</td>
				</tr>
				<tr>
				<th class="recipeth inrecipe" >└상품 할인</th>
				<td class="recipetd" style="font-size:13px;"><fmt:formatNumber value="${(price*count)-(price*count*(100-dto.p_discount_ratio)/100)}" type="currency" />원</td>
				</tr>
				<tr>
				<th class="recipeth">배송비</th>
				<td class="recipetd"> ₩2,500원</td>
				</tr>
				<tr>
				<th class="recipeth">적립금 사용</th>
				<td class="recipetd" id="welcome"> 원</td>
				</tr>
				<tr>
				<td colspan="2" style="border-bottom:1px solid #ccc"></td>
				</tr>
				<tr>
				<th class="recipeth">최종 결제 금액</th>
				<td class="recipetd" id="total"><fmt:formatNumber value="${price*count*(100-dto.p_discount_ratio)/100+2500}" type="currency" />원</td>
				</tr>
				<tr>
				<th colspan="2" style="font-size:12px; text-align:right;">구매시 적립 금액 <fmt:formatNumber value="${price*count/(100/3)}" type="currency" />원</th>
				</tr>
				</table>
				
				</div>
					<div style="float:left; width:100%;">
				<h3>
					<strong>개인정보 수집/ 제공 *</strong>
					
				</h3>
				<hr>
				<table class="table table-striped">
					<tr>
						<td><input type="checkbox" name="infocheck" id="infocheck"></td>
						<td><h6>결제 진행 필수 동의</h6></td>
						<td>
							<p class="personalInfo">개인정보 수집/ 이용 및 위탁 동의</p> <a
							class="agreecheck personalInfo" data-toggle="collapse"
							href="#collapseExample" role="button" aria-expanded="false"
							aria-controls="collapseExample"> 약관 확인 </a>
							<div class="collapse" id="collapseExample">
								<div class="card card-body">
									<button type="button" class="personalInfo" id="personal1" onclick="modal();" style="background-color:white; border:0px;">개인정보수집 이용 및 위탁동의</button>
									<button type="button" class="personalInfo" id="personal1" onclick="modal();" style="background-color:white; border:0px;">결제대행 서비스 약관 동의</button>
								</div>
							</div>

						</td>
					</tr>
				</table>
				</div>
				<div style="text-align: right; width:400px; float:left;">
					<input type="hidden" value="${count}" name="count" />
					<input type="hidden" value="${dto.p_writer}" name="p_writer" />
					<input type="hidden" value="${price*count/(100/3)}" name="uppoint" />
					<input type="hidden" value="${dto.p_number}" name="p_num" id="p_num"/>
					<input type="hidden" value="${price}" name="price" />
					<input type="hidden" value="${dto.p_filename}" name="p_filename" />
					<input type="hidden" value="${dto.p_title}" name="p_title" />
					<input type="hidden" value="${m_dto.id}" name="memberId" />
					<input type="submit" class="btn btn-danger" value="결제하기">
					</div>
					</form>
					<div style="text-align: left; width:400px; float:right; ">
					<button style="margin-left:5px;" class="btn btn-danger" onclick="goFirstForm()">주문취소</button>
				</div>
		</div>

	</div>
	
 <!-- The Modal -->
    <div id="myModal" class="modal">
 		
      <!-- Modal content -->
      <div class="modal-content">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">개인정보 수집에 대한 동의

</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><br />
                읽힘은 고객님께서 개인정보처리방침 또는 이용약관의 내용에 동의한다 또는 동의하지 않는다 버튼을 클릭할 수 있는 절차를 마련하고 있으며, 동의한다 버튼을 클릭하면 개인정보 수집 에 동의한 것으로 봅니다. 개인정보의 수집 및 이용 목적읽힘은 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다. 읽힘이 수집하는 개인정보는 다음과 같습니다.회원 관리	회원제 서비스 이용에 따른 회원식별불량회원의 부정이용 방지와 비인가 사용 방지, 중복가입방지가입의사 확인, 가입 및 가입횟수 제한고객상담, 고객불만 접수 및 처리, 분쟁조정을 위한 기록보존고지사항 전달서비스 제공에 관한 계약의 이행 및 서비스 제공에 따른 요금정산	서비스 및 콘텐츠 제공물품배송 또는 청구서 등 발송구매 및 요금 결제요금추심마케팅 및 광고에 활용	고객에게 최적화된 서비스 제공신규 서비스(제품) 개발 및 특화웹페이지 접속 빈도 파악상품/서비스의 이용실적 분석정기 간행물 발송, 새로운 상품 또는 서비스 안내고객 관심사에 부합하는 웹서비스 및 이벤트 기획경품행사, 이벤트 등 광고성 정보 전달 또는 회원 참여공간 운영고객대상 설문조사서비스 및 상품 안내
</p>
                <p><br /></p>
            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                     닫기
                </span>
            </div>
      </div>
 
    </div>
        <!--End Modal-->

	<!-- 메인푸터 -->
	<jsp:include page="/WEB-INF/views/MainFooter.jsp" />

</body>
</html>