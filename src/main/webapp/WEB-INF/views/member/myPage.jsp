<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<jsp:include page="../header.jsp" />
<link rel="stylesheet" type="text/css" href="/css/member/myStyle.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            overflow: hidden;
        }
        .card-header {
            background-color: #3f51b5;
            color: #fff;
            padding: 20px;
            font-size: 1.2em;
            font-weight: 500;
        }
        .card-body {
            padding: 20px;
        }
        .btn {
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-primary {
            background-color: #3f51b5;
            color: #fff;
        }
        .btn-secondary {
            background-color: #f50057;
            color: #fff;
        }
        .btn-primary:hover, .btn-secondary:hover {
            opacity: 0.9;
        }
        .account-info, .product-item {
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 0;
        }
        .account-info:last-child, .product-item:last-child {
            border-bottom: none;
        }
        .account-actions, .product-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
        .account-actions .btn, .product-actions .btn {
            margin-left: 10px;
        }
        .material-icons {
            vertical-align: middle;
            margin-right: 5px;
        }
        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #3f51b5;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }
        
            .myPage {
		        display: flex;
		        justify-content: space-between;
		        max-width: 1200px;
		        margin: 0 auto;
		        padding: 20px;
		    }
		    .main-content {
		        width: 70%;
		    }
		    .login-form {
		        width: 25%;
		        background-color: #fff;
		        border-radius: 8px;
		        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
		        padding: 20px;
		        align-self: flex-start;
		    }
    </style>
<main>
    <div class="myPage">
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

        <div class="login-form">
            <sec:authorize access="isAuthenticated()">
                <h2>안녕하세요, <sec:authentication property="principal.username"/> 님!</h2>
                <div><a href="${pageContext.request.contextPath}/member/myPage.do">마이 페이지</a></div>
                <div>대표 계좌 잔액 : ${account.balance}원 </div>
                <form action="<c:url value='/logout' />" method="post">
                    <button type="submit" class="btn btn-primary">로그아웃</button>
                </form>
            </sec:authorize>
        </div>
    </div>
</main>
<jsp:include page="../footer.jsp" />