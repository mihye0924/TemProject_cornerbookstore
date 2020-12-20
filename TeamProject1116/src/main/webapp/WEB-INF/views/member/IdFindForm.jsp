<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
	<%  
	String dbid=(String)request.getSession().getAttribute("dbid");
	System.out.println(dbid);
%>    
<html>
<head> 
<link rel="stylesheet" href="css/member/idpwcheck.css">
  <title>아이디찾기완료</title> 
</head>
<body>
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 <!-- Cookie가 비어있지 않을 때 checked 속성을 줌 --> 
  
  <!-- 로그인 메인화면 -->
   
              
        <div id="main">
            <div class="loginWrapper">
                <form name="loginInfo" method="post" action="MemberLoginAction" onsubmit="return checkValue()">
                    <p class="login_head">아이디찾기</p> 
                    <table> 
                    <tr class="user_img">   
                        <div class="img_box"> 
                        <img src="image/FindIdUser.png" width="80px" height="80px">
                        </div>
                        <div class="user_img_text1">
                            고객님의 아이디 찾기가 <br /> 완료되었습니다.
                        </div>
                        <div class="user_id_complete">
                            <%= dbid %>
                        </div>
                    </tr> 
                    <tr>
                    <div class="loginDiv3">
                        <td>
                        <input type="button" class="check_btn" onclick="gologinForm()" value="로그인하기"> 
                        </td>
                    </div>
                    </tr>
                </table>
                </form>
            </div> 
        </div>

 
     
 
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
		
		function gologinForm(){ location.href="LoginForm";}
      </script>
   
        
</body>
</html>