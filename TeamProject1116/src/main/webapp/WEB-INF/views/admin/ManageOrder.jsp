<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- 1123수정 -->
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
	<script type="text/javascript">
	function formChange(obj)
	{
		obj.submit(); 
	} 
	</script>
</head>
<body>
<!-- 헤더부분 -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
    <!-- 헤더부분 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">
	
	  <!-- 왼쪽 사이드 메뉴바 시작 -->
       	<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;" cellpadding="10px" cellspaing="10px">
				<p>회원관리</p>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageMember">회원 목록</a>
							<span>&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="WithdrawMember">탈퇴 목록</a>
							<span>&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageOrder">주문 관리</a>
							<span>&gt</span>
							</div>
						</td>
					</tr> 
				</table>
				<table style="margin-top:30px">
					<tr >
						<td>
						    <div class="sidebarlist">
							<a href="BookstoryManage">북스토리목록</a>
							<span>&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
      
      <!-- 오른쪽 컨텐츠 시작 -->	    
		<div class="contents" style="height: 100%;">
		  
		    <section>
		   <h2>주문 목록</h2>
		   <hr>
       <form action="stateAlign" method="POST" >
       <div style="width:200px; float:right;">
       <span>	<select style="height:26px;"class="tbox" name="o_stateview" onchange="formChange(this.form)">
         	<option value="0" selected>배송 상태별 보기</option>
			<option value="1" >주문 확인 중</option>
			<option value="2" >주문 확인</option>
			<option value="3" >배송 준비 중</option>
			<option value="4" >배송 중</option>
			<option value="5">배송 완료</option>
			<option value="6">모두 보기</option>
			</select></span>
       </div>   
       </form>
		   <br>
		     <form action="stateUpdate" method="POST" >
		   <table style="width:800px;"id="order_list"  class="table table-striped">
		   <tr>
		   <th scope="col" style="width:120px;">모두 선택<input type="checkbox" name="allCheck" id="allCheck" onclick="checkAll();" style="position:relative; left:5px; top:2px;" /></th><th scope="col" style="width:80px">번호</th><th scope="col" style="width:120px">주문일자</th><th scope="col" style="width:230px">상품정보</th><th scope="col" style="width:80px">ID</th><th scope="col" style="width:120px">배송상태</th><th scope="col" style="width:100px">비고</th>
		   </tr>
		   <c:forEach items="${ list }" var="dto" >
			<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
		   <tr>
		   <td><input type="checkbox" name="chBox" class="chBox" value="${dto.o_number}" /></td>
		   <td>${dto.o_number}</td>
		   <td>${reg}</td>
		   <td><a href="purchase_check?o_number=${dto.o_number}&p_number=${dto.p_number}">${dto.p_title}</a></td>
		   <td style='overflow:hidden;text-overflow:ellipsis;'>${dto.o_orderid}</td>
		    <c:if test="${dto.o_state == 1}" ><td>주문 확인 중</td></c:if>
			<c:if test="${dto.o_state == 2}"><td>주문 확인</td></c:if>
			<c:if test="${dto.o_state == 3}"><td>배송 준비 중</td></c:if>
			<c:if test="${dto.o_state == 4}"><td>배송 중</td></c:if>
		 	<c:if test="${dto.o_state == 5}"><td>배송 완료</td></c:if>
		   <td style='overflow:hidden;text-overflow:ellipsis;'>${dto.o_memo}</td>
		   </tr>
		   </c:forEach>
		   </table>
		   <div style="float:right;">
		   <select class="tbox" name="o_state2" >
			<option value="1" >주문 확인 중</option>
			<option value="2" >주문 확인</option>
			<option value="3" >배송 준비 중</option>
			<option value="4" >배송 중</option>
			<option value="5">배송 완료</option>
			</select>
		    <button type="submit" class="selectUpdate_btn btn btn-sm btn-danger"  >선택변경</button>
		    </div>
		    </form>
		    
	         <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page2?no=<%=i%>" class="page-link"><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav>     
			
		    </section>
		 </div>
		 
	   </div>  <!-- AdminWrapper2 -->
	   </div>  <!-- AdminWrapper1 -->
	

	
	<script>
	function checkAll(){
	      if( $("#allCheck").is(':checked') ){
	        $("input[name='chBox']").prop("checked", true);
	      }else{
	        $("input[name='chBox']").prop("checked", false);
	      }
	}
		
		</script>
	 
<script src="js/jquery-2.2.4.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
    
    
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
</body>
</html>