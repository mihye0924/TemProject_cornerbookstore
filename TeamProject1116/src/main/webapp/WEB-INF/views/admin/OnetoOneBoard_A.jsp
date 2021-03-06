<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title>1:1문의리스트</title>
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
	#bt{
	 relative : bottom;
	}
	.actionbar{
	width:150px;
	} 
	</style>
   <script>
	function ChangeForm(){
		location.href="NoAnswer";
		}
    function checkValue()
	{
    	if(document.o_search.check_category.value==0){
    		alert("검색유형을 지정해주세요");
    		return false;
        	}
	}
   </script>
</head>
<body>
<!-- 헤더 부분  -->
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<!-- 헤더 부분  -->

 <!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2"> 
	   
	   <!-- 왼쪽 사이드 메뉴바 시작 -->
		<div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>게시판 관리</p>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Notice_board">공지사항</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
						    <a href="OnetoOneBoard_A">1:1문의</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="sidebarlist">
							<a href="Event_board">이벤트</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->
	   
	  <!-- 오른쪽 컨텐츠 시작 -->
	<div class="contents">
	  	<div class="section"> 
	         <div class="head_orderlist"> 
	             <h4>1:1문의게시판</h4> 
	             <hr>    
	                 <div class="form-row align-items-center">
	                 <input type="button" value="답변 없는 문의만 보기" style="width:150px;height:30px;"
	                 onclick="ChangeForm()" />  
						<form class="board_search" method="POST" action="board_search" onsubmit="return checkValue()" name="o_search">
	                     <table style="margin-left:200px;">
	                         <tr>
	                             <td>
	                             <div class="col-auto my-1 search-text-form"> 
	                                 <select class="custom-select mr-sm-2" id="inlineFormCustomSelect" name="check_category">
	                                  
	                                   <option selected value="1">제목</option>
	                                   <option value="2">제목+내용</option>
	                                   <option value="3">작성자</option>
	                              </select>  
	                     		</div> 
	                             </td>
	                             <td>
	                                 <input  name="keyword" class="form-control search-text" type="search-1" placeholder="Search" aria-label="Search">
	                             </td>
	                             <td>
	                                 <button class="btn btn-secondary" type="submit">검색</button> 
	                             </td> 
	                         </tr>  
	                     </table>
	                     </form>
	                 </div>  
	                 <table id="member_list"  class="table table-striped order-list ">
	               <tr class="one-list-title">
	                   <th scope="col" style="width: 8%;" >번호</th>
	                   <th scope="col" style="width: 12%;" >유형</th>
	                   <th scope="col" style="width: 30%;" >제목</th>
	                   <th scope="col" style="width: 10%;" >작성자</th>
	                   <th scope="col"  style="width: 10%;">답변완료</th> 
	                   <th scope="col"  style="width: 10%;">작성일</th> 
	               </tr>
	                <c:forEach var="list" items="${list}" >
	               <tr class="one-list-text">
	               <fmt:formatDate var="reg" value="${list.reg}"  pattern="yyyy.MM.dd"/>
	                   <td>${list.idx}</td>
	                   <td>${list.o_type}</td>
	                   <td> <a href="OnetoOneBoardView_A?idx=${list.idx}"> ${list.o_title}  </a></td>
	                   <td>${list.user_id}</td> 
	                   <!-- 답변상태 -->
	                   <c:set var = "o_ans_check" scope = "session" value ="${list.o_ans_check}"/> 
				      	<c:if test = "${o_ans_check eq '미등록'}">
					 	<td style="color:red;"><c:out value = "${list.o_ans_check}"/> </td> 
				      	</c:if>
			          	<c:if test = "${o_ans_check eq '답변완료'}">
				      	<td style="color:blue;"><c:out value = "${list.o_ans_check}"/> <a href="OnetoOneBoardView_A?idx=${list.idx}"></a></td>
			          	</c:if>
	                   <td>${reg}</td> 
	             
	               </tr> 
	              </c:forEach>
	                    <c:set var = "admin_id" scope = "session" value = "${dto.admin_id}"/>
			        	<c:if test = "${admin_id eq '관리자'}">
			        	</c:if>
                
	             </table>   
	             
		          	<nav aria-label="Page navigation example">
			   		<ul class="pagination justify-content-center">
			    	<%
			    	int allPageNum=(Integer)request.getAttribute("allPageNum");
			    	for(int i=1; i<=allPageNum; i++){
   		    	   	%>
			     	<li class="page-item"><a href="page8?no=<%=i%>" class="page-link"><%=i%></a></li>
			        <%
			     	}
			   	    %>    
			  </ul> 
			</nav>       
	         </div> 
          </div> 
    </div>  
    </div>  <!-- AdminWrapper2 --> 
	</div>  <!-- AdminWrapper1 -->
<!-- 푸터 부분  -->
<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/> 

 <script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>