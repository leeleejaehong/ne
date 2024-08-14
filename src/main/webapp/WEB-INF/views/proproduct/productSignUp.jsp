<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>neoheulge - 모던 적금 상품</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/proproduct/productSignUp.css">

</head>

    <!-- 헤더 include -->
    <%@ include file="../header.jsp" %>


        <section id="product-info">
            <h2>상품 정보</h2>
            <p><span class="icon">💰</span> 기본 이율: ${product.base_rate} %</p>
            <p><span class="icon">💰</span> 골든볼 이율: ${product.goldenball_rate} %</p>
            <p><span class="icon">📅</span> 가입 기간: ${product.subscription_period}</p>
            <p><span class="icon">💸</span> 최소 가입금액: ${product.minimum_deposit}원</p>
            <p><span class="icon">🏦</span> 최대 가입금액: ${product.maximum_deposit}원</p>
        </section>

        <section id="registration-form" >
            <h2>적금 가입</h2>
            <form name="f" id="savings-form" action="/proProduct/input.do" method="post">
                <sec:authentication var="username" property="principal.username"/>
				<input type="hidden" name="user" value="${username}"/>
            	<input type="hidden" name="product_code" value="${product.product_code}"/>
            	
                <label for="name">이름</label>
                	<input type="text" id="name" name="author" value="<sec:authentication property='principal.username'/>" readonly>

                <label for="amount">월 납입금액</label>
                	<input type="number" id="amount" name="amount" min="${product.minimum_deposit}" max="${product.maximum_deposit}" required>
                
                <label for="period">가입 선택</label>
	                <select id="period" name="select" required>
	                    <option value="base">기본 이율</option>
	                    <option value="goldenball">골든볼 이율</option>
	                </select>
                <input type="submit" value="가입하기">
            </form>
        </section>

         <section id="faq">
            <h2>자주 묻는 질문</h2>
            <details>
                <summary>중도해지 시 불이익이 있나요?</summary>
                <p>네, 중도해지 시 약정된 이자율보다 낮은 이자율이 적용됩니다.</p>
            </details>
            <details>
                <summary>월 납입일을 변경할 수 있나요?</summary>
                <p>네, 고객센터를 통해 월 납입일 변경이 가능합니다.</p>
            </details>
        </section>


	

    <%@ include file="../footer.jsp" %>

    <script>
        

    </script>

</html>