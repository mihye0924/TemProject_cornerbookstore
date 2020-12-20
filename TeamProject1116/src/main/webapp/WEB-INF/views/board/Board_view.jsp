<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 썸머노트 -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- 썸머노트 -->
<title>게시판리스트</title>
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
    p{
    margin-bottom: 0;
    }
    td{
    content: 50px;
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
    th, td {
	    font-size: 1.4ch !important;
	}
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	</style>
	
    <script type="text/javascript">
    function goFirstForm(value) {
	if(value=="1"){
		location.href = "Notice_board";
	}
	else if(value=="2"){
		location.href = "Question_board";
		}
	else if(value=="3"){
		location.href = "User_Event_board";
		}
	else if(value=="4"){
		location.href = "Event_board";
		}
	}
	
    function checkValue()
	{
    	if(!document.n_write.text_Title.value){
			alert("제목을 입력하세요.");
			return false;
		}
		
		if(!document.n_write.text_Writer.value){
			alert("작성자를 입력하세요.");
			return false;
		}
		if(!document.n_write.text_Content.value){
			alert("본문을 입력해주세요.");
			return false;
		}
		if(document.n_write.n_Category.value==0){
			alert("카테고리를 지정해주세요");
			return false;
		}
	}
	//써머노트
    var $j = jQuery.noConflict();
    $j(document).ready(function() {
    	//여기 아래 부분
    	$j('#summernote').summernote({
    		  height: 400,					// 에디터 높이            
    		  minHeight: null,             // 최소 높이
    		  maxHeight: null,             // 최대 높이
    		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
    		  lang: "ko-KR",					// 한글 설정
    		  placeholder: '최대 2048자까지 쓸 수 있습니다',//placeholder 설정
    		  disableDragAndDrop: true,
    		  toolbar: []	
    	});
    	$j('#summernote').summernote('disable');
    	
    	$j("div.note-editable").on('drop',function(e){
            for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){
            	uploadSummernoteImageFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]);
            }
           e.preventDefault();
      })
    });
   
	/**
	* 이미지 파일 업로드
	*/
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
    </script>
</head>
<body>
<!-- 헤더부분 -->
<%if("admin".equals(session.getAttribute("sessionID"))){  %>
<jsp:include page="/WEB-INF/views/AdminHeader.jsp"/>
<%} else{%>
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
<% }%>
<!-- 헤더부분 -->

<!-- 메인컨텐츠 -->
    <div class="AdminWrapper1">
	<div class="AdminMain AdminWrapper2">

 	<!-- 왼쪽 사이드 메뉴바 시작 -->
		<%if("admin".equals(session.getAttribute("sessionID"))){  %>
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
	    <%} else{%>
	    <c:choose>
	    <c:when test="${dto.category eq '3'}">
	    <div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>이벤트</p>
					<tr>
						<td>
						<div class="sidebarlist">
							<a href="User_Event_board">이벤트</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
	    </c:when>
	    <c:when test="${dto.category ne '3'}">
	    <div class="sidebar" style="width:200px; float:left;">
				<table style="width: 150px;">
				<p>고객센터</p>
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
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
							</div>
						</td>
					</tr>
				</table>
	    </div>
	    </c:when>
	    </c:choose>
	    <% }%>
      <!-- 왼쪽 사이드 메뉴바 끝 -->

	
	<div id="mainsector" class="contents">
	<c:choose>
		<c:when test="${dto.category eq '1'}">
		<h2>공지 사항</h2>
		</c:when>
		<c:when test="${dto.category eq '2'}">
		<h2>자주하는 질문</h2>
		</c:when>
		<c:when test="${dto.category eq '3'}">
		<h2>이벤트</h2>
		</c:when>
		</c:choose>
	<hr>
	<form name="n_write" method="post" action="Board_Modify" 
				onsubmit="return checkValue()">
	<table id="notice_list" class="table table-striped">
	<tr>
	<th style="width:80px;" scope="col" class="ntd"><p class="n_title">제목</p></th>
	<td style="width:400px;" colspan="3"><input style="height:25px; float: left;" type="text" name="text_Title" size = "50" value="${dto.n_title}" disabled></td>
	<th scope="col"><p>카테고리</p></th>
	
	<c:choose> 
	<c:when test="${dto.category eq '1'}">
	<td><select name="n_Category" disabled >
			<option value="">카테고리를 지정해주세요</option>
			<option value="1" selected >공지사항</option>
			<option value="2" >자주묻는질문</option>
			<option value="3" >이벤트</option>
			</select>
	</td>
	</c:when>
	<c:when test="${dto.category eq '2'}">
	<td><select name="n_Category" disabled >
			<option value="">카테고리를 지정해주세요</option>
			<option value="1" >공지사항</option>
			<option value="2" selected>자주묻는질문</option>
			<option value="3" >이벤트</option>
			</select>
	</td>
	</c:when>
	<c:when test="${dto.category eq '3'}">
	<td><select name="n_Category" disabled >
			<option value="">카테고리를 지정해주세요</option>
			<option value="1" >공지사항</option>
			<option value="2" >자주묻는질문</option>
			<option value="3" selected>이벤트</option>
			</select>
	</td>
	</c:when>
	</c:choose>
	</tr>
	<tr>
	<th scope="col" class="ntd"><p class="n_write">작성자</p></th>
	<td colspan="3"><input style="height:25px; float: left;" type="text" name="text_Writer" size = "50" value="${dto.n_writer}" disabled></td>
	<td></td>
	<td></td>
	</tr>
	<tr>
	<th scope="col" class="ntd"><p class="date">작성일</p></th>
	<fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy-MM-dd"/>
	<td><input type="text" id="text_Date" style="height:25px; float: left;" name="text_Date" size = "20" value="${reg}" disabled></td>
	<th scope="col" class="ntd"><p class="hit">조회수</p></th>
	<td><input type="text" name="text_Hit" style="height:25px; float: left;" size = "20"  value="${dto.n_hit}" disabled></td>
	<td></td>
	<td></td>
	</tr>
	<tr>
	 <td colspan="6"><textarea rows="10" id="summernote" name="text_Content">${dto.n_content}</textarea><td>
	</tr>
	</table>
	<div id ="butt">
	<input type="hidden" name="idx" value="${dto.idx}">
	<%if("admin".equals(session.getAttribute("sessionID"))){  %>
		<input type="submit" class="btn btn-sm btn-danger" value="수정"/>
		<c:choose>
		<c:when test="${dto.category eq '1'}">
		<input type="button" value="목록" onclick="goFirstForm(1)">
		</c:when>
		<c:when test="${dto.category eq '2'}">
		<input type="button" value="목록" onclick="goFirstForm(2)">
		</c:when>
		<c:when test="${dto.category eq '3'}">
		<input type="button" value="목록" onclick="goFirstForm(4)">
		</c:when>
		</c:choose>
		<% }else{%> 
		<c:choose>
		<c:when test="${dto.category eq '1'}">
		<input type="button" value="목록" onclick="goFirstForm(1)">
		</c:when>
		<c:when test="${dto.category eq '2'}">
		<input type="button" value="목록" onclick="goFirstForm(2)">
		</c:when>
		<c:when test="${dto.category eq '3'}">
		<input type="button" value="목록" onclick="goFirstForm(3)">
		</c:when>
		</c:choose>
		<% } %>
	</div>
	</form>
	
	</div>
	
</div>  <!-- AdminWrapper2 -->
</div>  <!-- AdminWrapper1 -->

 <!-- 메인 컨텐츠  -->
	
 <!-- 푸터  -->
	<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
	
	 <!-- jQuery first, then Popper.js, then Bootstrap JS -->  
    
     <script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  

</body>
</html>