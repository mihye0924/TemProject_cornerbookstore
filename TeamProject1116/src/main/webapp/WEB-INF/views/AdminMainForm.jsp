<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>관리자 메인 화면</title>
	
	<style>
	/* 사이드바 메인컨텐츠 기본양식 시작 */
 	.AdminWrapper1{
	width: 100%;
	text-align:center; 
	min-width:1200px;
	}
	 .AdminWrapper2{
	max-width:1200px;
	display: inline-block;  
	margin-top:250px;
	}  
 	.sidebar2, .Todaycontents{
	display: inline-block;
	}
	.sidebar2>p{
    font-size: 30px;
    font-weight: 900; 
    }  
    table tr td >a{
    text-decoration:none;
    color: rgb(40, 40, 40);
    }
	th, td {
	    font-size: 1.4ch;
	}
	.Today_list {
  border-spacing: 5px;
  border-collapse: separate;
}
.todaytable{
	height:20px;
	border : 1px solid #ccc;
	padding : 0 !important;
}
.box{
 border-left : 1px solid #ccc;
}
.box2{
width:500px;
margin-top: 20px;
display: inline-block;
}
.box3{

}
.boardtable{
padding: 5px !important;
}
.txt_line {
      width:70px;
      padding:0 5px;
      overflow:hidden;
      text-overflow:ellipsis;
      white-space:nowrap;
  }
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	</style>
	<script type="text/javascript">
    function goForm(value) {
	if(value==1){
    		location.href = "MyInfo";
	}else{
		location.href = "LogOut";
		}
	}	
	</script>
	</head>
<body>
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
  <!-- 메인컨텐츠 -->
  
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	<div class="sidebar2 box" style="width:200px;">
				<p><%= session.getAttribute("sessionID") %>님.<p>
				
				<table style="width: 200px;">
				<tr>
				<th colspan="2"><input type="text"  style=" float: right;" id="text_Date" name="text_Date" size = "10" disabled></th>
				</tr>
				<tr>
				<th scope="col" ><button style="width:100px;" onclick="goForm(1)">내정보</button> </th>
				<th scope="col" ><button style="width:100px;" onclick="goForm(2)">로그아웃</button> </th>
				</tr>
				</table>
	    </div>
	<div class="Todaycontents box" style="height:180px;">
		<h4>Today현황</h4>
		<table id="Today_list1" class="table table-striped Today_list" style="width:400px;" >
		<tr>
			<th class="todaytable" scope="col" >회원가입 수</th>
			<th class="todaytable" scope="col" >탈퇴회원 수</th>
		</tr>
		<tr>
			<td class="todaytable"><a href="ManageMember" style="font-size: 20px;">${check}</a></td>
			<td class="todaytable"><a href="WithdrawMember" style="font-size: 20px;">${check4}</a></td>
		</tr>
		<tr>
			<th scope="col" class="todaytable">상품등록 수</th>
			<th scope="col" class="todaytable">상품주문 수</th>
		</tr>
		<tr>
			<td class="todaytable"><a href="ManageProduct" style="font-size: 20px;">${check2}</a></td>
			<td class="todaytable"><a href="ManageOrder" style="font-size: 20px;">${check3}</a></td>
		</tr>
		</table>
	</div>
	<div class="Todaycontents box" style="height:180px;">
	<h4>미처리 항목</h4>
		<table id="Today_list2" class="table table-striped Today_list" style="width:400px;">
		<tr>
			<th class="todaytable" scope="col" >1:1 문의</th>
			<th class="todaytable" scope="col" >교환/환불신청</th>
			
		</tr>
		<tr>
			<td class="todaytable"><a a href="OnetoOneBoard_A" style="font-size: 20px;">${check6}</a></td>
			<td class="todaytable"><a a href="OnetoOneBoard_A" style="font-size: 20px;">${check7}</a></td>
		</tr>
		<tr>
			<th scope="col" class="todaytable">상품문의</th>
		</tr>
		<tr>
			<td class="todaytable"><a a href="ProductQnA" style="font-size: 20px;">${check5}</a></td>
			
			
		</tr>
		</table>
		</div>
		<div class="box2">
	<h4 style="width:500px;">최근후기</h4>
		<table id="Today_list3" class="table table-striped txt_line" style=" table-layout: fixed; max-width:500px !important;">
		<tr>
			<th class="boardtable" scope="col" style="max-width: 100px !important;">도서명</th>
			<th class="boardtable" scope="col" style="max-width:200px;">제목</th>
			<th class="boardtable" scope="col" style="max-width:100px;">일자</th>
			
		</tr>
		<c:forEach items="${ list2 }" var="dto2" end="5" >
		<fmt:formatDate value="${dto2.reg}" var="reg2" pattern="yyyy.MM.dd"/>
		<tr>
			<th style="table-layout: fixed; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100px !important;">
			<a href="ProductDetail3?p_number=${dto2.p_number}" style="color:black; ">${dto2.p_title}</a></th>
			<td style="  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px; ">${dto2.description }</td>
			<td>${reg2}</td>
		</tr>
		</c:forEach>
		</table>
	</div>
	<div class="box2">
	<h4 style="width:500px;">최근주문목록</h4>
		<table id="Today_list4" class="table table-striped txt_line" style="width:500px;">
		<tr>
			<th class="boardtable" scope="col" style="width:150px;">도서명</th>
			<th class="boardtable" scope="col" style="width:80px;">금액</th>
			<th class="boardtable" scope="col" style="width:100px;">일자</th>
			<th class="boardtable" scope="col" style="width:70px;">결제내역</th>
		</tr>
		<c:forEach items="${ list }" var="dto" end="5" >
		<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
		<tr>
			<th ><a href="ManageOrder" style="color:black;">${dto.p_title}</a></th>
			<td>${dto.o_total}</td>
			<td>${reg}</td>
			<c:choose>
			<c:when test="${dto.o_state eq '1'}">
			<td>결제 전</td>
			</c:when>
			<c:when test="${dto.o_state ne '1'}">
			<td>결제 완료</td>
			</c:when>
			</c:choose>
		</tr>
		</c:forEach>
		
		</table>
	</div>
	
        </div>
        </div>
        <!-- 푸터 -->
       <jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
       
  <script src="js/jquery-2.2.4.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
   <script>
   var $j = jQuery.noConflict();
   $j(function() {
	    getTimeStamp();
	});
	function getTimeStamp() {
	    var d = new Date();
	    var date = leadingZeros(d.getFullYear(), 4) + '-' +
	        leadingZeros(d.getMonth() + 1, 2) + '-' +
	        leadingZeros(d.getDate(), 2) + ' ';
	    $j('#text_Date').val(date);
	}
	function leadingZeros(n, digits) {
	    var zero = '';
	    n = n.toString();
	    if (n.length < digits) {
	        for (i = 0; i < digits - n.length; i++)
	            zero += '0';
	    }
	    return zero + n;
	}
   </script>
</body>
</html>