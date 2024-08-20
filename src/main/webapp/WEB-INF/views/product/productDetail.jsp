<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="../header.jsp" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product/productDetail.css">

<main>
<div class="product-detail">
  
        <section class="product-header">
            <img src="${pageContext.request.contextPath}/img/product_image.jpg" alt="적금상품 이미지" class="product-image">
            <div class="product-title">
                <h1>${product.product_name}</h1>
                <span class="status-badge ${product.product_status == '활성' ? '' : 'inactive'}">${product.product_status}</span>
                <p class="product-code">상품 코드: ${product.product_code}</p>
            </div>
            <div class="signup-container">
            	<c:if test="${product.product_status == '활성'}">
	                <sec:authorize access="isAuthenticated()">
	                    <a href="/proProduct/does.do?product_code=${product.product_code}" class="signup-btn">가입하기</a>
	                </sec:authorize> 
	                
	                <sec:authorize access="isAnonymous()">
	                    <a href="javascript:void(0);" class="signup-btn" onclick="checkLogin()">가입하기</a>
	                </sec:authorize>
                </c:if>
            </div>
        </section>

        <section class="product-info">
		    <div class="info-card rate-info">
		        <h2>금리 정보</h2>
		        <p>기본 금리: <span class="rate">${product.base_rate}%</span></p>
		        <p>골든볼 금리: <span class="rate">${product.goldenball_rate}%</span></p>
		    </div>
		    <div class="info-card subscription-info">
		        <h2>가입 정보</h2>
		        <p><i class="icon-method"></i> 가입 방법: ${product.subscription_method}</p>
		        <p><i class="icon-period"></i> 가입 기간: ${product.subscription_period}</p>
		        <p><i class="icon-min"></i> 최소 가입 금액: ${product.minimum_deposit}원</p>
		        <p><i class="icon-max"></i> 최대 가입 금액: ${product.maximum_deposit}원</p>
		    </div>
		    <div class="info-card date-info">
		        <h2>상품 기간</h2>
		        <p><i class="icon-start"></i> 시작일: ${product.start_date}</p>
		        <p><i class="icon-end"></i> 종료일: ${product.end_date}</p>
		    </div>
		</section>
		
		<section class="termination-info">
		    <h2>해지 정보</h2>
		    <p><i class="icon-conditions"></i> 해지 조건: ${product.termination_conditions}</p>
		    <p><i class="icon-fee"></i> 중도해지 수수료: ${product.early_fee}%</p>
		</section>

        <section class="product-description">
            <h2>상품 설명</h2>
            <p>${product.product_description}</p>
        </section>

        <section class="product-progress">
            <h2>적립 현황</h2>
            <div class="progress-box">
                <div class="progress-fill" id="progress-fill"></div>
                <p class="progress-text">현재 적립액: <span id="current-amount"></span>원</p>
            </div>
        </section>
    </div>
</main>

<script>
    function updateProgress(currentAmount, goalAmount) {
        var percentage = (currentAmount / goalAmount) * 100;
        percentage = Math.min(percentage, 100);
        var progressFill = document.getElementById('progress-fill');
        var currentAmountSpan = document.getElementById('current-amount');
        
        progressFill.style.width = percentage + '%';
        currentAmountSpan.textContent = currentAmount.toLocaleString();
    }

    // 페이지 로드 시 초기 진행 상황 설정
   
    window.onload = function() {
    	checkAdVisibility();
        updateProgress(${product.accumulated_amount}, ${product.maximum_deposit});
    };
 
    function checkLogin() {
        alert('로그인이 필요한 서비스입니다.');
        // 여기에 로그인 페이지로 리디렉션하는 코드를 추가할 수 있습니다.
    }
</script>

<jsp:include page="../footer.jsp" />