<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/css/commu/commuContent.css">
    <link rel="stylesheet" type="text/css" href="/css/commu/commuStyle.css">
	<jsp:include page="../header.jsp"/>
	<script> 
        function checkLogin() {
                alert("로그인이 필요합니다.");
                window.location.href = "/index.do";
            
        }
        
        function checkUpdateId(username){
        	
        	  if (username === '${getCommu.author}') {
                  window.location.href = "/commu/commuUpdate.do?id=${getCommu.id}";
              } else {
                  alert("본인만 글만 수정 가능합니다.");
              }

        }
        
        function checkDeleteId(username) {
        	if (username === '${getCommu.author}' || username === 'admin') {
                if (confirm("정말로 삭제하시겠습니까?")) {
                    window.location.href = "/commu/commuDelete.do?id=${getCommu.id}";
                }
            } else {
                alert("본인만 글을 삭제할 수 있습니다.");
            }
        }
    </script>
	<main>
	<div class="commu">
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
        <h2>글내용 보기</h2>
        <table class="content-table">
            <tr>
                <th>글번호</th>
                <td>${getCommu.id}</td>
                <th>조회수</th>
                <td>${getCommu.views}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${getCommu.author}</td>
                <th>작성일</th>
                <td>${getCommu.createtime}</td>
            </tr>
            <tr>
                <th>글제목</th>
                <td colspan="3">${getCommu.subject}</td>
            </tr>
            <tr>
                 <td colspan="90">
                <div class="textarea-container">
                    <textarea readonly>${getCommu.content}</textarea>
                </div>
            </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: right;">
                <sec:authorize access="isAuthenticated()">
                <sec:authentication property="principal.username" var="username" />
                    <input type="button" value="답글달기" onclick="window.location='/commu/commuWrite.do?id=${getCommu.id}'">
                    <input type="button" value="글수정" onclick="checkUpdateId('${username}')">
                    <input type="button" value="글삭제" onclick="checkDeleteId('${username}')">
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                	<input type="button" value="답글달기" onclick="checkLogin()">
                	<input type="button" value="글수정" onclick="checkLogin()">
                 	<input type="button" value="글삭제" onclick="checkLogin()">
                </sec:authorize>
                    <input type="button" value="글목록" onclick="window.location='/commu/commuList.do'">
                </td>
            </tr>
        </table>
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
					</div>                    <table>
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
                                    <td width="50%" align="left">                                        <span>&nbsp;&nbsp;</span>
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
				</div>            </div>
        </div>
    </div>
    </div>
    </main>
    <jsp:include page="../footer.jsp"/>


