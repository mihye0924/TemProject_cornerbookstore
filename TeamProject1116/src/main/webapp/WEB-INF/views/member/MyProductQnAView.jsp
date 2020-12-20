<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
  
<html>
<head> 
<link rel="stylesheet" href="css/member/onetooneboardwrite.css">
    <title>글보기</title> 
</head>
<style>
.o_title_box_reg{
padding-left: 80px;
}
</style>
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
                                
                                <table>
                                    <tr>
                                        <td> 
                                            <div class="input-group phone-num">
                                                <span>도서명</span>   
                                            <div class="select-box"> 
                                              <input class="form-control" type="text" name="p_title" value="${dto.p_title}" disabled>                                 
                                            </div> 
                                            </div>
                                        </td> 
                                    </tr>
                                     <tr>
                                        <td> 
                                            <div class="input-group o_title">
                                                <span>작가</span> 
                                            <div class="select-box o_title_box">
                                              <input class="form-control" type="text" name="p_writer" value="${dto.p_writer}" disabled>      
                                            </div>
                                            </div>
                                        </td> 
                                     </tr>
                                      <tr>
                                        <td> 
                                            <div class="input-group o_title">
                                                <span>작성일</span> 
                                            <div class="select-box o_title_box_reg">
                                             <fmt:formatDate value="${dto.reg}" var="reg" pattern="yyyy.MM.dd"/>
                                              <input class="form-control" type="text" name="reg" value="${reg}" disabled>      
                                            </div>
                                            </div>
                                        </td> 
                                     </tr>
                                    <tr>
                                        <td> 
                                            <div class="input-group content">
                                                <span>내용</span> 
                                                <div class="text-box"> 
                                                <textarea name="o_content_Q" cols="75" rows="10" style="border: 1px solid rgb(206, 206, 206);" disabled>${dto.p_content}</textarea>
                                                
                                            </div>
                                            </div>
                                        </td> 
                                    </tr>
                                        <tr>
                                        <td>  
                                            <div class="product-review-save">
                                            <button type="button" class="btn btn-danger ">
                                            <a href="DeleteMyProductQnA?idx=${dto.idx}"><span style="text-decoration:none; color: white;">삭제</span></a>
                                            </button>         
                                            <input type="button" class="btn btn-danger" value="목록" onclick="golist()">
                                            </div>
                                        </td> 
                                    </tr>
                            </table>
                            </form> 
                           
                    
                   
                            <table>
                            <tr>
                            <td>
                            	<hr />
                            	 <div class="input-group content">
                                    <span>답변</span> 
                                    <div class="text-box"> 
                                    
                                     <c:set var = "p_answer_state" scope="session" value = "${dto.p_answer_state}" />
                                     <c:if test = "${p_answer_state eq '미등록'}">
                                      <textarea name="o_content_A" cols="75" rows="5" style="border: 1px solid rgb(206, 206, 206);" disabled>아직 답변이 등록되지 않았습니다.</textarea>
                                     </c:if>
                                     <c:if test = "${p_answer_state eq '답변완료'}">
                                      <textarea name="o_content_A" cols="75" rows="5" style="border: 1px solid rgb(206, 206, 206);" disabled>${dto.p_answer}</textarea>
                                     </c:if>
                                    
                                 </div>
                                 </div>
                            </td>
                            </tr>
                            </table>
                      
                           	<!-- 관리자답변끝  --> 
							</div> 
                     
                     
       
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
	function golist(){location.href="MyProductQnA"} 
 
</script>
 
</body>
</html>
