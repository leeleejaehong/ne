<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../header.jsp"/>

<style>
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
    h1 {
        color: #333;
        text-align: center;
        margin-bottom: 30px;
    }
    .add-product {
        display: inline-block;
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    .product-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
    .product-card {
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .product-card p {
        margin: 5px 0;
    }
    .update-btn {
        background-color: #008CBA;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 3px;
        cursor: pointer;
    }
</style>

<div class="container">
    <h1>상품 리스트</h1>


    <div class="product-list">
        <c:forEach var="dto" items="${prodList}">
            <form name="f" action="/admin/updateProdPro.do" method="POST" class="product-card">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" name="product_code" value="${dto.product_code}" />
                
                <p><strong>상품 이름:</strong> ${dto.product_name}</p>
                <p><strong>상품 기간:</strong> ${dto.start_date} ~ ${dto.end_date}</p>
                <p><strong>기본 금리:</strong> ${dto.base_rate}</p>
                <p><strong>골든볼 금리:</strong> ${dto.goldenball_rate}</p>
                <p><strong>상품 상태:</strong> ${dto.product_status}</p>
                <input type="submit" value="수정하기" class="update-btn">
            </form>
        </c:forEach>
    </div>
</div>

<jsp:include page="../footer.jsp"/>