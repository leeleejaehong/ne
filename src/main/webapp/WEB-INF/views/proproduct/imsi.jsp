<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>neoheulge - 모던 적금 상품</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mainStyle.css">
    <style>
        /* 메인 콘텐츠 스타일 */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        section {
            margin-bottom: 2rem;
        }

        h2 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 0.5rem;
        }

        form {
            display: grid;
            gap: 1rem;
        }

        label {
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        button {
            background-color: #2ecc71;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #27ae60;
        }

        .icon {
            display: inline-block;
            width: 1em;
            height: 1em;
            margin-right: 0.5em;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <!-- 헤더 include -->
    <%@ include file="../header.jsp" %>

    <div class="main-content">
        <section id="product-info">
            <h2>상품 정보</h2>
            <p><span class="icon">💰</span> 연 이율: 3.5%</p>
            <p><span class="icon">📅</span> 가입 기간: 12개월 ~ 36개월</p>
            <p><span class="icon">💸</span> 최소 납입금액: 10,000원</p>
            <p><span class="icon">🏦</span> 최대 납입금액: 3,000,000원</p>
        </section>

        <section id="registration-form">
            <h2>적금 가입</h2>
            <form id="savings-form">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>

                <label for="amount">월 납입금액</label>
                <input type="number" id="amount" name="amount" min="10000" max="3000000" required>

                <label for="period">가입 기간</label>
                <select id="period" name="period" required>
                    <option value="12">12개월</option>
                    <option value="24">24개월</option>
                    <option value="36">36개월</option>
                </select>

                <button type="submit">가입하기</button>
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
    </div>

    <!-- 푸터 include -->
    <%@ include file="../footer.jsp" %>

    <script>
        document.getElementById('savings-form').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('적금 가입이 완료되었습니다. 감사합니다!');
        });
    </script>
</body>
</html>