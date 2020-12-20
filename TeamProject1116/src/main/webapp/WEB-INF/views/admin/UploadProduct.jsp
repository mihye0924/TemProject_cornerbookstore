<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    textarea{
    height: 200px;
    resize: none;
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
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	function numCheck(){
		var p_number = $( '#p_number' ).val();
		if(!p_number){
			alert('상품번호를 입력하세요.');
			return false;
			}

		$.ajax({
			url : 'http://localhost:8081/Product_num_Check?p_number='+ p_number,
			type : 'get',
			success : function(data) {
				console.log("1 = 중복됨, 0 = 중복안됨 :"+data);

				if(data == 1){
					alert("상품번호가 중복됩니다.");
					$('#check_hidden').val("no");
					} else {
					alert("상품번호를 사용할 수 있습니다.");
					$('#check_hidden').val("yes");
					}
				}, error : function(){
					console.log("실패");
				}
			});
		}
</script>


</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<!-- 헤더부분 -->
    <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	

	   <!-- 왼쪽 사이드 메뉴바 시작 -->
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>상품관리</p>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageProduct">상품 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="UploadProduct">상품 등록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="ProductQnA">상품 문의</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
		
      
     <div class="contents">
		<form name="productInfo" action="UploadProductAction" method="post" enctype="multipart/form-data"  
		onsubmit="return checkValue()"> 
		<h2>상품 등록</h2>
		<hr>
				<table class="table table-striped">
			  <tbody>
			    <tr>
			      <th scope="row">상품번호</th>
			      <td><input name="p_number" id="p_number" type="text" placeholder="ex) 20201030" style="width: 250px;">
			      <input type="button" class="btn btn-sm btn-danger" id="num_check" value="중복확인" onclick="numCheck()">
			      <input id="check_hidden" type="hidden" value="no"/>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">상품명</th>
			      <td><input name="p_title" type="text" placeholder="ex) 삼국지(상)" style="width: 250px;"></td>
			    </tr>
			     <tr>
			      <th scope="row">작가명</th>
			      <td><input name="p_writer" type="text" placeholder="ex) 홍길동"></td>
			    </tr>
			    <tr>
			      <th scope="row">판매가</th>
			      <td>
					<input name="p_price" id="p_price" type="text" placeholder="ex) 1000" onchange="cal_point()">원
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">할인율</th>
						<td>
							<select name="p_discount_ratio" id="discount_rate" onchange="cal_price()" >
								<option value="0">없음</option>
								<option value="5">5%</option>
								<option value="10">10%</option>
								<option value="15">15%</option>
								<option value="20">20%</option>
								<option value="30">30%</option>
							</select>
							할인가 : 총<span id="discountprice"></span>원
						</td>
			    </tr>
			    <tr>
			      <th scope="row">포인트 (판매가 x 3%)</th>
				  <td>적립금 : 총<span id="point"></span>원</td>
			    </tr>
			    <tr>
			      <th scope="row">카테고리1</th>
						<td>
							<select name="p_category">
								<option value="소설">소설</option>
								<option value="경제/경영">경제/경영</option>
								<option value="시/에세이">시/에세이</option>
								<option value="인문학">인문학</option>
								<option value="예술">예술</option>
								<option value="자기계발">자기계발</option>
								<option value="독립서적">독립서적</option>
								<option value="음반">음반</option>
							</select>
						</td>
			    </tr>
			        <tr>
			      <th scope="row">카테고리2</th>
						<td>
							<select name="p_category2">
								<option value="일반">일반도서</option>
								<option value="인기">인기도서</option>
								<option value="신간">신간도서</option>
								<option value="추천">추천도서</option>
							</select>
						</td>
			    </tr>
			     <tr>
			      <th scope="row">배송비</th>
				 <td>
						<select name="p_post">
								<option value="free">무료배송</option>
								<option value="basic">일반배송</option>
							</select>
						</td>
			    </tr>
			    <tr>
			      <th scope="row">재고수량</th>
				  <td><input name="p_stock" type="number"></td>
			    </tr>
			    <tr>
			      <th scope="row">상품 설명</th>
				  <td>
					<textarea name="p_content" placehold="상품 상세정보를 입력해주세요." cols="70" row="100"></textarea>
				  </td>
			    </tr>
			    <tr>
			     <th scope="row">상품 표지 이미지 등록</th>
			     <td><input type="file" name="p_filename"></td>
			    </tr>
			    <tr>
			     <th scope="row">상품 소개 이미지 등록</th>
			     <td><input type="file" name="p_filename2"></td>
			    </tr>
			  </tbody>
			</table>
		<button type="submit" class="btn btn-sm btn-danger" >상품 등록</button>
		<button class="btn btn-sm btn-danger" ><a href="ManageProduct" style="text-decoration:none; color:white;">목록으로</a></button>
		</form>      
     </div> 
   
    </div>  <!-- AdminWrapper2 -->
	</div>  <!-- AdminWrapper1 -->
 <script src="js/jquery-2.2.4.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
// 할인율에 따른 가격 계산
function cal_price(){
	if(document.getElementById('discount_rate').value=='0'){
	var total_price= document.getElementById('p_price').value;
	document.getElementById('discountprice').innerHTML=total_price;
	}else {	
	var discount_rate = (document.getElementById('discount_rate').value) / 100;
	var p_price= document.getElementById('p_price').value;
	var total_price = p_price - discount_rate * p_price;
	document.getElementById('discountprice').innerHTML=total_price;
  }
}
// 마일리지 계산
function cal_point(){
	var p_price= document.getElementById('p_price').value;
	var point_rate=0.03;
	var total_point=p_price*point_rate;
	document.getElementById('point').innerHTML=total_point;	
}

function checkValue(){
	var proInfo=document.productInfo;
	var p_number=proInfo.p_number.value;
	var p_title=proInfo.p_title.value;
	var p_writer=proInfo.p_writer.value;
	var p_price=proInfo.p_price.value;
	var p_stock=proInfo.p_stock.value;
	var p_content=proInfo.p_content.value;
	var p_filename=proInfo.p_filename.value;
	var p_filename2=proInfo.p_filename2.value;
	var num_check = $('#check_hidden').val();
	
    if(num_check != "yes"){
		alert('상품번호 중복확인을 해주세요.'); 
		return false;}
    else if(!p_number){
    	alert('상품번호를 입력해주세요.'); 
		productInfo.p_number.focus();
		return false;}
	else  if(!p_title){
		alert('상품명을 입력해주세요.'); 
		productInfo.p_title.focus();
		return false;}
	else if(!p_writer){
		alert('작가명을 입력해주세요.'); 
		productInfo.p_writer.focus();
		return false;}
	else if(!p_price){
		alert('판매가를 입력해주세요.'); 
		productInfo.p_price.focus();
		return false;}
	else if(!p_stock){
		alert('재고를 입력해주세요.'); 
		productInfo.p_stock.focus();
		return false;}
	else if(!p_content){
		alert('내용을 입력해주세요.'); 
		productInfo.p_content.focus();
		return false;}
	else if(!p_filename){
		alert('메인 이미지를 등록해주세요.'); 
		productInfo.p_filename.focus();
		return false;}
	else if(!p_filename2){
		alert('소개 이미지를 등록해주세요.'); 
		productInfo.p_filename2.focus();
		return false;}	
} 

</script>
</body>

</html>
















