<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    
    /* 사이드바 메인컨텐츠 기본양식 끝 */
	</style>
	
    <script type="text/javascript">
    function goFirstForm() {
		location.href = "Notice_board";
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
		
		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		if(!document.n_write.text_Content.value){
			alert("본문을 10자이상 입력해주세요.");
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
    		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
    	});
    	$('#summernote').summernote('disable');
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
    <script>
function SirenFunction(idMyDiv){
     var objDiv = document.getElementById(idMyDiv);
     if(objDiv.style.display=="block"){ objDiv.style.display = "none"; }
      else{ objDiv.style.display = "block"; }
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
				<p>게시판 관리</p>
					<tr>
						<td>
							<a href="Notice_board">공지사항</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
						    <a href="QnA_board">1:1문의</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
							<a href="Question_board">자주하는 질문</a>
							<span href="#">&gt</span>
						</td>
					</tr>
					<tr>
						<td>
							<a href="Event_board">이벤트</a>
							<span href="#">&gt</span>
						</td>
					</tr>
				</table>
	    </div>
      <!-- 왼쪽 사이드 메뉴바 끝 -->

	
	<div id="mainsector" class="contents">
	<h2>1:1 문의</h2>
	<hr>
	<form name="n_write" method="post" action="Notice_Modify" 
				onsubmit="return checkValue()">
	<table id="notice_list">
	<tr>
	<th style="width:80px;" scope="col" class="ntd"><p class="n_category">[카테고리]</p></th>
	<th scope="col" class="ntd"><p class="n_title">제목</p></th>
	<th scope="col" class="ntd"><p class="n_title">작성자</p></th>
	<th scope="col" class="ntd"><p class="date">작성일</p></th>
	</tr>
	<tr>
	<td colspan="6"><textarea  placeholder="최대 200자까지 입력가능합니다." rows="5" id="textA" name="text_Content" style="width:700px;"></textarea><td>
	<td></td>
	<td></td>
	</tr>
	</table>
	<div id ="butt" style="float:right;margin-right:100px;">
	<input type="hidden" name="idx" value="${dto.idx}">
		<input type="button" value="목록" onclick="goFirstForm()" class="btn btn-sm btn-danger">
		<input type="button" onclick="SirenFunction('SirenDiv'); return false;" class="blind_view btn btn-sm btn-danger"" value="답변하기">
	</div>
	</form>
	
    <div class="singo_view" id="SirenDiv" style="display:none">
        <form name="n_write1" method="post" action="Notice_Modify" 
				onsubmit="return checkValue()">
				
	<table id="notice_list">
	<tr>
	<td colspan="2"><h2>1:1 문의 답변하기</h2><td>
	<td></td>
	<tr>
	<tr>
	<th style="width:60px;" scope="col" class="ntd"><p class="n_category">답변 ID :</p></th>
	<th scope="col" class="ntd"><input type="text" name="text_Writer" size = "10" value="sessionID" style="float:left;"></th>
	<td></td>
	<td></td>
	</tr>
	<tr>
	<td colspan="2"><textarea  placeholder="최대 200자까지 입력가능합니다." rows="5" id="textA" name="text_Content" style="width:700px;"></textarea><td>
	<td></td>
	<td></td>
	</tr>
	</table>
	</form>
    </div>
</div>
</div>  <!-- AdminWrapper2 -->
</div>  <!-- AdminWrapper1 -->

 <!-- 메인 컨텐츠  -->
 
 <div class="container">
	       <footer>
	           <p>Copyright (c) 2015 <a href="http://markgoodyear.com">Mark Goodyear</a><span class="top"><a href="#top">#top</a></span></p>
	       </footer>
       </div>
	<jsp:include page="/WEB-INF/views/AdminFooter.jsp"/>
	
	 <!-- jQuery first, then Popper.js, then Bootstrap JS -->  
    
     <script src="js/jquery-2.2.4.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>


</body>
</html>