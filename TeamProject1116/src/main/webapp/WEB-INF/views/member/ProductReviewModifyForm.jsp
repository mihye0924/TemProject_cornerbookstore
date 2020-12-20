<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head> 
<link rel="stylesheet" href="css/member/reivew_write.css">
    <title>상품후기수정</title> 
</head>
<body> 
      
<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
  
  		<!-- 상품후기쓰기 -->
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
                             <h4>후기쓰기</h4> 
                              
                          <form action = "modifyReview" name="review" method="post" enctype="multipart/form-data">
                             <p> 만족도를 표현해주세요</p>
                             <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="매우만족" 
                                 <c:if test="${dto.rate eq '매우만족'}">checked</c:if>>
                                 <label class="form-check-label" for="inlineRadio1">매우만족</label>
                             </div>
                             <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="만족"
                                 <c:if test="${dto.rate eq '만족'}">checked</c:if>>
                                 <label class="form-check-label" for="inlineRadio2">만족</label>
                             </div> 
                             <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="보통" 
                                 <c:if test="${dto.rate eq '보통'}">checked</c:if>>
                                 <label class="form-check-label" for="inlineRadio2">보통</label>
                             </div> 
                             <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="불만"
                                 <c:if test="${dto.rate eq '불만'}">checked</c:if>>
                                 <label class="form-check-label" for="inlineRadio2">불만</label>
                             </div> 
                             <div class="form-check form-check-inline">
                                 <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="매우불만"
                                 <c:if test="${dto.rate eq '매우불만'}">checked</c:if>>
                                 <label class="form-check-label" for="inlineRadio2">매우불만</label>
                             </div>  

                             <table>
                                 <tr>
                                     <td> 
                                     <div class="input-group choose-product">  
                                         <span>상품명</span>
                                     <div class="select-box"> 
                                         <input class="form-control" value="${dto.p_title}" type="text" disabled="true" style="width:400px;">
                                     </div>
                                     </div>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <td> 
                                         <div class="input-group review-id">
                                             <span>아이디</span> 
                                         <div class="select-box"> 
                                         <input class="form-control" value="${dto.o_orderid}" type="text" disabled="true">    
                                         </div>
                                         </div>
                                     </td> 
                                 </tr>
                          
                                 <tr>
                                     <td> 
                                         <div class="input-group phone-num">
                                             <span>내용</span> 
                                             <div class="text-box"> 
                                             <textarea name="description" cols="75" rows="10" 
                                             style="border: 1px solid rgb(206, 206, 206);">
                                             ${dto.description}
                                             </textarea>
                                         </div>
                                         </div>
                                     </td> 
                                 </tr>
                                 <tr>
                                 	 <td> 
                                         <div class="input-group phone-num">
                                             <span>이미지</span> 
                                             <div class="text-box"> 
                                             <input type="file" name="p_filename">
                                             </div>
                                         </div>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td> 
                                        <input type="hidden" name="idx" value="${dto.idx}">
                                        <input type="hidden" name="o_number" value="${o_number}">
                                        <input type="hidden" name="p_number" value="${p_number}">
                                     	<input type="hidden" name="p_title" value="${p_title}">
                                     	<input type="hidden" name="p_writer" value="${p_writer}">
                                     	<input type="hidden" name="o_orderid" value="${o_orderid}">
                                         <div class="product-review-save">
                                         <button type="submit" class="btn btn-danger">저장</button>
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
 <script>
function checkValue(){

	if(!document.review.inlineRadioOptions.value){
		alert("만족도를 체크해주세요.");
		return false;
	}
	if(!document.review.description.value){
		alert("내용란을 기입해주세요.");
		return false;
	}

}

</script>
</body>
</html>
