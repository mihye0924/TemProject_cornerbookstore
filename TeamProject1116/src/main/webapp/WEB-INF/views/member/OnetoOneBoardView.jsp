<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.study.springboot.dto.OnetoOneBoardDto" %>
<%@ page import="java.util.ArrayList"%>
<%
	OnetoOneBoardDto content_view=(OnetoOneBoardDto)session.getAttribute("content_view");
%> 
  
<html>
<head> 
<link rel="stylesheet" href="css/member/onetooneboardwrite.css">
    <title>글보기</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>


	<!--글보기-->	
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
                                <h4>글 보기</h4>   
                                
                                <!-- 상품명 -->
                              	<form action="OnetoOneBoardModifyAction" method="post" >
                              	<input type="hidden" name="idx" value="${content_view.idx}">
                                <table>
                                 	<tr>
                                        <td> 
                                        <div class="input-group choose-product">  
                                            <span>문의유형</span>
                                        <div class="select-box-type"> 
                                        <select class="custom-select" id="inputGroupSelect04" name="o_type" value="${content_view.o_type}">
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
                                            <div class="input-group review-id">
                                                <span>아이디</span> 
                                            <div class="select-box"> 
                                             <input class="form-control" type="text" name="user_id" value="${content_view.user_id}" disabled>                                 
             		                         </div>
                                            </div>
                                        </td>  
                                    </tr>
                                    <tr>
                                        <td> 
                                            <div class="input-group phone-num">
                                                <span>휴대폰</span>   
                                            <div class="select-box"> 
                                              <input class="form-control" type="text" name="o_phone" value="${content_view.o_phone}" >                                 
                                            </div> 
                                            </div>
                                        </td> 
                                    </tr>
                                     <tr>
                                        <td> 
                                            <div class="input-group o_title">
                                                <span>제목</span> 
                                            <div class="select-box o_title_box">
                                              <input class="form-control" type="text" name="o_title" value="${content_view.o_title}">      
                                            </div>
                                            </div>
                                        </td> 
                                     </tr>
                                    <tr>
                                        <td> 
                                            <div class="input-group content">
                                                <span>내용</span> 
                                                <div class="text-box"> 
                                                <textarea name="o_content_Q" cols="75" rows="10" style="border: 1px solid rgb(206, 206, 206);">${content_view.o_content_Q}</textarea>
                                                
                                            </div>
                                            </div>
                                        </td> 
                                    </tr>
                                    <tr>
                                        <td>  
                                            <div class="product-review-save">
                                            <button type="button" class="btn btn-danger ">
                                            <a href="OnetoOneDeleteBoard?idx=${content_view.idx}"><span style="text-decoration:none; color: white;">삭제</span></a>
                                            </button>
                                            <input type="submit" class="btn btn-danger" value="수정">
                                            <input type="button" class="btn btn-danger" value="목록" onclick="golist()">
                                            </div>
                                        </td> 
                                    </tr> 
                            </table>
                            </form> 
                           
                           <!-- 관리자 답변 보기 --> 
                            <form action="GetReplyA" method="post" name="getcontent_a">
                           	<input type="hidden" name="idx" value="${content_view.idx}" disabled>
                            <table>
                            <tr>
                            <td>
                            	<hr />
                            	 <div class="input-group content">
                                    <span>답변</span> 
                                    <div class="text-box"> 
                                    <textarea name="o_content_A" cols="75" rows="5" style="border: 1px solid rgb(206, 206, 206);" disabled>${content_view.o_content_A}</textarea>
                                     

                                 
                                 
                                 </div>
                                 </div>
                            </td>
                            </tr>
                            </table>
                            </form> 
                           	<!-- 관리자답변끝  --> 
							</div> 
                    </div>
                    </td>
                </tr>
               </table> 
	        </div> 
	    </div>     
    
<!-- 메인푸터 -->
<jsp:include page="/WEB-INF/views/MainFooter.jsp"/>

<script>
	function golist(){location.href="OnetoOneBoard"} 
 
</script>
 
</body>
</html>
