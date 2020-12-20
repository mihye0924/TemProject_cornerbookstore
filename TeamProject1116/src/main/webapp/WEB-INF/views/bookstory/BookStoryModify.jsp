<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.BookStoryBoardDto" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
	BookStoryBoardDto content_view=(BookStoryBoardDto)session.getAttribute("content_view"); 
	String id = (String) session.getAttribute("sessionID"); 
%>
 <!-- 1123수정 -->
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8"> 
<!-- 썸머노트 -->

 	<link rel="stylesheet" href="css/bookstory/bookstorywrite.css">
 	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
 
    <title>북스토리 글수정</title> 
	 
<style> 
.note-modal-backdrop{
position:relative;}
</style>
	<script type="text/javascript">
	 function checkValue()
		{
			if(!document.write.bs_title.value){
				alert("제목을 입력하세요.");
				return false;
			}
			 
			if(!document.write.bs_content.value){
				alert("본문을 입력해주세요.");
				return false;
			}
			if(document.write.bs_catagory.value==0){
				alert("카테고리를 지정해주세요");
				return false;
			}
		}
	 </script>
<script> 

       //써머노트 -제이쿼리 충동제거  alias 사용j
       var $j = jQuery.noConflict();
       $j(document).ready(function() {
           //여기 아래 부분
           $j('#summernote').summernote({
                 height: 400,					// 에디터 높이            
                 minHeight: null,             // 최소 높이
                 maxHeight: null,             // 최대 높이
                 focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
                 lang: "ko-KR",					// 한글 설정
                 placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
              	 callbacks: {	//이미지 첨부하는 부분
   	               	onImageUpload : function(files) {
                    uploadSummernoteImageFile(files[0],this);
  	                }
  				}

           });
       });
       

   	/**
   	* 이미지 파일 업로드
   	*/
   	function uploadSummernoteImageFile(file,editor) {
   		var data = new FormData();
   		data.append("file", file);
   		$.ajax({
   			data : data,
   			type : "POST",
   			url : "/uploadSummernoteImageFile",
   			contentType : false,
   			processData : false,
   			success : function(data,url) {
               	            //항상 업로드된 파일의 url이 있어야 한다.
               	            $j(editor).summernote('insertImage', data.url);
               	                alert("Success");
               	                
   			 }
   			,error:function(request,status,error, data){
               	            alert("Error");
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
<body>




<!-- 북스토리메인헤더 -->
<jsp:include page="/WEB-INF/views/BookStoryMainHeader.jsp"/> 
  
        <div id="main">
            <div class="write_box" id="pannel1">
            <div style="width: 60%; margin: auto;">
                <form method="post" action="BookStoryModifyAction" name="modify" onsubmit="return checkValue()"> 
                 	<input type="hidden" name="idx" value="${content_view.idx}"> 
                <br/>
                <br/>
                    <table>
                        <tr class="category_form1">  
                            <td class="title_2">
                                <span>카테고리</span>
                            </td>
                            <td> 
                            
                            <% 
                            if(id.equals("admin")){	
                           	%>
                           	<!-- 중복된 이름 제거 -->
                            <div class="form-group board_category text_form" >  
                                <select class="form-control" id="bs_category" name="bs_category">    
                                 <option value="${content_view.bs_category}"></option>
                                <option value="${content_view.bs_category}">북스토리</option>
                                <option value="${content_view.bs_category}">한줄서평</option>
                                <option value="${content_view.bs_category}">책읽고,리뷰남기기</option>
                                <option value="${content_view.bs_category}">좋은글귀 남기기</option>  
                                <option value="${content_view.bs_category}"><strong>작가정보</strong></option>
                                <option value="${content_view.bs_category}"><strong>책미리보기</strong></option>
                                <option value="${content_view.bs_category}"><strong>책 이벤트</strong></option>
                                </select> 
                            </div>
                            <% 
                            }else{
                            %>
                            <!-- 중복된 이름 제거 -->
                            <div class="form-group board_category text_form" >  
                                <select class="form-control" id="bs_category" name="bs_category">    
                                 <option value="${content_view.bs_category}"></option>
                                <option value="${content_view.bs_category}">북스토리,소통</option>
                                <option value="${content_view.bs_category}">한줄서평</option>
                                <option value="${content_view.bs_category}">책읽고,리뷰남기기</option>
                                <option value="${content_view.bs_category}">좋은글귀 남기기</option>  
                                </select> 
                            </div>
                            <%
                            }
                            %>  
                            
                            </td>
                        </tr>  
                        <tr>
                            <td class="title_2">
                                <span>제목</span>
                            </td> 
                            <td class="text_form2">  
                            <input class="form-control form-control-lg" type="text" value="${content_view.bs_title}" name="bs_title">
                            </td>
                        </tr> 
                    </table> 
                    <br/><br/>
                    <textarea id="summernote" name="bs_content" style="z-index: 1;">${content_view.bs_content}</textarea> 
                    <div  style="margin-top:10px; float:right"> 
                    <input type="submit" class="btn btn-secondary" value="수정하기" data-toggle="modal" data-target="#basicModal" >
                    <input type="button" class="btn btn-secondary" value="취소" onclick="goMain()"> 
                    </div>
                </form>
            </div>
            </div>
        </div>
        
    <div class="footer">
    <!-- 메인푸터 -->
	<jsp:include page="/WEB-INF/views/BookStoryMainFooter.jsp"/>
	</div>     

    <script>
		function goMain(){location.href="BookStoryView"}   
		$("#bs_category option:selected").text("${content_view.bs_category}") 
		
    </script>
</body>
</html>