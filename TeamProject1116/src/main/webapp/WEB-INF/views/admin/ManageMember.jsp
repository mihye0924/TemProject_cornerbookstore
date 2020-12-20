<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!-- 1123수정 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원관리 화면</title>
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
    
    .table-striped th, .table-striped td{
		font-size:1.4ch;
		overflow:hidden;
		text-overflow:ellipsis; 
		white-space:nowrap;
	}
	/* The Modal (background) */
    .modal {
	     display: none; /* Hidden by default */
	     position: fixed; /* Stay in place */
	     z-index: 1; /* Sit on top */
	     left: 0;
	     top: 0;
	     width: 300px; 
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
         width: 300px !important;/* Could be more or less, depending on screen size */                          
     }
     .searchcon input{
     width:75px;
     }
	</style>
	<script>
	function modal() {
		if($('input:checkbox[id="memberid"]').is(":checked")==false){
			alert("마일리지 관리하실 회원을 체크해주세요");
			 return false;
			}
        $('#myModal').show();
	};
	function close_pop() {
	     $('#myModal').hide();
	};

	 

	function goDelete() {
		var delchk =[];
		$('.chk:checked').each(function(){
			delchk.push($(this).val());
			});
		if($('input:checkbox[id="memberid"]').is(":checked")==false){
			alert("삭제하실 회원을 체크해주세요");
			 return false;
			}
		if(confirm("정말 삭제하시겠습니까??") == true){
			location.href="AdminDeleteAction?deleteid="+delchk;
			}			
	};
	
	function goAction(){
		var delchk =[];
		$('.chk:checked').each(function(){
			delchk.push($(this).val());
			});
		var uppoint=$('#uppoint').val();
		var downpoint=$('#downpoint').val();
		$.ajax({
			url  : "/upPointAction",
			type : "post",
			dataType : "json",
			traditional:true,
			data : {
				"memberid" : delchk ,
				"uppoint" : uppoint ,
				"downpoint" : downpoint
				},
				success : function(Data){
				alert("완료!");
				},
				error : function(request,status,error){
				console.log("AJAX_ERROR");
					},
				complete : function(){
				alert("적립 성공");
				$('#myModal').hide();
					}
			});
		}

	 function checkValue()
		{
		 if(document.memberSearch.keyword1.value!=""){
			 if(document.memberSearch.keyword2.value==""){
				alert("종료일을 입력해주세요.");
				 return false;
				 }	
			}
		 if(document.memberSearch.keyword2.value!=""){
			 if(document.memberSearch.keyword1.value==""){
				alert("시작일을 입력해주세요.");
				 return false;
				 }	
			}
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
				<table style="width: 150px;" cellpadding="10px" cellspaing="10px">
				<p>회원관리</p>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageMember">회원 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
						    <a href="WithdrawMember">탈퇴 목록</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
						    <div class="sidebarlist">
							<a href="ManageOrder">주문 관리</a>
							<span href="#">&gt</span>
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
		   <h2>회원 목록</h2>
		   <hr>
		   <form action="MemberSearch" onsubmit="return checkValue()" name="memberSearch">
		   	<div class="searchcon">
			   <table class="membersearch">
				   <tr>
				   	<th>가입일</th><td><input type="date" style="width:130px;" name="keyword1">~</td><td><input type="date" style="width:130px;" name="keyword2"></td>
				   	<th>아이디</th><td><input type="text" name="keyword3"></td>
				   	<th>이름</th><td><input type="text" name="keyword4"></td>
				   	<th><button type="submit" >검색</button></th>
				   </tr>   
			   </table>   
			</div>
		   </form>
		   <br>
		   
		   <table id="member_list"  class="table table-striped">
		   <tr>
		   <th style="width:80px !important;" scope="col">선택</th><th scope="col">가입일</th><th scope="col">아이디</th><th scope="col">이름</th><th scope="col">휴대폰</th><th scope="col">주소</th><th scope="col">이메일</th> 
		   </tr>
		   <c:forEach items="${ list }" var="dto" >
		   <fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd" />
		   <tr>
		   <td><input type="checkbox" id="memberid" class="chk" name="pointcheck" value="${dto.id}"/></td><td>${reg}</td><td id="id">${dto.id}</td><td>${dto.name}</td><td>${dto.phone}</td>
		   <td >${dto.address1} ${dto.address2} <br>${dto.address3} ${dto.address4}</td><td>${dto.mail1}@${dto.mail2}</td>
		   </tr>
		   </c:forEach>
		   </table>
		   
	         <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page3?no=<%=i%>" class="page-link"><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav>  
				   
		    <button onclick="goDelete();" class="btn btn-sm btn-danger">회원 탈퇴</button>
		    <button onclick="modal();" class="btn btn-sm btn-danger">마일리지 관리</button>
		     
		    </section>
		 </div>
		 
	   </div>  <!-- AdminWrapper2 -->
	   </div>  <!-- AdminWrapper1 -->
	   <!-- 메인컨텐츠 -->
	   
	   <!-- The Modal -->
    <div id="myModal" class="modal">
 		
      <!-- Modal content -->
      <div class="modal-content">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">마일리지 

		</span></b></span></p>
			<table style="text-align: center; line-height: 1.5;">
                <tr>
                <th>적립할 마일리지</th><th>차감할 마일리지</th>
                </tr>
                <tr>
                <td><input type="text" id="uppoint" name="uppoint" value=0 style="width:50px;"></td>
                <td><input type="text" id="downpoint" name="downpoint" value=0 style="width:50px;"></td>
				</tr>
			</table>
                <p><br /></p>
                <div>
                
           		<button type="submit" style="width:50px; float:left; margin-left:70px;" onClick="goAction();"><span class="pop_bt" style="font-size: 13pt;" >
                     적립
                </span></button>
                <button type="button" style="width:50px; margin-left:20px; " onClick="close_pop();"><span class="pop_bt" style="font-size: 13pt;" >
                     닫기
                </span></button>
           		</div>
      </div>
    </div>
        <!--End Modal-->
        
        
        
        
  <script src="js/jquery-2.2.4.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  
  <jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
    
</body>
</html>