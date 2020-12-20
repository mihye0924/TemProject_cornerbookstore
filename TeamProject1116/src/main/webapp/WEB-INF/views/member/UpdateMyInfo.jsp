<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dao.IMemberDao" %>    
<%@ page import="com.study.springboot.dto.MemberDto" %>
 
 <%
	// MemberInfoAction에서 넘긴 회원정보를 추출한다.
	MemberDto member = (MemberDto)session.getAttribute("memberInfo");
  
 %>
  
<html>
<head> 
<link rel="stylesheet" href="css/member/updatemyinfo.css">
    <title>개인정보수정</title> 
    <script type="text/javascript">  
	function deleteForm(){location.href="DeleteForm";} 


 
	function updateActionCheck()
		{  
		 
		if(!document.updateInfo.password.value){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		
 		if(!document.updateInfo.phone.value){ 
			alert("전화번호를 입력하세요.");
			inputForm.phone.focus();
			return false; 
 		}
 		
		if(!document.updateInfo.mail1.value){ 
			alert("이메일을 입력하세요.");
			inputForm.mail1.focus();
			return false; 
		}
		
		if(!document.updateInfo.sample6_detailAddress.value){  
			alert("주소를 입력하세요.");
			inputForm.sample6_detailAddress.focus();
			return false; 
		} 
		
		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		if(document.updateInfo.password.value != document.updateInfo.password_check.value ){
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
}
		
		   /*비밀번호, 비밀번호 확인 일치 여부*/
	      function check_pw(){
	            var pw = document.getElementById('password').value;
	             if(pw.length < 6 || pw.length>16){
	                window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
	                document.getElementById('password').value='';
	            }
	             if(document.getElementById('password').value !='' && document.getElementById('password_check').value!=''){
	                if(document.getElementById('password').value==document.getElementById('password_check').value){
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
  
  		<!-- 1:1문의 -->
        <div id="main">
            <div class="MyPage_Form">  
                <table>
                    <tr>
                    <td> 
                        <div class="section">
                            <div class="aside">
                                <table  cellpadding="10px" cellspaing="10px">
                                <p><a href="MyPageMain?id=<%=session.getAttribute("sessionID")%>" style="text-decoration:none; color:black;">마이페이지</a></p> 
                                <tr>
                                    <td>
                                        <div class="orderlist">
                                        <a href="OrderList">주문내역</a> 
                                        <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="basket">
                                        <a href="Basket">장바구니</a>
        
                                         <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="review">
                                        <a href="ProductReivew">상품후기</a>
                                          <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="point">
                                        <a href="PointInfo">적립금</a>
                                           <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                        <div class="ask">
                                        <a href="OnetoOneBoard">1:1문의</a>
                                         <span>&gt</span> 
                                        </div>
                                    </td> 
                                </tr>
                                <tr>
                                    <td>
                                    <div class="my_info">
                                    <a href="MyInfo">내정보</a>
                                      <span>&gt</span> 
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                <td>
                                <div class="orderlist">
                                <a href="MyProductQnA">상품문의</a>
                                  <span>&gt</span> 
                                </div>
                                </td>
                            </tr>
                                </table>
                            </div>
                        <div class="head_orderlist"> 
                            <h4>개인정보수정</h4>   
                               <hr />

                         <div class="join_form">  
                             <form name="updateInfo" action="UpdateAction" method="post"  onsubmit="return updateActionCheck()"> 
                                    
                                <table class="myinfo-form"> 
                                 <tr> 
                                     <td>
                                     <div class="text-box">아이디</div>
                                     </td>
                                     <td colspan="2">  
                                     <input class="form-control id" id="input_userId" name="id" type="text" value="<%= member.getId() %>" readonly > 
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                     <div class="text-box">새 비밀번호</div>
                                     </td>
                                     <td colspan="2"> 
                                     <input class="form-control pw" name="password" type="password" id="password" onchange="check_pw()"/> 
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                     <div class="text-box">새 비밀번호확인</div>
                                     </td>
                                     <td colspan="2"> 
                                     <input class="form-control pw_check"  name="password_check" type="password" id="password_check" onchange="check_pw()"/> 
                                      <span id="check"></span>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <td>
                                     <div class="text-box">이름</div>
                                     </td>
                                     <td colspan="2"> 
                                     <input class="form-control name"  name="name" type="text" value="<%= member.getName() %>" readonly > 
                                     </td>
                                 </tr>  
                                 <tr>
                                     <td>
                                     <div class="text-box">휴대폰</div>
                                     </td>
                                     <td colspan="2"> 
                                     <input class="form-control phone"  name="phone" type="text" value="<%= member.getPhone() %>"> 
                                     </td>
                                 </tr> 
                                 
                                 <th> 
                                     <tr>
                                     <td>
                                     <div class="text-box">이메일</div>
                                     </td>
                                     <td> 
                                     <input class="form-control email" type="text" name="mail1" maxlength="50"  value="<%= member.getMail1() %>" > 
                                     </td>
                                     <td>
                                     <select class="form-control emai2" name="mail2">
                                         <option value="naver.com">naver.com</option>
                                         <option value="daum.net">daum.net</option>
                                         <option value="gmail.com">gmail.com</option>
                                         <option value="nate.com">nate.com</option>                  
                                     </select> 
                                     </td>
                                 </tr>
                                 </th>
                                 <th>
                                     <tr>
                                     <td>
                                     <div class="text-box">우편번호</div>
                                     </td>
                                     <td>
                                     <input type="text" class="form-control" id="sample6_postcode" name="address1" value="<%= member.getAddress1() %>"  >
                                     </td>
                                     <td>
                                     <input type="button" class="form-control searchpostnum" onclick="execDaumPostcode()" value="우편번호 찾기" ></button> 
                                     </td>
                                     </tr>
                                 </th>
                                 <tr> 
                                     <td>
                                     <div class="text-box">주소</div>
                                     </td>
                                     <td colspan="2"> 
                                     <input type="text" class="form-control address" id="sample6_address" name="address2" value="<%= member.getAddress2() %>" >
                                     </td> 
                                 </tr>
                                 <tr>
                                     <td>
                                     <div class="text-box">참고항목</div>
                                     </td> 
                                     <td colspan="2"> 
                                     <input type="text" class="form-control etc" id="sample6_extraAddress" name="address3" value="<%= member.getAddress3() %>">
                                     </td>
                                 </tr>       
                                 <tr>
                                     <td>
                                     <div class="text-box">상세주소</div>
                                     </td> 
                                     <td colspan="2"> 
                                     <input type="text" class="form-control address_long" id="sample6_detailAddress" name="address4" value="<%= member.getAddress4() %>" >
                                     </td>
                                  </tr> 
                                </table>  
                                 <div class="delete_update">
                                 <input type="button" class="btn delete" value="탈퇴하기" onclick="deleteForm()" style="text-align: center;"> 
                                 <input type="submit" class="btn update" value="수정하기" style="text-align: center;">
                                 </div> 
                             </form>  
                          </div> 
	                    </div>
	                    </td>
	                </tr>
	               </table> 
	        </div> 
	    </div>     
<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>



 <!-- 우편번호API -->
   <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
   <script type="text/javascript" src="js/headhesive.js"></script>
 
</body>
</html>
