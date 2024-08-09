<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header.jsp" />

<main class="product-detail">
    <c:forEach var="product" items="${product}">
        <div class="container">
            <section class="product-header">
                <img src="${pageContext.request.contextPath}/img/product_image.jpg" alt="적금상품 이미지" class="product-image">
                <div class="product-title">
                    <h1>${product.product_name}</h1>
                    <span class="status-badge">${product.product_status}</span>
                    <p class="product-code">상품 코드: ${product.product_code}</p>
                    <p class="product-code"><a href="/proProduct/does.do">가입하기</a></p>
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
                <div class="info-card termination-info">
                    <h2>해지 정보</h2>
                    <p><i class="icon-conditions"></i> 해지 조건: ${product.termination_conditions}</p>
                    <p><i class="icon-fee"></i> 중도해지 수수료: ${product.early_fee}%</p>
                </div>
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
	        updateProgress(${product.accumulated_amount}, ${product.maximum_deposit});
	    };
	</script>
    </c:forEach>
</main>



<style>
    :root {
        --primary-color: #3498db;
        --secondary-color: #2ecc71;
        --text-color: #333;
        --bg-color: #f4f6f8;
        --card-bg: #ffffff;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: var(--bg-color);
        color: var(--text-color);
        line-height: 1.6;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    .product-header {
        display: flex;
        align-items: center;
        background-color: var(--card-bg);
        border-radius: 1rem;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .product-image {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 2rem;
        border: 5px solid var(--primary-color);
    }

    .product-title h1 {
        font-size: 2.5rem;
        margin: 0;
        color: var(--primary-color);
    }

    .status-badge {
        display: inline-block;
        background-color: var(--secondary-color);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 2rem;
        font-size: 0.9rem;
        margin-top: 0.5rem;
    }

    .product-code {
        color: #777;
        font-size: 1rem;
        margin-top: 0.5rem;
    }

    .product-info {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-bottom: 2rem;
    }

    .info-card {
        background-color: var(--card-bg);
        border-radius: 1rem;
        padding: 2rem;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .info-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .info-card h2 {
        color: var(--primary-color);
        margin-top: 0;
        font-size: 1.5rem;
        margin-bottom: 1rem;
    }

    .rate {
        font-size: 2rem;
        font-weight: bold;
        color: var(--secondary-color);
    }

    .info-card i {
        margin-right: 0.5rem;
        color: var(--primary-color);
    }

    .product-description, .product-progress {
        background-color: var(--card-bg);
        border-radius: 1rem;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    }

    .product-description h2, .product-progress h2 {
        color: var(--primary-color);
        margin-top: 0;
    }

    .progress-box {
        background-color: #e9ecef;
        border-radius: 2rem;
        height: 2rem;
        position: relative;
        overflow: hidden;
        margin-top: 1rem;
    }

    .progress-fill {
        background-color: var(--secondary-color);
        height: 100%;
        width: 0;
        transition: width 0.5s ease-in-out;
        border-radius: 2rem;
    }

    .progress-text {
        position: absolute;
        top: 50%;
        left: 1rem;
        transform: translateY(-50%);
        color: var(--text-color);
        font-weight: bold;
    }

    @media (max-width: 768px) {
        .product-header {
            flex-direction: column;
            text-align: center;
        }

        .product-image {
            margin-right: 0;
            margin-bottom: 1rem;
        }
    }
</style>

<jsp:include page="../footer.jsp" />