<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head> 
<link rel="stylesheet" href="css/member/delete.css">
    <title>탈퇴하기</title>  
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 탈퇴폼 -->
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
                                </table>
                            </div>
                        <div class="head_orderlist">
                            <h4>회원탈퇴안내</h4>   
                            <hr/>
                            <form action="DeleteAction" name="deleteInfo" method="post" onsubmit="return passwordCheck()">
                       <table>
                           <tr>
                               <td>
                                <div class="delete-info-text1">
                                    <span>회원탈퇴 안내 </span>
                                </div>  
                               </td>
                               <td> 
                                <div class="delete-info-text2"> 
                                고객님께서 회원 탈퇴를 원하시거나 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나봅니다.
                                불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해드리도록 
                                노력하겠습니다.  

                                <br /><br />
                                <span style="color: #d4b886;"> 회원 탈퇴시에 아래 사항을 숙지하시기 바랍니다.</span>
                                <br /><br />
                                1. 회원 탈퇴시 고객님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서 소비자 보호관한 법률에 의거한 고객정보
                                정책에 따라 관리 됩니다.
                                <br />
                                2. 탈퇴 시 고객님께서 보유하셨던 적립금은 모두 삭제됩니다. 
                                </div>    
                               </td> 
                                </tr>
                                <tr>
                                <td>
                                <div class="delete-info-text3">
                                <span>비밀번호확인</span>
                                </div>  
                                </td>
                                <td>    
                                <input class="form-control pw_check"  id="password" name="password" type="password" /> 
                                <input id="check_hidden" type="hidden"	value="no" />
                                </tr>
                                <tr>
                                <td>
                                <div class="delete-info-text4">
                                <span>무엇이 불편하셨나요?</span>
                                </div>  
                                </td> 
                                <td class="complain">     
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio" value="고객서비스(상담,포장)불만">
                                        <label class="form-check-label" for="inlineRadio1">고객서비스(상담,포장)불만</label>
                                    </span>
                                    <br />

                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio"  value="배송불만">
                                        <label class="form-check-label" for="inlineRadio2">배송불만</label>
                                    </span>
                                    <br />
                                    
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio" value="교환/환불/반품 불만">
                                        <label class="form-check-label" for="inlineRadio2">교환/환불/반품 불만</label>
                                    </span> 
                                    <br />
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio"  value="방문빈도낮음">
                                        <label class="form-check-label" for="inlineRadio2">방문빈도낮음</label>
                                    </span> 
                                    <br />
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio" value="개인정보유출우려">
                                        <label class="form-check-label" for="inlineRadio2">개인정보유출우려</label>
                                    </span>  
                                    <br />
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio" value="개인정보유출우려">
                                        <label class="form-check-label" for="inlineRadio2">쇼핑기능불만</label>
                                    </span>  
                                    <br />
                                    <span class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="complain_radio" id="complain_radio"value="쇼핑몰의 신뢰도 불만">
                                        <label class="form-check-label" for="inlineRadio2">쇼핑몰의 신뢰도 불만</label>
                                    </span>   
                                </td> 
                                </tr>
                              
                                <tr>
                                <td>
                                <div class="delete-info-text3">
                                <span></span>
                                </div>  
                                </td> 
                                <td>
                                <div class="text-box"></div>
                                <textarea cols="60" rows="10" placeholder="내용" style="border: 1px solid rgb(206, 206, 206);" id="complain_text" name="complain_text">불편사항을 남겨주세요</textarea>
                                </td>
                                </tr>  
                                <tr> 
                                    <td colspan="2"> 
                                        <div class="delete_cancle">
                                        <input type="submit" class="btn delete" value="탈퇴하기" style="text-align: center;"> 
                                        <input type="button" class="btn update" value="취소" onclick="cancle()"> 
                                        </div>
                                    </td>  
                                </tr>  
                        </table>      
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript"> 
	function cancle(){location.href="MainForm";}


	// 비밀번호 미입력시 경고창
	function passwordCheck(){
		var radiocheck = $('input:radio[name=complain_radio]').is(':checked');
		var passwordcheck
		if (radiocheck == false) {
		    alert('옵션을 선택해주세요.');
		    return false;
		   }
		   
	    if(document.deleteInfo.password.value==""){
			alert("비밀번호를 입력하지 않았습니다.");
			return false;
		}

	}

</script>
 
 
</body> 
</html>
