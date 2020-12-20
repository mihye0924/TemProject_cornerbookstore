<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품관리 화면</title>
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
	function DeleteConfirm(){
		if(confirm("상품을 삭제하시겠습니까?")==true){
			window.location.href="DeleteProduct?idx="+$("#idx").val();
			}else { return false; }
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
        <h2>상품 목록</h2>
        <hr>
        <form action="SearchProduct" onsubmit="return checkValue()">
        
        <select name="check_category">
	        <option value="p_writer">작가</option>
	        <option value="p_title">상품명</option>
        </select>
        <input id="check_hidden" type="hidden" name="check_hidden"  value="no" />
        <input type ="text" name="searchName" placeholder="상품명을 입력하세요.">
        <button type="submit" class="btn btn-sm btn-danger">검색</button>
        </form>
          <table id="member_list"  class="table table-striped">
		   <tr>
		   <th scope="col">상품번호</th><th scope="col">이미지</th><th scope="col">분류1</th><th scope="col">분류2</th><th scope="col">도서명</th><th scope="col">작가</th><th scope="col">판매가</th><th scope="col"></th>
		   </tr>
		   
		   <c:forEach var="list" items="${ list }">
		    <tr>
		     <input type="hidden" id="idx" value="${list.idx}"> 
		     <td>${ list.p_number } </td>
		     <td><img src="${list.p_filename}" width=70px; height=90px;></td>
		     <td>${ list.p_category }</td>
		     <td>${ list.p_category2 }</td>
		     <td><a href="ProductDetail?p_number=${list.p_number}">${ list.p_title }</td>
		     <td>${ list.p_writer }</td>
		     <td>${ list.p_price}</td>
		     <td><button class="btn btn-sm btn-danger" style="color: white;" onclick="DeleteConfirm()"
		     style="font-size: 1.6ch;">삭제
		     	  </button>
		     </td>
		     
		    </tr>
		    </c:forEach>
		   	 
		   </table>
		   
			   <nav aria-label="Page navigation example">
			   <ul class="pagination justify-content-center">
			    <%
			    int allPageNum=(Integer)request.getAttribute("allPageNum");
			    for(int i=1; i<=allPageNum; i++){
   		    	   %>
			     <li class="page-item"><a href="page?no=<%=i%>" class="page-link"><%=i%></a></li>
			       <%
			     }
			    %>    
			  </ul> 
			</nav>  
		    <button class="btn btn-danger"><a href="UploadProduct" style="color: white; text-decoration:none;">상품등록</a></button>   
	</div>

  </div>  <!-- AdminWrapper2 -->
  </div>  <!-- AdminWrapper1 -->
 <script src="js/jquery-2.2.4.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
 
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
</body>
</html>