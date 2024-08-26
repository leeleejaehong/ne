<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<jsp:include page="header.jsp" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/index.css">
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js"
	crossorigin="anonymous"></script>
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
		<img class="img" src="http://lorempixel.com/1920/400/sports/10/"
			alt="">
	</div>
</div>
<main>
	<div class="hero-container">
		<div class="slideshow-container">
			<div class="slides fade">
				<img src="img/fast.jpg" width="100%" height="280">
			</div>
			<div class="slides fade">
				<img src="img/adult.jpg" width="100%" height="280">
			</div>
			<div class="slides fade">
				<img src="img/smart.jpg" width="100%" height="280">
			</div>
			<div class="slides fade">
				<img src="img/year.jpg" width="100%" height="280">
			</div>
			<a class="prev" onclick="plusSlides(-1)">&#10094;</a> 
			<a class="next" onclick="plusSlides(1)">&#10095;</a>
		</div>
				<%-- <sec:authorize access="hasRole('ROLE_1')">
                 	123
                 	</sec:authorize> --%>
		<div class="login-form">
			<sec:authorize access="isAuthenticated()">
		<div class="logview">
    	<div class="profile-container">
        <img src="https://blogpfthumb-phinf.pstatic.net/MjAyNDA3MTZfMjAg/MDAxNzIxMTE1NzY3MjY4.ueDvccl7mHx7z0DVBHHqagXj2aoAhIi1uSYaQrufjS4g.1xT_9Yxv4LolXwixUFJ-SEK-Y0z39lD3qbv2YsZbhS4g.JPEG/%EC%96%B4%EB%9E%98%EA%B3%A4.jpeg/%25EC%2596%25B4%25EB%259E%2598%25EA%25B3%25A4.jpeg?type=w161"
            alt="프로필 이미지" class="profile-img"/>
        
        <div class="profile-info">
            <strong class="itemfont col" id="nickNameArea">
                <sec:authentication property="principal.username"/>
            </strong> 
            <br>
            <div class="links">
                <a href="${pageContext.request.contextPath}/member/myPage.do?user=<sec:authentication property="principal.username"/>" class="link-btn">마이페이지</a>
                <a href="" class="link-btn">내 정보 수정(링크 없음)</a>
            </div>
        </div>
        
        <form action="<c:url value='/logout' />" method="post" class="logout-form">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
    </div>
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
					<a href="${pageContext.request.contextPath}/member/findid.do">아이디
						찾기</a> | <a href="/member/updatepw.do">비밀번호 변경</a> | <a
						href="${pageContext.request.contextPath}/member/signup.do">회원가입</a>
				</div>
			</sec:authorize>
		</div>
	</div>


	<%-- 
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
    --%>

	<h2 class="section-title" style="margin-bottom: 8px; border-bottom: 2px solid #c0c0c0;">적금 상품</h2>
	<div class="container">
		<div class="products">
			<c:forEach var="dto" items="${prodList}" varStatus="status">
				<a href="/product/productDetail.do?product_code=${dto.product_code}">
					<div class="product-card">
						<div class="product-image">💰</div>
						<div class="product-info">
							<h3 class="product-title">${dto.product_name}</h3>
							<h5>
								누적금액-
								<fmt:formatNumber value="${dto.accumulated_amount}"
									type="number" groupingUsed="true" />
								원
							</h5>
							<p class="product-description">
								연 ${dto.base_rate}% 금리, ${dto.subscription_period} 만기, 최소
								<fmt:formatNumber value="${dto.minimum_deposit}" type="number"
									groupingUsed="true" />
								원부터
							</p>
						</div>
					</div>
				</a>
			</c:forEach>
		</div>
	</div>


	<div class="commu-container">
		<br> <br>
		<div class="community-content">
			<div class="community-posts">
				<div>
					<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #c0c0c0; margin-bottom: 8px;">
					    <span style="text-align: left;"><h3 style="margin: 0;">공지사항</h3></span>
					    <span style="text-align: left;"><a href="/notice/noticeList.do"> 더보기 + </a></span>
					</div>
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
										<td width="50%"><span>&nbsp;&nbsp;</span> <a
											href="/notice/noticeView.do?id=${dto.id}"> 
											<c:choose>
                                        <c:when test="${fn:length(dto.subject) > 8}">
                                            ${fn:substring(dto.subject, 0, 8)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${dto.subject}
                                        </c:otherwise>
                                    </c:choose>

										</a></td>
										<td align="center" width="25%">${dto.author}</td>
										<td align="center"><fmt:parseDate var="parsedDate"
												value="${dto.createtime}" pattern="yyyy-MM-dd HH:mm:ss" />
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
					<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #c0c0c0; margin-bottom: 8px;">
					    <span style="text-align: left;"><h3 style="margin: 0;">커뮤니티</h3></span>
					    <span style="text-align: left;"><a href="/commu/commuList.do">더보기 +</a></span>
					</div>
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
										<td width="50%"><span>&nbsp;&nbsp;</span> <a
											href="/commu/commuContent.do?id=${dto.id}">
												<c:choose>
                                        <c:when test="${fn:length(dto.subject) > 8}">
                                            ${fn:substring(dto.subject, 0, 8)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${dto.subject}
                                        </c:otherwise>
                                    </c:choose>
									</a></td>
										<td align="center" width="25%">${dto.author}</td>
										<td align="center"><fmt:parseDate var="parsedDate"
												value="${dto.createtime}" pattern="yyyy-MM-dd HH:mm:ss" />
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
				<div>
					<div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #c0c0c0; margin-bottom: 8px;">
					    <span style="text-align: left;"><h3 style="margin: 0;">전회차 상금</h3></span>
					</div>
					<table>
						<thead>
							<tr class="commu-header">
								<th>상품이름</th>
								<th>누적 금액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${sessionScope.winnerList}" varStatus="status">
									<tr>
										<td width="50%"><span>&nbsp;&nbsp;</span> 
											${dto.product_name}
										</td>
										<td align="right" width="50%">
										<fmt:formatNumber value="${dto.accumulated_amount}"
									type="number" groupingUsed="true" />
										원</td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
		</div>
	</div>
	
	<br> <br>
	<div class="section-main area-banner6">
		<a href="/quics?page=C063677"> <img
			src="https://oimg1.kbstar.com/img/ocommon/o_banner/banner_2022_chatbot2.png "
			alt="챗봇에게 물어봐~ 24시간 간편한 채팅상담 인터넷뱅킹 궁금증을 해결해드려요!">

		</a>
	</div>



</main>

<jsp:include page="footer.jsp" />