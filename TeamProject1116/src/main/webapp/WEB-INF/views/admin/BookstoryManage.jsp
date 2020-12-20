<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.study.springboot.dto.MemberDto" %>
<%@ page import="java.util.List"%>
 <!-- 1123수정 -->
 <%
 MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");   
 %>
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>북스토리 회원관리</title>
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
		   <form action="Rankstate" method="post" >
		   <input type="hidden"	value="${dto.idx}">
	       <div style="width:200px; float:right;">
	       <span>	<select style="height:26px;"class="tbox" name="ContentAndReplyCount" onchange="formChange(this.form)">
	         	<option value="0" selected>게시글,댓글 수</option>
				<option value="20" >20개</option>
				<option value="40" >40개</option>
				<option value="60" >60개</option>
				<option value="80">80개</option>
				<option value="100">100개</option>
				</select></span>
	       </div>   
	       </form>
	       
	       
		   
		  <form action="updateRankAction" method="post" > 
		   <table id="member_list"  class="table table-striped">
		   <tr>
		   <th scope="col" style="width:120px;">모두 선택<input type="checkbox" name="allCheck" id="allCheck" onclick="checkAll();" style="position:relative; left:5px; top:2px;" />
		   <th scope="col">가입일</th>
		   <th scope="col">아이디</th>
		   <th scope="col">이름</th>
		   <th scope="col">휴대폰</th>
		   <th scope="col">게시글 수</th>
		   <th scope="col">댓글 수</th> 
		   <th scope="col">등급</th> 
		   </tr>
		   
		  
		   <c:forEach items="${ list }" var="dto" >
		   <fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd" />
		   <tr>
		   <td>
		   <input type="checkbox" id="chBox" name="chBox" class="chBox" value="${dto.id}"/></td>
		   <td>${reg}</td>
		   <td id="id">${dto.id}</td>
		   <td>${dto.name}</td>
		   <td>${dto.phone}</td>
		   <td>${dto.content_count}</td>
		   <td>${dto.reply_count}</td>
		   <td>${dto.rank}</td>
		   </tr>
		   </c:forEach>
		   </table>
		   
		   <div class="input-group choose-product"> 
            <div class="select-box-type"> 
            <select class="custom-select" id="rank" name="rank">
            <option selected value="한자루">한자루</option>
            <option value="두자루">두자루</option>
            <option value="세자루">세자루</option>
            <option value="네자루">네자루</option>
            <option value="다섯자루">다섯자루</option> 
            </select> 
            </div>
			  
	      <input type="submit" class="btn btn-sm btn-danger" value="등급관리">
		    </div>
		  </form> 
		
		    
		   </section>
		   
		    
    		
		 	
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