<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="/css/product/ProductStyle.css">
<link rel="stylesheet" type="text/css" href="/css/product/productList.css">
<main>
<div class="myPage">
    <div class="header-content">
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:898px; height: 280px;">
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

    <h2 class="section-title">적금 상품</h2>
        
    
    <div class="products">
    <c:forEach var="dto" items="${product}">
        <div class="product-card">
            <div class="product-image">💰</div>
            <div class="product-info">
                <a class="product-title" href="productDetail.do">${dto.product_name}</a>
                <p><strong>기본 금리:</strong> ${dto.base_rate}</p>
                <p><strong>골든볼 금리:</strong> ${dto.goldenball_rate}</p>
                <p><strong>만기:</strong> ${dto.subscription_period}</p>
                <p><strong>최소금액:</strong> ${dto.minimum_deposit}</p>
                <button class="show-details" onclick="toggleDetails(this)">상세 정보</button>
                <div class="product-details">
                    <p><strong>월 납입액:</strong> ${dto.minimum_deposit}원 ~ ${dto.maximum_deposit}원</p>
                    <p><strong>중도해지 금리:</strong> 전체의 ${dto.early_fee}%</p>
                    <p><strong>상품설명:</strong> ${dto.product_description}</p>
                </div>
            </div>
        </div>
	 </c:forEach>
        
    </div>
   
    <div class="commu-container">
        <div class="community-content">
            <div class="community-posts">
                <div>
                    <h3>공지글</h3>
                    <table>
                        <thead>
                        <tr class="commu-header">
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="dto" items="${noticeList}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <tr>
                                    <td width="50%">
                                        <span>&nbsp;&nbsp;</span>
                                        <a href="/notice/noticeView.do?id=${dto.id}">
                                                ${dto.subject}
                                        </a>
                                    </td>
                                    <td align="center" width="25%">
                                            ${dto.author}
                                    </td>
                                    <td align="center">
                                        <fmt:parseDate var="parsedDate" value="${dto.createtime}" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:formatDate value="${parsedDate}" pattern="MM-dd HH:mm" />
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="community-posts">
                <div>
                    <h3>커뮤니티</h3>
                    <table>
                        <thead>
                        <tr class="commu-header">
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>
                        </thead>
                        <tbody>

                        <c:forEach var="dto" items="${commuList}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <tr>
                                    <td width="50%">
                                        <span>&nbsp;&nbsp;</span>
                                        <a href="/commu/commuContent.do?id=${dto.id}">
                                                ${dto.subject}
                                        </a>
                                    </td>
                                    <td align="center" width="25%">
                                            ${dto.author}
                                    </td>
                                    <td align="center">
                                        <fmt:parseDate var="parsedDate" value="${dto.createtime}" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <fmt:formatDate value="${parsedDate}" pattern="MM-dd HH:mm" />
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="community-prizes">
                <h3>전회차 상금</h3>
                <c:forEach var="dto" items="${sessionScope.winnerList}">
           			 <p>${dto.product_name} ${dto.accumulated_amount}원</p>
       			 </c:forEach>
            </div>
        </div>
    </div>
</div>
</main>

<script>
    function toggleDetails(button) {
        var details = button.nextElementSibling;
        if (details.style.display === "none" || details.style.display === "") {
            details.style.display = "block";
            button.textContent = "상세 정보 접기";
        } else {
            details.style.display = "none";
            button.textContent = "상세 정보";
        }
    }
</script>


<%@ include file="../footer.jsp" %>