<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<html>
<head> 
<link rel="stylesheet" href="css/member/login.css">
  <title>로그인</title> 
</head>
<body>
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 
  <!-- 로그인 메인화면 -->
  <div id="main">
            <div class="loginWrapper">
                <form name="loginInfo" method="post" action="AdminLoginAction" onsubmit="return checkValue()">
                    <p class="login_head">Admin Login</p> 
                    <table> 
                    <tr>   
                        <td>
                        <div class="login">
                        <img src="image/user.png" width="20px" height="20" >
                        <input class="form-control login" type="text" name="id" placeholder="아이디를 입력하세요" value="admin" style="font-size: 12px">  
                        </div> 
                        <td>
                    </tr>
                    <tr>  
                        <td>
                        <div class="pw">   
                        <img src="image/pw.png" width="20px" height="23">
                        <input class="form-control pw" type="password"  name="password"  placeholder="비밀번호를 입력하세요" value="123456789" style="font-size: 12px">  
                        </div>
                        </td>
                    </tr>
                    <tr> 
                        <td>
                        <div class="form-check" style="font-size:12px">
                            <input type="checkbox" class="form-check-input" id="exampleCheck1">
                            <label class="form-check-label" for="exampleCheck1">자동로그인</label>
                        </div>  
                         </td>
                    </tr>
                    <tr> 
                    <td>
	                    <div class="loginDiv3">
	                    <button type="submit" class="login_btn">로그인</button><br>	     
                    </div>
                    </td> 
                    </tr>
                </table>
                </form>
            </div> 
        </div>


    <!-- 로그인 메인화면  끝-->     
     
 
  <!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>

     	<script>
		function checkValue(){
			var inputForm = eval("document.loginInfo");
	
			if(!inputForm.id.value)
				{
				alert("아이디를 입력하세요.");
				inputForm.id.focus();
				return false;  //전송 안됨
				}
			if(!inputForm.password.value)
				{
				alert("비밀번호를 입력하세요.");
				inputForm.password.focus();
				return false;
				}
			} 
		
		function goJoinForm(){ location.href="JoinForm";}
      </script>
   
        
</body>
</html>