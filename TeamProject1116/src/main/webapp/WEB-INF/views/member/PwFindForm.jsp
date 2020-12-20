<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<%  
	String email=(String)request.getSession().getAttribute("email");
	System.out.println(email);
%>    
<%  
	String password=(String)request.getSession().getAttribute("password");
	System.out.println(password);
%>  
<html>
<head> 
<link rel="stylesheet" href="css/member/idpwcheck.css">
  <title>비밀번호찾기-이메일전송</title> 
</head>
<body>
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 <!-- Cookie가 비어있지 않을 때 checked 속성을 줌 --> 
   
      <div id="main">
            <div class="loginWrapper"> 
            <form action="EmailSendAction" name="email_send" method="post">
				<table>  
                  <p class="login_head">비밀번호찾기</p> 
                  <tr>
                  <div class="user_email_img">
                      <img src="image/email.png" width="50px" height="50px">
                  </div>
                  </tr>
                  <tr>
                  <div class="user_email_text1">
                      이메일 인증 완료 후<br />
                      비밀번호를 재발급 받으세요!
                  </div>
                  </tr>
                  <tr>
                  <div class="user_email_text2">
                      입력하신 <%= email %> 으로 비밀번호가 전송됩니다.<br />
                      전송량이 많은 경우 이메일 전송이 지연 될 수 있습니다.
                  </div>
                  </tr>
                  <tr>
                  <div class="loginDiv3">
                    <td>
                    <input type="submit" class="check_btn" id="checkEmail" value="인증번호받기" style="text-align: center"> 
                    </td>
                 </div>
                  </tr>
              	</table> 
			</form>
            </div> 
        </div> 
        
  <!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>
 
   
  
        
</body>
</html>