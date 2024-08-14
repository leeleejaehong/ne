<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" type="text/css" href="/css/member/myStyle.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<main>
    <div class="myPage">
        <div class="header-content">
            <div class="vanner">
                <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:750px; height: 280px;">
            </div>
            <div class="login-form">
                <sec:authorize access="isAuthenticated()">
                    <img src="https://blogpfthumb-phinf.pstatic.net/MjAyNDA3MTZfMjAg/MDAxNzIxMTE1NzY3MjY4.ueDvccl7mHx7z0DVBHHqagXj2aoAhIi1uSYaQrufjS4g.1xT_9Yxv4LolXwixUFJ-SEK-Y0z39lD3qbv2YsZbhS4g.JPEG/%EC%96%B4%EB%9E%98%EA%B3%A4.jpeg/%25EC%2596%25B4%25EB%259E%2598%25EA%25B3%25A4.jpeg?type=w161"
                         alt="프로필 이미지"/>
                    <div class="nick">
                        <strong class="itemfont col" id="nickNameArea">현재 접속 아이디</strong> <br>
                        <span class="itemfont col">
                        <a id="blogDomainChange" onclick="return false;" class="set_domain_btn">
                        <span class="blog_domain col"> <sec:authentication property="principal.username"/> </span>
                        <span class ="set_domain_iconcol"></span>
                        </a>
                    </span>
                    </div>
                    <form action="<c:url value='/logout' />" method="post">
                        <button type="submit">로그아웃</button>
                    </form>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <h4>neoheulge <br> 더 안전하고 더 편리하게</h4>
                    <form action="<c:url value='/login' />" method="post">
                        <input type="text" name="username" placeholder="사용자 이름" required>
                        <input type="password" name="password" placeholder="비밀번호" required>
                        <button type="submit">로그인</button>
                    </form>
                    <div class="links">
                        <a href="/find-id">아이디 찾기</a> |
                        <a href="/find-password">비밀번호 찾기</a> |
                        <a href="${pageContext.request.contextPath}/member/signup.do">회원가입</a>
                    </div>
                </sec:authorize>
            </div>
        </div>

        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <span class="material-icons">account_balance</span> 계좌 정보
                </div>
                <div class="card-body">
                    <c:choose>
                    <c:when test="${empty account}">
                        <p>등록된 계좌가 없습니다.</p>
                        <form action="<c:url value='/account/add'/>" method="get">
                            <button type="submit" class="btn btn-primary">
                                <span class="material-icons">add_circle</span> 계좌 추가하기
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="account-info">
                            <p><strong>계좌 번호:</strong> ${account.number}</p>
                            <p><strong>현재 잔액:</strong> ${account.balance}원</p>
                            <div class="account-actions">
                                <form action="<c:url value='/account/add' />" method="get">
                                    <button type="submit" class="btn btn-primary">계좌 추가</button>
                                </form>
                                <form action="<c:url value='/account/delete' />" method="post">
                                    <button type="submit" class="btn btn-secondary">계좌 삭제</button>
                                </form>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <span class="material-icons">shopping_basket</span> 가입한 상품
                </div>
                <div class="card-body">
                <div class="products">
                    <c:forEach items="${getByMemberId}" var="product">
                    <c:if test="${product.STATUS == '활성'}">
	                    <div class="product-card">
	                    	<div class="product-image">💰</div>
	                    	<div class="product-info">
	                      		<h3>${product.PRODUCT_NAME}</h3>
	                        	<p><strong>가입일:</strong>
	                        		<fmt:formatDate value="${product.SUBSCRIPTION_DATE}" pattern="yyyy-MM-dd"/>
								</p>
	                        	<p><strong>상태:</strong> 
	                        		${product.STATUS}
	                        	</p>
	                        	<p><strong>가입 금액:</strong> 
	                        		${product.SUBSCRIPTION_AMOUNT}
	                        	</p>
	                        	<p><strong>가입 금액:</strong>
	                        		${product.AUTO_CYCLE}
	                        	</p>
	                        	<p><strong>가입 금액:</strong>
	                        		${product.AUTO_AMOUNT}
	                        	</p>
	                        	  
	                        	<div class="product-actions">
	                            	<form action="<c:url value='/proProduct/cancel' />" method="post">
	                            		<sec:authentication var="username" property="principal.username"/>
										<input type="hidden" name="user" value="${username}"/>
	                                	<input type="hidden" name="product_code" value="${product.PRODUCT_CODE}">
	                                	<button type="submit" class="btn btn-secondary">해지하기</button>
	                            	</form>
	                        	</div>
	                        </div>
	                    </div>
                    </c:if>
                </c:forEach>
                </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <span class="material-icons">shopping_basket</span> 해지한 상품
                </div>
                <div class="card-body">
                <div class="products">
                    <c:forEach items="${getByMemberId}" var="product">
                    <c:if test="${product.STATUS == '해지'}">
	                    <div class="product-card">
	                    	<div class="product-image">💰</div>
	                    	<div class="product-info">
	                      		<h3>${product.PRODUCT_NAME}</h3>
	                        	<p><strong>해지일:</strong>
	                        		<fmt:formatDate value="${product.TERMINATION_DATE}" pattern="yyyy-MM-dd"/>
								</p>
	                        	<p><strong>상태:</strong> 
	                        		${product.STATUS}
	                        	</p>
	               				<div class="product-actions">
	                            	<form action="" method="post">
	                                	<button type="submit" class="btn btn-secondary">삭제하기</button>
	                            	</form>
	                        	</div>
	                        </div>
	                    </div>
                    </c:if>
					</c:forEach>
                </div>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="../footer.jsp" />