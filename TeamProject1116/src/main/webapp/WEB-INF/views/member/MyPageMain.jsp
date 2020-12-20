<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <% String id = (String)session.getAttribute("sessionID"); %>
    <link rel="stylesheet" href="css/member/myinfo.css">
</head>
<style>

    /* *{border: 1px red solid;} */
	.banner{
	min-width: 1000px;
    }
    .post{width:700px; height:150px;}
    .onetoone, .proqna{ width:340px; height: 200px;}
    .more{float:right;}
    .post1{
        background-color:#E6D2C9;
        display: flex;
    }
    .postdiv{
        justify-content: center;
        width: 150px;
        text-align: center;
    }
    .currentPointDiv{
    margin: 40px 0 40px; 
    text-align:center;
    border: 1px solid #E6D2C9;
    }
 
</style>

<body>

<!-- 메인헤더 -->
<jsp:include page="/WEB-INF/views/MainHeader.jsp"/>
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
                                </div>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <div class="basket">
                                <a href="Basket">장바구니</a>
                                </div>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <div class="review">
                                <a href="ProductReivew">상품후기</a>

                                </div>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <div class="point">
                                <a href="PointInfo">적립금</a>
                                </div>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                                <div class="ask">
                                <a href="OnetoOneBoard">1:1문의</a>
                                </div>
                            </td> 
                        </tr>
                        <tr>
                            <td>
                            <div class="my_info">
                            <a href="MyInfo">내정보</a>
                            </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            <div class="my_info">
                            <a href="MyProductQnA">상품문의</a>
                            </div>
                            </td>
                        </tr>
                        </table>
                    </div>
               <div class="head_orderlist"> 
                       <h4>마이페이지</h4>   
                    <table>
                    <tr>
                    <td>
                    <div class="currentPointDiv"><img src="image/images.png" width="70px" height="70px"><h3>현재 <%=id%>님의 포인트는 ${userdto.point}점 입니다.</h3></div>
                    </td>
                    </tr>
                        <tr>
                            <td>
                                <div><strong>진행중인 주문/배송 (최근 3개월)</strong></div>
                                <div class="post post1">
                                    <div class="postdiv">
                                        <h1><div class="delivery"><a href="OrderList" style="text_decoration: none; color:black;">${del1}</a></div></h1><br>
                                        <h6>주문확인중</h6>
                                    </div>
                                    <div style="margin: 0 auto;"><h1>></h1></div>
                                    <div class="postdiv">
                                        <h1><div class="delivery"><a href="OrderList" style="text_decoration: none; color:black;">${del2}</a></div></h1><br>
                                        <h6>주문확인</h6>
                                    </div>
                                    <div style="margin: 0 auto;"><h1>></h1></div>
                                    <div class="postdiv">
                                        <h1><div class="delivery"><a href="OrderList" style="text_decoration: none; color:black;">${del3}</a></div></h1><br>
                                        <h6>배송준비중</h6>
                                    </div>
                                    <div style="margin: 0 auto;"><h1>></h1></div>
                                    <div class="postdiv">
                                        <h1><div class="delivery"><a href="OrderList" style="text_decoration: none; color:black;">${del4}</a></div></h1><br>
                                        <h6>배송중</h6>
                                    </div>
                                    <div style="margin: 0 auto;"><h1>></h1></div>
                                    <div class="postdiv">
                                        <h1><div class="delivery"><a href="OrderList" style="text_decoration: none; color:black;">${del5}</a></div></h1><br>
                                        <h6>배송완료</h6>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr><td>　</td></tr>
						<hr>
                        <tr><td>　</td></tr>
                        
                        <tr>
                            <td>
                                <table style="margin-top: 40px;">
                                    <tr>
                                        <td><strong>1:1 문의 현황</strong><a href="OnetoOneBoard" class="more" style="text-decoration: none; color:black; font-size: 1.3ch;">+더보기</a></td>
                                        <td>　</td>
                                        <td><strong>상품 문의 현황</strong><a href="MyProductQnA" class="more" style="text-decoration: none; color:black; font-size: 1.3ch;">+더보기</a></td>
                                    </tr>
                                    <tr>
                                        <td><div class="onetoone">
                                       
                                       <c:if test="${onelist == '[]' }">
                                       <h5 style="text-align:center; margin-top: 50px;">등록된 1:1 문의가 없습니다.</h5>
                                       </c:if>
                                        
                                        <c:if test="${onelist != '[]' }">
                                      <table class="table table-striped">
                                               <thead>
                                                  <tr>
                                                    <th scope="col">문의유형</th>
                                                    <th scope="col">제목</th>
                                                    <th scope="col">답변상태</th>
                                                  </tr>
                                                  </tr>
                                               </thead>
                                              
                                               <tbody>
                                                <c:forEach items="${ onelist }" var="onelist" begin="0" end="2" step="1">
                                                 <tr>
                                                    <td style="font-size:1.4ch;">${onelist.o_type}</td>
                                                    <td style="font-size:1.4ch;"><a href="OnetoOneBoardView?idx=${onelist.idx}"
                                                    style="text-decoration : none; color:black">${onelist.o_title}</a></td>
                                                    
                                                    <c:set var = "o_ans_check" scope = "session" value = "${onelist.o_ans_check}"/>
                                                    <c:if test="${o_ans_check eq '미등록'}">
                                                    <td style="font-size:1.4ch; color: red;">${onelist.o_ans_check}</td>
                                                    </c:if>
                                                    <c:if test="${o_ans_check eq '답변완료'}">
                                                    <td style="font-size:1.4ch; color: blue;">${onelist.o_ans_check}</td>
                                                    </c:if>
                                                  </tr>
                                                  </c:forEach>
                                                </tbody>
                                        </table>
                                        </c:if>
                                                  
                                        </div></td>
                                        
                                      <td>　</td>
                                        <td><div class="proqna">
                                        
                                        <c:if test="${qnalist == '[]' }">
                                        <h5 style="text-align:center; margin-top: 50px;">등록된 상품 문의가 없습니다.</h5>
                                        </c:if>
                                        
                                        <c:if test="${qnalist != '[]' }">
                                            <table class="table table-striped">
                                                <thead>
                                                  <tr>
                                                    <th scope="col">도서명</th>
                                                    <th scope="col">작가명</th>
                                                    <th scope="col">답변상태</th>
                                                  </tr>
                                                </thead>
                                                <tbody>
  
                                                <c:forEach items="${ qnalist }" var="qnalist" begin="0" end="2" step="1">
                                                 <tr>
                                                    <td style="font-size:1.4ch;"><a href="MyProductQnAView?idx=${qnalist.idx}"
                                                    style="text-decoration : none; color:black">${qnalist.p_title}</a></td>
                                                    <td style="font-size:1.4ch;">${qnalist.p_writer}</td>
                                                    <c:set var = "p_answer_state" scope = "session" value = "${qnalist.p_answer_state}"/>
                                                    <c:if test = "${p_answer_state eq '미등록'}">
                                                    <td style="font-size:1.4ch; color: red;">${qnalist.p_answer_state}</td>
                                                    </c:if>
                                                    <c:if test = "${p_answer_state eq '답변완료'}">
                                                    <td style="font-size:1.4ch; color: blue;">${qnalist.p_answer_state}</td>
                                                    </c:if>
                                                  </tr>
                                                </c:forEach>
                                                  </tbody>
                                                  </table>
                                           </c:if>                                      
                                             
                                        </div></td>
                                    </tr>
                                </table>
                                </table>
                                </table>
                            </td>
                        </tr>

                    </table>
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