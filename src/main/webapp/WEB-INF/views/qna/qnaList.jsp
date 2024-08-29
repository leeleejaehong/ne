<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/qna/qnaStyle.css">
<script>
    function performSearch() {
        var searchType = document.getElementById("searchType").value;
        var searchTerm = document.getElementById("search").value.trim();

        if (searchTerm !== "") {
            var currentURL = window.location.href.split('?')[0];
            var queryString = "?searchType=" + searchType + "&search=" + encodeURIComponent(searchTerm);
            window.location.href = currentURL + queryString;
        }else if(searchTerm === ""){
            var currentURL = window.location.href.split('?')[0];
            window.location.href =currentURL;
        }
    }

    function checkLogin() {
        alert("로그인이 필요합니다.");
        window.location.href = "/index.do";

    }
</script>
<main>
<div class="qna">
    <div class="header-content">
        <div class="vanner">
            <img alt="main" src="${pageContext.request.contextPath}/img/van.jpg" style="width:898px; height: 280px;">
        </div>
        <div class="login-form">
            <sec:authorize access="isAuthenticated()">
<div class="logview">
    <div class="profile-container">
        <table class="profile-table">
            <tr>
                <td width="50%" class="profile-image-cell">
                    <img src="${pageContext.request.contextPath}/img/${profile.profile}" alt="프로필 이미지" class="profile-img"/>
                </td>
                <td class="profile-info-cell">
                    <div class="profile-info">
                        <strong class="itemfont col" id="nickNameArea">
                            환영합니다<br>
                            <sec:authentication property="principal.username"/>님
                        </strong>
                        <br>
                        <div class="links">
                            <a href="${pageContext.request.contextPath}/member/myPage.do?user=<sec:authentication property="principal.username"/>" class="link-btn">마이페이지</a>
                            <a href="/member/editMemberForm.do?memberID=<sec:authentication property='principal.username'/>" class="link-btn">내 정보 수정</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <form action="<c:url value='/logout' />" method="post" class="logout-form">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
</div>
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

    <h3>문의사항</h3>
    <div class="search-form">
        <select id="searchType">
            <option value="all" <c:if test="${searchType == 'all'}">selected</c:if>>전체</option>
            <option value="subject" <c:if test="${searchType == 'subject'}">selected</c:if>>제목</option>
            <option value="author" <c:if test="${searchType == 'author'}">selected</c:if>>작성자</option>
        </select>
        <input type="text" placeholder="검색어를 입력하세요" id="search" value="${search}">
        <button onclick="performSearch()">검색</button>
    </div>
    <div id="qna">
        <table align="right">
            <tr>
                <td>
                    <sec:authorize access="isAuthenticated()">
                        <a href="/qna/qnaWrite.do" class="write-btn">글쓰기</a>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <a href="javascript:void(0);" class="write-btn" onclick="checkLogin()">글쓰기</a>
                    </sec:authorize>
                </td>
            </tr>
        </table>
        <table class="qna-table">
            <thead>
            <tr class="qna-header">
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty qnaList}">
                <tr>
                    <td colspan="5" class="no-data">등록된 문의글이 없습니다.</td>
                </tr>
            </c:if>
            <c:forEach var="dto" items="${qnaList}">
                <tr class="qna-row">
                    <td align="center">${dto.id}</td>
                    <td align="left">
                        <!-- 're_level'에 따라 공백 추가 --> <c:choose>
                        <c:when test="${dto.re_level > 0}">
                            <c:forEach var="i" begin="1" end="${dto.re_level}">
                                <span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                <!-- 4 공백 -->
                            </c:forEach>
                            <span>ㄴ[답변]: </span>
                        </c:when>
                        <c:otherwise>
                            <span>[질문] : </span>
                        </c:otherwise>
                    </c:choose> <a href="/qna/qnaContent.do?id=${dto.id}" class="qna-link">${dto.subject}</a>
                    </td>
                    <td align="center">${dto.author}</td>
                    <td align="center">${dto.createtime}</td>
                    <td align="right">${dto.views}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${not empty qnaList}">
            <div class="pagination">

                <%
                    int pageSize = 15;
                    int currentPage = (request.getParameter("pageNum") != null) ? Integer.parseInt(request.getParameter("pageNum")) : 1;
                    int count = (Integer) request.getAttribute("count");
                    int pageBlock = 15;
                    int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
                    int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
                    int endPage = startPage + pageBlock - 1;
                    if (endPage > pageCount) endPage = pageCount;
                %>

                <% if (startPage > pageBlock) { %>
                <a href="/qna/qnaList.do?pageNum=<%=startPage-pageBlock%>">&laquo; 이전</a>
                <% } %>


                <% for (int i = startPage; i <= endPage; ++i) { %>
                <a href="/qna/qnaList.do?pageNum=<%=i%>" class="<%= (i == currentPage) ? "active" : "" %>"><%=i%></a>
                <% } %>


                <% if (endPage < pageCount) { %>
                <a href="/qna/qnaList.do?pageNum=<%=startPage+pageBlock%>">다음 &raquo;</a>
                <% } %>
            </div>
        </c:if>
    </div>
    <br>
    <div class="commu-container">
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
                                    <td width="50%" align="left">
                                        <span>&nbsp;&nbsp;</span>
                                        <a href="/notice/noticeView.do?id=${dto.id}">
                                                <c:choose>
                                        <c:when test="${fn:length(dto.subject) > 8}">
                                            ${fn:substring(dto.subject, 0, 8)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${dto.subject}
                                        </c:otherwise>
                                    </c:choose>

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
                                    <td width="50%" align="left">
                                        <span>&nbsp;&nbsp;</span>
                                        <a href="/commu/commuContent.do?id=${dto.id}">
                                               <c:choose>
                                        <c:when test="${fn:length(dto.subject) > 8}">
                                            ${fn:substring(dto.subject, 0, 8)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${dto.subject}
                                        </c:otherwise>
                                    </c:choose>

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
										<td width="50%" align="left"><span>&nbsp;&nbsp;</span> 
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
</div>
</main>
<jsp:include page="../footer.jsp"/>
