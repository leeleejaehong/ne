<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>


<jsp:include page="header.jsp"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">

<div class="img-container-size">
<div class="img=box-center">
<img class="img" src="http://lorempixel.com/1920/400/sports/10/" alt="">
</div>
</div>
    <main>
         <section class="hero">
            <div class="hero-content">
                <div class="slideshow-container">
                    <div class="slides fade">
                        <img src="img/images1.jpg" width="100%" height="280">
                    </div>
                    <div class="slides fade">
                        <img src="img/images2.jpg" width="100%" height="280">
                    </div>
                    <div class="slides fade">
                        <img src="img/images3.jpg" width="100%" height="280">
                    </div>
                    <a class="prev" onclick="plusSlides(-1)">&#10094;</a> 
                    <a class="next" onclick="plusSlides(1)">&#10095;</a>
                </div>
                <div class="login-form">
			    <sec:authorize access="isAuthenticated()">
			        <!-- 로그아웃 버튼을 표시합니다. -->
			        <h2>로그아웃</h2>
			        <sec:authentication property="principal.Username"/>
			        <form action="<c:url value='/logout' />" method="post">
			            <button type="submit">로그아웃</button>
			        </form>
			    </sec:authorize>
			    
			    <sec:authorize access="isAnonymous()">
			        <!-- 로그인 폼을 표시합니다. -->
			        <h2>로그인</h2>
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
        </section>

       <section id="products" class="products">
    <div class="container">
        <h2>상품 목록</h2>
        <div class="container">
        <div class="box-wrapper">
            <div class="box-container">
                <div id="box-fill-1" class="box-fill"></div>
                <div id="box-label-1" class="box-label">150,000원</div>
            </div>
            <div class="box-container">
                <div id="box-fill-2" class="box-fill"></div>
                <div id="box-label-2" class="box-label">700,000원</div>
            </div>
            <div class="box-container">
                <div id="box-fill-3" class="box-fill"></div>
                <div id="box-label-3" class="box-label">500,000원</div>
            </div>
            <div class="box-container">
                <div id="box-fill-4" class="box-fill"></div>
                <div id="box-label-4" class="box-label">1,000,000원</div>
            </div>
        </div>
    </div>
</section>
        
        
    <section id="community" class="community">
    <div class="container">
                <h2>커뮤니티</h2>
        <div class="community-content">
            <div class="community-posts">
                <div>
                    <h3>공지글</h3>
                    <p>글 내용 요약...</p>
                    <p>글 내용 요약...</p>
                    <p>글 내용 요약...</p>
                    <p>글 내용 요약...</p>
                    <p>글 내용 요약...</p>
                </div>
            </div>
            <div class="community-posts">
                <div>
                   <h3>커뮤니티</h3>
                 <c:forEach var="dto" items="${commuList}" varStatus="status">
				   <c:if test="${status.index < 5}">
				<p>
				<a href="/commu/commuContent.do?id=${dto.id}">
				${dto.subject}
				</a>
				</p>
				</c:if>
                </c:forEach>
                </div>
            </div>
            <div class="community-prizes">
                <h3>전회차 상금</h3>
                <p>상품1 100,000원</p>
                <p>상품2 145,000원</p>
                <p>상품3 609,000원</p>
                <p>상품4 1,681,500원</p>
            </div>
        </div>
    </div>
</section>

        
    </main>

<jsp:include page="footer.jsp"/> 

