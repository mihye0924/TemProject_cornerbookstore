<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
  <%@ page import="com.study.springboot.dto.MemberDto" %>
<!-- 1123수정 -->
 <% 
 MemberDto book_img = (MemberDto)session.getAttribute("book_img"); 
 %>
  
<html>
<head> 
<link rel="stylesheet" href="css/bookstory/bookstorymain.css"> 
<title>북스토리 프로필</title> 
<script>
var newImage = new Image(); 
function updateImage() {//이미지 자동 새로고침
    if(newImage.complete) {
           newImage.src = document.getElementById("img").src;
           var temp = newImage.src;
           document.getElementById("img").src = newImage.src;
           newImage = new Image();
           newImage.src = temp+"?" + new Date().getTime();

}
setTimeout(updateImage, 1000);
};
</script>
</head>
<body  onload="updateImage();">
<!-- 북스토리메인헤더 -->
<jsp:include page="/WEB-INF/views/BookStoryMainHeader.jsp"/>


    <div id="main"> 
            <div class="profile_box"> 
                <div class="profile">
                    
                    <div class="profile_img" >
                        <a>프로필</a>
                    <%
						if(book_img==null){
					%>
					  <img src="image/bookstory/user.png" width="200px" height="200px">  
					<%
						}else{
					%>
					  <img id="img" src="../uploadPro3_bookstory/${book_img.book_profile}" width="200px" height="200px">	
					<%
						}
                    %>    
                  
                   
                    </div> 
                    <form action="ProfileRegister" name="ProfileRegister" method="post" enctype="multipart/form-data"  >
                    <table> 
                        <tr> 
                            <div class="input-group mb-3 img_upload"> 
                            <input type="file" class="btn btn-link" name="profile_img">
                            </div>
                            <div class="register">
                            <button type="button" class="btn btn-secondary" onclick="goMain()">메인화면</button>  
                            <input type="submit" class="btn btn-secondary" value="등록"> 
                            </div>
                        </tr> 
                    </table>
                    </form>
                </div> 
            </div> 
        </div>
        
    <!-- 메인푸터 -->
	<jsp:include page="/WEB-INF/views/BookStoryMainFooter.jsp"/> 
 	<!-- 글쓰기  -->
     <script> 
      function writeReturn() {
   		alert("로그인해주세요");
   	 }
      function goMain() {location.href="BookStoryMain"} 
    </script> 
</body>
</html>