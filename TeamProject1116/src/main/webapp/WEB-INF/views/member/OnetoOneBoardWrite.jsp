<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.MemberDto" %> 
 <% 
 String session_id = (String) session.getAttribute("sessionID"); 
 	System.out.println("아이디찍기"+session_id);
 %>
<html>
<head> 
<link rel="stylesheet" href="css/member/onetooneboardwrite.css">
    <title>1:1문의작성</title> 
    <script>
    /*비밀번호, 비밀번호 확인 일치 여부*/
    function check_id(){ 
           if(document.getElementById('session_id').text !='' && document.getElementById('user_id').text!=''){
              if(document.getElementById('session_id').text==document.getElementById('user_id').text){
                  document.getElementById('check').innerHTML='아이디가 일치합니다'
                  document.getElementById('check').style.color='blue';
                  document.getElementById('check').style.fontSize="12px";
              }
              else{
                  document.getElementById('check').innerHTML='아이디가 불일치합니다';
                  document.getElementById('check').style.color='red';
                  document.getElementById('check').style.fontSize="12px";
              }
          }
      }

    function checkValue(){
		if(!document.onewrite.user_id.value){
			alert("아이디를 입력해주세요");
			return false;
			}
		if(!document.onewrite.o_phone.value){
			alert("전화번호를 입력해주세요");
			return false;
			}
		if(!document.onewrite.o_title.value){
			alert("제목을 입력해주세요");
			return false;
			}
		if(!document.onewrite.o_content_Q.value){
			alert("내용을 입력해주세요");
			return false;
			}
        }
 
    
    </script>
</head>
<body> 
  <!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 글쓰기 -->
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
                                <h4>1:1문의</h4>   
                                
                                <!-- 상품명 -->  
                                <form action="OnetoOnewriteAction" method="post" name="onewrite" onsubmit="return checkValue()">
                                <table>
                               			 <input type="hidden" name="o_ans_check2" value="${dto.o_ans_check}" >
                                		  <input type="hidden" name="o_ans_check" value="미등록" >
                                    <tr>
                                        <td> 
                                        <div class="input-group choose-product">  
                                            <span>문의유형</span>
                                        <div class="select-box-type"> 
                                        <select class="custom-select" id="inputGroupSelect04" name="o_type">
                                        <option selected value="배송지연/불만">배송지연/불만</option>
                                        <option value="교환문의">교환문의</option>
                                        <option value="반품문의">반품문의</option>
                                        <option value="상품손상">상품손상</option>
                                        <option value="주문/결제 문의">주문/결제 문의</option>
                                        <option value="입고 문의">입고 문의</option>
                                        <option value="기타">기타</option> 
                                        </select> 
                                        </div>
                                        </td> 
                                    </tr>
                                    <tr>
                                        <td> 
                                        <input type="hidden" name="session_id"  id="session_id" value="${dto.session_id}" onchange="check_id()">                                   
                                        <div class="input-group review-id" >
                                                <span>아이디</span> 
                                            <div class="select-box"> 
                                            <input class="form-control" type="text" name="user_id"  id="user_id" onchange="check_id()" value="<%= session_id%>" readonly>    
                                            <span id="check"></span>
                                            </div>
                                            </div>
                                        </td> 
                                    </tr>
                                    <tr>
                                        <td> 
                                            <div class="input-group phone-num" >
                                                <span>휴대폰</span>   
                                            <div class="select-box"> 
                                            <input class="form-control" type="text" name="o_phone" >    
                                            </div>  
                                        </td> 
                                    </tr>
                                       <tr>
                                        <td> 
                                            <div class="input-group o_title">
                                                <span>제목</span> 
                                            <div class="select-box o_title_box"> 
                                            <input class="form-control" type="text" name="o_title" > 
                                            </div>
                                            </div>
                                        </td> 
                                     </tr>
                                    <tr>
                                        <td> 
                                            <div class="input-group phone-num">
                                                <span>내용</span> 
                                                <div class="text-box"> 
                                                <textarea name="o_content_Q" cols="75" rows="10" placeholder="상품, 서비스에 대한 이용 후기를 남겨주세요" style="border: 1px solid rgb(206, 206, 206);"></textarea>
                                            </div>
                                            </div>
                                        </td> 
                                    </tr>
                                    <tr>
                                        <td> 
                                            <div class="product-review-save">
                                            <button type="submit" class="btn btn-danger">완료</button>
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
 
</body>
</html>
