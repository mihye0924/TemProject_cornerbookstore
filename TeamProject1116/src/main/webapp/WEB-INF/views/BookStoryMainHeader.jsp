<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="com.study.springboot.dto.MemberDto" %>    
     
    <%
    String id = (String) session.getAttribute("sessionID");  
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인헤더</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- 헤더 -->
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/main.css">
    
    <!-- 메인 -->
    <link rel="stylesheet" href="/css/flickity.css">   

    <!--슬라이드 --> 
    <link rel="stylesheet" href="css/headhesive.css"> 
    <link rel="stylesheet" href="css/owl.carousel.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>    
</head>
<style>
	.banner{
	min-width: 1000px;
	}
</style>
<body> 
     <div id="top"> 
        <div class="banner">  
            <div class="top_nav container">    
             <div class="login_before">
        
            <%
            	if(session.getAttribute("sessionID")==null){
       		%>
            		 <a href="JoinForm">회원가입</a> 
                     <a href="LoginForm">로그인</a>   
                     <a href="Notice_board">고객센터</a> 
                     <a href="AdminLoginForm">관리자페이지</a>
               </div>      
            <%   
            	}else if(id.equals("admin")){
           %>    
			       <div class="login_state">
                
                <span class="dropdown show login_head">
                    <a class="login_notice_btn" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <span><%= id %>회원님</span>
                    </a>
                    <div class="dropdown-menu member_dropdown" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="MyPageMain?id=<%=id%>">마이페이지</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="PointInfo">마일리지</a>
                        <a class="dropdown-item" href="ProductReivew">상품후기</a>
                        <a class="dropdown-item" href="OnetoOneBoardWrite">1:1문의</a>
                        <a class="dropdown-item" href="LogOut">로그아웃</a>
                    </div>
                    </span>   
                
                    <a href="OrderList">주문/배송</a>   
                    <a href="Basket">장바구니</a> 
                 	
                  <span class="dropdown show login_notice">
                    <a class="login_notice_btn" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span>고객센터</span>
                    </a>   
                                     
                    <div class="dropdown-menu notice_dropdown" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="Notice_board">공지사항</a> 
                        <a class="dropdown-item" href="Question_board">자주묻는질문</a> 
                    </div>
                    </span>   
                  <a href="AdminMainForm">관리자페이지</a>
                </div>
          <%
            	}else{
            %>     
            <div class="login_state">
                
                <span class="dropdown show login_head">
                    <a class="login_notice_btn" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <span><%= id %>회원님</span>
                    </a>
                    <div class="dropdown-menu member_dropdown" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="MyPageMain?id=<%=id%>">마이페이지</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="PointInfo">마일리지</a>
                        <a class="dropdown-item" href="ProductReivew">상품후기</a>
                        <a class="dropdown-item" href="OnetoOneBoardWrite">1:1문의</a>
                        <a class="dropdown-item" href="LogOut">로그아웃</a>
                    </div>
                    </span>   
                
                    
                    <a href="OrderList">주문/배송</a>   
                    <a href="Basket">장바구니</a> 
                 
                  
                
                    <span class="dropdown show login_notice">
                    <a class="login_notice_btn" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span>고객센터</span>
                    </a>
                    <div class="dropdown-menu notice_dropdown" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="Notice_board">공지사항</a> 
                        <a class="dropdown-item" href="Question_board">자주묻는질문</a> 
                    </div>
                    </span>    
                </div>
                <% } %>
                <div class="logo"> 
                    <a href="MainForm"><img src="/image/logo.png" width="140px" height="50px" /></a>      
                    <nav class="navbar navbar-light navbar_search">
                        <form class="form-inline" action="bookSearch">
                           
                            <input class="search_main mr-sm-2" type="search" aria-label="Search" placeholder="검색" name="search"> 
                            <button class="search_click btn btn-link" type="submit"><img src="/image/search.png" width="15px" height="15px"></button>
                        </form>
                    </nav> 
                </div>  
                <div class="navigation">  
                    <nav class="navbar navbar-expand-lg navbar-light">  
                        <table>  
                        
                       <tr class="nav-item dropdown">
                            <a class="nav-link " href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="navbar-toggler-icon"></span>  
                                <span> 전체카테고리 </span>  
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="AllBook">전체보기</a>
                            <a class="dropdown-item" href="novel">소설</a>
                            <a class="dropdown-item" href="essay">시/에세이</a>
                            <a class="dropdown-item" href="humanities">인문학</a> 
                            <a class="dropdown-item" href="economics">경영/경제</a>
                            <a class="dropdown-item" href="art">예술</a>
                            <a class="dropdown-item" href="self-improvement">자기계발</a>
                            <a class="dropdown-item" href="independent">독립서적</a>
                            <a class="dropdown-item" href="records">음반</a>  
                            </div>
                        </tr> 
                        
                        <tr class="nav-item active">
                            <a class="nav-link" href="NewBook"><span> 신간도서 </span></a>
                        </tr> 
                        <tr class="nav-item">
                            <a class="nav-link" href="BestBook"><span> 베스트도서 </span></a>
                        </tr> 
                        <tr class="nav-item">
                            <a class="nav-link" href="RecommendBook"><span> 추천도서 </span></a>
                        </tr>  
                        <tr class="nav-item">
                            <a class="nav-link" href="User_Event_board"><span> 이벤트 </span></a>
                        </tr>  
                        <tr class="nav-item">
                            <a class="nav-link" href="BookStoryMain"><span> 북스토리 </span></a>
                        </tr>  
                        </table>   
                    </nav> 
                    </div> 
                </div>   
            </div>   
          </div>
        <div class="top_clone"></div>
