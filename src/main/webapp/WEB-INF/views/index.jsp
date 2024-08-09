<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<jsp:include page="header.jsp"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
<script>
     document.addEventListener('DOMContentLoaded', () => {
            // 서버에서 전달받은 공지사항 유무 확인
            const hasNotice = ${not empty noticeList}; // JSP EL을 사용하여 noticeList가 비어있지 않은지 확인

            if (hasNotice) {
                // 공지 사항의 ID 또는 고유 식별자를 설정
                const noticeId = '${noticeList[0].id}'; // 첫 번째 공지사항의 ID 사용
                // 로컬 스토리지에서 저장된 시간을 확인
                const storedTime = localStorage.getItem(`dontShowNoticeTime_${noticeId}`);
                const currentTime = new Date().getTime();
                const oneDayInMilliseconds = 24 * 60 * 60 * 1000; // 24시간

                // 저장된 시간이 없거나 24시간 이상 경과된 경우에만 팝업 열기
                if (!storedTime || currentTime >= parseInt(storedTime, 10) + oneDayInMilliseconds) {
                    viewNotice();
                }
            }
        });

    function viewNotice() {
        window.open("${pageContext.request.contextPath}/viewNotice.do", "Notice", "width=400,height=650");
    }
</script>

<div class="img-container-size">
    <div class="img=box-center">
        <img class="img" src="http://lorempixel.com/1920/400/sports/10/" alt="">
    </div>
</div>
<main>
   <div class="hero-container">
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
                    <%-- <sec:authorize access="hasRole('ROLE_1')">
                 	123
                 	</sec:authorize> --%>
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
                        <a href="${pageContext.request.contextPath}/member/findid.do">아이디 찾기</a> |
                        <a href="/find-password">비밀번호 찾기</a> |
                        <a href="${pageContext.request.contextPath}/member/signup.do">회원가입</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
    

   

            <h2>상품 목록</h2>
            <div class="container">
    <div class="box-wrapper">
        <c:forEach var="dto" items="${prodList}" varStatus="status">
            <div class="box-container">
                <div id="box-fill-${status.index}" class="box-fill"></div>
                <div id="box-label-${status.index}" class="box-label">
                    ${dto.product_name}
                    ${dto.start_date}
                    ${dto.accumulated_amount}
                </div>
            </div>
            <h2><a href="/product/dd.do?product_code=${dto.product_code}">임시</a></h2>
        </c:forEach>

    </div>
</div>
   

    
        <div class="commu-container">
            <h2>커뮤니티</h2>
            <div class="community-content">
                <div class="community-posts">
                    <div>
                        <h3>공지글</h3>
                        <c:forEach var="dto" items="${noticeList}" varStatus="status">
                            <c:if test="${status.index < 5}">
                                <p>
                                    <a href="/notice/noticeView.do?id=${dto.id}">
                                            ${dto.subject}
                                    </a>
                                </p>
                            </c:if>
                        </c:forEach>
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
   


</main>

<jsp:include page="footer.jsp"/>