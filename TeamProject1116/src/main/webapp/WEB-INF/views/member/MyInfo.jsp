<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<html>
<head> 
<link rel="stylesheet" href="css/member/myinfo.css">
    <title>개인정보폼</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 내정보 -->
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
                           <h4>내정보</h4>   
                        
                       <form name="loginInfocheck" method="post" action="MyInfoAction" onsubmit="return checkMyInfo()">   
                         <!-- 개인정보수정 -->
                       <div class="check-pw">
                       <span>비밀번호 재확인</span><br />
                       <span style="font-size: 13px;">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</span>
                       </div>
                       <hr style="border: 1px solid black;" />

                        
                               <div class="id-text">아이디</div>
                               <div class="id">  
                               <input class="form-control login" name="id" type="text">    
                               </div> 
                               <div class="pw-text">비밀번호<span style="color:red">*</span></div>
                               <div class="pw"> 
                                <input class="form-control login" name="password" type="password">  
                               </div>  
                           

                       <hr style="border: 1px solid black;" />
                       <div class="button_check">
                           <button type="submit" class="login_btn_again">확인</button><br> 
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

	<script type="text/javascript"> 
	function checkValue(){location.href="UpdateMyInfo";}
	
	function checkMyInfo(){
		var inputForm = eval("document.loginInfocheck");

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
	 
     </script>
 
 
</body>
</html>
