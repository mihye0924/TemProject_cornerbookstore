<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<html>
<head>
<link rel="stylesheet" href="css/member/join.css">
 <title>회원가입</title>   
 
 
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript">
	

		// 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
		function checkValue()
		{
			if(!document.userInfo.id.value){
				alert("아이디를 입력하세요.");
				return false;
			}
			
			var idChecked = $('#check_hidden').val();
			if( idChecked != "yes") {
				alert("아이디 중복확인을 해주세요.");
				return false;
			}
			
			if(!document.userInfo.password.value){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
			if(document.userInfo.password.value != document.userInfo.password_check.value ){
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			} 
			 var name = document.getElementById("name");
			 var phone = document.getElementById("phone"); 
			 var mail1 = document.getElementById("mail1"); 
			 var sample6_detailAddress = document.getElementById("sample6_detailAddress"); 
  

	       if(userInfo.name.value=="") {
	           alert("이름을 입력해 주세요");
	           userInfo.name.focus();
	           return false;
	       } 
	       if(userInfo.phone.value=="") {
	           alert("전화번호를 입력해 주세요");
	           userInfo.phone.focus();
	           return false;
	       }


	       if(userInfo.mail1.value=="") {
	           alert("이메일을 입력해 주세요");
	           userInfo.mail1.focus();
	           return false;
	       }

	       if(userInfo.sample6_detailAddress.value=="") {
	           alert("주소를 입력해 주세요");
	           userInfo.sample6_detailAddress.focus();
	           return false;
	       }   
	       
	       if ($("input:checkbox[id=agree2]").is(":checked") == false) {
	    	   alert('서비스 이용약관(필수)에 동의해주세요');
	    	   return false;
			  }
	       if ($("input:checkbox[id=agree3]").is(":checked") == false) {
	    	   alert('개인정보처리방침(필수)에 동의해주세요');
	    	   return false;
			  }
		} 
		$(document).ready(function(){
		    //최상단 체크박스 클릭
		    $("#checkall").click(function(){
		        //클릭되었으면
		        if($("#checkall").prop("checked")){
		            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
		            $("input[name=agree]").prop("checked",true);
		            //클릭이 안되있으면
		        }else{
		            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
		            $("input[name=agree]").prop("checked",false);
		        }
		    })
		})

 
		function idCheck() {
			var user_id = $('#input_userId').val();
			
			if(!user_id){
				alert("아이디를 입력하세요.");
				return false;
			}
			// ajax 용도 : 화면 갱신(reload,redirect)가 없이
			//            부분화면 갱신(통신)을 js에서 한다.
			//           예)네이버 - 실시간검색어, 실시간날씨
			
			// 아이디 유효성 검사(1 = 중복 / 0 != 중복)
			$.ajax({
				/* url : 'http://localhost:8080/servlet3_LoginJoinDB/idCheck.do?id='+ user_id, */
	  			url : 'http://localhost:8081/idCheck?userId='+ user_id,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복됨, 0 = 중복안됨 : "+ data);							
					
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						alert("아이디가 중복됩니다.");
						$('#check_hidden').val("no");
					} else {
						// 0 : 아이디가 안됨.
						alert("아이디가 사용가능합니다.");
						$('#check_hidden').val("yes");
					}
				}, 
				error : function() {
						console.log("실패");
				}
			});
		} 
      
      /*비밀번호, 비밀번호 확인 일치 여부*/
      function check_pw(){
            var pw = document.getElementById('pw').value;
             if(pw.length < 6 || pw.length>16){
                window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
                document.getElementById('pw').value='';
            }
             if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다'
                    document.getElementById('check').style.color='blue';
                    document.getElementById('check').style.fontSize="12px";
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 불일치합니다';
                    document.getElementById('check').style.color='red';
                    document.getElementById('check').style.fontSize="12px";
                }
            }
        }
      
       
   /*우편번호 찾기 기능*/
    function execDaumPostcode() {
           new daum.Postcode({
               oncomplete: function(data) {
                var addr = ''; 
                   var extraAddr = ''; 
                   if (data.userSelectedType === 'R') { 
                       addr = data.roadAddress;
                   } else { 
                       addr = data.jibunAddress;
                   }

                   if(data.userSelectedType === 'R'){
                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                           extraAddr += data.bname;
                       }                    
                       if(data.buildingName !== '' && data.apartment === 'Y'){
                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                       }
                       if(extraAddr !== ''){
                           extraAddr = ' (' + extraAddr + ')';
                       }
                       document.getElementById("sample6_extraAddress").value = extraAddr;
                   
                   } else {
                       document.getElementById("sample6_extraAddress").value = '';
                   }
                   document.getElementById('sample6_postcode').value = data.zonecode;
                   document.getElementById("sample6_address").value = addr;
                   document.getElementById("sample6_detailAddress").focus();
               }
           }).open();
       }
</script>
</head>
<body> 
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
 
<div id="main"> 
      <div class="join_form">  
         <form name="userInfo" action="MemberJoinAction" method="post"  onsubmit="return checkValue()"> 
              <input type="hidden" name="book_profile"> 
              <input type="hidden" name="rank" value="구석책방">
            <p class="join_head">Join us</p> 
            <table> 
               <th>
                    <input class="form-control id" id="input_userId" name="id" type="text" placeholder="아이디">
                    <td colspan="5">   
                    <input type="button" class="btn id_check" id="input_userId_check" value="중복확인" onclick="idCheck()"> 
                    <input id="check_hidden" type="hidden"   value="no" />
                    </td> 
               </th>
               <tr>
                    <td colspan="2"> 
                    <input class="form-control pw" name="password" type="password" placeholder="비밀번호" id="pw" onchange="check_pw()"/> 
                    </td>
               </tr>
               <tr>
                    <td colspan="2"> 
                    <input class="form-control pw_check"  name="password_check" type="password" placeholder="비밀번호확인" id="pw2" onchange="check_pw()"/> 
                    <span id="check"></span>
                    </td> 
               </tr>
               <tr>
                    <td colspan="2"> 
                    <input class="form-control name"  name="name" type="text" placeholder="이름"> 
                    </td>
               </tr>  
               <tr>
                    <td colspan="2"> 
                    <input class="form-control phone"  name="phone" type="text" placeholder="휴대폰번호    하이픈(-) 없이 입력해주세요"> 
                    </td>
               </tr> 
               <th>
                    <input class="form-control email" type="text" name="mail1" maxlength="50" placeholder="이메일" > 
                    <td colspan="2"> 
                    <select class="form-control emai2" name="mail2">
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="nate.com">nate.com</option>                  
                    </select> 
                  </td>
               </th>
               <tr>
                <td><input type="text" class="form-control" id="sample6_postcode" name="address1" placeholder="우편번호"></td>
                <td><input type="button" class="form-control searchpostnum" onclick="execDaumPostcode()" value="우편번호 찾기"></button> </td>
             </tr>
             <tr> 
                <td colspan="2"> 
                    <input type="text" class="form-control address" id="sample6_address" name="address2" placeholder="주소">
                </td> 
             </tr> 
              <tr>
                <td colspan="2"> 
                    <input type="text" class="form-control etc" id="sample6_extraAddress" placeholder="참고항목" name="address3">
                </td>
             </tr>
             <tr>
                <td colspan="2"> 
                    <input type="text" class="form-control address_long" id="sample6_detailAddress" name="address4" placeholder="상세주소">
                </td>
             </tr>  
               <tr>
                <td>
                <div class="form-check agree">
                        <input type="checkbox"class="form-check-input" id="checkall" onclick="cAll() name="agree1">
                        <label class="form-check-label" for="exampleCheck1">전체동의</label>
                </div>  
                </td> 
               </tr> 
               <tr> 
                <td> 
                <div class="form-check service-use">
                        <input type="checkbox" class="form-check-input" id="agree2" name="agree" target="_blank">
                        <label class="form-check-label" for="exampleCheck1">서비스 이용약관(필수)</label>
                </div>  
                </td>
                <td class="box_view">
                    <a href="TermOfUse">내용보기</a>
                  </td>
               </tr>
               <tr>
                <td>
                <div class="form-check money-pay">
                        <input type="checkbox" class="form-check-input" id="agree3" name="agree" target="_blank">
                        <label class="form-check-label" for="exampleCheck1">개인정보처리방침(필수)</label>
                </div>   
                </td>
                <td class="box_view">
                    <a href="PrivacyPolicy">내용보기</a>
                </td>
               </tr>
               <tr> 
                  <td colspan="2">  
                     <input type="submit" class="btn join" value="가입" style="text-align:center" > 
                     <input type="button" class="btn cancle" value="취소" onclick="goFirstForm()" style="margin-left: 5px"> 
                  </td>
               </tr>
            </table>
         </form>  
      </div>
   </div> 

    
  <!-- 메인푸터 -->
 <jsp:include page="/WEB-INF/views/MainFooter.jsp"/>
    
    
       
   <!-- 우편번호API -->
   <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
   <script type="text/javascript" src="js/headhesive.js"></script>
</body>
</html> 